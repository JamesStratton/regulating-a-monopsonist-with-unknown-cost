* ---------------------------------------------------------------------------- *
* --------------- Make diagrams for "Regulating a Monopsonist" --------------- *
* ---------------------------------------------------------------------------- *

* ---------------------------------
* Figure 1
* ---------------------------------
* Create wages 
clear 
set obs 1001 
gen theta = (_n - 1) / 1000 
gen w_comp = theta 
gen w_monop = theta * (1 - 1 / (1 + 2 * theta)) 
gen minimum_wage = 1 / 2 
gen w_regulated = max(minimum_wage, w_monop + 0.007)
replace w_regulated = . if theta <= 1 / 2

* Plot Figure 1(a)
tw /// 
	(pci 0 0.5 1.1 0.5, lcolor(gs8) lpattern(dash)) /// 
	(pci 0 0.8 1.1 0.8, lcolor(gs8) lpattern(dash)) /// 
	(pcarrowi 1.1 0 1.1 0.48, lcolor(purple) mcolor(purple)) /// 
	(pcarrowi 1.1 0.48 1.1 0, lcolor(purple) mcolor(purple)) /// 
	(pcarrowi 1.1 0.52 1.1 0.78, lcolor(purple) mcolor(purple)) /// 
	(pcarrowi 1.1 0.78 1.1 0.52, lcolor(purple) mcolor(purple)) /// 
	(pcarrowi 1.1 0.82 1.1 1, lcolor(purple) mcolor(purple)) /// 
	(pcarrowi 1.1 1 1.1 0.82, lcolor(purple) mcolor(purple)) /// 
	(line w_comp theta, lcolor(navy)) /// 
	(line w_monop theta, lcolor(dkorange)) ///
	(line w_regulated theta, lcolor(purple)) /// 
	, /// 
    xlab(0.5 "w̲" 0.8 "θ{superscript:†}(w̲)", nogrid noticks labsize(large)) /// 
    ylab(0.52 "w̲", nogrid noticks labsize(large)) /// 
	aspect(1) /// 
	xtitle("Labor productivity (θ)", size(large)) /// 
	ytitle("Wage (w(θ))", size(large)) /// 
	legend(off) /// 
	text(1.02 1.22 "Competitive" "wage w{superscript:c}(θ)", color(navy) size(large) j(left)) /// 
	text(0.62 1.2 "Monopsony" "wage w{superscript:m}(θ)", color(dkorange) size(large)) /// 
	text(0.77 1.18 "Regulated" "wage ŵ(θ)", color(purple) size(large)) /// 
	xsc(ra(0 1.14)) /// 
	ysc(ra(0 1.1)) /// 
	text(1.17 0.25 "Shutdown", color(purple) size(large)) /// 
	text(1.17 0.65 "Binding", color(purple) size(large)) /// 
	text(1.17 0.95 "Unconstr.", color(purple) size(large))  
graph export "../Output/Figure 1(a).pdf", replace 

* Create employment levels 
gen emp_comp = w_comp^(3/4)
gen emp_monop = w_monop^(3/4)
gen emp_regulated = w_regulated^(3/4) 
replace emp_regulated = 0 if theta < minimum_wage 

* Plot Figure 1(b)
tw /// 
	(pci 0 0.5 1.1 0.5, lcolor(gs8) lpattern(dash)) /// 
	(pci 0 0.8 1.1 0.8, lcolor(gs8) lpattern(dash)) /// 
	(pcarrowi 1.1 0 1.1 0.48, lcolor(purple) mcolor(purple)) /// 
	(pcarrowi 1.1 0.48 1.1 0, lcolor(purple) mcolor(purple)) /// 
	(pcarrowi 1.1 0.52 1.1 0.78, lcolor(purple) mcolor(purple)) /// 
	(pcarrowi 1.1 0.78 1.1 0.52, lcolor(purple) mcolor(purple)) /// 
	(pcarrowi 1.1 0.82 1.1 1, lcolor(purple) mcolor(purple)) /// 
	(pcarrowi 1.1 1 1.1 0.82, lcolor(purple) mcolor(purple)) /// 
	(pci 0.595 0 0.595 0.5, lcolor(gs8) lpattern(dash)) /// 
	(pci 0 0.8 0.595 0.8, lcolor(gs8) lpattern(dash)) /// 
	(line emp_comp theta, lcolor(navy)) /// 
	(line emp_monop theta, lcolor(dkorange)) ///
	(line emp_regulated theta, lcolor(purple)) /// 
	, /// 
    xlab(0.5 "w̲" 0.8 "θ{superscript:†}(w̲)", nogrid noticks labsize(large)) /// 
    ylab(0.6 "G(w̲)", nogrid noticks labsize(large)) /// 
	aspect(1) /// 
	xtitle("Labor productivity (θ)", size(large)) /// 
	ytitle("Employment (L(θ))", size(large)) /// 
	legend(off) /// 
	text(1.02 1.22 "Competitive" "emp. L{superscript:c}(θ)", color(navy) size(large) j(left)) /// 
	text(0.68 1.22 "Monopsony" "emp. L{superscript:m}(θ)", color(dkorange) size(large) j(left)) /// 
	text(0.83 1.195 "Regulated" "emp. `=ustrunescape("L\u0302")'(θ)", color(purple) size(large) j(left)) /// 
	xsc(ra(0 1.14)) /// 
	ysc(ra(0 1.1)) /// 
	text(1.17 0.25 "Shutdown", color(purple) size(large)) /// 
	text(1.17 0.65 "Binding", color(purple) size(large)) /// 
	text(1.17 0.95 "Unconstr.", color(purple) size(large))  
graph export "../Output/Figure 1(b).pdf", replace 

* Create surplus levels 
gen s_comp = w_comp * emp_comp + 0.5 * emp_comp * (theta - w_comp) 
gen s_monop = w_monop * emp_monop + 0.5 * emp_monop * (theta - w_monop) 
gen s_regulated = w_regulated * emp_regulated + 0.5 * emp_regulated * (theta - w_regulated)  
replace s_regulated = 0 if mi(s_regulated) 

* Plot Figure 1(c)
tw /// 
	(pci 0 0.5 1.1 0.5, lcolor(gs8) lpattern(dash)) /// 
	(pci 0 0.8 1 0.8, lcolor(gs8) lpattern(dash)) /// 
	(pcarrowi 1.1 0 1.1 0.48, lcolor(purple) mcolor(purple)) /// 
	(pcarrowi 1.1 0.48 1.1 0, lcolor(purple) mcolor(purple)) /// 
	(pcarrowi 1.1 0.52 1.1 0.78, lcolor(purple) mcolor(purple)) /// 
	(pcarrowi 1.1 0.78 1.1 0.52, lcolor(purple) mcolor(purple)) /// 
	(pcarrowi 1.1 0.82 1.1 1, lcolor(purple) mcolor(purple)) /// 
	(pcarrowi 1.1 1 1.1 0.82, lcolor(purple) mcolor(purple)) /// 
	(line s_comp theta, lcolor(navy)) /// 
	(line s_monop theta, lcolor(dkorange)) ///
	(line s_regulated theta, lcolor(purple)) /// 
	, /// 
    xlab(0.5 "w̲" 0.8 "θ{superscript:†}(w̲)", nogrid noticks labsize(large)) /// 
    ylab(, nogrid noticks nolab) /// 
	aspect(1) /// 
	xtitle("Labor productivity (θ)", size(large)) /// 
	ytitle("Social welfare (S(θ))", size(large)) /// 
	legend(off) /// 
	text(1 1.225 "Competitive" "surplus S{superscript:c}(θ)", color(navy) size(large) j(left)) /// 
	text(0.55 1.23 "Monopsony" "surplus S{superscript:m}(θ)", color(dkorange) size(large) j(left)) /// 
	text(0.72 1.22 "Regulated" "surplus `=ustrunescape("S\u0302")'(θ)", color(purple) size(large) j(left)) /// 
	xsc(ra(0 1.14)) /// 
	ysc(ra(0 1.1)) /// 
	text(1.17 0.25 "Shutdown", color(purple) size(large)) /// 
	text(1.17 0.65 "Binding", color(purple) size(large)) /// 
	text(1.17 0.95 "Unconstr.", color(purple) size(large))  
graph export "../Output/Figure 1(c).pdf", replace 

* ---------------------------------
* Figure 2
* ---------------------------------
tw ///
    (function y = normalden(x, 0, 1), range(-2 -1) recast(area) base(0) color(green%35) lcolor(white%0)) /// 
    (pci 0 -2 0.054 -2, color(red) lpattern(dash)) ///
    (pci 0 -1.6 0.11 -1.6, color(green) lpattern(dash)) ///
    (function y = normalden(x, 0, 2), range(-4 4) lcolor(orange) lwidth(medthick)) ///
	(pcarrowi 0.054 -2 0.12 -2, color(red)) /// 
	(pcarrowi 0.11 -1.6 0.145 -1.6, color(green)) /// 
    (function y = normalden(x, 0, 1), range(-4 4) lcolor(navy) lwidth(medthick)) ///
    , ///
    ytitle("PDF of firm productivity", size(large)) ///
    legend(off) ///
    xlab(-2 "w̲" -1 "θ{superscript:†}(w̲)", labsize(large)) ///
    ylab(, nogrid nolab noticks) /// 
	xtitle("Labor productivity (θ)", size(large)) /// 
	text(0.01 5.1 "Initial dist'n f", size(large) color(navy)) ///
	text(0.04 5.2 "Spread dist'n f'", size(large) color(orange)) /// 
	xsc(ra(-4 6))
graph export "../Output/Figure 2.pdf", replace 

* ---------------------------------
* Figure 3 
* --------------------------------- 
* Create wage schedules  
gen L = _n / 1000 
gen min_wage_original = 0.5 
gen min_wage_new = 0.4 if L < 0.4 
replace min_wage_new = 0.495 if L >= 0.4 

* Plot Figure 3(a) 
tw /// 
	(pci 0 0.4 0.5 0.4, lcolor(gs8) lpattern(dash)) /// 
	(pci 0 0.6 0.5 0.6, lcolor(gs8) lpattern(dash)) /// 
	(line min_wage_original L, lcolor(navy)) /// 
	(line min_wage_new L, lcolor(dkorange)) /// 
	, /// 
    xlab(0.4 "δ" 0.6 "G(w̲)", nogrid noticks labsize(large)) /// 
    ylab(0.42 "w̲ - ε" 0.52 "w̲", nogrid noticks labsize(large)) /// 
	aspect(1) /// 
	xtitle("Employment (L)", size(large) margin(small)) /// 
	ytitle("Minimum wage (w̲(L))", size(large)) /// 
	legend(off) /// 
	ysc(ra(0 1.1)) /// 
	xsc(ra(0 1.14)) /// 
	text(0.6 1.2 "Uniform" "min. wage", color(navy) size(large) j(left)) /// 
	text(0.44 1.19 "Reformed" "schedule", color(dkorange) size(large) j(left))
graph export "../Output/Figure 3(a).pdf", replace 
 
* Create wage levels   
gen min_wage_type_original = . 
replace min_wage_type_original = 0.5 if inrange(theta, 0.5, 0.85) 
replace min_wage_type_original = w_monop if theta >= 0.82 
replace min_wage_type_original = w_monop if w_monop >= 0.5 
gen min_wage_type_new = 0.4 if inrange(theta, 0.4, 0.6) 
replace min_wage_type_new = 0.5 if inrange(theta, 0.6, 0.85)
replace min_wage_type_new = w_monop if w_monop >= 0.5 
replace min_wage_type_new = min_wage_type_new - 0.008

* Plot Figure 3(b) 
tw /// 
	(pci 0 0.4 0.9 0.4, lcolor(gs8) lpattern(dash)) /// 
	(pci 0 0.6 0.39 0.6, lcolor(gs8) lpattern(dash)) /// 
	(pci 0 0.8 0.5 0.8, lcolor(gs8) lpattern(dash)) /// 
	(pci 0.39 0 0.39 0.4, lcolor(gs8) lpattern(dash)) /// 
	(pci 0.5 0 0.5 0.5, lcolor(gs8) lpattern(dash)) /// 
	(pci 0 0.5 0.9 0.5, lcolor(gs8) lpattern(dash)) /// 
	(pci 0 0.6 0.9 0.6, lcolor(gs8) lpattern(dash)) /// 
	(pcarrowi 0.9 0 0.9 0.39, lcolor(purple) mcolor(purple)) /// 
	(pcarrowi 0.9 0.39 0.9 0, lcolor(purple) mcolor(purple)) /// 
	(pcarrowi 0.9 0.41 0.9 0.49, lcolor(eltblue) mcolor(eltblue)) /// 
	(pcarrowi 0.9 0.49 0.9 0.41, lcolor(eltblue) mcolor(eltblue)) /// 
	(pcarrowi 1.07 0.41 0.92 0.45, lcolor(eltblue) mcolor(eltblue)) /// 
	(pcarrowi 0.9 0.51 0.9 0.59, lcolor(cranberry) mcolor(cranberry)) /// 
	(pcarrowi 0.9 0.59 0.9 0.51, lcolor(cranberry) mcolor(cranberry)) /// 
	(pcarrowi 1.07 0.75 0.92 0.55, lcolor(cranberry) mcolor(cranberry)) /// 
	(pcarrowi 0.9 0.61 0.9 0.99, lcolor(forest_green) mcolor(forest_green)) /// 
	(pcarrowi 0.9 0.99 0.9 0.61, lcolor(forest_green) mcolor(forest_green)) /// 
	(line min_wage_type_original theta, lcolor(navy)) /// 
	(line min_wage_type_new theta, lcolor(dkorange)) /// 
	, /// 
	aspect(1) /// 
	xtitle("Labor productivity (θ)", size(large) margin(small)) /// 
	ytitle("Assigned wage (w̲(θ))", size(large)) /// 
	legend(off) /// 
	ysc(ra(0 1.1)) /// 
	xsc(ra(0 1.14)) /// 
    xlab(0.4 "δ" 0.51 "θ{superscript:*}" 0.523 " {subscript:ε}" 0.6 "w̲" 0.8 "θ{superscript:†}", nogrid noticks labsize(large)) /// 
    ylab(0.41 "w̲ - ε" 0.52 "w̲" , nogrid noticks labsize(large)) /// 
	text(0.76 1.2 "Uniform" "min. wage", color(navy) size(large) j(left)) /// 
	text(0.59 1.19 "Reformed" "schedule", color(dkorange) size(large) j(left)) /// 
	text(0.99 0.2 "Shut down under" "either schedule", color(purple) j(left)) /// 
	text(1.15 0.36 "Shut down under uniform," "operate at (w̲ - ε) under reform", color(eltblue) j(left)) /// 
	text(1.15 1.11 "Operate at w̲ under uniform," "operate at (w̲ - ε) under reform", color(cranberry) j(left)) /// 
	text(0.99 0.85 "Unaffected" "by reform", color(forest_green) j(left))
graph export "../Output/Figure 3(b).pdf", replace 

* Create employment levels   
gen assigned_emp_type_original = 0 
replace assigned_emp_type_original = (0.5)^(3/4) if theta >= 0.5 
replace assigned_emp_type_original = emp_monop if w_monop >= 0.5
gen assigned_emp_type_new = 0 
replace assigned_emp_type_new = 0.4^(3/4) if theta >= 0.4 
replace assigned_emp_type_new = 0.5^(3/4) if theta >= 0.6 
replace assigned_emp_type_new = emp_monop if w_monop >= 0.5
replace assigned_emp_type_new = assigned_emp_type_new - 0.007

* Plot Figure 3(c) 
tw /// 
	(pci 0 0.4 0.9 0.4, lcolor(gs8) lpattern(dash)) /// 
	(pci 0 0.6 0.39 0.6, lcolor(gs8) lpattern(dash)) /// 
	(pci 0 0.8 0.9 0.8, lcolor(gs8) lpattern(dash)) /// 
	(pci 0.6 0 0.6 0.5, lcolor(gs8) lpattern(dash)) /// 
	(pci 0.495 0 0.495 0.495, lcolor(gs8) lpattern(dash)) /// 
	(pci 0 0.5 0.9 0.5, lcolor(gs8) lpattern(dash)) /// 
	(pci 0 0.6 0.9 0.6, lcolor(gs8) lpattern(dash)) /// 
	(pcarrowi 0.9 0 0.9 0.39, lcolor(purple) mcolor(purple)) /// 
	(pcarrowi 0.9 0.39 0.9 0, lcolor(purple) mcolor(purple)) /// 
	(pcarrowi 0.9 0.41 0.9 0.49, lcolor(eltblue) mcolor(eltblue)) /// 
	(pcarrowi 0.9 0.49 0.9 0.41, lcolor(eltblue) mcolor(eltblue)) /// 
	(pcarrowi 1.07 0.41 0.92 0.45, lcolor(eltblue) mcolor(eltblue)) /// 
	(pcarrowi 0.9 0.51 0.9 0.59, lcolor(cranberry) mcolor(cranberry)) /// 
	(pcarrowi 0.9 0.59 0.9 0.51, lcolor(cranberry) mcolor(cranberry)) /// 
	(pcarrowi 1.07 0.75 0.92 0.55, lcolor(cranberry) mcolor(cranberry)) /// 
	(pcarrowi 0.9 0.61 0.9 0.99, lcolor(forest_green) mcolor(forest_green)) /// 
	(pcarrowi 0.9 0.99 0.9 0.61, lcolor(forest_green) mcolor(forest_green)) /// 
	(line assigned_emp_type_original theta, color(navy)) /// 
	(line assigned_emp_type_new theta, color(dkorange)) /// 
	, /// 
	aspect(1) /// 
	xtitle("Labor productivity (θ)", size(large) margin(small)) /// 
	ytitle("Assigned employment (L(θ))", size(large)) /// 
	legend(off) /// 
	ysc(ra(0 1.1)) /// 
	xsc(ra(0 1.14)) /// 
    xlab(0.4 "δ" 0.51 "θ{superscript:*}" 0.523 " {subscript:ε}" 0.6 "w̲" 0.8 "θ{superscript:†}", nogrid noticks labsize(large)) /// 
    ylab(0.5 "δ" 0.6 "G(w̲)" , nogrid noticks labsize(large)) /// 
	text(0.83 1.2 "Uniform" "min. wage", color(navy) size(large) j(left)) /// 
	text(0.66 1.19 "Reformed" "schedule", color(dkorange) size(large) j(left)) /// 
	text(0.99 0.2 "Shut down under" "either schedule", color(purple) j(left)) /// 
	text(1.15 0.36 "Shut down under uniform," "operate at (w̲ - ε) under reform", color(eltblue) j(left)) /// 
	text(1.15 1.11 "Operate at w̲ under uniform," "operate at (w̲ - ε) under reform", color(cranberry) j(left)) /// 
	text(0.99 0.85 "Unaffected" "by reform", color(forest_green) j(left))
graph export "../Output/Figure 3(c).pdf", replace 
