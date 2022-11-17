#' intro_papeles UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS
#' @importFrom shiny tagList
#' @importFrom shiny textInput
#' @importFrom shiny actionButton
#' @importFrom shiny textOutput
introUI <- function(id){

  tagList(

    textInput(NS(id, "introducidos"),
              "Mete papelitos:",
              placeholder = "el chico guapo de ayer, Caperucita Roja, ..."
    ),
    actionButton(NS(id, "a_la_cesta"), label = "\u00a1A la cesta\u0021"),
    textOutput(NS(id, "num_papelitos"))
  )
}

#' intro_papeles Server Functions
#'
#' @param cesta cesta object
#'
#' @importFrom stringr str_trim
#' @importFrom shiny moduleServer
#' @importFrom shiny observeEvent
#' @importFrom shiny renderText
#'
#' @noRd
introServer <- function(id, cesta){

  moduleServer(id, function(input, output, session){

    observeEvent(input$a_la_cesta, {
      nuevos_papelitos <- setdiff(str_trim(unlist(strsplit(input$introducidos, ","))),
                                  "")
      cesta$papelitos <- c(cesta$papelitos, nuevos_papelitos)
    })

    output$num_papelitos <- renderText({
      input$a_la_cesta
      if(length(cesta$papelitos) == 0){
        return(sprintf("A\u00fan no hay papelitos en la cesta"))
      } else {
        return(sprintf("En total hay %i papelitos", length(cesta$papelitos))  )
      }

    })
    # return reactive value cesta
    cesta
  })


}


## To be copied in the UI
# mod_intro_papeles_ui("intro_papeles_1")

## To be copied in the server
# mod_intro_papeles_server("intro_papeles_1")
