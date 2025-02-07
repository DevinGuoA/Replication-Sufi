/**********************************************************************************************
This script: 
- Generates figure 1
***********************************************************************************************/

clear all
set more off

use "${root}/prepared_data/sufi(2009).dta", clear

* Generate deciles for lag_EBITDA_to_assets_cash;
xtile decile_ebitda = lag_EBITDA_to_assets_cash, nq(10)

* Calculate cash/assets ratio;
gen cash_assets = che / at

* Compute average values by decile;
collapse (mean) cash_assets line_credit = lineofcredit, by(decile_ebitda)

* plot
twoway (connected cash_assets decile_ebitda, sort lpattern(dash) lcolor(black) ///
        ylabel(0(0.1)0.6) ytitle("Cash/assets")) ///
       (connected line_credit decile_ebitda, sort lpattern(solid) lcolor(black) ///
        yaxis(2) ylabel(0(0.2)1, axis(2)) ytitle("Fraction with line of credit", axis(2))), ///
       legend(order(1 "Average cash/assets" 2 "Fraction with line of credit") ///
       col(2) position(bottom)) ///
       xtitle("Deciles of EBITDA/(assets-cash)")
graph export "${root}/output/Figure1.png", replace
