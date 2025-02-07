/***********************************************************************************************
This transcript:
- Merge the firm characteristics with Sufi(2009) specific data
***********************************************************************************************/
clear all
set more off

/***********************************
Read in Compustat Data 
***********************************/
use "${root}/raw_data/annual_fundamental.dta"
sort gvkey fyear
destring gvkey,replace
drop if indfmt=="FS"
xtset gvkey fyear

/***********************************
Clean Variables
***********************************/
destring sic,replace
gen ind_group = .
replace ind_group = 1 if (sic >= 100 & sic <= 1999)    // Agriculture and mining
replace ind_group = 2 if (sic >= 2000 & sic <= 3999)   // Manufacturing
replace ind_group = 3 if (sic >= 4000 & sic <= 4799)   // Transportation and communication
replace ind_group = 4 if (sic >= 4800 & sic <= 4999)   // Utilities
replace ind_group = 5 if (sic >= 6000 & sic <= 6999)   // Finance (to be excluded)
replace ind_group = 6 if (sic >= 5000 & sic <= 5999)   // Wholesale and retail trade
replace ind_group = 7 if (sic >= 7000 & sic <= 8999)   // Services
replace ind_group = 8 if (sic >= 9000 & sic <= 9999)   // Public and non-profit organizations
tab ind_group, gen(ind_dummy)

/* Firm Age Calculation */
gen firm_age = year(datadate) - year(ipodate) if year(datadate) - year(ipodate)>=0
egen avg_firm_age = mean(firm_age), by(ind_group)
replace firm_age = avg_firm_age if missing(firm_age)
label variable firm_age "Firm age (years since IPO)"

/* Assets - cash  */
gen assets_cash = at - che
label variable assets_cash "Assets-cash"
gen ln_assets_cash = ln(assets_cash)
egen lower_assets_cash = pctile(assets_cash), p(5)
egen upper_assets_cash = pctile(assets_cash), p(95)
gen lag_ln_assets_cash = L.ln_assets_cash 
label variable lag_ln_assets_cash "$\text{Ln(assets-cash)}_{t-1}$"

/*  Book debt/assets */
gen debt_to_assets = (dlc + dltt) / at if at > 0 & !missing(at)
label variable debt_to_assets "Book debt/assets"

/* EBITDA / (assets - cash) */
gen EBITDA_to_assets_cash = oibdp / assets_cash if assets_cash != 0 & !missing(assets_cash)
label variable EBITDA_to_assets_cash "EBITDA/(assets-cash)"
egen lower_cut_ebitda = pctile(EBITDA_to_assets_cash), p(5)
egen upper_cut_ebitda = pctile(EBITDA_to_assets_cash), p(95)
gen lag_EBITDA_to_assets_cash = L.EBITDA_to_assets_cash
label variable lag_EBITDA_to_assets_cash "$\frac{\text{EBITDA}}{\text{assets-cash}}_{t-1}$"

/* Tangible assets / (assets - cash): two approaches */
gen tangible_assets_to_assets_cash = ppent/ assets_cash if assets_cash != 0 & !missing(assets_cash)
label variable tangible_assets_to_assets_cash "Tangible assets/(assets-cash)"
egen lower_cut_tangible = pctile(tangible_assets_to_assets_cash), p(5)
egen upper_cut_tangible = pctile(tangible_assets_to_assets_cash), p(95)
gen lag_tangible = L.tangible_assets_to_assets_cash
label variable lag_tangible "$\frac{\text{Tangible assets}}{\text{assets-cash}}_{t-1}$"

/* Net worth, cash adjusted */
gen net_w=seq-pstk
gen net_worth = (net_w)/assets_cash
label variable net_worth "Net worth, cash adjusted"
gen lag_net_worth = L.net_worth
label variable lag_net_worth "$\text{Net worth, cash adjusted}_{t-1}$"

/* Market-to-book, cash adjusted */ 
gen market_to_book_cash_adjusted = (prcc_f * csho)/(at-lt-pstk-txdb-che)
label variable market_to_book_cash_adjusted "Market-to-book, cash adjusted"
egen lower_market_to_book = pctile(market_to_book_cash_adjusted), p(5)
egen upper_market_to_book = pctile(market_to_book_cash_adjusted), p(95)
egen avg_market_to_book = mean(market_to_book_cash_adjusted), by(ind_group)
replace market_to_book_cash_adjusted = avg_market_to_book if missing(market_to_book_cash_adjusted)
gen lag_market_to_book_cash_adjusted = L.market_to_book_cash_adjusted
label variable lag_market_to_book_cash_adjusted "$\text{Market-to-book, cash adjusted}_{t-1}$"

/* Traded Over the Counter  */
gen otc = (exchg == 17 | exchg == 15 | exchg == 14)
label define otc_label 0 "Not OTC" 1 "Traded Over the Counter"
label values otc otc_label
label variable otc "Traded over the counter {0,1}"

/* ln(age+1) */
gen ln_firm_age_1 =ln(firm_age+1)
gen ln_firm_age = ln(firm_age)
gen lag_firm_age = L.ln_firm_age_1
label variable lag_firm_age "$\text{Firm age (years since IPO)}_{t-1}$"
save "${root}/processing_data/database.dta",replace

/***********************************
Merge
***********************************/

do "${root}/do_file/S&P_clean.do"
sort gvkey fyear
merge 1:1 gvkey fyear using "${root}/processing_data/database.dta"
keep if _merge == 3
drop _merge
label variable sp500 "Not in an S\&P index {0,1}"
save "${root}/processing_data/merge_after_sp.dta", replace

/* Cash flow volalitity window method */
do "${root}/do_file/cash_flow_clean.do"
use  "${root}/processing_data/cash_flow_volatility_window.dta",clear
merge 1:1 gvkey fyear using "${root}/processing_data/merge_after_sp.dta"
keep if _merge == 3
drop _merge
gen scale_cash_flow_volatility = cash_flow_volatility/(at-che) if (at-che)!=0
label variable scale_cash_flow_volatility "Cash-flow volalitity"
gen lag_scale_cash_flow_volatility = L.scale_cash_flow_volatility
label variable lag_scale_cash_flow_volatility "$\text{Cash-flow volatility}_{t-1}$"
save "${root}/processing_data/database1.dta", replace

/* Cash flow volalitity quarterly method (see appendix) */
do "${root}/do_file/cash_flow_clean_quarterly.do"
use  "${root}/processing_data/cash_flow_volatility_quarterly.dta",clear
merge 1:1 gvkey fyear using "${root}/processing_data/merge_after_sp.dta"
keep if _merge == 3
drop _merge
gen scale_cash_flow_volatility = cash_flow_volatility/(at-che) if (at-che)!=0
label variable scale_cash_flow_volatility "Cash-flow volalitity"
xtset gvkey fyear
gen lag_scale_cash_flow_volatility = L.scale_cash_flow_volatility
label variable lag_scale_cash_flow_volatility "$\text{Cash-flow volatility}_{t-1}$"
save "${root}/processing_data/database1a.dta", replace

/* Industry Sales volalitity window method*/
do "${root}/do_file/industry_clean_window.do"
use "${root}/processing_data/database1.dta",clear
merge m:1 ind_group fyear using "${root}/processing_data/industry_clean_window.dta"
keep if _merge == 3
drop _merge
egen sum_industry_assets = sum(at), by(ind_group fyear)
gen scaled_industry_sale_volatility = industry_sale_volatility / sum_industry_assets
label variable scaled_industry_sale_volatility "Industry sales volalitity"
egen lower_industry = pctile(scaled_industry_sale_volatility), p(5)
egen upper_industry = pctile(scaled_industry_sale_volatility), p(95)
xtset gvkey fyear
gen lag_industry_volatility = L.scaled_industry_sale_volatility
label variable lag_industry_volatility "$\text{Industry sales volatility}_{t-1}$"
save "${root}/processing_data/database2.dta", replace

/* Industry Sales volalitity quarterly method (see appendix)*/
do "${root}/do_file/industry_clean.do"
use "${root}/processing_data/database1a.dta",clear
merge m:1 ind_group fyear using "${root}/processing_data/industry_clean.dta"
keep if _merge == 3
drop _merge
egen sum_industry_assets = sum(at), by(ind_group fyear)
gen scaled_industry_sale_volatility = industry_sale_volatility / sum_industry_assets
label variable scaled_industry_sale_volatility "Industry sales volalitity"
egen lower_industry = pctile(scaled_industry_sale_volatility), p(5)
egen upper_industry = pctile(scaled_industry_sale_volatility), p(95)
xtset gvkey fyear
gen lag_industry_volatility = L.scaled_industry_sale_volatility
label variable lag_industry_volatility "$\text{Industry sales volatility}_{t-1}$"
save "${root}/processing_data/database2a.dta", replace

/* Merge with Sufi(2009)*/
use "${root}/processing_data/database2.dta",clear
keep if fyear>=1996 & fyear<=2003
merge 1:1 gvkey fyear using "${root}/raw_data/sufi(2009).dta"
keep if _merge == 3
drop _merge
label variable lineofcredit "Has line of credit {0,1}"
label variable lineofcredit_rs "Has line of credit {0,1}"
gen total_line_assets = linetot/at if at!=0
label variable total_line_assets "Total line of credit/assets"
gen used_line_assets = line/at if at!=0
label variable used_line_assets "Used line of credit/assets"
gen total_line_total_line_cash= linetot/(linetot+che)
label variable total_line_total_line_cash "Total line/(total line+cash)"
gen unused_line_assets = lineun/at if at!=0
label variable unused_line_assets "Unused line of credit/assets"
gen unused_line_unused_line_cash = lineun/(lineun+che)
label variable unused_line_unused_line_cash "Unused line/(unused line + cash)"
label variable def "Violation of financial covenant {0,1}"
save "${root}/prepared_data/database3.dta", replace


/* Merge with Sufi(2009) (appendix)*/
use "${root}/processing_data/database2a.dta",clear
merge 1:1 gvkey fyear using "${root}/raw_data/sufi(2009).dta"
keep if _merge == 3
drop _merge
label variable lineofcredit "Has line of credit {0,1}"
label variable lineofcredit_rs "Has line of credit {0,1}"
gen total_line_assets = linetot/at if at!=0
label variable total_line_assets "Total line of credit/assets"
gen used_line_assets = line/at if at!=0
label variable used_line_assets "Used line of credit/assets"
gen total_line_total_line_cash= linetot/(linetot+che)
label variable total_line_total_line_cash "Total line/(total line+cash)"
gen unused_line_assets = lineun/at if at!=0
label variable unused_line_assets "Unused line of credit/assets"
gen unused_line_unused_line_cash = lineun/(lineun+che)
label variable unused_line_unused_line_cash "Unused line/(unused line + cash)"
label variable def "Violation of financial covenant {0,1}"
save "${root}/prepared_data/database3a.dta", replace
