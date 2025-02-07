/***********************************************************************************************
This transcript:
- Cleans the industry sale volatility and generates the variable
***********************************************************************************************/


clear all
set more off
use "${root}/raw_data/industry_volatility.dta", clear
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

// Drop finance and public/non-profit organizations

// Generate dummy variables for remaining industry groups
tab ind_group, gen(ind_dummy)

// Drop unnecessary ind_dummy1 (no longer needed)
drop ind_dummy1

// Generate year variable based on fiscal quarter year
gen year = fyearq

// Calculate cumulative quarterly sales
bysort ind_group year (fqtr): gen industry_quarterly_sales = sum(revtq)

// Collapse to calculate mean and standard deviation of revenue per industry per year
collapse (mean) quarterly_sales = revtq (sd) sales_volatility = revtq, by(ind_group year)

// Rename variables for clarity
rename year fyear
rename sales_volatility industry_sale_volatility

// Label the variables
label variable quarterly_sales "Mean Quarterly Sales (Revenue)"
label variable industry_sale_volatility "Industry Sales Volatility (Standard Deviation)"

// Winsorize industry sales volatility at 5th and 95th percentiles
winsor2 industry_sale_volatility, cuts(5,95) replace

// Drop observations with missing industry sale volatility
drop if missing(industry_sale_volatility)

// Save the cleaned dataset
save "${root}/processing_data/industry_clean.dta", replace
