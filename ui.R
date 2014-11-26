# ui.R
# Rebecca Johnston

shinyUI(fluidPage(
	titlePanel("Gapminder Shiny app"),
	
	sidebarLayout(
		sidebarPanel("Choose an indicator, two countries, and a year range to 
								 compare indicators between two countries graphically:",
								 hr(),
								 radioButtons("variable_from_gapminder",
								 						 label = h5("Variable:"),
								 						 choices = c("Population" = "pop",
								 						 						"Life Expectancy" = "lifeExp",
								 						 						"GDP Per Capita" = "gdpPercap"),
								 						 selected = "pop"),
								 hr(),
								 uiOutput("choose_country"),
								 hr(),
								 uiOutput("choose_country_2"),
								 hr(),
								 sliderInput("year_range",
								 						label = h5("Range of years:"),
								 						min = 1952,
								 						max = 2007,
								 						value = c(1952, 2007), 
								 						format = "####", 
								 						step = 5)),
		mainPanel(h3(textOutput("output_countries_years")),
							textOutput("info"),
							textOutput("more_info"),
							plotOutput("ggplot_variable_vs_two_countries"),
							hr(),
							h3("Tabulated results"),
							tableOutput("gapminder_table"))
		)
	))