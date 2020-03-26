#Codigo para realizar mapa de salinidad de Venezuela:

setwd("C:/Sevilla/Mario/Venezuela/Salinidad/Salinidad")
getwd()
library("aqp")

horizontes <- read.csv(file = "hori_inia_soter_230320.csv", header=TRUE)
names(horizontes)
str(horizontes)

#Eliminamos las columnas no necesarias:
horizontes <- horizontes[, -c(2, 43, 42, 44, 45 ) ]
summary(horizontes$CON_EXT_SA)

boxplot(horizontes$CON_EXT_SA)
hist(horizontes$CON_EXT_SA)

#Eliminamos los valores de CE mayores a 10:
horizontes <- horizontes[horizontes$CON_EXT_SA < 10,]

# Verificamos y eliminamos valores "NA" de CE:
eliminar <- which(is.na(horizontes$CON_EXT_SA))
horizontes1 <- horizontes[-eliminar,]
summary(horizontes1$CON_EXT_SA)
boxplot(horizontes1$CON_EXT_SA)

#Prueba de normalidad:
normalidad <- shapiro.test(horizontes1$CON_EXT_SA)
print(normalidad)
#si p-value es menor a 0.05 es no normal.

#Observamos el numero de filas y columnas del objeto R:
dim(horizontes1)

#Creamos un objeto R del tipo de SoilProfileCollection:
depths(horizontes1) <- CODIGO ~ PROF_S + PROF_I

#Verificamos si tenemos problemas o erores en los datos de profundidad superior e inferior de 
#los diferentes horizontes: 
Errores <-  checkHzDepthLogic(horizontes1)

#vemos un dataframe con los posibles errores:
View(Errores, getOption("max.print"))