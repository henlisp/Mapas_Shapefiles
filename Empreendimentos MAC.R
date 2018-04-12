library(rgdal)
br <- readOGR("Desktop/municipios_2010","municipios_2010")

#Testando se R l? acentos do portugu?s
##########
s<-"são paulo"
s
##########

#Caso n???o leia acentos do portugu?s, executar linha de baixo
Sys.setlocale("LC_ALL", "pt_PT.ISO8859-1")

names(br)
head(br$uf)

SP <- br[br@data$nome == "São Paulo",]
plot(SP)
names(SP)
plot(SP[SP$nome=="São Paulo",], add=T, col="grey70")
library(maps)
map.axes()
map.scale(ratio = F, cex = 0.7) #tentem ratio = T

library(leaflet)
pj <- CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs")
SP2 <- spTransform(SP, pj)

longitude <- as.vector(c(-46.74,-46.62))
lattitude <- as.vector(c(-23.57, -23.63))
labels <- as.vector(c("Passeio do Bosque", "Varanda Botanic"))

macIcon <-makeIcon(
  iconUrl = "http://www.unestaca.com.br/clientes/10-Mac.png",
  iconWidth = 15*150/120, iconHeight = 15,
  iconAnchorX = 15*150/120/2, iconAnchorY = 8
)

map3 <- leaflet(SP2) %>%
  #addProviderTiles("CartoDB.Positron")
  addProviderTiles("OpenStreetMap.Mapnik") %>%
  #addProviderTiles("OpenMapSurfer.Roads")%>%
  #addTiles()
  addPolygons(fillOpacity = 0.2, color = "Blue", weight = 1)%>%
  addMarkers(lng = longitude,lat = lattitude, label = labels, icon = macIcon)
#addMarkers(-46.74,-23.57, label = "Passeio do Bosque")
#addMarkers(-46.62,-23.63, label = "Varanda Botanic")

#addPopups(-46.74,-23.57,"blah", options = popupOptions(closebutton = F))
map3

library(htmlwidgets)
getwd()
setwd("Desktop")
saveWidget(map3, file="Dois Empreendimentos MAC.html")




