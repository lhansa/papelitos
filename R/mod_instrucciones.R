#' instrucciones UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom htmltools includeHTML
instruccionesUI <- function(id){
  includeHTML("inst/app/www/instrucciones.html")
}

