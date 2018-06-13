## Assemble gapminder data for Shiny workshop

library(tidyverse)
library(readxl)
library(gganimate)

population <- read_excel("sourcedata/DataPopulationv5.xlsx", sheet = "Data countries etc by year") # long
gdpPerCap <- read_excel("sourcedata/gdppc_cppp-by-gapminder.xlsx", sheet = "countries_and_territories") # wide
lifeExp <- read_excel("sourcedata/lex-by-gapminder.xlsx",  sheet = "countries_and_territories") # wide
tfr <- read_excel("sourcedata/tfr-by-gapminder.xlsx", sheet = "countries_and_territories")

continent_lookup <- #read_csv("https://raw.githubusercontent.com/lukes/ISO-3166-Countries-with-Regional-Codes/master/all/all.csv") %>% 
  read_csv("sourcedata/all.csv") %>% 
  select(name, region, `sub-region`)
 
# gapminder <- gather(population, key = "year", value = "population", -1) %>% rename(country = `Total population`) %>% 
#   full_join( gather(totalgdp, key = "year", value = "gdp", -1)
#             %>% rename(country = `Total GDP, PPP`) ) %>% 
#   full_join( gather(lifeexp, key = "year", value = "lifeExp", -1) %>%
#                rename(country = `Life expectancy`) )
gapminder <- population %>% 
  full_join( gather(gdpPerCap, key = "year", value = "gdpPerCap", -(1:4)) %>% 
               mutate(year = as.integer(year)),
             by  = c("geo", "year")) %>% 
  full_join(gather(lifeExp, key = "year", value = "lifeExp", -(1:4)) %>% 
              mutate(year = as.integer(year)),
            by = c("geo", "year")) %>% 
  full_join(gather(tfr, key = "year", value = "tfr", -(1:4)) %>% 
              mutate(year = as.integer(year)),
            by = c("geo", "year")) %>% 
  select(-starts_with("indicator")) %>% # Remove unwanted and duplicate columns from join
  select(-ends_with(".x")) %>% 
  select(-ends_with(".y")) %>% 
  rename(country = name)


completeGapminder <- gapminder %>% 
  filter(complete.cases(gapminder)) 
  

# Some countries names are recorded differently in the continent lookup table
countryRename <- tribble(
  ~gapcountry, ~isocountry,
  "Bolivia", "Bolivia (Plurinational State of)",
  "Brunei", "Brunei Darussalam",
  "Cape Verde", "Cabo Verde",
  "Congo, Dem. Rep.", "Congo (Democratic Republic of the)",
  "Congo, Rep.", "Congo",
  "Cote d'Ivoire" ,"Côte d'Ivoire",
  "Hong Kong, China", "Hong Kong",
  "Iran", "Iran (Islamic Republic of)",
  "Macao, China", "Macao",
  "Macedonia, FYR", "Macedonia (the former Yugoslav Republic of)",
  "Micronesia, Fed. Sts.", "Micronesia (Federated States of)",
  "Moldova","Moldova (Republic of)",
  "Reunion", "Réunion",
  "Russia", "Russian Federation",
  "Slovak Republic", "Slovakia",
  "Syria", "Syrian Arab Republic",
  "Taiwain", "Taiwan, Province of China",
  "Tanzania", "Tanzania, United Republic of",
  "United Kingdom", "United Kingdom of Great Britain and Northern Ireland",
  "United States", "United States of America",
  "Venezuela", "Venezuela (Bolivarian Republic of)",
  "Vietnam", "Viet Nam"
)


gapminder <- completeGapminder %>% 
  left_join(countryRename, by = c("country" = "gapcountry")) %>% 
  mutate(consolidatedCountry = ifelse(is.na(isocountry), country, isocountry)) %>% 
  left_join(continent_lookup, by = c("consolidatedCountry" = "name") ) %>% 
  select(-isocountry, -consolidatedCountry) %>%
  rename(continent = region, subregion = `sub-region`) %>% 
  filter(!is.na(continent)) %>% # There's still a couple of countries we can't assign a continent to
  mutate(continent = factor(continent)) %>% 
  mutate(subregion = factor(subregion))%>% 
  filter(year <= 2017) # don't use predicted values

# Only keep countries we  have a full time series for
maxcountry <- (gapminder %>% count(country) %>% arrange(desc(n)))[1,]$n
completecountries <- (gapminder %>% count(country) %>% filter(n==maxcountry))$country

gapminder <- gapminder %>% 
  filter(country %in% completecountries)

# Check we have sequential years 
yearcheck <- gapminder %>% 
  select(year) %>% 
  mutate(lagyear = lag(year)) %>% 
  mutate(delta = year - lagyear)
if (max(yearcheck$delta, na.rm = TRUE) != 1){
  stop("Non sequential year")
}

## Just keep countries with the largest population in 2017?
# gapminder <- gapminder %>% 
#   filter(year == 2017) %>% 
#   arrange(desc(population)) %>% 
#   filter(row_number() <= 100) %>% 
#   select(country) %>% 
#   inner_join(gapminder, by = "country")

saveRDS(gapminder, "coursematerial/gapminder.rds")
