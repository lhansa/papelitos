introUI <- function(id){

    tagList(

            textInput(NS(id, "intro"), 
                      "Mete papelitos:"
                      placeholder = "el chico guapo de ayer, Caperucita Roja, ..."
            ), 
            textOutput(NS(id, "num_papelitos"))
    )
}

introServer <- function(id){

    moduleServer(id, function(input, output, session){
                 
                papelitos <- c(papelitos, input$num_papelitoinput$num_papelitos) 

    }

}
