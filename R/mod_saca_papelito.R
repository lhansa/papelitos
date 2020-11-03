cogerPapelitoUI <- function(id){
  tagList(
    actionButton(NS(id, "saca_papelito"), "Saca papelito!"), 
    br(),
    br(),
    uiOutput(NS(id, "papelito_turno"))
  )
  
}

cogerPapelitoServer <- function(id){
  moduleServer(id, function(input, output, session){
    
    output$papelito_turno <- renderUI({
      
      input$saca_papelito # Pulsar botón de sacar papelito
      if(length(cesta$papelitos) == 0) return(HTML("<p></p>"))
      
      papelito_sacado <- sample(cesta$papelitos, 1)
      cesta$papelitos <- setdiff(cesta$papelitos, papelito_sacado)
      cesta$usados <- c(cesta$usados, papelito_sacado)
      
      return(HTML(sprintf("<div id=\"papelito\">%s</div>", papelito_sacado)))
    })
    
    
  })
}