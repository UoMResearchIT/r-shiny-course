## Download full gapminder data for Shiny workshop

library(tidyverse)
library(readxl)
library(gganimate)

population <- read_csv("https://docs.google.com/spreadsheet/pub?key=phAwcNAVuyj0XOoBL_n5tAQ&output=csv")
totalgdp <- read_csv("https://docs.google.com/spreadsheet/pub?key=0Asm_G8nr4TCSdDh2NWQtVDJhYlVsTElFRjJIYkNlSnc&output=csv")
lifeexp <- read_csv("https://docs.google.com/spreadsheet/pub?key=phAwcNAVuyj2tPLxKvvnNPA&output=csv")

continent_lookup <- read_csv("https://raw.githubusercontent.com/lukes/ISO-3166-Countries-with-Regional-Codes/master/all/all.csv") %>% 
  select(name, region, `sub-region`)
 
gapminder <- gather(population, key = "year", value = "population", -1) %>% rename(country = `Total population`) %>% 
  full_join( gather(totalgdp, key = "year", value = "gdp", -1)
            %>% rename(country = `Total GDP, PPP`) ) %>% 
  full_join( gather(lifeexp, key = "year", value = "lifeExp", -1) %>%
               rename(country = `Life expectancy`) )

completeGapminder <- gapminder %>% filter(complete.cases(gapminder)) %>% 
  mutate(gdpPerCap = gdp / population)

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
  mutate(subregion = factor(subregion)) %>% 
  mutate(yearInt = as.integer(year)) %>% 
  mutate(year = factor(year)) 
           
saveRDS(gapminder, "coursematerial/gapminder.rds")
