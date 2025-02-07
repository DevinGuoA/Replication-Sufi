/***********************************************************************************************
This script: 
Generate the Table 3 in Sufi(2009)
***********************************************************************************************/
clear all
set more off

use "${root}/prepared_data/sufi(2009).dta", clear
xtset gvkey fyear
misstable summarize

/***********************************
Regression
***********************************/

/***********************************
Regression and Calculate Number of Firms
***********************************/

quietly probit lineofcredit lag_EBITDA_to_assets_cash lag_tangible lag_ln_assets_cash lag_net_worth ///
    lag_market_to_book_cash_adjusted lag_industry_volatility sp500 otc lag_firm_age i.fyear ///
    ind_dummy1 ind_dummy2 ind_dummy3 ind_dummy4 ind_dummy6 ind_dummy7 ind_dummy8, vce(cluster gvkey) 
est store reg1

levelsof gvkey if e(sample), local(firms_reg1)
display "Number of firms in reg1: " wordcount("`firms_reg1'")

probit lineofcredit_rs lag_EBITDA_to_assets_cash lag_tangible lag_ln_assets_cash lag_net_worth ///
    lag_market_to_book_cash_adjusted lag_industry_volatility sp500 otc lag_firm_age i.fyear ///
    ind_dummy1 ind_dummy2 ind_dummy3 ind_dummy4 ind_dummy6 ind_dummy7 ind_dummy8 if randomsample==1, cluster(gvkey) 
est store reg2

levelsof gvkey if e(sample), local(firms_reg2)
display "Number of firms in reg2: " wordcount("`firms_reg2'")

quietly reg total_line_total_line_cash lag_EBITDA_to_assets_cash lag_tangible lag_ln_assets_cash ///
    lag_net_worth lag_market_to_book_cash_adjusted lag_industry_volatility sp500 otc lag_firm_age ///
    i.fyear ind_dummy1 ind_dummy2 ind_dummy3 ind_dummy4 ind_dummy6 ind_dummy7 ind_dummy8 if randomsample==1, cluster(gvkey)
est store reg4

levelsof gvkey if e(sample), local(firms_reg4)
display "Number of firms in reg4: " wordcount("`firms_reg4'")

quietly reg total_line_total_line_cash lag_EBITDA_to_assets_cash lag_tangible lag_ln_assets_cash ///
    lag_net_worth lag_market_to_book_cash_adjusted lag_industry_volatility sp500 otc lag_firm_age ///
    i.fyear ind_dummy1 ind_dummy2 ind_dummy3 ind_dummy4 ind_dummy6 ind_dummy7 ind_dummy8 ///
    if lineofcredit_rs==1 & randomsample==1, cluster(gvkey) robust
est store reg5

levelsof gvkey if e(sample), local(firms_reg5)
display "Number of firms in reg5: " wordcount("`firms_reg5'")

quietly reg unused_line_unused_line_cash lag_EBITDA_to_assets_cash lag_tangible lag_ln_assets_cash ///
    lag_net_worth lag_market_to_book_cash_adjusted lag_industry_volatility sp500 otc lag_firm_age ///
    i.fyear ind_dummy1 ind_dummy2 ind_dummy3 ind_dummy4 ind_dummy6 ind_dummy7 ind_dummy8 if randomsample==1, cluster(gvkey) robust
est store reg6

levelsof gvkey if e(sample), local(firms_reg6)
display "Number of firms in reg6: " wordcount("`firms_reg6'")

quietly reg unused_line_unused_line_cash lag_EBITDA_to_assets_cash lag_tangible lag_ln_assets_cash ///
    lag_net_worth lag_market_to_book_cash_adjusted lag_industry_volatility sp500 otc lag_firm_age ///
    i.fyear ind_dummy1 ind_dummy2 ind_dummy3 ind_dummy4 ind_dummy6 ind_dummy7 ind_dummy8 ///
    if lineofcredit_rs==1 & randomsample==1, cluster(gvkey) robust
est store reg7

levelsof gvkey if e(sample), local(firms_reg7)
display "Number of firms in reg7: " wordcount("`firms_reg7'")


/***********************************
Export Table
***********************************/
esttab reg1 reg2 reg4 reg5 reg6 reg7 using "${root}/output/table3_raw.tex", replace ///
    keep(lag_EBITDA_to_assets_cash lag_tangible lag_ln_assets_cash lag_net_worth lag_market_to_book_cash_adjusted lag_industry_volatility sp500 otc lag_firm_age) /// Keep only xvariable coefficients
    mgroups("Firm has line of credit{0,1} Probit (Marginal Effects)" ///
            "Total line/(total line + cash) OLS" ///
            "Unused line/(unused line + cash) OLS", ///
            pattern(1 0 1 0 1 0)) /// Correct grouping
    addnotes("Full = Full Sample, Random = Random Sample") ///
    alignment(c) ///
    b(3) se(3) /// Display coefficients and standard errors with 3 decimal places
    booktabs ///
    lines ///
    label
	