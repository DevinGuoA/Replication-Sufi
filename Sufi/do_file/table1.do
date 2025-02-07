/**********************************************************************************************
This script: 
- Generates a table with Full Sample and Random Sample side by side with aligned variables.
***********************************************************************************************/
clear all
set more off

use "${root}/prepared_data/sufi(2009).dta", clear

* Full sample and Random sample variable lists
local fullsamplelist lineofcredit debt_to_assets EBITDA_to_assets_cash tangible_assets_to_assets_cash ///
    net_worth assets_cash market_to_book_cash_adjusted scaled_industry_sale_volatility ///
    scale_cash_flow_volatility sp500 otc firm_age

local randomsamplelist lineofcredit_rs total_line_assets unused_line_assets used_line_assets ///
    debt_to_assets EBITDA_to_assets_cash tangible_assets_to_assets_cash net_worth assets_cash ///
    market_to_book_cash_adjusted scaled_industry_sale_volatility scale_cash_flow_volatility ///
    sp500 otc firm_age

* Set variable labels to match the required order and descriptions
label variable lineofcredit "Has line of credit {0,1}"
label variable lineofcredit_rs "Has line of credit {0,1}"  // Same label for Full and Random samples

label variable total_line_assets "Total line of credit/assets"
label variable unused_line_assets "Unused line of credit/assets"
label variable used_line_assets "Used line of credit/assets"
label variable debt_to_assets "Book debt/assets"
label variable EBITDA_to_assets_cash "EBITDA/(assets-cash)"
label variable tangible_assets_to_assets_cash "Tangible assets/(assets-cash)"
label variable net_worth "Net worth, cash adjusted"
label variable assets_cash "Assets-cash"
label variable market_to_book_cash_adjusted "Market-to-book, cash adjusted"
label variable scaled_industry_sale_volatility "Industry sales volatility"
label variable scale_cash_flow_volatility "Cash-flow volatility"
label variable sp500 "Not in an S\&P index {0,1}"
label variable otc "Traded over the counter {0,1}"
label variable firm_age "Firm age (years since IPO)"

* Generate summary statistics for Full Sample
estpost tabstat `fullsamplelist', statistics(mean median sd) columns(statistics)
est store a

* Generate summary statistics for Random Sample
estpost tabstat `randomsamplelist' if randomsample==1, statistics(mean median sd) columns(statistics)
est store b

* Create LaTeX table using esttab, with the specified order and group headers
esttab a b using "${root}/output/table1_raw.tex", ///
    replace mtitles("\textbf{\emph{Full Sample}}" "\textbf{\emph{Random Sample}}") ///
    collabels(\multicolumn{1}{c}{{Mean}} \multicolumn{1}{c}{{Median}} \multicolumn{1}{c}{{St.Dev}}) ///
    cells("mean(fmt(3)) p50(fmt(3)) sd(fmt(3))") /// Use mean, median (p50), and standard deviation (sd)
    label noobs booktabs ///
    order(lineofcredit lineofcredit_rs total_line_assets unused_line_assets used_line_assets ///
          debt_to_assets EBITDA_to_assets_cash tangible_assets_to_assets_cash net_worth ///
          assets_cash market_to_book_cash_adjusted scaled_industry_sale_volatility ///
          scale_cash_flow_volatility sp500 otc firm_age) ///
    refcat(lineofcredit "\textit{Line of Credit Variables}" debt_to_assets "\textit{Firm Characteristics}", nolabel) ///
    alignment(c)  // Center-align the table content
