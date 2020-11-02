#' A Jugar
#' 
#' Función para ejecutar la Shiny App Papelitos.
#'
#' @return
#' @export
#'
#' @examples aJugar()
aJugar <- function(){
  shiny::runApp("inst", port = 3838, launch.browser = FALSE)
}
