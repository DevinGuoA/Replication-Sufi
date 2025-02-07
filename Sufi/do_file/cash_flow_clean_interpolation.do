/***********************************************************************************************
This transcript:
- Calculates cash flow volatility in two ways:
  1. Dropping firm-years with missing cash flow volatility after calculation.
  2. Interpolating missing values before volatility calculation.
***********************************************************************************************/

clear all
set more off

* Load the raw quarterly dataset
use "${root}/raw_data/cash_flow_volatility.dta", clear

destring gvkey, replace

/***********************************
 Part 1: Drop Method
***********************************/

/*
* Generate net cash flow
gen net_cash_flow = oancfy + ivncfy + fincfy

* Create a time variable for quarterly data
gen time = yq(fyearq, fqtr)
format time %tq  // Format as quarterly

* Handle duplicates by collapsing to a single row per firm and quarter
collapse (mean) net_cash_flow oancfy ivncfy fincfy, by(gvkey time)

* Generate fyear from the time variable
gen fyear = year(dofq(time))

* Set time-series structure
tsset gvkey time

* Compute within-year cash flow volatility
egen cash_flow_volatility = sd(net_cash_flow), by(gvkey fyear)

* Collapse to annual level (mean net cash flow and volatility)
collapse (mean) net_cash_flow (first) cash_flow_volatility, by(gvkey fyear)

* Drop firm-years where cash flow volatility is missing
drop if missing(cash_flow_volatility)

* Rename variables for clarity before saving
rename net_cash_flow net_cash_flow_drop
rename cash_flow_volatility cash_flow_volatility_drop

* Save cleaned dataset (drop method)
save "${root}/cleaned_data/cash_flow_clean_drop.dta", replace
*/


/***********************************
 Part 2: Interpolation for Missing Quarterly Values 
***********************************/

* Reload the original raw data
use "${root}/raw_data/cash_flow_volatility.dta", clear

* Ensure gvkey is properly formatted
destring gvkey, replace

* Generate net cash flow again
gen net_cash_flow = oancfy + ivncfy + fincfy

* Create a time variable for quarterly data
gen time = yq(fyearq, fqtr)
format time %tq  // Format as quarterly

* Handle duplicates by collapsing to a single row per firm and quarter
collapse (mean) net_cash_flow oancfy ivncfy fincfy, by(gvkey time)

* Generate fyear from the time variable
gen fyear = year(dofq(time))

* Set time-series structure
tsset gvkey time

* Interpolate missing quarterly values
ipolate net_cash_flow time, by(gvkey) generate(net_cash_flow_interp)

* Compute within-year cash flow volatility using the interpolated cash flow
egen cash_flow_volatility = sd(net_cash_flow_interp), by(gvkey fyear)

* Collapse to the annual level (mean interpolated cash flow and volatility)
collapse (mean) net_cash_flow_interp (first) cash_flow_volatility, by(gvkey fyear)

* Optionally save the result
save "${root}/processing_data/cash_flow_volatility_clean.dta", replace

* su cash_flow_volatility,detail *

/***********************************
 Part 3: Compare the differences
***********************************/

/*
clear all
set more off

* Load the "drop" method dataset
use "${root}/cleaned_data/cash_flow_clean_drop.dta", clear

* Merge with the "interpolation" method dataset
merge 1:1 gvkey fyear using "${root}/cleaned_data/cash_flow_clean_interpolation.dta", keep(match)
keep if _merge == 3
drop _merge

* Generate difference variables
gen diff_net_cash_flow = net_cash_flow_interp_final - net_cash_flow_drop
gen diff_cash_flow_volatility = cash_flow_volatility_interp - cash_flow_volatility_drop

* Summarize the differences
summarize diff_cash_flow_volatility cash_flow_volatility_interp cash_flow_volatility_drop

save "${root}/cleaned_data/cash_flow_clean_merged.dta", replace
*/
