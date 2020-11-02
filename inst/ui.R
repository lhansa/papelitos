shinyUI(fluidPage(

    # Application title
    titlePanel("Papelitos"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            instruccionesUI("instrus")
        ),

        # Show a plot of the generated distribution
        mainPanel(
            introUI("comienzo"), 
            br(),
            cogerPapelitoUI("partida")
        )
    )
))
