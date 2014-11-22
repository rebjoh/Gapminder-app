shinyUI(fluidPage(
	titlePanel("Gapminder Shiny App"),
	
	sidebarLayout(
		sidebarPanel("Select year and country from Gapminder",
								 uiOutput("choose_country"),
# 								 selectInput("select_country",
# 								 						label = "Country",
# 								 						choices = list("Chad", "Iraq", "Mali")),
								 sliderInput("year_range",
								 						label = "Range of years:",
								 						min = 1952,
								 						max = 2007,
								 						value = c(1955, 2005), 
								 						format = "####", 
								 						step = 5)
								 ),
		mainPanel(#"My cool graphs will go here",
							h2(textOutput("output_country")),
							textOutput("info"),
							plotOutput("ggplot_gdpPercap_vs_country"),
							tableOutput("gapminder_table"))
		)
	))