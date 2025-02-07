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
	global root "/Users/devin/Desktop/BA952 Replication/Sufi"
}

** Create log directory if it doesn't exist ***
cap mkdir "${root}/log"

** Set up log file ***
global date: display %tdCCYYNNDD date(c(current_date), "DMY")
log using "${root}/log/log${date}.log", text replace

//************** Clean the dataset **************//
do "${root}/do_file/merge_clean.do"

do "${root}/do_file/clean_basic.do"

do "${root}/do_file/clean_appendix.do"

//************** Table 1 **************//
do"${root}/do_file/table1.do"

//************** Table 3 **************//
do"${root}/do_file/table3.do"

//************** Figure 1 **************//
do"${root}/do_file/figure1.do"

//************** Appendix Table 1A **************//
do"${root}/do_file/table1a.do"

//************** Appendix Table 3A **************//
do"${root}/do_file/table3a.do"

//************** Appendix Figure 1a **************//
do"${root}/do_file/figure1a.do"

//************** Diagnostic **************//
do"${root}/do_file/diagnostic.do"

log close
