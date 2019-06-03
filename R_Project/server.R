
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
  
  output$LinePlotStocks = renderPlot({
    yearly_data =
      Data[Data$Year == input$Year &
             Data$Investment.policy == input$FundType,]
    
    ggplot(yearly_data, aes(x = Date, y = Investment.stocks)) +
      geom_line(aes(color = Country), size=1) +
      labs(title = "Investment Stocks",
           x = "Date",
           y = "Value (Billions)") +
      theme(axis.text = element_text(size = 13),
            axis.title = element_text(size = 15),
            legend.title = element_text(size=14),
            legend.text = element_text(size=13))
    
  })
  
  output$LinePlotFlows = renderPlot({
    yearly_data =
      Data[Data$Year == input$Year &
             Data$Investment.policy == input$FundType,]
    
    ggplot(yearly_data, aes(x = Date, y = Investment.flows)) +
      geom_line(aes(color = Country), size=1) +
      labs(title = "Investment Flows",
           x = "Date",
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
      labs(title = "Stock Value by Fund Type",
           x = "Country",
           y = "Value (Billions)") +
      coord_flip() +
      theme(axis.text = element_text(size=13),
            axis.title = element_text(size=15),
            legend.title = element_text(size=14),
            legend.text = element_text(size=13)) +
      scale_fill_manual(values = "darkcyan", name = "Fund Type")
    
  })
  
  output$BarFlows = renderPlot({
    
    ggplot(TopCountries, aes(x=reorder(Country, Investment.stocks), y=Investment.stocks)) + 
      geom_bar(stat = 'identity', 
               aes(fill = Investment.policy),
               position = 'dodge') +
      labs(title = "Stock Value of Top 5 European Countries",
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
