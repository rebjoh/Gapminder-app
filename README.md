Gapminder-app
=============

Shiny application for viewing Gapminder data.

* View [Gapminder Shiny app](https://rebjoh.shinyapps.io/Gapminder-app/)
* View code: [server.R](https://github.com/rebjoh/Gapminder-app/blob/master/server.R) and [ui.R](https://github.com/rebjoh/Gapminder-app/blob/master/ui.R)

## Reflections

**Debugging Shiny app issues was not easy, and very time consuming!**
- If anything, making my first Shiny app helped me to appreciate the awesomeness of built in testing when building an R package.

**Adding a `radioButtons` widget to Shiny app, and using selection from `radioButtons` to filter (using dplyr) and plot (using ggplot) Gapminder data was MUCH harder than I expected!**
- This step was very painful and time consuming to debug. The choices within `radioButtons` are returned in quotes, and by default, `dplyr` and `ggplot` do not handle quoted variables. Thus the output of `renderTable` and `renderPlot` failed.
- I tried many different ways to remove quotes from the variables, but this turned out to be difficult.
- Solution part 1: I found [this StackOverflow issue](http://stackoverflow.com/questions/24292706/rmarkdown-v2-shiny-document-and-dplyr) related to my problem. When I added `matches(input$variable)` to the `reactive` function, the downstream `renderTable` function works, but `renderPlot` didn't work.
 - Solution part 2: I also needed to use `aes_string` within the `renderPlot` ggplot call! Thanks to both [Winston's post on Shiny google groups](https://groups.google.com/forum/#!topic/shiny-discuss/Ds2CKVfC4-Q) and Julia's help ([see issue 1](https://github.com/rebjoh/Gapminder-app/issues/1))

**The reactive function is very confusing!**
- From the earliest stages of the Shiny app development, I obtained the error: "Error in eval(expr, envir, enclos) : object 'year' not found". I spent hours trying to debug this issue. It turns out I had to add another `is.null` argument for the year variable produced by the reactive function, but not in the way I expected...
 - Clue: adding the print statement `str(two_country_data$year())` produced the following error: "Error in two_country_data$year : object of type 'closure' is not subsettable".
 - i.e. reactive objects are functions!!! Consequently, if you produce a dataframe using a reactive function, you do not access columns in the usual way. To access reactive object variable columns, I didn't realise you had to add open close brackets BEFORE the `$` column name! i.e. `two_country_data()$year` (correct) is not the same as `two_country_data$year()` (incorrect).
- Thanks again to Julia for helping me figure this out! ([see issue 1](https://github.com/rebjoh/Gapminder-app/issues/1))

**Favourite moment during Shiny app development: no more red error messages popping up on the screen**
- I could then concentrate on making the user interface pretty :)

**Future applications for Shiny?**
- Shiny + ggvis, full integration? It would be nice to hover your mouse over graphs in Shiny and see the values.
- Aim to be as cool as the [Google Public Data Explorer](www.google.ca/publicdata/directory) (which actually acquired Gapminder's Trendalyzer software!). The play button feature is pretty wicked.
- Add Shiny apps to presentations, e.g. add it as a slide in Keynote/Powerpoint/other? That would be sweet!
