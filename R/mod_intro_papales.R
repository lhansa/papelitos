introUI <- function(id){

    tagList(

            textInput(NS(id, "introducidos"), 
                      "Mete papelitos:",
                      placeholder = "el chico guapo de ayer, Caperucita Roja, ..."
            ), 
            actionButton(NS(id, "a_la_cesta"), label = "¡A la cesta!"), 
            textOutput(NS(id, "num_papelitos"))
    )
}

introServer <- function(id, papelitos){

    moduleServer(id, function(input, output, session){
      
      papelitos <- eventReactive(input$a_la_cesta, {
        setdiff(stringr::str_trim(unlist(strsplit(input$introducidos, ","))), 
                "")
      })
      
      output$num_papelitos <- renderText({
        sprintf("En total hay %i papelitos", length(papelitos()))
      })
      
    })

}
