shinyServer(function(input, output) {
  
  cesta <- reactiveValues(papelitos = NULL, 
                          usados = NULL)
  
  
  cesta <- introServer("comienzo", cesta)
  
  cesta <- botonAccionServer("partida", cesta)
  
  cesta <- cogerPapelitoServer("partida", cesta)  
  cuantosQuedanServer("partida", cesta)
  timeServer("tiempo")
})
