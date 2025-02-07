use "${root}/raw_data/cashflow_volatility_window.dta", clear
destring gvkey,replace
gen cash_flow = ni+dp
sort gvkey fyear
gen start_year = fyear - 4 if fyear >= 1996
rangestat (sd) cash_flow, by(gvkey) interval(fyear start_year fyear)
rename cash_flow_sd cash_flow_volatility
drop start_year
keep gvkey fyear cash_flow_volatility
duplicates drop gvkey fyear,force
save "${root}/processing_data/cash_flow_volatility_window.dta", replace
