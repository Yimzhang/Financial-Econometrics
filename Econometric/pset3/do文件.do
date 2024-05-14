clear
capture log close
import delimited "/Users/yimingzhang/Desktop/Econometric/pset3/njmin3.csv"

reg fte nj d d_nj
outreg2 using results.doc, replace

gen centralj_d = d*centralj
gen southj_d = d*southj
gen pa1_d = d*pa1

gen bk_d = bk*d
gen kfc_d = kfc*d
gen roys_d = roys*d

reg fte nj d d_nj bk_d kfc_d roys_d centralj_d southj_d pa1_d
outreg2 using results.doc, append

gen d_centralj = d*centralj
gen d_southj = d*southj
gen d_pa1 = d*pa1
gen d_pa2 = d*pa2

reg fte d centralj southj pa1 pa2 d_centralj d_southj d_pa1 d_pa2
outreg2 using results1.doc, replace
