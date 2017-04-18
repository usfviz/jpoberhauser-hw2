library(shiny)
library(ggplot2)
library(plotly)

shinyServer(function(input, output) {
        dataset <- reactive({
                 full_w_cot[full_w_cot$year==input$year,]
        })
        output$plot <- renderPlotly({
                p <- ggplot(dataset(), aes(fertility,life_ex, color=Region, key=Country.Name))
                p + geom_point(aes(size = population),alpha=0.5) + ylim(c(0,90)) +
                        xlim(c(0,9)) + theme(legend.title=element_blank())+
                        scale_size(range = c(3,input$population_size))+ylab("Life Expectancy") + xlab("Fertility")
                
        })
})