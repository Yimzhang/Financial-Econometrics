* 设置工作目录到您存储数据的地方
cd "/Users/yimingzhang/Desktop"


* 读入数据
import excel "PPI_predict.xlsx", firstrow clear


regress PPI_final AHEEHC_6 UDGS_6 MSP_6 MTI_6
outreg2 using PPI_result.doc, replace

import excel "Predict Core PPI.xlsx", firstrow clear

regress PPI_CORE AHEEHC_6 UDGS_6 MSP_6 MTI_6
outreg2 using PPI_result.doc, append
