library(rjson)
library(tidyverse)
library(lubridate)
library(magrittr)

rm(list = ls())
# Prepare the data

myusername <- "myusername" # specify the username in MyFitbitData

root.data.path <- paste0("./MyFitbitData/", myusername, "/Physical Activity/", sep = "") # where the heart rate files are located
data.files <- list.files(root.data.path, pattern = "^heart_rate*") # list files starting with (^) "heart rate" with anything after (there's only .json files)
myresultsfolder <- "./Results/" # the results folder


# Big function--------------------------------------
  fitbit_json_to_tibble <- function(root.data.path, data.files, myresultsfolder){
    my_data <- vector("list", length = length(data.files)) # prepare a list to contain all tibbles of all data from all files
for(i in 1:length(data.files)){
  my_results <- fromJSON(file = paste0(root.data.path, data.files[[i]], sep = "")) # read the data to create a list of lists
  my_results1 <- vector("list", length = length(my_results)) # initialise empty list
  for(j in 1:length(my_results)){ # change the index
    my_results1[[j]] <- flatten(my_results[[j]]) # flatten just the "value" part, not the dateTime
  }
  my_results <- my_results1 %>% dplyr::bind_rows() # merge into a tibble with dateTime, bpm, and confidence. Without flattening the "value," you only get dateTime and value, and it's trickier to separate these out
  
  my_data[[i]] <- my_results # this is a vector to be added as the i-th element to the list, my_data, containing each tibble generated from each data file
  # the i-th element is the i-th data file
  
  print(paste0("Loading... ", round((i/length(data.files))*100, 1), " % complete", sep = "")) # this function takes a while so print percentage loading
  
}
    df <- dplyr::bind_rows(my_data) # huge.
    save(df, file = paste0(myresultsfolder, "complete heart rate data.RData", sep = ""))
    write.csv(df, file = paste0(myresultsfolder, "complete heart rate data.csv", sep = ""), row.names = F)
    return(df)
  }
df <- fitbit_json_to_tibble(root.data.path, data.files, myresultsfolder)

