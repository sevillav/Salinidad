#Codigo para realizar mapa de salinidad de Venezuela:

#Establecemos directorio de trabajo:
setwd("C:/Sevilla/Mario/Venezuela/Salinidad/Salinidad")

# Verificamos directotio de trabajo:
getwd()

#Activamos paquetes necesarios:
library("aqp")

#Cargamos la tabla de los horizontes de los sitios de muestreos:
horizontes <- read.table("C:/Sevilla/Mario/Venezuela/Salinidad/Salinidad/Tablas/Sal_horizontes.csv", sep=",", dec = ".", header=TRUE)

#Observamos los nombres de las columnas:
names(horizontes)

#Observamos resumen estadisticos de cada columna o variables, para ver datos extraños:
summary(horizontes)

#Eliminamos columnas sin datos:
horizontes1 <- horizontes[,-(42:51)]

#Verificamos la eliminacion anterior:
summary(horizontes1)

#Observamos la estructura del objeto R de los horizontes y vemos si todas las columnas
# tienen el tipo de campo correctos (int, factor, num, etc):
str(horizontes1)

#Observamos el numero de filas y columnas del objeto R:
dim(horizontes1)

#Observamos diagramas de cajas para ver como se comportan los datos: 
boxplot(horizontes1[,21:41])

#Creamos un objeto R del tipo de SoilProfileCollection:
depths(horizontes1) <- CODIGO ~ PROF_S + PROF_I

#Verificamos si tenemos problemas o erores en los datos de profundidad superior e inferior de 
#los diferentes horizontes: 
Errores <-  checkHzDepthLogic(horizontes1)

#vemos un dataframe con los posibles errores:
View(Errores, getOption("max.print"))

Errores


