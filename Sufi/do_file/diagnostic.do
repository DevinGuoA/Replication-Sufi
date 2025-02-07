/***********************************************************************************************
This script: 
Check which firms are missing in this process and output results to LaTeX
***********************************************************************************************/
use "${root}/prepared_data/sufi(2009).dta", clear 
merge 1:1 gvkey fyear using "${root}/raw_data/sufi(2009).dta"
keep if _merge == 2
save "${root}/prepared_data/diagnostic.dta", replace
keep gvkey fyear
duplicates drop
save "${root}/prepared_data/missinglist.dta", replace
use "${root}/prepared_data/database3.dta", clear
merge 1:1 gvkey fyear using "${root}/prepared_data/missinglist.dta"
keep if _merge == 3
misstable summarize, generate(missing_)

count if costat=="I" & randomsample==1

count if costat=="I" 
