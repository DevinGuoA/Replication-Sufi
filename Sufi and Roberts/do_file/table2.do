/***********************************************************************************************
This transcript:
- Output Table II in Sufi and Roberts (2009)
***********************************************************************************************/
clear all
set more off

use "${root}/prepared_data/sufi_and_roberts(2009).dta", clear

global table2 "net_debt_issuance net_equity_issuance book_debt_assets net_worth_assets net_working_capital_assets cash_assets EBITDA_lag_assets cash_flow_lag_assets net_income_lag_assets interest_expense_lag_assets market_to_book_ratio tangible_assets_assets ln_at"

estpost tabstat $table2, statistics(mean median sd) columns(statistics)
est store table2

esttab table2 using "${root}/output/table2.tex", ///
    replace booktabs label noobs alignment(c) /// Center-align, clean formatting
    cells("mean(fmt(3)) p50(fmt(3)) sd(fmt(3))") /// Use mean, median (p50), and standard deviation (sd)
    collabels("\multicolumn{1}{c}{Mean}" "\multicolumn{1}{c}{Median}" "\multicolumn{1}{c}{SD}") ///
    title("Summary Statistics Table") ///
    mgroups("Capital structure variables" 3 "Covenant control variables" 7 "Other control variables" 3, pattern(1 0 0 1 0 0 1)) ///
    order(net_debt_issuance net_equity_issuance book_debt_assets ///
          net_worth_assets net_working_capital_assets cash_assets EBITDA_lag_assets ///
          cash_flow_lag_assets net_income_lag_assets interest_expense_lag_assets ///
          market_to_book_ratio tangible_assets_assets ln_at) ///
    refcat(net_debt_issuance "\textit{Capital Structure Variables}" net_worth_assets "\textit{Covenant Control Variables}" market_to_book_ratio "\textit{Other Control Variables}", nolabel)
