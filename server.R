library("plyr")
library("dplyr")
library("ggplot2")

gdURL <- "http://tiny.cc/gapminder"
gDat <- read.delim(file = gdURL)


shinyServer(function(input, output){
	
	output$choose_country <- renderUI({
		selectInput("country_from_gapminder",
								"Country",
								levels(gDat$country))
	})
	
	one_country_data <- reactive({
# 		if(is.null(input$country_from_gapminder)) {
# 			return(NULL)
# 		}
		filter(gDat, country == input$country_from_gapminder,
					 year >= min(input$year_range),
					 year <= max(input$year_range))
	})
	
	output$gapminder_table <- renderTable({
		one_country_data()
	})
	
	output$output_country <- renderText({
		# str(input$year_range) # Print to console
		paste("country_from_gapminder", input$country_from_gapminder)
	})
	output$info <- renderText({ # Use renderPrint to print to UI
		str(input$year_range)
		})
	output$ggplot_gdpPercap_vs_country <- renderPlot({
# 		if(is.null(input$one_country_data())) {
# 			return(NULL)
# 		}
		ggplot(one_country_data(), aes(x = year, y = gdpPercap, colour = country)) +
			geom_line()
	})
})