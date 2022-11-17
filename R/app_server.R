#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function(input, output, session) {
  # Your application server logic


  cesta <- reactiveValues(papelitos = c(),
                          usados = c())

  cesta <- introServer("comienzo", cesta)

  cesta <- botonAccionServer("partida", cesta)

  cesta <- cogerPapelitoServer("partida", cesta)
  cuantosQuedanServer("partida", cesta)
  timeServer("tiempo")
}
