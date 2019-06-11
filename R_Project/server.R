
#Server
shinyServer(function(input, output) {
  
  output$text = renderText({
    "The dataset used to create this app contained a total of 12,055 data points pertaining to investment funds of
    more than 20 European countries over a span of 10 years. These funds are broken down into stocks and flows, which
    refers to the total value held and the total value traded by the start of each month. This dataset also contained
    the type of fund the investments were made in. Each plot included in this app is intended to allow you to interact 
    with it and find any information that you may be interested in on this subject matter. Every plot varies by the year
    that you select on the scroll bar on the side menu. The first set of bar plots allows you to select a country and compare 
    how much this individual country invests in a particular kind of fund. The second set of line plots allows you to select a fund
    type and compare which countries invest in that type of fund the most. The final set of bar plots display the investment funds
    of the top 5 countries in Europe"
  })

  output$BarPlotStocks = renderPlot({
    filtered_data =
      Data[Data$Country == input$Country &
             Data$Year == input$Year,]
    
    ggplot(filtered_data) +
      geom_bar(
        stat = 'identity',
        aes(x = factor(filtered_data$Date),
            y = filtered_data$Investment.stocks,
            fill = filtered_data$Investment.policy),
        position = 'dodge') +
      labs(title = "Investment Stocks",
           x = "Date",
           y = "Amount (Billions of Euros)") +
      theme(axis.text = element_text(size = 13),
            axis.title = element_text(size = 15),
            legend.title = element_text(size=14),
            legend.text = element_text(size=13)) +
      xlab('Date') +
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
          x = factor(filtered_data$Date),
          y = filtered_data$Investment.flows,
          fill = filtered_data$Investment.policy
        ),
        position = 'dodge'
      ) +
      labs(title = "Investment Flows",
           x = "Date",
           y = "Amount (Billions of Euros)") +
      theme(axis.text = element_text(size = 13),
            axis.title = element_text(size = 15),
            legend.title = element_text(size=14),
            legend.text = element_text(size=13)) +
      scale_fill_brewer(palette = "Dark2", name = "Fund Type")
  })
  
  output$LinePlotStocks = renderPlotly({
    yearly_data =
      Data[Data$Year == input$Year &
             Data$Investment.policy == input$FundType,]
    
    ggplot(yearly_data, aes(x = Date, y = Investment.stocks)) +
      geom_line(aes(color = Country, linetype = Country), size=1) +
      scale_linetype_manual(values =rep(c(2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2))) +
      labs(title = "Investment Stocks",
           x = "Date",
           y = "Amount (Billions of Euros)") +
      xlab('Date') +
      theme(axis.text = element_text(size = 10),
            axis.title = element_text(size = 10),
            legend.title = element_text(size=12),
            legend.text = element_text(size=9))
    
  })
  
  output$LinePlotFlows = renderPlotly({
    yearly_data =
      Data[Data$Year == input$Year &
             Data$Investment.policy == input$FundType,]
    
    ggplot(yearly_data, aes(x = Date, y = Investment.flows)) +
      geom_line(aes(color = Country, linetype = Country), size=1) +
      scale_linetype_manual(values =rep(c(2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2))) +
      labs(title = "Investment Flows",
           x = "Date",
           y = "Amount (Billions of Euros)") +
      xlab('Date') +
      theme(axis.text = element_text(size = 10),
            axis.title = element_text(size = 10),
            legend.title = element_text(size=12),
            legend.text = element_text(size=9))
  })
  
  output$BarStocks = renderPlot({
    fund_data = 
      Data[Data$Investment.policy == input$FundType2 &
             Data$Year == input$Year, ]
    
    ggplot(fund_data, aes(x=reorder(Country, Investment.stocks), y=Investment.stocks)) + 
      geom_bar(stat = 'identity', 
               aes(fill = Investment.policy),
               position = 'dodge') +
      labs(title = "Stock Value by Fund Type",
           x = "Country",
           y = "Amount (Billions of Euros)") +
      coord_flip() +
      theme(axis.text = element_text(size=13),
            axis.title = element_text(size=15),
            legend.title = element_text(size=14),
            legend.text = element_text(size=13)) +
      scale_fill_manual(values = "red4", name = "Fund Type")
    
  })
  
  output$BarFlows = renderPlot({
    TopCountries = 
      TopCountries[TopCountries$Year == input$Year, ]
    
    ggplot(TopCountries, aes(x=reorder(Country, Investment.stocks), y=Investment.stocks)) + 
      geom_bar(stat = 'identity', 
               aes(fill = Investment.policy),
               position = 'dodge') +
      labs(title = "Stock Value of Top 5 European Countries",
           x = "Country",
           y = "Amount (Billions of Euros)") +
      coord_flip() +
      theme(axis.text = element_text(size=13),
            axis.title = element_text(size=15),
            legend.title = element_text(size=14),
            legend.text = element_text(size=13)) +
    scale_fill_brewer(palette = "Set1", name = "Fund Type")
    })
})
