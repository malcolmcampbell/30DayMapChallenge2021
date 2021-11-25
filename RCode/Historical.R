# HISTORICAL
# A/Prof Malcolm Campbell 2021 November
# Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0)
# Load libraries - NOTE: if not installed,un-hash the install packages
#install.packages("sf", "tmap")
library(sf) # For spatial features
library(tmap) # For mapping

## ONLINE VERSION
#create temp files
temp <- tempfile()
temping <- tempfile()
download.file("https://data-midulster.opendata.arcgis.com/datasets/3d891596bcee40ecb0b8329d41d37ead_0.zip?outSR=%7B%22latestWkid%22%3A29902%2C%22wkid%22%3A29900%7D.zip",temp)
# unzip into 'temp' and save unzipped to 'temp2'
unzip(zipfile = temp, exdir = temping)
SHP <- list.files ( temping, pattern = ".shp$",full.names=TRUE)
SHP
#read the shapefile. 
TOWNLANDS <- st_read(SHP)
# offline version
#TOWNLANDS <- st_read("Mid_Ulster_Council_Townlands-shp/Mid_Ulster_Council_Townlands-shp.shp")

Townlands_mid_map <- tm_shape(TOWNLANDS) +
  tm_fill(col = "sandybrown", lwd=0.01) +
  tm_borders(col = "grey30", lwd=0.001) +
  tm_layout (main.title=
               "Townlands | Bhailte Fearainn | Toonlann", 
            main.title.position = "center",
            title="Mid Ulster | L\u00E0r Uladh", title.size=.8,
            bg.color = "sandybrown") +
  tm_compass(position=c("right","bottom"), 
             type="arrow", size=3,text.color = "grey20", 
             color.dark = "grey20") +
  tm_scale_bar(width=0.15, position=c("right","bottom"), 
               color.dark = "grey20") +
  tm_credits(text ="Created by A.Prof M.Campbell \nSource:OpenDataNI \n| Sonra\u00edOscailteT\U00C9", 
             just="right", col="grey20") +
  tm_credits( 
  text = 
  "
  Mid Ulster covers an area with a population 
  of more than 140,000, living in a mix of 
  urban and rural communities. Townlands are 
  an ancient method of land measurement 
  found only in Ireland and can be 
  very important in genealogical 
  research. These small areas of 
  land can vary from a few 
  acres upwards in size", 
             position=c("left","top"), col="black")

tmap_mode("plot")
Townlands_mid_map 
# SAVE as a png flie
tmap_save(tm=Townlands_mid_map, filename="Townlands_mid_map.png", 
          dpi=300, width=1800, height=2400)
#interactive VERISON - next challenge
tmap_mode("view")
Townlands_mid_map
#########################################################################
#END
