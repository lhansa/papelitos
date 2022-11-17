#' saca_papelito UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS
#' @importFrom shiny tagList
#' @importFrom shiny actionButton
#' @importFrom shiny uiOutput
cogerPapelitoUI <- function(id){
  tagList(
    # actionButton(NS(id, "saca_papelito"), "Saca papelito!"),
    # br(),
    # br(),
    # uiOutput(NS(id, "papelito_turno"))


    uiOutput(NS(id, "main_button")),
    br(),
    br(),
    uiOutput(NS(id, "turno")),
    textOutput(NS(id, "cuantos_quedan"))
  )

}
#' saca_papelito Server Functions
#'
#' @param cesta Objeto cesta
#'
#' @importFrom shiny moduleServer
#' @importFrom htmltools HTML
#' @importFrom shiny renderUI
#'
#' @noRd
botonAccionServer <- function(id, cesta) {
  moduleServer(id, function(input, output, session) {
    output$main_button <- renderUI({
      if(length(cesta$papelitos) == 0) {
        actionButton(NS(id, "nada"), "")
      } else if(length(cesta$papelitos) == length(cesta$usados)) {
        actionButton(NS(id, "nueva_ronda"), "Nueva ronda\u0021")
      } else {
        actionButton(NS(id, "saca_papelito"), "Saca papelito\u0021")
      }
    })

    observeEvent(input$nueva_ronda, {
      cesta$usados <- NULL
    })
    cesta
  })
}

#' @param cesta Objeto cesta
#'
#' @importFrom shiny moduleServer
#' @importFrom shiny observeEvent
#' @importFrom htmltools HTML
#' @importFrom shiny renderUI
#'
#' @noRd
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
          "<div id=\"papelito\">%s</div>",
          papelito_sacado
        ))

        # }

      })

    })


    cesta

  })
}

#' @param cesta Objeto cesta
#'
#' @importFrom shiny moduleServer
#' @importFrom shiny renderText
#'
#' @noRd
cuantosQuedanServer <- function(id, cesta) {
  moduleServer(id, function(input, output, session) {
    output$cuantos_quedan <- renderText({

      if (length(cesta$papelitos) == 0) {
        return("")
      } else if (length(cesta$usados) == 0) {
        return("La cesta est\u00e1 completa. Empieza a jugar :)")
      } else if (length(cesta$usados) == length(cesta$papelitos)) {
        return("Ya no quedan papelitos. \u00a1Nueva ronda\u0021")
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

## To be copied in the UI
# mod_saca_papelito_ui("saca_papelito_1")

## To be copied in the server
# mod_saca_papelito_server("saca_papelito_1")
