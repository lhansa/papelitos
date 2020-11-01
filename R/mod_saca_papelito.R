cogerPapelitoUI <- function(id){
  tagList(
    actionButton(NS(id, "saca_papelito"), "Saca papelito!"), 
    textOutput(NS(id, "papelito_turno"))
  )
  
}

cogerPapelitoServer <- function(id){
  moduleServer(id, function(input, output, session){
    
    output$papelito_turno <- renderText({
      input$saca_papelito
      papelito_sacado <- sample(cesta$papelitos, 1)
      cesta$papelitos <- setdiff(cesta$papelitos, papelito_sacado)
      cesta$usados <- c(cesta$usados, papelito_sacado)
      
      return(papelito_sacado)
    })
    
    
  })
}