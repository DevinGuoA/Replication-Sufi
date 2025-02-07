/***********************************************************************************************
This transcript:
- Clean Net Equity Issuance
***********************************************************************************************/
winsor2 ceqq, cuts(5,95) replace
gen lag_ceqq=L.ceqq
gen net_equity_issuance=10000*(ceqq-lag_ceqq)/(lag_assets)
winso2 net_equity_issuance,cuts(5,95) replace
label variable "Net Equity Issuance (basis point)"

