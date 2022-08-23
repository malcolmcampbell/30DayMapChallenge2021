# Associate Professor Malcolm Campbell
# Attribution-NonCommercial-ShareAlike  # CC BY-NC-SA 
# November 2021 - Updated AUGUST2022
# Geography and vaccinations
# Vaccinations by NZ TA 2020
# source https://raw.githubusercontent.com/minhealthnz/nz-covid-data/main/vaccine-data/latest/tla_uptake.csv JULY2022
# TA 2020 from Koordinates https://datafinder.stats.govt.nz/layer/106669-territorial-authority-2022-clipped-generalised/
library(sf)
library(tmap)
library(readr)
library(dplyr)

TA2020 <- st_read("https://github.com/malcolmcampbell/30DayMapChallenge2021/raw/main/Data/territorial-authority-2020-clipped-generalised.gpkg")
plot(st_geometry(TA2020))

# Join Vaccination data here!!
VAXbyTA <- read_csv("https://raw.githubusercontent.com/minhealthnz/nz-covid-data/main/vaccine-data/latest/tla_uptake.csv")
glimpse(VAXbyTA)
# LEFT JOIN
TA2020_VAX <- left_join(x = TA2020, y = VAXbyTA, by = c("TA2020_V1_00_NAME_ASCII" = 'Territorial Authority'))
rm(TA2020)

# remove areas outside 
TA2020_VAX <- TA2020_VAX %>%
  filter (TA2020_V1_00_NAME_ASCII!="Area Outside Territorial Authority") %>%
  filter (Age=="12+")

TA2020_VAX <- TA2020_VAX %>%
  mutate ( BOOSTER_ELIGIBLE_2 = round(((`Booster 2 recieved`/`Eligible for booster 2`)*100),digits=1) )
glimpse(TA2020_VAX)

# remove chathams - sorry chathams!!
TA2020_VAX <- TA2020_VAX %>%
  filter (TA2020_V1_00_NAME!="Chatham Islands Territory")

BOOSTER_ELIGIBLEPC_map <- tm_shape(TA2020_VAX) +
  tm_fill(col = "BOOSTER_ELIGIBLE_2", style = "quantile", 
          n = 5,  palette = "BuPu", lwd=0.01, legend.hist=T) +
  tm_borders(col = "black", lwd=0.001) +
  tm_layout (main.title="Boosters 2, % of Eligible Population", title.size=.8) +
  tm_scale_bar(width=0.15, position=c("right","bottom")) +
  tm_credits(text ="Created by A.Prof Malcolm Campbell \n Source:https://github.com/minhealthnz/nz-covid-data", position=c("right","bottom")) +
  tm_legend(frame=F, legend.position=c("left", "top"))+
  tm_layout(legend.hist.width = .25)
BOOSTER_ELIGIBLEPC_map
tmap_save(tm=BOOSTER_ELIGIBLEPC_map, filename="BOOSTER_ELIGIBLE2MapbyTA.png", dpi=300, width=1800, height=2000)
rm(BOOSTER_ELIGIBLEPC_map)

TA2020_VAX %>% slice_max(BOOSTER_ELIGIBLE_2, n=10)
#END
