setwd("C:/Sevilla/Mario/Venezuela/Salinidad/Salinidad")
getwd()

horizontes <- read.table("C:/Sevilla/Mario/Venezuela/Salinidad/Salinidad/Tablas/Sal_horizontes.csv", sep=",", dec = ".", header=TRUE)
names(horizontes)
summary(horizontes)
horizontes1 <- horizontes[,-(42:51)]
summary(horizontes1)
str(horizontes1)

dim(horizontes1)
boxplot(horizontes1[,21:41])
