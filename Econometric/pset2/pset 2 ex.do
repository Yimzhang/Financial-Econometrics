clear
capture log close
cd "/Users/yimingzhang/Desktop"
log using "data.log", replace

insheet using "PS2 example.csv", comma names

gen stata_date = mdy(month, day, year)

tsset stata_date


// *does the data look right?
// tsline spx
// tsline msft

*does it look heteroskedastic?

tsline ret_spx

*CAPM style - without taking away risk free rates

reg ret_msft ret_aapl ret_spx

*test for heteroskedasticity
estat hettest

*correct standard errors
reg ret_msft ret_aapl ret_spx, robust

*test that beta = one
test ret_spx == 1

*test that beta = one and half
test ret_spx == 1.5



*estimate GLS
*1) Get residuals, square them, 
*2) divide every thing by sqrt of squared residuals
*3) re-run regression

qui reg ret_msft ret_spx, robust
predict ehat, resid
gen ehat_sq = ehat^2

gen ret_spx_gls = ret_spx / sqrt(ehat_sq)
gen ret_msft_gls = ret_msft / sqrt(ehat_sq) 
gen cons_gls = 1 / sqrt(ehat_sq)

reg ret_msft_gls cons_gls ret_spx_gls, noc
*estat hettest

predict temp, resid
qui reg temp
estat hettest

*Hausman test
qui reg ret_msft ret_spx
est store ols

qui reg ret_msft_gls cons_gls ret_spx_gls, noc
est store gls
*a few ways to do this. Since I have different variable names, easiest to estimate at once with suest and compare.
suest ols gls
*test if constants and slopes are the same in the two specifications
test ([ols_mean]_cons=[gls_mean]cons_gls) ([ols_mean]ret_spx=[gls_mean]ret_spx_gls)

*do the betas vary through time?  Will go back to OLS, robust here

reg ret_msft ret_spx, robust
*going to check yearly as an example. generate year*ret_spx interactions
xi i.year*ret_spx
*want to remove the fixed effects and keep interactions: I know they outperform and underperform randomly
drop _Iyear*

reg ret_msft ret_spx _I*, robust


*What happened in 2014? Satya Nadella.

*Looks like MSFT became systematically riskier (= higher beta) when he came on board.  Did he improve returns on average, or just increase the beta?
xi: reg ret_msft ret_spx i.year, robust





