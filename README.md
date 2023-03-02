# Fitbit-heartrate-data-import
Imports Fitbit heart rate data from individual daily files to one tibble

Fitbit heart rate files are separate for every single day, and in a .json format. This file contains a function to convert all of this data into one dataframe/tibble.

Output: .RData and .csv file

The Fitbit data is obtained by requesting an export from the website.

The only input required is the username, and desired results folder. The root.data.path may need to be adjusted depending on where you have saved your Fitbit data folder. I've placed it in the same location as the R file.
