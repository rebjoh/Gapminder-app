Gapminder-app
=============

Shiny application for viewing Gapminder data


## Reflections

Add `radioButton` widget to Shiny app, use choice to filter (using dplyr) and plot (using ggplot) Gapminder data
- This was MUCH harder than I expected!!! Very painful. I have documented my approach to debug this issue below:
 - I'm having a lot of problems with this. I think it is because I am using `dplyr` within a `shiny::reactive` function (i.e. `dplyr::select` piped to `dplyr::filter`)?
 - I tried to remove pipes: Failed. I now have multiple `reactive` functions for the same data (one wth a `dplyr::select` call, another with a `dplyr::filter`), but `dplyr` functions do not know how to deal with `reactive` objects: no applicable method for 'filter_' applied to an object of class "reactive"
 - I found [this StackOverflow issue](http://stackoverflow.com/questions/24292706/rmarkdown-v2-shiny-document-and-dplyr) that may relate to my problem. When I added "matches" to the `reactive` function, `renderTable` works, but `renderPlot` doesn't. Is it because I refer to the radioButton `input$variable` within `renderPlot` but not within `renderTable`???
 - I have found a solution: I need to use `aes_string` within ggplot! Thanks to both [Winston's post on Shiny google groups](https://groups.google.com/forum/#!topic/shiny-discuss/Ds2CKVfC4-Q) and [Julia's help](https://github.com/rebjoh/Gapminder-app/issues/1) 
- However, I STILL have an error about an object not found: "Error in eval(expr, envir, enclos) : object 'year' not found". I really don't know how to get rid of this error. I tried:
 - Adding `quote` before suppling the reactive expression, and adding `quoted = TRUE` argument to the reactive function, as per the documentation on `?reactive`. Fail.
 - Adding `paste` in front of the ggplot call. Fail.
 - I tried adding `return` to the reactive function.
 - Print statement `str(two_country_data_year())` I get an error: "Error in two_country_data$year : 
  object of type 'closure' is not subsettable". Hmm.
