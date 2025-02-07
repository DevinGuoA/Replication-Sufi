/***********************************************************************************************
This transcript:
- generate first difference for variables needed in Table III using L1
***********************************************************************************************/

foreach var in net_debt_issuance violation lag_violation ln_at lag_tangible_assets_assets lag_market_to_book_ratio lag_sp500 lag_cash_assets lag_EBITDA_lag_assets EBITDA_lag_assets lag_cash_flow_lag_assets cash_flow_lag_assets lag_net_income_lag_assets net_income_lag_assets lag_book_debt_assets lag_net_worth_assets {
    gen d_`var' = `var' - L1.`var'
}

gen d_interest_expense_assets = interest_expense_lag_assets - L1.interest_expense_lag_assets
gen d_interest_expense_lag_assets = interest_expense_lag_assets - L1.interest_expense_lag_assets

foreach i of numlist 1/5 {
    gen d_covenant_control`i' = covenant_control`i' - L1.covenant_control`i'
}

foreach i of numlist 1/112 {
    gen d_covenant_high`i' = covenant_high`i' - L1.covenant_high`i'
}

// Update control columns with L1 differences
global control_column1d "d_ln_at d_lag_tangible_assets_assets d_lag_market_to_book_ratio d_lag_sp500"

global control_column2d "d_ln_at d_lag_tangible_assets_assets d_lag_market_to_book_ratio d_lag_sp500 d_lag_book_debt_assets d_lag_net_worth_assets d_lag_cash_assets d_lag_EBITDA_lag_assets d_EBITDA_lag_assets d_lag_cash_flow_lag_assets d_cash_flow_lag_assets d_lag_net_income_lag_assets d_net_income_lag_assets d_interest_expense_assets d_interest_expense_lag_assets"

global control_column3d "d_ln_at d_lag_tangible_assets_assets d_lag_market_to_book_ratio d_lag_sp500 d_lag_book_debt_assets d_lag_net_worth_assets d_lag_cash_assets d_lag_EBITDA_lag_assets d_EBITDA_lag_assets d_lag_cash_flow_lag_assets d_cash_flow_lag_assets d_lag_net_income_lag_assets d_net_income_lag_assets d_interest_expense_assets d_interest_expense_lag_assets d_covenant_control1 d_covenant_control2 d_covenant_control3 d_covenant_control4 d_covenant_control5 d_covenant_high1 d_covenant_high2 d_covenant_high3 d_covenant_high4 d_covenant_high5 d_covenant_high6 d_covenant_high7 d_covenant_high8 d_covenant_high9"

global control_column4d "d_ln_at d_lag_tangible_assets_assets d_lag_market_to_book_ratio d_lag_sp500 d_lag_book_debt_assets d_lag_net_worth_assets d_lag_cash_assets d_lag_EBITDA_lag_assets d_EBITDA_lag_assets d_lag_cash_flow_lag_assets d_cash_flow_lag_assets d_lag_net_income_lag_assets d_net_income_lag_assets d_interest_expense_assets d_interest_expense_lag_assets d_covenant_control1 d_covenant_control2 d_covenant_control3 d_covenant_control4 d_covenant_control5 d_covenant_high1 d_covenant_high2 d_covenant_high3 d_covenant_high4 d_covenant_high5 d_covenant_high6 d_covenant_high7 d_covenant_high8 d_covenant_high9 d_covenant_high10 d_covenant_high11 d_covenant_high12 d_covenant_high13 d_covenant_high14 d_covenant_high15 d_covenant_high16 d_covenant_high17 d_covenant_high18 d_covenant_high19 d_covenant_high20 d_covenant_high21 d_covenant_high22 d_covenant_high23 d_covenant_high24 d_covenant_high25 d_covenant_high26 d_covenant_high27 d_covenant_high28 d_covenant_high29 d_covenant_high30 d_covenant_high31 d_covenant_high32 d_covenant_high33 d_covenant_high34 d_covenant_high35 d_covenant_high36 d_covenant_high37 d_covenant_high38 d_covenant_high39 d_covenant_high40 d_covenant_high41 d_covenant_high42 d_covenant_high43 d_covenant_high44 d_covenant_high45 d_covenant_high46 d_covenant_high47 d_covenant_high48 d_covenant_high49 d_covenant_high50 d_covenant_high51 d_covenant_high52 d_covenant_high53 d_covenant_high54 d_covenant_high55 d_covenant_high56 d_covenant_high57 d_covenant_high58 d_covenant_high59 d_covenant_high60 d_covenant_high61 d_covenant_high62 d_covenant_high63 d_covenant_high64 d_covenant_high65 d_covenant_high66 d_covenant_high67 d_covenant_high68 d_covenant_high69 d_covenant_high70 d_covenant_high71 d_covenant_high72 d_covenant_high73 d_covenant_high74 d_covenant_high75 d_covenant_high76 d_covenant_high77 d_covenant_high78 d_covenant_high79 d_covenant_high80 d_covenant_high81 d_covenant_high82 d_covenant_high83 d_covenant_high84 d_covenant_high85 d_covenant_high86 d_covenant_high87 d_covenant_high88 d_covenant_high89 d_covenant_high90 d_covenant_high91 d_covenant_high92 d_covenant_high93 d_covenant_high94 d_covenant_high95 d_covenant_high96 d_covenant_high97 d_covenant_high98 d_covenant_high99 d_covenant_high100 d_covenant_high101 d_covenant_high102 d_covenant_high103 d_covenant_high104 d_covenant_high105 d_covenant_high106 d_covenant_high107 d_covenant_high108 d_covenant_high109 d_covenant_high110 d_covenant_high111 d_covenant_high112"
