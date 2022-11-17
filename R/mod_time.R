#' time UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS
#' @importFrom shiny uiOutput
timeUI <- function(id) {
  tags$div(
    style = "width: 100%; text-align: center;",
    "Time elapsed:",
    uiOutput(outputId = NS(id,"timer_ui"),
             style = "font-size: 200%; font-weight: bold;",
             inline = TRUE)
  )
}

#' time Server Functions
#'
#' @importFrom shiny reactiveVal
#' @importFrom shiny observeEvent
#' @importFrom shiny observe
#' @importFrom shiny invalidateLater
#' @importFrom shiny isolate
#' @importFrom shiny renderUI
#'
#' @noRd
timeServer <- function(id, start = reactive(0)){
  moduleServer(id, function(input, output, session){

    time_r <- reactiveVal(value = 0)
    started <- reactiveVal(value = FALSE)

    observeEvent(start(), {
      time_r(0)
      started(TRUE)
    }, ignoreInit = TRUE)

    observe({
      if (started()) {
        invalidateLater(1000, session)
        isolate({
          newTime <- time_r() + 1
          time_r(newTime)
        })
      }
    })

    output$timer_ui <- renderUI({
      as.character(time_r())
    })

    return(time_r)
  })
}
## To be copied in the UI
# mod_time_ui("time_1")

## To be copied in the server
# mod_time_server("time_1")
