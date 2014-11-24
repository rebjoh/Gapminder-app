Gapminder-app
=============

Shiny application for viewing Gapminder data


## Reflections

Adding `radioButton` widget for variable from Gapminder to Shiny app
- I'm having a lot of problems with this. I think it is because I am using `dplyr` within a `shiny::reactive` function (i.e. `dplyr::select` piped to `dplyr::filter`)?
- I tried to remove pipes: Failed. I now have multiple `reactive` functions for the same data (one wth a `dplyr::select` call, another with a `dplyr::filter`), but failed since `dplyr` functions do not know how to deal with `reactive` objects: no applicable method for 'filter_' applied to an object of class "reactive"
- I found [this StackOverflow issue](http://stackoverflow.com/questions/24292706/rmarkdown-v2-shiny-document-and-dplyr) that may relate to my problem? When I added "matches" to the `reactive` function, `renderTable` works but `renderPlot` doesn't. Is it because I refer to the radioButton `input$variable` within `renderPlot` but not within `renderTable`???
