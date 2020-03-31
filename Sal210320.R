#Codigo para realizar mapa de salinidad de Venezuela:

#Establcemos espacio de trabajo:
setwd("C:/Sevilla/Mario/Venezuela/Salinidad/Salinidad")
getwd()

# activamos librerias:
library("aqp")
library("raster")

#Cargamos los datos:
horizontes <- read.csv(file = "hori_inia_soter_300320a.csv", header=TRUE)

#Observamos nombre de columnas: 
names(horizontes)

#Eliminamos las columnas no necesarias:
hori_ce <- horizontes[,-c(3:6, 9:30,  32:55 )]
names(hori_ce)

#Resumen estadistico:
summary(hori_ce$CON_EXT_SA)

#Eliminamos datos con CE = NA:
eliminar <- which(is.na(hori_ce$CON_EXT_SA))
hori_ce <- hori_ce[-eliminar,]

#Primeros 6 registros:
summary(hori_ce$CON_EXT_SA)
head(hori_ce)

#Creamos objeto R espacial:
hori_ce_sp <- hori_ce
coordinates(hori_ce_sp) <- ~ POINT_X + POINT_Y
hori_ce_sp@proj4string <- crs("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0")
Venezuela = shapefile("../covariables/gadm36_VEN_0.shp")

#ploteamos graficos:
par(mfrow = c(2,2))
plot(hori_ce$CON_EXT_SA, ylab="CE/dsm", xlab="muetras",
     main="Vaores de CE encontrados", cex= 0.8)
hist(hori_ce$CON_EXT_SA, ylab = "Frecuencia", xlab = "valores de CE",
     main = "Histograma de frecuencia de CE", col = "blue", breaks = 100)
boxplot(hori_ce$CON_EXT_SA, main = "Diagrama de caja", horizontal = TRUE)

bubble(hori_ce_sp, "CON_EXT_SA", sp.layout = Venezuela, col = "blue")

#Prueba de normalidad:
print(shapiro.test(hori_ce$CON_EXT_SA))
#si p-value es menor a 0.05 es no normal.

#Transformamos la CE a Log:
hori_ce_log <- log(hori_ce$CON_EXT_SA)

#Creamos un objeto R del tipo de SoilProfileCollection:
depths(hori_ce) <- CODIGO ~ PROF_S + PROF_I

#Verificamos si tenemos problemas o erores en los datos de profundidad superior e inferior de 
#los diferentes horizontes: 
Errores <-  checkHzDepthLogic(hori_ce)
e <- Errores[Errores$valid == FALSE,]
#vemos un dataframe con los posibles errores:
View(Errores, getOption("max.print"))

#ultimo
