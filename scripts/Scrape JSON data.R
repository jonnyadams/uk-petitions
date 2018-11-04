library(jsonlite)
library (plyr)
library(tidyverse)

url <- "https://petition.parliament.uk/petitions.json?page=1&state=all"

all_pets_raw <- fromJSON(url)

all_pets_filtered <- all_pets_raw$data$id

pets_combined <- all_pets_filtered

for(i in 2:200){
#for(i in 2:4){
  print(i)
  url <- paste("https://petition.parliament.uk/petitions.json?page=",
               i, "&state=all", sep="")
  print(url)
  all_pets_raw <- fromJSON(url)
  
  all_pets_filtered <- all_pets_raw$data$id
  
  pets_combined <- combine(pets_combined, all_pets_filtered)
  
}

counter = 1

for (i in pets_combined) {
  
  print(i)
  url <- paste("https://petition.parliament.uk/petitions/",
               i, ".json", sep="")
  print(url)
  
  pet_i <- fromJSON(url)
  
  pet_i_cons <- pet_i$data$attributes$signatures_by_constituency
  
  
  pet_i_cons <- pet_i$data$attributes$signatures_by_constituency
  
  pet_i_cons <- pet_i_cons %>% mutate(id = i)
  
  pet_i_details <- pet_i$data$attributes
  
  pet_i_cons <- pet_i_cons %>% mutate(action = pet_i_details$action)
  pet_i_cons <- pet_i_cons %>% mutate(background = pet_i_details$background)
  pet_i_cons <- pet_i_cons %>% mutate(state = pet_i_details$state)
  pet_i_cons <- pet_i_cons %>% mutate(created_at = pet_i_details$created_at)
  pet_i_cons <- pet_i_cons %>% mutate(response_threshold_reached_at = pet_i_details$response_threshold_reached_at)
  
  if (counter == 1) { 
    agg_data <- pet_i_cons
  } else {
    agg_data <- bind_rows(agg_data, pet_i_cons)    
  }

  print(counter)
  counter = counter + 1
}