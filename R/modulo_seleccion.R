seleccion_ui <- function(id) {
  ns <- NS(id) # Crea un espacio de nombres para el módulo
  tagList(
    selectizeInput(ns("pais"), "Selecciona un país:", choices = unique(resultados$home_team)),
    verbatimTextOutput(ns("salida"))
  )
}
seleccion_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    output$salida <- renderPrint({
      paste("Selección:", input$pais)
    })
    return(list(pais = reactive(input$pais))) # Devuelve el país seleccionado como un valor reactivo
  })
}