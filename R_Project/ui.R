
#UI
header <- dashboardHeader(title = "Investment Funds of European Countries", titleWidth = 550)


sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem("Fund Types", tabName = "Chart", icon = icon("chart-bar")),
    menuItem("Wealth Distribution", tabName = "Lineplot", icon = icon("chart-bar")),
    menuItem("Asset Values", tabName = "Barplot", icon = icon("chart-bar"))
    
  ),
  selectInput(
    inputId = "Country",
    label = "Choose a Country",
    choices = sort(unique(Data$Country))
  ),
  
  selectInput(
    inputId = "FundType",
    label = "Choose a Fund Type",
    choices = sort(unique(Data$Investment.policy))
  ),
  
  sliderInput(
    inputId = "Year",
    label = "Choose a Year",
    sep = "",
    value = 2009,
    min = 2009,
    max = 2018
  )
)

body <- dashboardBody(
  
  tabItems(
  
  tabItem(
    tabName = "Chart",
    h2("Fund Types Per Month by Country"),
    fluidRow(box(plotOutput("BarPlotStocks"), width = 12),
             box(plotOutput("BarPlotFlows"), width = 12))
  ),
  tabItem(
    tabName = "Lineplot",
    h2("Wealth Distribution Across Europe"),
    fluidRow(box(plotOutput("LinePlotStocks"), width = 12),
             box(plotOutput("LinePlotFlows"), width = 12))
  ),
  tabItem(
    tabName = "Barplot",
    h2("Asset Values by Country"),
    fluidRow(box(plotOutput("BarStocks"), width = 12),
             box(plotOutput("BarFlows"), width = 12))
  )
)
)

dashboardPage(skin = "purple",
  header,
  sidebar,
  body)
