
#UI
header <- dashboardHeader(title = "Investment Funds of European Countries", titleWidth = 550)


sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem("Introduction", tabName = "Intro", icon = icon("chart-bar")),
    menuItem("Individual Countries", tabName = "Chart", icon = icon("chart-bar")),
    menuItem("Fund Type Over Time", tabName = "Lineplot", icon = icon("chart-line")),
    menuItem("Top 5 Countries", tabName = "Barplot", icon = icon("chart-bar"))
    
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
      tabName = "Intro",
      h2("Introduction"),
      fluidRow(box(textOutput("text"), style="font-size:200%", width = 12))
    ),
  tabItem(
    tabName = "Chart",
    h2("Fund Types Per Month by Country"),
    selectInput(
      inputId = "Country",
      label = "Choose a Country",
      choices = sort(unique(Data$Country))),
    fluidRow(box(plotOutput("BarPlotStocks"), width = 12),
             box(plotOutput("BarPlotFlows"), width = 12))

  ),
  tabItem(
    tabName = "Lineplot",
    h2("Investment Distribution Across Europe"),
    selectInput(
      inputId = "FundType",
      label = "Choose a Fund Type",
      choices = sort(unique(Data$Investment.policy))
    ),
    fluidRow(box(plotlyOutput("LinePlotStocks"), width = 12),
             box(plotlyOutput("LinePlotFlows"), width = 12))
  ),
  tabItem(
    tabName = "Barplot",
    h2("Assets Owned by Each Country"),
    selectInput(
      inputId = "FundType2",
      label = "Choose a Fund Type",
      choices = sort(unique(Data$Investment.policy))
    ),
    fluidRow(box(plotOutput("BarStocks"), width = 12),
             box(plotOutput("BarFlows"), width = 12))
  )
)
)

dashboardPage(skin = "purple",
  header,
  sidebar,
  body)
