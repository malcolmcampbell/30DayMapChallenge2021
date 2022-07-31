################################################################################
# SOURCE - "Cartography Self Contained.R"
# 5 	05-11-2021 	Data challenge 1: OpenStreetMap 	
#OpenStreetMap is the source for geospatial data. 
#Use OSM to map something that is interesting to you. 
# You can access the data e.g. from GeoFabrik or some of these sources. 
# Remember to credit '© OpenStreetMap contributors'.

library(osmdata)
library(tmap)
motorway <- getbb("Belfast, U.K.")%>%
  opq()%>%
  add_osm_feature(key = "highway", 
                  value = c("motorway", "motorway_link")) %>%
  osmdata_sf()
motorway

mainstreets <- getbb("Belfast, U.K.")%>%
  opq()%>%
  add_osm_feature(key = "highway", 
                  value = c("primary", "primary_link")) %>%
  osmdata_sf()
mainstreets
tm_shape(mainstreets$osm_lines)+tm_lines()

smallstreets <- getbb("Belfast, U.K.")%>%
  opq()%>%
  add_osm_feature(key = "highway", 
                  value = c("residential", "living_street", "unclassified", "service", "footway"
                  )) %>%
  osmdata_sf()

# map it
tm_shape(smallstreets$osm_lines)+tm_lines(col="seagreen2") +
  tm_shape(mainstreets$osm_lines)+tm_lines(col="orange", lwd=1.5) +
  tm_shape(motorway$osm_lines)+tm_lines(col="dodgerblue2", lwd=2)

# production map
OSMBELFASTMAP <- 
  tm_shape(smallstreets$osm_lines)+tm_lines(col="seagreen2", lwd=0.5) +
  tm_shape(mainstreets$osm_lines)+tm_lines(col="orange", lwd=1.5) +
  tm_shape(motorway$osm_lines)+tm_lines(col="dodgerblue2", lwd=2) +
  tm_compass(position=c("right","bottom"), type="rose", size=3) +
  tm_layout (main.title="Belfast, United Kingdom", title.size=.8, main.title.position = "center", bg.color = "grey60") +
  tm_scale_bar(width=0.15, position=c("right","bottom")) +
  tm_credits(text ="Created by A.Prof Malcolm Campbell \n Source: OSM © OpenStreetMap contributors") 
OSMBELFASTMAP
OSMBELFASTMAPGREY <- 
  tm_shape(smallstreets$osm_lines)+tm_lines(col="grey40", lwd=0.5) +
  tm_shape(mainstreets$osm_lines)+tm_lines(col="grey70", lwd=1.5) +
  tm_shape(motorway$osm_lines)+tm_lines(col="grey90", lwd=2) +
  tm_compass(position=c("right","bottom"), type="rose", size=3) +
  tm_layout (main.title="Belfast, United Kingdom", title.size=.8, main.title.position = "center", bg.color = "grey60") +
  tm_scale_bar(width=0.15, position=c("right","bottom")) +
  tm_credits(text ="Created by A.Prof Malcolm Campbell \n Source: OSM © OpenStreetMap contributors") 
OSMBELFASTMAPGREY

OSMBELFASTMAPGREYTSHIRT <- 
  tm_shape(smallstreets$osm_lines)+tm_lines(col="grey40", lwd=0.5) +
  tm_shape(mainstreets$osm_lines)+tm_lines(col="grey70", lwd=1.5) +
  tm_shape(motorway$osm_lines)+tm_lines(col="grey90", lwd=2)+tm_layout (bg.color = "grey60") 
OSMBELFASTMAPGREYTSHIRT

tmap_save(tm=OSMBELFASTMAP, filename="OSMBELFASTMAP.png", dpi=300, width=1600, height=2200)
tmap_save(tm=OSMBELFASTMAPGREY, filename="OSMBELFASTMAPGREY.png", dpi=300, width=1600, height=2200)
tmap_save(tm=OSMBELFASTMAPGREYTSHIRT, filename="OSMBELFASTMAPGREYTSHIRT.png", dpi=300, width=2200, height=2200)
#END