/***********************************************************************************************
This transcript:
- Clean the database2 using Sufi(2009) definitions
***********************************************************************************************/
use "${root}/prepared_data/database3.dta",clear

/***********************************
Drop conditions sets 
***********************************/
gen asset_positive = (at > 0)                      
gen ebitda_ok = !missing(oibdp)                    
gen price_ok = !missing(prcc_f)                   
gen shares_ok = !missing(csho)                     
gen preferred_stock_ok = !missing(pstk)  
gen lt_ok = !missing(lt)
gen sale_ok =!missing(sale)
gen txdb_ok = !missing(txdb)
gen pstk_ok = !missing(pstk)
gen dcvt_ok = !missing(dcvt)
gen prcc_f_ok=!missing(prcc_f)
gen csho_ok=!missing(csho)

gen valid_year = (fyear >= 1996 & fyear <= 2003) & asset_positive & ebitda_ok & price_ok & preferred_stock_ok & lt_ok & sale_ok & txdb_ok & pstk_ok & dcvt_ok & prcc_f_ok & csho_ok

gen consecutive_years = 0                          
bysort gvkey (fyear): replace consecutive_years = ///
    cond(valid_year, sum(valid_year[_n] & fyear == fyear[_n-1] + 1) + 1, 0)

egen max_consecutive_years = max(consecutive_years), by(gvkey)
gen four_years_valid = (max_consecutive_years >= 4)

keep if four_years_valid == 1

drop asset_positive price_ok shares_ok preferred_stock_ok consecutive_years max_consecutive_years valid_year

drop if missing(debt_to_assets)
drop if missing(scaled_industry_sale_volatility)
drop if missing(scale_cash_flow_volatility)
drop if missing(EBITDA_to_assets_cash)
drop if missing(otc)
drop if missing(market_to_book_cash_adjusted)
drop if missing(net_worth)
drop if missing(tangible_assets_to_assets_cash)
drop if missing(debt/assets)
drop if missing(sp500)
drop if missing(exchg)
drop if (missing(total_line_assets) & randomsample == 1)
drop if (missing(used_line_assets) & randomsample == 1)
drop if (missing(unused_line_assets) & randomsample == 1)
drop if (missing(unused_line_unused_line_cash) & randomsample == 1)
drop if (missing(lineofcredit_rs) & randomsample == 1)

* winsor2 process *
winsor2 assets_cash,cuts(5,95) replace
winsor2 debt_to_assets, cuts(5,95) replace
winsor2 EBITDA_to_assets_cash, cuts(5,95) replace
winsor2 tangible_assets_to_assets_cash,cuts(5,95) replace
winsor2 net_worth,cuts(5,95) replace
winsor2 market_to_book_cash_adjusted, cuts(5,95) replace
winsor2 scale_cash_flow_volatility,cuts(5,95) replace
winsor2 scale_cash_flow_volatility,cuts(5,95) replace
winsor2 scaled_industry_sale_volatility,cuts(5,95) replace
winsor2 scaled_industry_sale_volatility,cuts(5,95) replace
winsor2 lag_ln_assets_cash,cuts(5,95)replace
winsor2 lag_EBITDA_to_assets_cash,cuts(5,95)replace
winsor2 lag_tangible,cuts(5,95)replace
winsor2 lag_net_worth,cuts(5,95)replace
winsor2 lag_market_to_book_cash_adjusted,cuts(5,95)replace
winsor2 lag_firm_age,cuts(5,95)replace

save "${root}/prepared_data/sufi(2009).dta", replace
