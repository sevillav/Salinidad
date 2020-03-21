setwd("C:/Sevilla/Mario/Venezuela/Salinidad/Salinidad")
getwd()

library("aqp")

horizontes <- read.table("C:/Sevilla/Mario/Venezuela/Salinidad/Salinidad/Tablas/Sal_horizontes.csv", sep=",", dec = ".", header=TRUE)
names(horizontes)
summary(horizontes)
horizontes1 <- horizontes[,-(42:51)]
summary(horizontes1)
str(horizontes1)

dim(horizontes1)
boxplot(horizontes1[,21:41])


depths(horizontes1) <- CODIGO ~ PROF_S + PROF_I

res <-  checkHzDepthLogic(horizontes1)
res

groupedProfilePlot(horizontes1)

site(horizontes1) <- ~ groupedProfilePlot()

hzDepthTests(PROF_S, PROF_I)

View(horizontes1@horizons)
