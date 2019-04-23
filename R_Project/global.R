library(tidyverse)
library(shiny)
library(shinydashboard)
library(RColorBrewer)


Data = read.csv("R_Project_Data.csv")

colnames(Data)
#Clean Data

#Remove weird characters
colnames(Data)[colnames(Data)=="ï..Investment.policy"] = "Investment.policy"

#Put numbers in billions
Data$Investment.stocks = Data$Investment.stocks/1000000000
Data$Investment.flows = Data$Investment.flows/1000000000
options(scipen=999)

#Select desired columns
Data = Data %>% 
  select(Country, Date, Investment.policy, Investment.stocks, Investment.flows) %>% 
  filter(Country != "Euro area")

#Remove NA
Data = na.omit(Data)

#Organize Dates
Data$Date = as.Date(Data$Date, format = '%m/%d/%Y')
Data$Year <- format(Data$Date, format='%Y')


