shinyUI(fluidPage(
	titlePanel("Gapminder Shiny app"),
	
	sidebarLayout(
		sidebarPanel("Select 'Country' and 'Range of years' from Gapminder:",
								 uiOutput("choose_country"),
								 uiOutput("choose_country_2"),
								 sliderInput("year_range",
								 						label = "Range of years:",
								 						min = 1952,
								 						max = 2007,
								 						value = c(1952, 2007), 
								 						format = "####", 
								 						step = 5)
								 ),
		mainPanel(#"My cool graphs will go here",
							h3(textOutput("output_countries_years")),
							textOutput("info"),
							plotOutput("ggplot_gdpPercap_vs_two_countries"),
							tableOutput("gapminder_table"))
		)
	))