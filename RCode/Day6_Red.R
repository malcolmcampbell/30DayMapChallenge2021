################################################################################
# SOURCE - "Cartography Self Contained.R"
# 6 	06-11-2021 	Red 	A map with red colour or a map about something red.
# "Red " places in Canterbury - from LINZ NZ gazette
library(sf)
library(tmap)
library(tidyverse)
library(htmltools)

gaz <- read_csv("https://gazetteer.linz.govt.nz/gaz.csv")
NZgazette_sf <- st_as_sf(gaz, coords = c("crd_longitude", "crd_latitude"), crs = 4167)

NZgazette_sf <- NZgazette_sf %>%
  filter(grepl('Red ', name)) %>%
  filter(land_district=="Canterbury") %>%
  filter(status=="Official Assigned") 

tmap_mode("plot")
tmap_mode("view")
REDCAN <-  
  tm_shape(NZgazette_sf) + tm_dots(col="red") + 
  tm_text("name", shadow=T, auto.placement = T)+
  tm_legend(text.size=1,title.size=1.2,position=c("left","top")) + 
  tm_layout(main.title="'Red' Places, Canterbury, N.Z.") +
  tm_compass(position=c("left","top"), type="rose", size=4) +
  tm_scale_bar(width=0.15, position=c("left","top")) +
  tm_credits(text = "Source: LINZ \n Land Information New Zealand \n
             Created by A.Prof Malcolm Campbell",
             position=c("left","top")) 
REDCAN

# leaflet version
library(leaflet)
NZgazette_sf_wgs84 <- st_transform (NZgazette_sf, crs=4326 )
# Map Red of Canterbury
leaflet() %>%
  #addProviderTiles("CartoDB.Positron") %>%
  #addProviderTiles("Stamen.Watercolor") %>%
  #addProviderTiles("Esri.NatGeoWorldMap") %>%
  addProviderTiles("Esri.OceanBasemap") %>%
  addMiniMap()%>%
  addLabelOnlyMarkers(data = NZgazette_sf_wgs84, 
                      label = ~htmlEscape(name),
                      labelOptions = labelOptions(noHide = T, direction = "bottom",
                                                  style = list(
                                                    "color" = "red",
                                                    "font-family" = "serif",
                                                    "font-style" = "bold",
                                                    "box-shadow" = "7px 3px rgba(0,0,0,0.5)",
                                                    "font-size" = "14px",
                                                    "border-color" = "rgba(0,0,0,0.5)"
                                                  )))
#END