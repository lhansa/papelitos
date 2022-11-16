cogerPapelitoUI <- function(id){
  tagList(
    uiOutput(NS(id, "main_button")),
    br(),
    br(),
    uiOutput(NS(id, "turno")),
    textOutput(NS(id, "cuantos_quedan"))
  )
  
}

botonAccionServer <- function(id, cesta) {
  moduleServer(id, function(input, output, session) {
    output$main_button <- renderUI({
      if(length(cesta$papelitos) == 0) {
        actionButton(NS(id, "nada"), "")
      } else if(length(cesta$papelitos) == length(cesta$usados)) {
        actionButton(NS(id, "nueva_ronda"), "Nueva ronda!")
      } else {
        actionButton(NS(id, "saca_papelito"), "Saca papelito!")
      }
    })
    
    observeEvent(input$nueva_ronda, {
      cesta$usados <- NULL
    })
    cesta
  })
}

cogerPapelitoServer <- function(id, cesta){
  moduleServer(id, function(input, output, session){
    
    # papelito_sacado <- eventReactive(input$saca_papelito, {
    #   if(length(cesta$papelitos) == length(cesta$usados)) return("")
    #   if(length(cesta$papelitos) == 0) return("")
    #   sample(setdiff(cesta$papelitos, cesta$usados), 1)
    #   # cesta$papelitos <- setdiff(cesta$papelitos, papelito_sacado)
    #   # cesta$usados <- c(cesta$usados, papelito_sacado)  
    #   
    # })
    
    observeEvent(input$saca_papelito, {
      
      papelito_sacado <- sample(setdiff(cesta$papelitos, cesta$usados), 1)
      
      output$turno <- renderUI({
        # if(is.null(papelito_sacado())) {
        #   print("is null")
        #   HTML("<p></p>")
        # } else if (papelito_sacado() == "") {
        #   print("is ''")
        #   HTML("<p></p>")
        # } else {
        isolate(cesta$usados <- c(cesta$usados, papelito_sacado))
        # print(papelito_sacado())
        HTML(sprintf(
          "<div id=\"raro\">%s</div>",
          papelito_sacado
        ))
        
        # }
        
      })
      
    })
  
  
  cesta
  
  })
}

cuantosQuedanServer <- function(id, cesta) {
  moduleServer(id, function(input, output, session) {
    output$cuantos_quedan <- renderText({
      
      if (length(cesta$papelitos) == 0) {
        return("")
      } else if (length(cesta$usados) == 0) {
        return("La cesta está completa. Empieza a jugar :)")
      } else if (length(cesta$usados) == length(cesta$papelitos)) {
        return("Ya no quedan papelitos. ¡Nueva ronda!")
      } else {
        n_cuantos_quedan <- length(cesta$papelitos) - length(cesta$usados)
        return(sprintf(
          "Quedan %i papelitos para esta ronda", 
          n_cuantos_quedan
        ))  
      }
      
    })
  })
}