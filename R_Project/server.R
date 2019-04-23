
#Server
shinyServer(function(input, output) {

  
  output$BarPlotStocks = renderPlot({
    filtered_data =
      Data[Data$Country == input$Country &
             Data$Year == input$Year,]
    
    ggplot(filtered_data) +
      geom_bar(
        stat = 'identity',
        aes(x = filtered_data$Date,
            y = filtered_data$Investment.stocks,
            fill = filtered_data$Investment.policy),
        position = 'dodge') +
      labs(title = "Investment Stocks",
           x = "Date",
           y = "Value (Billions)") +
      theme(axis.text = element_text(size = 13),
            axis.title = element_text(size = 15),
            legend.title = element_text(size=14),
            legend.text = element_text(size=13)) +
      scale_fill_brewer(palette = "Dark2", name = "Fund Type")
  })
  
  output$BarPlotFlows = renderPlot({
    filtered_data =
      Data[Data$Country == input$Country &
             Data$Year == input$Year,]
    
    ggplot(filtered_data) +
      geom_bar(
        stat = 'identity',
        aes(
          x = filtered_data$Date,
          y = filtered_data$Investment.flows,
          fill = filtered_data$Investment.policy
        ),
        position = 'dodge'
      ) +
      labs(title = "Investment Flows",
           x = "Date",
           y = "Value (Billions)") +
      theme(axis.text = element_text(size = 13),
            axis.title = element_text(size = 15),
            legend.title = element_text(size=14),
            legend.text = element_text(size=13)) +
      scale_fill_brewer(palette = "Dark2", name = "Fund Type")
  })
  
  output$BoxPlotStocks = renderPlot({
    yearly_data =
      Data[Data$Year == input$Year,]
    
    ggplot(yearly_data, aes(x = Country, y = Investment.stocks)) +
      geom_boxplot(aes(color = Country)) +
      coord_flip(ylim = c(-200, 800)) +
      labs(title = "Investment Stocks",
           x = "Country",
           y = "Value (Billions)") +
      theme(axis.text = element_text(size = 13),
            axis.title = element_text(size = 15),
            legend.title = element_text(size=14),
            legend.text = element_text(size=13))
    
  })
  
  output$BoxPlotFlows = renderPlot({
    yearly_data =
      Data[Data$Year == input$Year,]
    
    ggplot(yearly_data, aes(x = Country, y = Investment.flows)) +
      geom_boxplot(aes(color = Country)) +
      coord_flip(ylim = c(-2, 7)) +
      labs(title = "Investment Flows",
           x = "Country",
           y = "Value (Billions)") +
      theme(axis.text = element_text(size = 13),
            axis.title = element_text(size = 15),
            legend.title = element_text(size=14),
            legend.text = element_text(size=13))
  })
  
  output$BarStocks = renderPlot({
    fund_data = 
      Data[Data$Investment.policy == input$FundType &
             Data$Year == input$Year, ]
    
    ggplot(fund_data, aes(x=reorder(Country, Investment.stocks), y=Investment.stocks)) + 
      geom_bar(stat = 'identity', 
               aes(fill = Investment.policy),
               position = 'dodge') +
      labs(title = "Stock Value by Country",
           x = "Country",
           y = "Value (Billions)") +
      coord_flip() +
      theme(axis.text = element_text(size=13),
            axis.title = element_text(size=15),
            legend.title = element_text(size=14),
            legend.text = element_text(size=13)) +
      scale_fill_manual(values = "darkturquoise", name = "Fund Type")
    
  })
  
  output$BarFlows = renderPlot({
    
    ggplot(Data, aes(x=reorder(Country, Investment.stocks), y=Investment.stocks)) + 
      geom_bar(stat = 'identity', 
               aes(fill = Investment.policy),
               position = 'dodge') +
      labs(title = "Stock Value by Country",
           x = "Country",
           y = "Value (Billions)") +
      coord_flip() +
      theme(axis.text = element_text(size=13),
            axis.title = element_text(size=15),
            legend.title = element_text(size=14),
            legend.text = element_text(size=13)) +
    scale_fill_brewer(palette = "Dark2", name = "Fund Type")
    })
})
