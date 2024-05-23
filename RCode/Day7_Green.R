################################################################################
# Updated 2024 May - website update data
# 7 	07-11-2021 	Green 	A map with green colour or a map about something green.
# see reference
# Citation: Marek, L., Hobbs, M., Wiki, J., Kingham, S., & Campbell, M. (2021). 
# The good, the bad, and the environment: 
# Developing an area-based measure of access to health-promoting and health-constraining environments in New Zealand. 
# International Journal of Health Geographics, 20(1), 16-16. 
# https://doi.org/10.1186/s12942-021-00269-x

library(downloader)
library(sf)
library(tmap)

# WARNING LARGE FILE - 103.2MB
url <- c("https://www.canterbury.ac.nz/content/dam/uoc-main-site/documents/zip-files/geohealth-laboratory/Environmental_goods_bads_MB2018.zip")
download(url, dest="HLI.zip", mode="wb") 
unzip ("HLI.zip", exdir = "./HLI")

# reading in the HLI geopackage
HLI <- read_sf("./HLI/MB2018_exposures_GB.gpkg")
#plot(st_geometry(HLI))

CHCH_UA <- read_sf("https://github.com/malcolmcampbell/30DayMapChallenge2021/raw/main/Data/CHCH_UA.gpkg")
plot(st_geometry(CHCH_UA))

#KEY BIT - joining
CHCH <- st_join(HLI, CHCH_UA, join = st_within)
# filter just CHCH
CHCH <- filter(CHCH, CHCH$UR2018_V_1=="Christchurch")
# map the distance to greenspace
# palette see tmaptools::palette_explorer()
GREEN <- tm_shape(CHCH)+
  tm_fill(col="GS", palette = "Greens", n=10, legend.hist = T) +
  tm_layout(title="Median Proximity (m) to Greenspace, \n Christchurch Urban Meshblocks") +
  tm_shape(CHCH_UA)+tm_borders(col="black")
GREEN

#tmap_save(tm=GREEN, filename="GREEN_CHCH_MAP.png", dpi=300, width=1600, height=2200)
# END
