/***********************************************************************************************
This transcript:
- generate first difference for variables needed in Table III
***********************************************************************************************/
gen d_net_debt_issuance=net_debt_issuance-L1.net_debt_issuance
gen d_violation=violation-L1.violation
gen d_lag_violation=lag_violation-L1.lag_violation
gen d_ln_at = ln_at - L1.ln_at
gen d_lag_tangible_assets_assets = lag_tangible_assets_assets - L1.lag_tangible_assets_assets
gen d_lag_market_to_book_ratio = lag_market_to_book_ratio - L1.lag_market_to_book_ratio
gen d_lag_sp500 = lag_sp500 - L1.lag_sp500
gen d_lag_cash_assets = lag_cash_assets - L1.lag_cash_assets
gen d_lag_EBITDA_lag_assets = lag_EBITDA_lag_assets - L1.lag_EBITDA_lag_assets
gen d_EBITDA_lag_assets = EBITDA_lag_assets - L1.EBITDA_lag_assets
gen d_lag_cash_flow_lag_assets = lag_cash_flow_lag_assets - L1.lag_cash_flow_lag_assets
gen d_cash_flow_lag_assets = cash_flow_lag_assets - L1.cash_flow_lag_assets
gen d_lag_net_income_lag_assets = lag_net_income_lag_assets - L1.lag_net_income_lag_assets
gen d_net_income_lag_assets = net_income_lag_assets - L1.net_income_lag_assets
gen d_interest_expense_assets = interest_expense_lag_assets - L1.interest_expense_lag_assets
gen d_interest_expense_lag_assets = interest_expense_lag_assets - L1.interest_expense_lag_assets
gen d_lag_book_debt_assets = lag_book_debt_assets - L2.lag_book_debt_assets
gen d_lag_net_worth_assets = lag_net_worth_assets - L2.lag_net_worth_assets
 
foreach i of numlist 1/4 {
    gen d_covenant_control`i' = covenant_control`i' - L2.covenant_control`i'
}
gen d_covenant_control5 = covenant_control5-L1.covenant_control5

gen d_covenant_high1 = covenant_high1 - L1.covenant_high1
gen d_covenant_high2 = covenant_high2 - L1.covenant_high2
gen d_covenant_high3 = covenant_high3 - L1.covenant_high3
gen d_covenant_high4 = covenant_high4 - L1.covenant_high4
gen d_covenant_high5 = covenant_high5 - L1.covenant_high5
gen d_covenant_high6 = covenant_high6 - L1.covenant_high6
gen d_covenant_high7 = covenant_high7 - L1.covenant_high7

gen d_covenant_high8 = covenant_high8 - L1.covenant_high8
gen d_covenant_high9 = covenant_high9 - L1.covenant_high9
gen d_covenant_high10 = covenant_high10 - L1.covenant_high10
gen d_covenant_high11 = covenant_high11 - L1.covenant_high11
gen d_covenant_high12 = covenant_high12 - L1.covenant_high12
gen d_covenant_high13 = covenant_high13 - L1.covenant_high13
gen d_covenant_high14 = covenant_high14 - L1.covenant_high14

gen d_covenant_high15 = covenant_high15 - L1.covenant_high15
gen d_covenant_high16 = covenant_high16 - L1.covenant_high16
gen d_covenant_high17 = covenant_high17 - L1.covenant_high17
gen d_covenant_high18 = covenant_high18 - L1.covenant_high18
gen d_covenant_high19 = covenant_high19 - L1.covenant_high19
gen d_covenant_high20 = covenant_high20 - L1.covenant_high20
gen d_covenant_high21 = covenant_high21 - L1.covenant_high21

gen d_covenant_high22 = covenant_high22 - L1.covenant_high22
gen d_covenant_high23 = covenant_high23 - L1.covenant_high23
gen d_covenant_high24 = covenant_high24 - L1.covenant_high24
gen d_covenant_high25 = covenant_high25 - L1.covenant_high25
gen d_covenant_high26 = covenant_high26 - L1.covenant_high26
gen d_covenant_high27 = covenant_high27 - L1.covenant_high27
gen d_covenant_high28 = covenant_high28 - L1.covenant_high28

gen d_covenant_high29 = covenant_high29 - L2.covenant_high29
gen d_covenant_high30 = covenant_high30 - L2.covenant_high30
gen d_covenant_high31 = covenant_high31 - L2.covenant_high31
gen d_covenant_high32 = covenant_high32 - L2.covenant_high32
gen d_covenant_high33 = covenant_high33 - L2.covenant_high33
gen d_covenant_high34 = covenant_high34 - L2.covenant_high34
gen d_covenant_high35 = covenant_high35 - L2.covenant_high35

gen d_covenant_high36 = covenant_high36 - L1.covenant_high36
gen d_covenant_high37 = covenant_high37 - L1.covenant_high37
gen d_covenant_high38 = covenant_high38 - L1.covenant_high38
gen d_covenant_high39 = covenant_high39 - L1.covenant_high39
gen d_covenant_high40 = covenant_high40 - L1.covenant_high40
gen d_covenant_high41 = covenant_high41 - L1.covenant_high41
gen d_covenant_high42 = covenant_high42 - L1.covenant_high42

gen d_covenant_high43 = covenant_high43 - L1.covenant_high43
gen d_covenant_high44 = covenant_high44 - L1.covenant_high44
gen d_covenant_high45 = covenant_high45 - L1.covenant_high45
gen d_covenant_high46 = covenant_high46 - L1.covenant_high46
gen d_covenant_high47 = covenant_high47 - L1.covenant_high47
gen d_covenant_high48 = covenant_high48 - L1.covenant_high48
gen d_covenant_high49 = covenant_high49 - L1.covenant_high49

gen d_covenant_high50 = covenant_high50 - L1.covenant_high50
gen d_covenant_high51 = covenant_high51 - L1.covenant_high51
gen d_covenant_high52 = covenant_high52 - L1.covenant_high52
gen d_covenant_high53 = covenant_high53 - L1.covenant_high53
gen d_covenant_high54 = covenant_high54 - L1.covenant_high54
gen d_covenant_high55 = covenant_high55 - L1.covenant_high55
gen d_covenant_high56 = covenant_high56 - L1.covenant_high56

gen d_covenant_high57 = covenant_high57 - L1.covenant_high57
gen d_covenant_high58 = covenant_high58 - L1.covenant_high58
gen d_covenant_high59 = covenant_high59 - L1.covenant_high59
gen d_covenant_high60 = covenant_high60 - L1.covenant_high60
gen d_covenant_high61 = covenant_high61 - L1.covenant_high61
gen d_covenant_high62 = covenant_high62 - L1.covenant_high62
gen d_covenant_high63 = covenant_high63 - L1.covenant_high63

gen d_covenant_high64 = covenant_high64 - L1.covenant_high64
gen d_covenant_high65 = covenant_high65 - L1.covenant_high65
gen d_covenant_high66 = covenant_high66 - L1.covenant_high66
gen d_covenant_high67 = covenant_high67 - L1.covenant_high67
gen d_covenant_high68 = covenant_high68 - L1.covenant_high68
gen d_covenant_high69 = covenant_high69 - L1.covenant_high69
gen d_covenant_high70 = covenant_high70 - L1.covenant_high70

gen d_covenant_high71 = covenant_high71 - L1.covenant_high71
gen d_covenant_high72 = covenant_high72 - L1.covenant_high72
gen d_covenant_high73 = covenant_high73 - L1.covenant_high73
gen d_covenant_high74 = covenant_high74 - L1.covenant_high74
gen d_covenant_high75 = covenant_high75 - L1.covenant_high75
gen d_covenant_high76 = covenant_high76 - L1.covenant_high76
gen d_covenant_high77 = covenant_high77 - L1.covenant_high77

gen d_covenant_high78 = covenant_high78 - L2.covenant_high78
gen d_covenant_high79 = covenant_high79 - L2.covenant_high79
gen d_covenant_high80 = covenant_high80 - L2.covenant_high80
gen d_covenant_high81 = covenant_high81 - L2.covenant_high81
gen d_covenant_high82 = covenant_high82 - L2.covenant_high82
gen d_covenant_high83 = covenant_high83 - L2.covenant_high83
gen d_covenant_high84 = covenant_high84 - L2.covenant_high84
gen d_covenant_high85 = covenant_high85 - L2.covenant_high85
gen d_covenant_high86 = covenant_high86 - L1.covenant_high86
gen d_covenant_high87 = covenant_high87 - L1.covenant_high87

gen d_covenant_high88 = covenant_high88 - L2.covenant_high88
gen d_covenant_high89 = covenant_high89 - L2.covenant_high89
gen d_covenant_high90 = covenant_high90 - L2.covenant_high90
gen d_covenant_high91 = covenant_high91 - L2.covenant_high91
gen d_covenant_high92 = covenant_high92 - L2.covenant_high92

gen d_covenant_high93 = covenant_high93 - L2.covenant_high93
gen d_covenant_high94 = covenant_high94 - L2.covenant_high94
gen d_covenant_high95 = covenant_high95 - L2.covenant_high95
gen d_covenant_high96 = covenant_high96 - L2.covenant_high96
gen d_covenant_high97 = covenant_high97 - L2.covenant_high97

gen d_covenant_high98 = covenant_high98 - L2.covenant_high98
gen d_covenant_high99 = covenant_high99 - L2.covenant_high99
gen d_covenant_high100 = covenant_high100 - L2.covenant_high100
gen d_covenant_high101 = covenant_high101 - L2.covenant_high101
gen d_covenant_high102 = covenant_high102 - L2.covenant_high102

gen d_covenant_high103 = covenant_high103 - L2.covenant_high103
gen d_covenant_high104 = covenant_high104 - L2.covenant_high104
gen d_covenant_high105 = covenant_high105 - L2.covenant_high105
gen d_covenant_high106 = covenant_high106 - L2.covenant_high106
gen d_covenant_high107 = covenant_high107 - L2.covenant_high107
gen d_covenant_high108 = covenant_high108 - L1.covenant_high108
gen d_covenant_high109 = covenant_high109 - L1.covenant_high109
gen d_covenant_high110 = covenant_high110 - L1.covenant_high110
gen d_covenant_high111 = covenant_high111 - L1.covenant_high111
gen d_covenant_high112 = covenant_high112 - L1.covenant_high112

global control_column1d "d_ln_at d_lag_tangible_assets_assets d_lag_market_to_book_ratio d_lag_sp500"

global control_column2d "d_ln_at d_lag_tangible_assets_assets d_lag_market_to_book_ratio d_lag_sp500 d_lag_book_debt_assets d_lag_net_worth_assets d_lag_cash_assets d_lag_EBITDA_lag_assets d_EBITDA_lag_assets d_lag_cash_flow_lag_assets d_cash_flow_lag_assets d_lag_net_income_lag_assets d_net_income_lag_assets d_interest_expense_assets d_interest_expense_lag_assets"

global control_column3d "d_ln_at d_lag_tangible_assets_assets d_lag_market_to_book_ratio d_lag_sp500 d_lag_book_debt_assets d_lag_net_worth_assets d_lag_cash_assets d_lag_EBITDA_lag_assets d_EBITDA_lag_assets d_lag_cash_flow_lag_assets d_cash_flow_lag_assets d_lag_net_income_lag_assets d_net_income_lag_assets d_interest_expense_assets d_interest_expense_lag_assets d_covenant_control1 d_covenant_control2 d_covenant_control3 d_covenant_control4 d_covenant_control5 d_covenant_high1 d_covenant_high2 d_covenant_high3 d_covenant_high4 d_covenant_high5 d_covenant_high6 d_covenant_high7 d_covenant_high8 d_covenant_high9"


global control_column4d "d_ln_at d_lag_tangible_assets_assets d_lag_market_to_book_ratio d_lag_sp500 d_lag_book_debt_assets d_lag_net_worth_assets d_lag_cash_assets d_lag_EBITDA_lag_assets d_EBITDA_lag_assets d_lag_cash_flow_lag_assets d_cash_flow_lag_assets d_lag_net_income_lag_assets d_net_income_lag_assets d_interest_expense_assets d_interest_expense_lag_assets d_covenant_control1 d_covenant_control2 d_covenant_control3 d_covenant_control4 d_covenant_control5 d_covenant_high1 d_covenant_high2 d_covenant_high3 d_covenant_high4 d_covenant_high5 d_covenant_high6 d_covenant_high7 d_covenant_high8 d_covenant_high9 d_covenant_high10 d_covenant_high11 d_covenant_high12 d_covenant_high13 d_covenant_high14 d_covenant_high15 d_covenant_high16 d_covenant_high17 d_covenant_high18 d_covenant_high19 d_covenant_high20 d_covenant_high21 d_covenant_high22 d_covenant_high23 d_covenant_high24 d_covenant_high25 d_covenant_high26 d_covenant_high27 d_covenant_high28 d_covenant_high29 d_covenant_high30 d_covenant_high31 d_covenant_high32 d_covenant_high33 d_covenant_high34 d_covenant_high35 d_covenant_high36 d_covenant_high37 d_covenant_high38 d_covenant_high39 d_covenant_high40 d_covenant_high41 d_covenant_high42 d_covenant_high43 d_covenant_high44 d_covenant_high45 d_covenant_high46 d_covenant_high47 d_covenant_high48 d_covenant_high49 d_covenant_high50 d_covenant_high51 d_covenant_high52 d_covenant_high53 d_covenant_high54 d_covenant_high55 d_covenant_high56 d_covenant_high57 d_covenant_high58 d_covenant_high59 d_covenant_high60 d_covenant_high61 d_covenant_high62 d_covenant_high63 d_covenant_high64 d_covenant_high65 d_covenant_high66 d_covenant_high67 d_covenant_high68 d_covenant_high69 d_covenant_high70 d_covenant_high71 d_covenant_high72 d_covenant_high73 d_covenant_high74 d_covenant_high75 d_covenant_high76 d_covenant_high77 d_covenant_high78 d_covenant_high79 d_covenant_high80 d_covenant_high81 d_covenant_high82 d_covenant_high83 d_covenant_high84 d_covenant_high85 d_covenant_high86 d_covenant_high87 d_covenant_high88 d_covenant_high89 d_covenant_high90 d_covenant_high91 d_covenant_high92 d_covenant_high93 d_covenant_high94 d_covenant_high95 d_covenant_high96 d_covenant_high97 d_covenant_high98 d_covenant_high99 d_covenant_high100 d_covenant_high101 d_covenant_high102 d_covenant_high103 d_covenant_high104 d_covenant_high105 d_covenant_high106 d_covenant_high107 d_covenant_high108 d_covenant_high109 d_covenant_high110 d_covenant_high111 d_covenant_high112"


