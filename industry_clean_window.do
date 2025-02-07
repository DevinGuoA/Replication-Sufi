// Load the Compustat firm-level dataset
use "${root}/raw_data/industry_volatility_window.dta", clear

// Step 1: Convert SIC to numeric and define industry groups
destring sic, replace
gen ind_group = .
replace ind_group = 1 if (sic >= 100 & sic <= 1999)    // Agriculture and mining
replace ind_group = 2 if (sic >= 2000 & sic <= 3999)   // Manufacturing
replace ind_group = 3 if (sic >= 4000 & sic <= 4799)   // Transportation and communication
replace ind_group = 4 if (sic >= 4800 & sic <= 4999)   // Utilities
replace ind_group = 5 if (sic >= 6000 & sic <= 6999)   // Finance (to be excluded)
replace ind_group = 6 if (sic >= 5000 & sic <= 5999)   // Wholesale and retail trade
replace ind_group = 7 if (sic >= 7000 & sic <= 8999)   // Services
replace ind_group = 8 if (sic >= 9000 & sic <= 9999)   // Public and non-profit organizations

// Create industry dummies for potential analysis
tab ind_group, gen(ind_dummy)

// Step 2: Aggregate firm-level sales (revt) to compute annual industry sales
collapse (sum) revt, by(ind_group fyear)
rename revt industry_sale

// Step 3: Calculate the five-year rolling volatility of industry sales
sort ind_group fyear

// Use rangestat to calculate five-year rolling standard deviation
rangestat (sd) industry_sale, by(ind_group) interval(fyear -4 0)
rename industry_sale_sd industry_sale_volatility

// Step 4: Save the result

save "${root}/processing_data/industry_clean_window.dta", replace
