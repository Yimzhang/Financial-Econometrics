* 设置工作目录到您存储数据的地方
cd "/Users/yimingzhang/Desktop"


* 读入数据
use "Final_All_Merged_Data_for_Stata.dta", clear

gen log_pop = ln(pop)





rename pop new_pop1
rename log_pop pop
* 设置面板数据结构
xtset state_id Time

* 随机效应模型
xtreg municipal_bond_return revenue_per_pop return poverty lessthanhighschoolgraduate gamb_rev_dummy pop, re
outreg2 using regression_results.xls, replace

xtreg municipal_bond_return revenue_per_pop poverty lessthanhighschoolgraduate gamb_rev_dummy new_pop1, fe
xtserial


