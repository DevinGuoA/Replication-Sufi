/***********************************************************************************************
This script: 
By running this script, you are expected to get all the empirical results shown in the research
***********************************************************************************************/

clear all
capture log close
set more off
macro drop _all
program drop _all
matrix drop _all

//************** Define directory structure and set up logs **************//
global user "Devin"
if "$user" == "Devin" {
	global root "/Users/devin/Desktop/BA952 Replication/Sufi and Roberts"
}

** Create log directory if it doesn't exist ***
cap mkdir "${root}/log"

** Set up log file ***
global date: display %tdCCYYNNDD date(c(current_date), "DMY")
log using "${root}/log/log${date}.log", text replace

//************** Clean **************//
do "${root}/do_file/clean.do"

//************** Table2 **************//
do "${root}/do_file/table2.do"

//************** Table3 **************//
do "${root}/do_file/table3.do"


log close
