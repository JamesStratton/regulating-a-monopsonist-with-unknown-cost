* ---------------------------------------------------------------------------- *
* ------------- Analyze CPS data for "Regulating a Monopsonist" -------------- *
* ---------------------------------------------------------------------------- *

* ---------------------------------
* Appendix Figure A1
* ---------------------------------
* Load data 
use "../Data/IPUMS data extract", clear 

* Restrict to relevant observations 
drop if hourwage2 == 999.99
drop if hourwage2 == 0 

* Generate weights 
gen fw = round(wtfinl)

* Adjust for inflation 
replace hourwage2 = hourwage2 * 1.014 * 1.06 * 1.056 * 1.039 * 1.033 if year == 2021
replace hourwage2 = hourwage2 * 1.06 * 1.056 * 1.039 * 1.033 if year == 2022
replace hourwage2 = hourwage2 * 1.056 * 1.039 * 1.033 if year == 2023
replace hourwage2 = hourwage2 * 1.039 * 1.033 if year == 2024
replace hourwage2 = hourwage2 * 1.033 if year == 2025

* Plot histogram 
tw /// 
	(hist hourwage2 [fw = fw], width(1) frac) /// 
	, /// 
	xtitle("Hourly Wage (2026 dollars)") /// 
	ytitle("Fraction of Workers Over 2021-2025 sample period") /// 
	ylab(, nogrid) 
graph export "../Output/Appendix Figure A2.pdf", replace 
