library(jsonlite)
library (plyr)
library(tidyverse)

url <- "https://petition.parliament.uk/petitions.json?page=1&state=all"

all_pets_raw <- fromJSON(url)

all_pets_filtered <- all_pets_raw$data$id

pets_combined <- all_pets_filtered

for(i in 2:200){
  print(i)
  url <- paste("https://petition.parliament.uk/petitions.json?page=",
               i, "&state=all", sep="")
  print(url)
  all_pets_raw <- fromJSON(url)
  
  all_pets_filtered <- all_pets_raw$data$id
  
  pets_combined <- combine(pets_combined, all_pets_filtered)
  
}


url <- "https://petition.parliament.uk/petitions/231147.json"

pet_i <- fromJSON(url)

pet_i_cons <- pet_i$data$attributes$signatures_by_constituency

pet_i_cons <- pet_i_cons %>% mutate(id = 231147)


state <- pet_i$data$attributes$state

pet_i_cons <- pet_i_cons %>% mutate(state = state)

pet_i_details <- pet_i$data$attributes

pet_i_details <- select(pet_i_details, action:debate)