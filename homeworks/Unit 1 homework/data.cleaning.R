library(tidyverse)
library(lubridate)

artdata <- read.csv("homeworks/Unit 1 homework/artdata.csv")

artdata.cleaned <- artdata %>% 
  mutate(yearOfBirth = as.numeric(yearOfBirth),
         year = as.numeric(year),
         soldtime = as.Date(soldtime),
         ageOfPainting = 2025-year) %>% 
  filter(country!="") %>%
  filter(!grepl("^[12]", country)) %>% 
  select(-Column1) %>% 
  arrange(country) %>% 
  relocate(ageOfPainting, .after=year)

write.csv(artdata.cleaned, "homeworks/Unit 1 homework/artdata.cleaned.csv", row.names = FALSE)



artdata.china <- artdata.cleaned %>% 
  filter(country=="Chinese")