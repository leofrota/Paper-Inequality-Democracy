### Applied Econometrics Working Paper

## Calling packages

library(ggplot2)
library(haven)
library(plm)


### Calling databases


# SWIID database

Gini_Database_SWIID <- read_dta("Base de dados/for_stata.dta")

#Polity IV Dataset

library(readxl)
p4v2016_1_ <- read_excel("Base de dados/p4v2016 (1).xls")
View(p4v2016_1_)

#VDEM 8.1 Dataset

#World Bank

#Penn World Table


### Cleaning the data

datagini <- Gini_Database_SWIID
politydata <-  p4v2016_1_

### Descriptive Statistics

#plots
plot(datagini$gini_disp_1 ~ datagini$year)
plot(politydata$democ ~ politydata$year)

# Histograms
hist(datagini$gini_disp_1,freq = FALSE)
hist(politydata$democ, freq = FALSE)

summary(Gini_Database_SWIID)

### Estimation

###

