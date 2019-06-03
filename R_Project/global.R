library(tidyverse)
library(shiny)
library(shinydashboard)
library(RColorBrewer)
library(imputeTS)
library(lubridate)


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

#Count NA
sum(is.na(Data$Investment.stocks))
sum(is.na(Data$Investment.flows))

#Impute missing data
which(is.na(Data$Investment.stocks))
Data$Investment.stocks = na.ma(Data$Investment.stocks, k=1)

which(is.na(Data$Investment.flows))
ind = which(is.na(Data$Investment.flows))
Data$Investment.flows[ind] = 
  Data$Investment.stocks[ind+1] - Data$Investment.stocks[ind]

sum(is.na(Data$Date))

#Organize Dates
Data$Date = as.Date(Data$Date, format = '%m/%d/%Y')
Data$Year <- format(Data$Date, format='%Y')

which(is.na(Data$Date))
missingDates = Data[rowSums(is.na(Data)) > 0,]
missingDates

# Data = na.omit(Data)

#Top Countries
TopCountries = Data %>%
  filter(Country == c('Luxembourg', 'Germany', 'France', 'Ireland', 'Netherlands'))
