library(shiny)
library(ggplot2)

# dataset <- diamonds

shinyUI(fluidPage(
        
        headerPanel("World Bank Fertility vs Life Expectancy"),
        fluidRow(column(1, plotlyOutput('plot', width = 950), width = 12)
        ),
        fixedRow(
                column(3,
                sliderInput('year', 'year', min=1960, max=2014,
                            value = 1960,step=1, round=0, animate = TRUE, sep="")
        ,width=3),
        column(2, offset=0, sliderInput("population_size",
                                        "Population",
                                        min = 3,
                                        max = 40,
                                        value = 16,
                                        sep="",
                                        ticks = FALSE)
        )
        )
        
))