/***********************************************************************************************
This transcript:
- Output Table III in Sufi and Roberts (2009)
***********************************************************************************************/
clear all
set more off
use "${root}/prepared_data/sufi_and_roberts(2009).dta"
xtset gvkey time

foreach var of global control_column2 {
    drop if missing(`var')
}

xtreg net_debt_issuance violation lag_violation $control_column1 i.cal_yq_num i.fiscal_yq_num, fe robust
local r2_fixed1 = round(e(r2), 3)
est store fixed1
levelsof gvkey if e(sample), local(fixed1_firms)
local num_firms_fixed1 : word count `fixed1_firms'

xtreg net_debt_issuance violation lag_violation $control_column2 i.cal_yq_num i.fiscal_yq_num, fe robust
local r2_fixed2 = round(e(r2), 3)
est store fixed2
levelsof gvkey if e(sample), local(fixed2_firms)
local num_firms_fixed2 : word count `fixed2_firms'

xtreg net_debt_issuance violation lag_violation $control_column3 i.cal_yq_num i.fiscal_yq_num, fe robust
local r2_fixed3 = round(e(r2), 3)
est store fixed3
levelsof gvkey if e(sample), local(fixed3_firms)
local num_firms_fixed3 : word count `fixed3_firms'

xtreg net_debt_issuance violation lag_violation $control_column4 i.cal_yq_num i.fiscal_yq_num, fe robust
local r2_fixed4 = round(e(r2), 3)
est store fixed4
levelsof gvkey if e(sample), local(fixed4_firms)
local num_firms_fixed4 : word count `fixed4_firms'

foreach var of global control_column3d {
    drop if missing(`var')
}

reg d_net_debt_issuance d_violation d_lag_violation $control_column1d i.cal_yq_num i.fiscal_yq_num, robust
local r2_d1 = round(e(r2), 3)
est store d1
levelsof gvkey if e(sample), local(d1_firms)
local num_firms_d1 : word count `d1_firms'

reg d_net_debt_issuance d_violation d_lag_violation $control_column2d i.cal_yq_num i.fiscal_yq_num, robust
local r2_d2 = round(e(r2), 3)
est store d2
levelsof gvkey if e(sample), local(d2_firms)
local num_firms_d2 : word count `d2_firms'

reg d_net_debt_issuance d_violation d_lag_violation $control_column3d i.cal_yq_num i.fiscal_yq_num, robust
local r2_d3 = round(e(r2), 3)
est store d3
levelsof gvkey if e(sample), local(d3_firms)
local num_firms_d3 : word count `d3_firms'

reg d_net_debt_issuance d_violation d_lag_violation $control_column4d i.cal_yq_num i.fiscal_yq_num, robust
local r2_d4 = round(e(r2), 3)
est store d4
levelsof gvkey if e(sample), local(d4_firms)
local num_firms_d4 : word count `d4_firms'

esttab fixed1 fixed2 fixed3 fixed4 using "${root}/output/table3.tex", replace ///
    prehead("\begin{tabular}{l*{4}{c}} \hline\hline") ///
    posthead("\hline \\ \multicolumn{5}{c}{\textbf{Panel A: Fixed Effects}} \\\\[-1ex]") ///
    keep(violation lag_violation) ///
    b(%9.2f) se(%9.2f) ///
    collabels("\makecell{None}" "\makecell{Covenant control \\ variables}" "\makecell{Covenant control variables, \\ covenant interaction \\ control variables}" "\makecell{Control variables, \\ control variables squared, \\ control variables to the third power, \\ and quintile indicators for each control}") ///
    fragment compress

file open table3 using "${root}/output/table3.tex", write append
file write table3 " \hline \multicolumn{1}{l}{Number of firm-quarter observations} & `obs_fixed1' & `obs_fixed2' & `obs_fixed3' & `obs_fixed4' \\\\ "
file write table3 " \multicolumn{1}{l}{Number of firms} & `num_firms_fixed1' & `num_firms_fixed2' & `num_firms_fixed3' & `num_firms_fixed4' \\\\ "
file write table3 " \multicolumn{1}{l}{R\(^2\)} & `r2_fixed1' & `r2_fixed2' & `r2_fixed3' & `r2_fixed4' \\\\ "
file close table3

esttab d1 d2 d3 d4 using "${root}/output/table3.tex", append ///
    posthead("\hline \\ \multicolumn{5}{c}{\textbf{Panel B: First Differences}} \\\\[-1ex]") ///
    keep(d_violation d_lag_violation) ///
    b(%9.2f) se(%9.2f) ///
    collabels("\makecell{None}" "\makecell{Covenant control \\ variables}" "\makecell{Covenant control variables, \\ covenant interaction \\ control variables}" "\makecell{Control variables, \\ control variables squared, \\ control variables to the third power, \\ and quintile indicators for each control}") ///
    fragment compress

file open table3 using "${root}/output/table3.tex", write append
file write table3 " \hline \multicolumn{1}{l}{Number of firm-quarter observations} & `obs_d1' & `obs_d2' & `obs_d3' & `obs_d4' \\\\ "
file write table3 " \multicolumn{1}{l}{Number of firms} & `num_firms_d1' & `num_firms_d2' & `num_firms_d3' & `num_firms_d4' \\\\ "
file write table3 " \multicolumn{1}{l}{R\(^2\)} & `r2_d1' & `r2_d2' & `r2_d3' & `r2_d4' \\\\ \hline\hline \end{tabular} "
file close table3
