resultados <- read.csv("data/results.csv")
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
# App principal
ui <- bslib::page_fluid(
    bslib::navset_card_underline(
        nav_panel("Panel 1", seleccion_ui("mod1"),
        plotOutput("plot1")), # Llama al módulo en la UI
        nav_panel("Panel 2", seleccion_ui("mod2"),
        reactableOutput("tabla2"))  # Llama al
    )
)
server <- function(input, output, session) {
  pais1 <- seleccion_server("mod1") # Llama al módulo en el server
  pais2 <- seleccion_server("mod2") # Llama al módulo otra vez para la segunda instancia
  output$plot1 <- renderPlot({
    # Código para generar el gráfico usando pais1$pais()
    resultados |> filter(home_team == pais1$pais()) |> 
      group_by(year = year(as.Date(date))) |> summarise(home_score = sum(home_score)) |> ggplot(aes(x = year, y = home_score)) + geom_line()
  })
  output$tabla2 <- renderReactable({
    # Código para generar la tabla usando pais2$pais()
    resultados |> filter(home_team == pais2$pais()) |> reactable()
  })
}
# shinyApp(ui, server)