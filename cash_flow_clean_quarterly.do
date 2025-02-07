* Reload the original raw data
use "${root}/raw_data/cash_flow_volatility_quarterly.dta", clear
destring gvkey, replace
gen net_cash_flow = niq+dpq
gen time = yq(fyearq, fqtr)
format time %tq
assert !missing(time)  
collapse (mean) net_cash_flow, by(gvkey time)
gen fyear = year(dofq(time))
sort gvkey time 
bysort gvkey fyear: egen cash_flow_volatility = sd(net_cash_flow)
bysort gvkey fyear: egen annual_cash_flow = total(net_cash_flow)
duplicates drop gvkey fyear, force
winsor2 cash_flow_volatility, cuts(5,95) replace
drop if missing(cash_flow_volatility)
keep gvkey fyear annual_cash_flow cash_flow_volatility
order gvkey fyear annual_cash_flow cash_flow_volatility
duplicates drop gvkey fyear,force
save "${root}/processing_data/cash_flow_volatility_quarterly.dta", replace
