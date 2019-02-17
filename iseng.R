library(shiny)
library(shiny.i18n)

# File with translations
i18n <- Translator$new(translation_json_path = "https://raw.githubusercontent.com/Appsilon/shiny.i18n/master/inst/examples/data/translation.json")

# Change this to en or comment this line


ui <- shinyUI(fluidPage(
  titlePanel(i18n$t("Hello Shiny!")),
  sidebarLayout(
    sidebarPanel(
      selectInput("translate",
                  "choice language",
                  choices = c("Polish" = "pl",
                              "English" = "en"
                              ),
                  selected = "pl"),
      sliderInput("bins",
                  i18n$t("Number of bins:"),
                  min = 1,
                  max = 50,
                  value = 30)
    ),
    mainPanel(
      plotOutput("distPlot"),
      p(i18n$t("This is description of the plot."))
    )
  )
))

server <- shinyServer(function(input, output) {
  
  bahasa <- reactive({
    input$translate
  })
  
  
  output$distPlot <- renderPlot({
    x    <- faithful[, 2]
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    hist(x, breaks = bins,
         col = "darkgray", border = "white",
         main = i18n$t("Histogram of x"), ylab = i18n$t("Frequency"))
  })
})

shinyApp(ui = ui, server = server)
