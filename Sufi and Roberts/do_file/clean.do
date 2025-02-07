/***********************************************************************************************
This transcript:
- Cleans the raw datasets and merge the firm characteristics with Sufi and Roberts(2009) specific data
- Detailed cleaning process and defenses are shown in the Appendix
***********************************************************************************************/

clear all
set more off

/***********************************
Read in Compustat Data 
***********************************/
use "${root}/raw_data/quarterly_fundamental.dta",clear
destring gvkey,replace
gen time = yq(fyear,fqtr)
format time %tq
duplicates drop gvkey time,force
xtset gvkey time

/***********************************
Clean Capital Structure Variables
***********************************/

/* Assets, Lagged Assets and Lagged Ln(Assets) */
gen lag_assets=L.at
gen ln_at=ln(at)
winsor2 ln_at,cuts(5,95)replace
winsor2 lag_assets,cuts(5,95)replace
gen lag_ln_at=L.ln_at
label variable at "Assets_t"
label variable lag_assets "Assets_{t-1}"
label variable ln_at "Ln(Assets_t)"
label variable lag_ln_at "Lagged Ln(Assets)"

/* Book Debt */
gen book_debt = dlttq + dlcq
winsor2 book_debt,cuts(5,95)replace
gen lag_book_debt= L.book_debt 
label variable book_debt "Book Debt_t"
label variable lag_book_debt "Book Debt_{t-1}"

/* Book Debt/Assets*/
gen book_debt_assets= book_debt/at
winsor2 book_debt_assets,cuts(5,95)replace
label variable book_debt_assets "$\frac{\text{Book Debt}_t}{{Assets}_t}$"

/* Net Debt Issuance(basis points)*/
gen net_debt_issuance=(book_debt-lag_book_debt)/lag_assets *10000
/*
summarize net_debt_issuance, detail
local median_net_debt_issuance= r(p50) 
replace net_debt_issuance=`median_net_debt_issuance' if missing(net_debt_issuance)*/
winsor2 net_debt_issuance,cuts(5,95) replace
label variable net_debt_issuance "Net Debt Issuance (basis point)"

/* Net Equity Issuance(basis points)*/
gen net_equity=sstky-prstkcy
gen net_equity_issuance=net_equity/lag_assets*10000
winsor2 net_equity_issuance,cuts(1,85) replace
label variable net_equity_issuance "Net Equity Issuance (basis point)"

/***********************************
Clean Covenant Control Variables
***********************************/

/* Net Worth/Assets */
gen net_worth=seq-pstkq
winsor2 net_worth,cuts(5,95)replace
gen net_worth_assets=net_worth/at
winsor2 net_worth_assets,cuts(5,95)replace
label variable net_worth_assets "$\frac{\text{Net worth}_{t}}{\text{Assets}_{t}}$" 

/* Net Worth/Lagged Assets */
gen net_worth_lag_assets=net_worth/lag_assets
winsor2 net_worth_lag_assets,cuts(5,95)replace
label variable net_worth_lag_assets "$\frac{\text{Net worth}_{t}}{\text{Assets}_{t-1}}$"

/* Net Working Capital/Assets */
gen net_working_capital=actq-lctq
gen net_working_capital_assets=(actq-lctq)/at
winsor2 net_working_capital_assets,cuts(5,95) replace
label variable net_working_capital_assets "$\frac{\text{Net Working Capital}_t}}{\text{Assets}_t}"

/* Cash/Assets */
gen cash_assets=che/at
winsor2 cash_assets, cuts(5,95) replace
label variable cash_assets "$\frac{\text{Cash}_t}{\text{Assets}_t}$"

/* EBITDA/Lagged Assets */
/*summarize oibdp, detail
local median_oibdp = r(p50)  
replace oibdp=`median_oibdp' if missing(oibdp)*/
winsor2 oibdp,cuts(5,95)replace
gen EBITDA_lag_assets=oibdp/lag_assets
winsor2 EBITDA_lag_assets,cuts(5,95)replace
label variable EBITDA_lag_assets "$\frac{\text{EBITDA}_t}{\text{Assets}_{t-1}}$"

/* Cashflow/Lagged Assets */
gen cash_flow=niq+dpq
winsor2 cash_flow,cuts(5,95)replace
gen cash_flow_lag_assets=cash_flow/lag_assets
winsor2 cash_flow_lag_assets, cut(5,95) replace
label variable cash_flow_lag_assets "$\frac{\text{Cash Flow}_t}{Assets_{t-1}}$"

/* Net income/Lagged Assets */
gen net_income = niq
winsor2 net_income,cuts(5,95)
gen net_income_lag_assets=net_income/lag_assets
winsor2 net_income_lag_assets,cuts(5,95) replace
label variable net_income_lag_assets "$\frac{Net Income_t}{Assets_{t-1}}"

/* Interest Expense/Lagged Assets */
winsor2 xint,cuts(5,95)replace
gen interest_expense_lag_assets= xint/lag_assets
winsor2 interest_expense_lag_assets,cuts(5,95)replace
label variable interest_expense_lag_assets "$\frac{\text{Interest Expense}_t}{\text{Assets}_{t-1}}$"

/***********************************
Clean Other Control Variables
***********************************/

/* Market-to-book Ratio and Lagged Market-to-book */
gen book_value_equity = seq - pstkq + ceqq - txditcq
gen market_value_equity=cshoq*prccq
gen market_to_book_ratio = market_value_equity/book_value_equity
winsor2 market_to_book_ratio,cuts(5,95)replace
gen lag_market_to_book_ratio = L.market_to_book_ratio
label variable market_to_book_ratio "Market-to-book Ratio"
label variable lag_market_to_book_ratio "Lagged Market-to-book Ratio"

/* Tangible Assets/Assets */
gen tangible_assets = ppentq
winsor2 tangible_assets,cuts(5,95)replace
gen tangible_assets_assets=(tangible_assets)/at
gen lag_tangible_assets_assets=L.tangible_assets_assets
winsor2 tangible_assets_assets,cuts(5,95)replace
label variable tangible_assets_assets "$\frac{\text{Tangible}_t}{\text{Assets}_t}$"
label variable lag_tangible_assets_assets "Lagged Tangible to Assets Ratio"

/***********************************
Clean 11 Covenant Variables
***********************************/

/* Lagged Book Debt to Assets */
gen lag_book_debt_assets=lag_book_debt/at
winsor2 lag_book_debt_assets,cuts(5,95)replace

/* Lagged Net Worth to Assets */
gen lag_net_worth=L.net_worth
gen lag_net_worth_assets=lag_net_worth/at
winsor2 lag_net_worth_assets,cuts(5,95)replace

/* Lagged Cash to Assets */
gen lag_cash=L.che
gen lag_cash_assets=lag_cash/at
winsor2 lag_cash_assets,cuts(5,95)replace

/* Lagged EBITDA to Lagged Assets */
gen lag_EBITDA=L.oibdp
gen lag_EBITDA_lag_assets=lag_EBITDA/lag_assets
winsor2 lag_EBITDA_lag_assets,cuts(5,95)replace

/* Current EBITDA to Lagged Assets has been generated above */

/* Lagged Cash Flow to Lagged Assets */
gen lag_cash_flow=L.cash_flow
gen lag_cash_flow_lag_assets=lag_cash_flow/lag_assets
winsor2 lag_cash_flow_lag_assets,cuts(5,95)replace

/* Current Cash Flow to Lagged Assets has been generate above */

/* Lagged Net Income to Lagged Assets */
gen lag_net_income=L.net_income
gen lag_net_income_lag_assets=lag_net_income/lag_assets
winsor2 lag_net_income_lag_assets,cuts(5,95)replace

/* Current Net Income to Lagged Assets has been generated */

/* Lagged Interest Expense to Lagged Assets */
gen lag_interest_expense=L.interest_expense
gen lag_interest_expense_lag_assets=lag_interest_expense/lag_assets
winsor2 lag_interest_expense_lag_assets,cuts(5,95)replace

/* Current Interest Expense to Lagged Assets has been generated above */

/***********************************
Generate Covenant Interaction
***********************************/

/* lagged debt to assets ratio interacted with 
lagged cash flow to lagged assets ratio*/
gen covenant_control1=lag_book_debt*lag_cash_flow_lag_assets

/* lagged debt to assets ratio interacted
with lagged EBITDA to lagged assets ratio */
gen covenant_control2=lag_book_debt*lag_EBITDA_lag_assets

/* lagged debt to assets ratio interacted with 
lagged net worth to assets ratio */
gen covenant_control3=lag_book_debt*lag_net_income_lag_assets

/* lagged debt to assets ratio interacted with 
lagged net worth to assets ratio */
gen covenant_control4=lag_book_debt*lag_net_worth_assets

/*lagged EBITDA to lagged assets ratio interacted with lagged interest
expense to lagged assets ratio*/
gen covenant_control5=lag_EBITDA_lag_assets*lag_interest_expense_lag_assets

/* Save to database1.dta */
save "${root}/processing_data/database1.dta",replace

/***********************************
Merge with sp500
***********************************/
use "${root}/raw_data/sp500.dta",clear
gen fqtr =.
replace fqtr=1 if month<=3
replace fqtr=2 if month<=6 & month>=4
replace fqtr=3 if month<=9 & month>=7
replace fqtr=4 if month>=10
gen time = yq(fyear,fqtr)
format time %tq
gen sp500_month = inlist(spmim, 81, 91, 92)
bysort gvkey time: gen sp500_quarter = sum(sp500_month)
bysort gvkey time (sp500_quarter): replace sp500_quarter = 1 if sp500_quarter > 0
replace sp500_quarter = 0 if missing(sp500_quarter)
rename sp500_quarter sp500
duplicates drop gvkey time, force
merge 1:1 gvkey time using "${root}/processing_data/database1.dta"
keep if _merge==3
drop _merge

/* lagged_sp500 */
label define sp500_label 0 "Not in S&P 500" 1 "In S&P 500"
label variable sp500 "S\&P membership indicator {0,1}"
xtset gvkey time
gen lag_sp500=L.sp500
label variable lag_sp500 "Lagged S\&P 500 Indicator"
save "${root}/processing_data/database2.dta",replace

/***********************************
Merge with violation
***********************************/
use "${root}/raw_data/violation.dta",clear
gen date_num = date(datadate, "MDY")
gen fyear = year(date_num)
gen month = month(date_num)
gen fqtr =.
replace fqtr=1 if month<=3
replace fqtr=2 if month<=6 & month>=4
replace fqtr=3 if month<=9 & month>=7
replace fqtr=4 if month>=10
gen time = yq(fyear, fqtr)
format time %tq
bysort gvkey time: gen violation_quarter = sum(viol)
bysort gvkey time (violation_quarter): replace violation_quarter = 1 if violation_quarter > 0
drop viol
rename violation_quarter violation
duplicates drop gvkey time, force
drop datadate
merge 1:1 gvkey time using "${root}/processing_data/database2.dta"
keep if _merge==3
drop _merge

/* Lagged Violation */
xtset gvkey time
gen lag_violation = L.violation
label variable violation "Covenant violation_t"
label variable lag_violation "Covenant violation_{t-1}"
save "${root}/processing_data/database3.dta",replace

/***********************************
Generate Square, Third Power, 5 Quantile Indicator  Control
***********************************/

global control_high "ln_at lag_tangible_assets_assets lag_market_to_book_ratio lag_sp500 lag_book_debt_assets lag_net_worth_assets lag_cash_assets lag_EBITDA_lag_assets EBITDA_lag_assets lag_cash_flow_lag_assets cash_flow_lag_assets lag_net_income_lag_assets net_income_lag_assets lag_interest_expense_lag_assets interest_expense_lag_assets covenant_control1 covenant_control2 covenant_control3 covenant_control4 covenant_control5"

gen covenant_high1 = ln_at^2
gen covenant_high2 = ln_at^3
xtile __temp_ln_at = ln_at, nq(5)
gen covenant_high3 = (__temp_ln_at == 1)
gen covenant_high4 = (__temp_ln_at == 2)
gen covenant_high5 = (__temp_ln_at == 3)
gen covenant_high6 = (__temp_ln_at == 4)
gen covenant_high7 = (__temp_ln_at == 5)
drop __temp_ln_at

gen covenant_high8 = lag_tangible_assets_assets^2
gen covenant_high9 = lag_tangible_assets_assets^3
xtile __temp_tangible = lag_tangible_assets_assets, nq(5)
gen covenant_high10 = (__temp_tangible == 1)
gen covenant_high11 = (__temp_tangible == 2)
gen covenant_high12 = (__temp_tangible == 3)
gen covenant_high13 = (__temp_tangible == 4)
gen covenant_high14 = (__temp_tangible == 5)
drop __temp_tangible

gen covenant_high15 = lag_market_to_book_ratio^2
gen covenant_high16 = lag_market_to_book_ratio^3
xtile __temp_market_to_book = lag_market_to_book_ratio, nq(5)
gen covenant_high17 = (__temp_market_to_book == 1)
gen covenant_high18 = (__temp_market_to_book == 2)
gen covenant_high19 = (__temp_market_to_book == 3)
gen covenant_high20 = (__temp_market_to_book == 4)
gen covenant_high21 = (__temp_market_to_book == 5)
drop __temp_market_to_book

gen covenant_high22 = lag_sp500^2
gen covenant_high23 = lag_sp500^3
xtile __temp_sp500 = lag_sp500, nq(5)
gen covenant_high24 = (__temp_sp500 == 1)
gen covenant_high25 = (__temp_sp500 == 2)
gen covenant_high26 = (__temp_sp500 == 3)
gen covenant_high27 = (__temp_sp500 == 4)
gen covenant_high28 = (__temp_sp500 == 5)
drop __temp_sp500

gen covenant_high29 = lag_book_debt_assets^2
gen covenant_high30 = lag_book_debt_assets^3
xtile __temp_debt_assets = lag_book_debt_assets, nq(5)
gen covenant_high31 = (__temp_debt_assets == 1)
gen covenant_high32 = (__temp_debt_assets == 2)
gen covenant_high33 = (__temp_debt_assets == 3)
gen covenant_high34 = (__temp_debt_assets == 4)
gen covenant_high35 = (__temp_debt_assets == 5)
drop __temp_debt_assets

gen covenant_high36 = lag_net_worth_assets^2
gen covenant_high37 = lag_net_worth_assets^3
xtile __temp_net_worth = lag_net_worth_assets, nq(5)
gen covenant_high38 = (__temp_net_worth == 1)
gen covenant_high39 = (__temp_net_worth == 2)
gen covenant_high40 = (__temp_net_worth == 3)
gen covenant_high41 = (__temp_net_worth == 4)
gen covenant_high42 = (__temp_net_worth == 5)
drop __temp_net_worth

gen covenant_high43 = lag_cash_assets^2
gen covenant_high44 = lag_cash_assets^3
xtile __temp_cash_assets = lag_cash_assets, nq(5)
gen covenant_high45 = (__temp_cash_assets == 1)
gen covenant_high46 = (__temp_cash_assets == 2)
gen covenant_high47 = (__temp_cash_assets == 3)
gen covenant_high48 = (__temp_cash_assets == 4)
gen covenant_high49 = (__temp_cash_assets == 5)
drop __temp_cash_assets

gen covenant_high50 = lag_EBITDA_lag_assets^2
gen covenant_high51 = lag_EBITDA_lag_assets^3
xtile __temp_ebitda_assets = lag_EBITDA_lag_assets, nq(5)
gen covenant_high52 = (__temp_ebitda_assets == 1)
gen covenant_high53 = (__temp_ebitda_assets == 2)
gen covenant_high54 = (__temp_ebitda_assets == 3)
gen covenant_high55 = (__temp_ebitda_assets == 4)
gen covenant_high56 = (__temp_ebitda_assets == 5)
drop __temp_ebitda_assets

gen covenant_high57 = lag_cash_flow_lag_assets^2
gen covenant_high58 = lag_cash_flow_lag_assets^3
xtile __temp_cash_flow = lag_cash_flow_lag_assets, nq(5)
gen covenant_high59 = (__temp_cash_flow == 1)
gen covenant_high60 = (__temp_cash_flow == 2)
gen covenant_high61 = (__temp_cash_flow == 3)
gen covenant_high62 = (__temp_cash_flow == 4)
gen covenant_high63 = (__temp_cash_flow == 5)
drop __temp_cash_flow

gen covenant_high64 = lag_net_income_lag_assets^2
gen covenant_high65 = lag_net_income_lag_assets^3
xtile __temp_net_income = lag_net_income_lag_assets, nq(5)
gen covenant_high66 = (__temp_net_income == 1)
gen covenant_high67 = (__temp_net_income == 2)
gen covenant_high68 = (__temp_net_income == 3)
gen covenant_high69 = (__temp_net_income == 4)
gen covenant_high70 = (__temp_net_income == 5)
drop __temp_net_income

gen covenant_high71 = lag_interest_expense_lag_assets^2
gen covenant_high72 = lag_interest_expense_lag_assets^3
xtile __temp_interest_expense = lag_interest_expense_lag_assets, nq(5)
gen covenant_high73 = (__temp_interest_expense == 1)
gen covenant_high74 = (__temp_interest_expense == 2)
gen covenant_high75 = (__temp_interest_expense == 3)
gen covenant_high76 = (__temp_interest_expense == 4)
gen covenant_high77 = (__temp_interest_expense == 5)
drop __temp_interest_expense

gen covenant_high78 = covenant_control1^2
gen covenant_high79 = covenant_control1^3
gen covenant_high80 = covenant_control2^2
gen covenant_high81 = covenant_control2^3
gen covenant_high82 = covenant_control3^2
gen covenant_high83 = covenant_control3^3
gen covenant_high84 = covenant_control4^2
gen covenant_high85 = covenant_control4^3
gen covenant_high86 = covenant_control5^2
gen covenant_high87 = covenant_control5^3

xtile __temp_covenant1 = covenant_control1, nq(5)
gen covenant_high88 = (__temp_covenant1 == 1)
gen covenant_high89 = (__temp_covenant1 == 2)
gen covenant_high90 = (__temp_covenant1 == 3)
gen covenant_high91 = (__temp_covenant1 == 4)
gen covenant_high92 = (__temp_covenant1 == 5)
drop __temp_covenant1

xtile __temp_covenant2 = covenant_control2, nq(5)
gen covenant_high93 = (__temp_covenant2 == 1)
gen covenant_high94 = (__temp_covenant2 == 2)
gen covenant_high95 = (__temp_covenant2 == 3)
gen covenant_high96 = (__temp_covenant2 == 4)
gen covenant_high97 = (__temp_covenant2 == 5)
drop __temp_covenant2

xtile __temp_covenant3 = covenant_control3, nq(5)
gen covenant_high98 = (__temp_covenant3 == 1)
gen covenant_high99 = (__temp_covenant3 == 2)
gen covenant_high100 = (__temp_covenant3 == 3)
gen covenant_high101 = (__temp_covenant3 == 4)
gen covenant_high102 = (__temp_covenant3 == 5)
drop __temp_covenant3

xtile __temp_covenant4 = covenant_control4, nq(5)
gen covenant_high103 = (__temp_covenant4 == 1)
gen covenant_high104 = (__temp_covenant4 == 2)
gen covenant_high105 = (__temp_covenant4 == 3)
gen covenant_high106 = (__temp_covenant4 == 4)
gen covenant_high107 = (__temp_covenant4 == 5)
drop __temp_covenant4

xtile __temp_covenant5 = covenant_control5, nq(5)
gen covenant_high108 = (__temp_covenant5 == 1)
gen covenant_high109 = (__temp_covenant5 == 2)
gen covenant_high110 = (__temp_covenant5 == 3)
gen covenant_high111 = (__temp_covenant5 == 4)
gen covenant_high112 = (__temp_covenant5 == 5)
drop __temp_covenant5

global control_column4_high "`control_high' "
forval i = 1/112 {
    global control_column4_high "$control_column4_high covenant_high`i'"
}

/***********************************
Calendar year-quarter indicator and Fiscal quarter indicator
***********************************/
gen cal_year = fyear
gen cal_quarter = ceil(month / 3)
gen cal_year_quarter = string(cal_year) + "Q" + string(cal_quarter)
gen fiscal_year = real(substr(datafqtr, 1, 4))
gen fiscal_quarter = real(substr(datafqtr, 6, 1))
gen fiscal_year_quarter = string(fiscal_year) + "Q" + string(fiscal_quarter)
encode cal_year_quarter, gen(cal_yq_num)
encode fiscal_year_quarter, gen(fiscal_yq_num)

/***********************************
Global Definition
***********************************/

global control_column1 "ln_at lag_tangible_assets_assets lag_market_to_book_ratio lag_sp500" 

global control_column2 "ln_at lag_tangible_assets_assets lag_market_to_book_ratio lag_sp500 lag_book_debt_assets lag_net_worth_assets lag_cash_assets lag_EBITDA_lag_assets EBITDA_lag_assets lag_cash_flow_lag_assets cash_flow_lag_assets lag_net_income_lag_assets net_income_lag_assets lag_interest_expense_lag_assets interest_expense_lag_assets "

global control_column3 "ln_at lag_tangible_assets_assets lag_market_to_book_ratio lag_sp500 lag_book_debt_assets lag_net_worth_assets lag_cash_assets lag_EBITDA_lag_assets EBITDA_lag_assets lag_cash_flow_lag_assets cash_flow_lag_assets lag_net_income_lag_assets net_income_lag_assets lag_interest_expense_lag_assets interest_expense_lag_assets covenant_control1 covenant_control2 covenant_control3 covenant_control4 covenant_control5"

//update control_column 4 to include the control variables in previous control
global control_column4 "ln_at lag_tangible_assets_assets lag_market_to_book_ratio lag_sp500 lag_book_debt_assets lag_net_worth_assets lag_cash_assets lag_EBITDA_lag_assets EBITDA_lag_assets lag_cash_flow_lag_assets cash_flow_lag_assets lag_net_income_lag_assets net_income_lag_assets lag_interest_expense_lag_assets interest_expense_lag_assets covenant_control1 covenant_control2 covenant_control3 covenant_control4 covenant_control5"

save "${root}/processing_data/database.dta",replace
/***********************************
First Difference Variable
***********************************/
do "${root}/do_file/clean_first_difference.do"

/***********************************
Drop conditions
***********************************/

drop if missing(at) | at<0 | missing(lag_assets) | missing(tangible_assets) | missing(book_debt) | ///
    missing(seq) | missing(che) | missing(net_working_capital) | missing(oibdp) | ///
    missing(cash_flow) | missing(net_income) | missing(market_to_book_ratio) | missing(xint)|missing(lag_assets) | missing(book_value_equity) | missing(market_value_equity) | missing(net_debt_issuance)
	

gen fiscal_quarter_id = fyear * 4 + fqtr 
sort gvkey fiscal_quarter_id
gen quarter_diff = fiscal_quarter_id - fiscal_quarter_id[_n-1] if gvkey == gvkey[_n-1]
replace quarter_diff = . if quarter_diff == . 
bysort gvkey (fiscal_quarter_id): gen consecutive_quarters = 1
replace consecutive_quarters = consecutive_quarters[_n-1] + 1 if quarter_diff == 1 & _n > 1
bysort gvkey (fiscal_quarter_id): egen max_consecutive = max(consecutive_quarters)
keep if max_consecutive >= 4


save "${root}/prepared_data/sufi_and_roberts(2009).dta",replace

/***********************************
First Difference Variable Appendix
***********************************/
use "${root}/processing_data/database.dta",clear
do "${root}/do_file/clean_first_difference_Appendix.do"

/***********************************
Drop conditions
***********************************/

drop if missing(at) | at<0 | missing(lag_assets) | missing(tangible_assets) | missing(book_debt) | ///
    missing(seq) | missing(che) | missing(net_working_capital) | missing(oibdp) | ///
    missing(cash_flow) | missing(net_income) | missing(market_to_book_ratio) | missing(xint)|missing(lag_assets) | missing(book_value_equity) | missing(market_value_equity) | missing(net_debt_issuance)
	

gen fiscal_quarter_id = fyear * 4 + fqtr 
sort gvkey fiscal_quarter_id
gen quarter_diff = fiscal_quarter_id - fiscal_quarter_id[_n-1] if gvkey == gvkey[_n-1]
replace quarter_diff = . if quarter_diff == . 
bysort gvkey (fiscal_quarter_id): gen consecutive_quarters = 1
replace consecutive_quarters = consecutive_quarters[_n-1] + 1 if quarter_diff == 1 & _n > 1
bysort gvkey (fiscal_quarter_id): egen max_consecutive = max(consecutive_quarters)
keep if max_consecutive >= 4


save "${root}/prepared_data/sufi_and_roberts(2009).dta",replace



