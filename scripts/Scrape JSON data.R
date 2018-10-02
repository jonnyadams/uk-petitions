library(jsonlite)
library (plyr)
library(tidyverse)

url <- "https://petition.parliament.uk/petitions.json?page=1&state=all"

all_pets_raw <- fromJSON(url)

all_pets_filtered <- all_pets_raw$data$attributes

all_pets <- select(all_pets_filtered, action:rejection)

pets_combined <- all_pets

for(i in 2:200){
  print(i)
  url <- paste("https://petition.parliament.uk/petitions.json?page=",
               i, "&state=all", sep="")
  print(url)
  all_pets_raw <- fromJSON(url)
  
  all_pets_filtered <- all_pets_raw$data$attributes
  
  all_pets <- select(all_pets_filtered, action:creator_name)
  
  pets_combined <- bind_rows(pets_combined, all_pets)
  
}