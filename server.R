library("plyr")
library("dplyr")
library("ggplot2")

gDat <- read.delim(file = "data/gapminderDataFiveYear.tsv")

shinyServer(function(input, output){

	# Drop-down selection box generated from Gapminder dataset
	output$choose_country <- renderUI({
		selectInput("country_from_gapminder",
								"Country",
								levels(gDat$country))
	})
	
	# Add reactive function for country and year input from UI
	one_country_data <- reactive({
		if(is.null(input$country_from_gapminder)) {
			return(NULL)
		}
		filter(gDat, country == input$country_from_gapminder,
					 year >= min(input$year_range),
					 year <= max(input$year_range))
	})
	
	# Render country and year input from UI as a table
	output$gapminder_table <- renderTable({
		one_country_data()
	})
	
	# Render country and range of years input from UI as text
	output$output_country <- renderText({
		paste("GDP per capita for", input$country_from_gapminder,
					min(input$year_range), "-", max(input$year_range))
	})

	# Print info on years selected to console (renderPrint prints to UI)
	output$info <- renderText({
		str(input$year_range)
		})
	
	# Render country and year input from UI as a plot
	output$ggplot_gdpPercap_vs_country <- renderPlot({
		if (is.null(input$country_from_gapminder)){
			return(NULL)
		}
		ggplot(one_country_data(), aes(x = year, y = gdpPercap, colour = country)) +
			geom_line() +
			ylab("GDP per capita") +
			xlab("Year")
	})
})