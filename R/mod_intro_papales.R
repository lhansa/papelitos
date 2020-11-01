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

introServer <- function(id){

    moduleServer(id, function(input, output, session){
      
      observeEvent(input$a_la_cesta, {
        nuevos_papelitos <- setdiff(stringr::str_trim(unlist(strsplit(input$introducidos, ","))), 
                                    "")
        cesta$papelitos <- c(cesta$papelitos, nuevos_papelitos)
      })
      
      output$num_papelitos <- renderText({
        input$a_la_cesta
        if(length(cesta$papelitos) == 0){
          return(sprintf("Aún no hay papelitos en la cesta"))
        } else {
          return(sprintf("En total hay %i papelitos", length(cesta$papelitos))  )
        }
        
      })
      
    })

}
