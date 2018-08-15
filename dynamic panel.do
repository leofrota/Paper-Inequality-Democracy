

* Applied Econometrics paper


* Getting data

import excel "D:\base de dados\database.xlsx", sheet("Planilha1") firstrow

* Declaring dataset to be a panel

xtset country_idx yeary

* Transforming variables

gen education = log(e_peaveduc)
gen infantmortality = log(e_peinfmor)
gen population = log(e_mipopula)
gen Gini = log(gini)
gen capital = log(CapitalStockPerCapita)
gen gini2 = Gini^2
gen GDP = e_migdppcln


*OLS

reg v2x_polyarchyx infantmortality population gini gini2 GDP education 

eststo model1



*Fixed effects

xtivreg v2x_polyarchyx infantmortality gini  gini2  education population (GDP = capital), fe

estimate store fixed

eststo model2

*Random effects

xtivreg v2x_polyarchyx infantmortality gini gini2  education population (GDP = capital), re

estimate store random

eststo model3

*Table

esttab, r2 ar2 se scalar(rmse)

esttab using painel1.tex, r2 ar2 se scalar(rmse) label title(Panel Models) nonumbers mtitles("OLS" "Fixed Effects" "Random Effects") addnote("Source: Author´s Estimation")
	
*Hausman Test

hausman fixed random

* Dynamic Panel Data 

*Arellano-Bond

xtabond v2x_polyarchyx infantmortality education population loggini gini2, lags(1) endog(e_migdppcln , lagstruct(2,.))  artests(2)

*System GMM
xtdpdsys v2x_polyarchyx infantmortality education population loggini gini2 , lags(1) endog(e_migdppcln , lagstruct(2,.))  artests(2)

* Sargan test


* Clearing

clear

* Consolidation model

* Getting data

import excel "D:\base de dados\consolidation2.xlsx", sheet("Planilha1") firstrow

*Transfoming data

gen population = log(e_mipopula)
gen education  = log(e_peaveduc)
gen infantmortality = log(e_peinfmor)
gen Gini = log(gini)
gen gini2 = Gini^2
gen capital = log(CapitalStockPerCapita)
gen GDP = e_migdppcln

*Logit and Probit

logit Consolidation education population infantmortality GDP Gini gini2 , vce(robust)
eststo model1
probit Consolidation education population infantmortality GDP Gini gini2  , vce(robust)
eststo model2


* Output

esttab, pr2  se

esttab using logit11.tex, pr2 se label title(Consolidation) nonumbers mtitles("Logit" "Probit") addnote("Source: Author´s Estimation")


*Instrumental probit

ivprobit Consolidation population infantmortality education loggini   (GDP = capital), vce(robust)
eststo model3


* Output

esttab, r2 ar2 se scalar(rmse)

esttab using logit2.tex, label title(Consolidation) nonumbers mtitles("Logit" "Probit" "IV Probit") addnote("Source: Author´s Estimation")
