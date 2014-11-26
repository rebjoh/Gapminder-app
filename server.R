# server.R
# Rebecca Johnston

# Load required libraries
library("plyr")
library("dplyr")
library("ggplot2")

# Load Gapminder data
gDat <- read.delim(file = "data/gapminderDataFiveYear.tsv")

# Make population and life exp variables in gDat more readable
gDat$pop <- gDat$pop/1000000 
gDat$lifeExp <- round(gDat$lifeExp)

# Define server functionality
shinyServer(function(input, output){

	# Create drop-down selection for country generated from Gapminder dataset
	output$choose_country <- renderUI({
		selectInput("country_from_gapminder",
								h5("First country:"),
								levels(gDat$country),
								selected = "Canada")
		})
	
	# Create drop-down selection for a 2nd country
	# Exclude "country_from_gapminder" as an option
	output$choose_country_2 <- renderUI({
		selectInput("country_2_from_gapminder",
								h5("Second country:"),
								levels(gDat$country)[levels(gDat$country) != 
																		 	input$country_from_gapminder],
								selected = "Australia")
		})

	# Add reactive function for two countries and year input from UI
	two_country_data <- reactive({

		if(is.null(input$country_from_gapminder)){
			return(NULL)
		}
		
		if(is.null(input$country_2_from_gapminder)){
			return(NULL)
		}
		
		gDat %>%
			select(country, year, continent, 
						 matches(input$variable_from_gapminder)) %>%
			filter(country %in% c(input$country_from_gapminder, 
														input$country_2_from_gapminder),
						 year >= min(input$year_range) &
						 	year <= max(input$year_range))
		})

	# Render two countries and year input from UI as a table
	output$gapminder_table <- renderTable({
		two_country_data()
	})

	# Render country and range of years input from UI as text
	output$output_countries_years <- renderText({
		paste(input$country_from_gapminder, "and",
					input$country_2_from_gapminder,
					min(input$year_range), "-", max(input$year_range))
		})

	# Print info on years selected to console (renderPrint prints to UI)
	output$info <- renderText({
		str(two_country_data()$year)
		})

	output$more_info <- renderText({
		str(two_country_data())
	})

	# Render ggplot plot based on variable input from radioButtons
	output$ggplot_variable_vs_two_countries <- renderPlot({
		
		if(is.null(two_country_data()$year)){
			return(NULL)
		}
		
		if(input$variable_from_gapminder == "pop") y_axis_label <- "Population (millions)"
		if(input$variable_from_gapminder == "lifeExp") y_axis_label <- "Life Expectancy (years)"
		if(input$variable_from_gapminder == "gdpPercap") y_axis_label <- "GDP Per Capita, PPP (fixed 2005 international $)"

		# Add aes_string argument for input from radioButtons, see:
		# https://groups.google.com/forum/#!topic/shiny-discuss/Ds2CKVfC4-Q
		ggplot(two_country_data(), aes_string(x = "year",
																					y = input$variable_from_gapminder,
																					colour = "country")) +
			geom_line(size = 1) +
			xlab("Year") +
			ylab(y_axis_label)
		})
})
