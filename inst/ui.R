shinyUI(fluidPage(

    includeCSS("www/style.css"),
    # Application title
    titlePanel("Papelitos"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            instruccionesUI("instrus")
        ),

        # Show a plot of the generated distribution
        mainPanel(
            fluidRow(
                introUI("comienzo")
            ),
            br(),
            fluidRow(
                column(4,
                    cogerPapelitoUI("partida")
                ), 
                column(4,
                    timeUI("tiempo")
                )
                    
            )
            
        )
    )
))
