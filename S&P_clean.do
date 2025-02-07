/***********************************************************************************************
This transcript:
- Clean S&P 500 dataset and generate the S&P 500 dummy
***********************************************************************************************/

clear all
set more off

* Load the raw data
use "${root}/raw_data/sp500.dta", clear

* Create a dummy variable for S&P 500 membership (81, 91, or 92)
gen sp500 = inlist(spmim, 81, 91, 92)

* Handle missing values (if any)
replace sp500 = 0 if missing(sp500)

* Label the dummy variable
label define sp500_label 0 "Not in S&P 500" 1 "In S&P 500"
label values sp500 sp500_label
label variable sp500 "S&P membership indicator {0,1}"

* Collapse the data to the annual level (by firm-year)
* Use (max) to assign 1 if any month within the year qualifies
collapse (max) sp500, by(gvkey fyear)

* Save the cleaned data
save "${root}/processing_data/sp500_clean.dta", replace

