library(shiny)

ui <- pageWithSidebar(
  # App title ----
  headerPanel("Miles Per Gallon"),
  # Sidebar panel for inputs ----
  sidebarPanel(),
  # Main panel for displaying outputs ----
  mainPanel(
	    img(src="sector-1.png", align="right")
	    )
)

# Define server logic to plot various variables against mpg ----
server <- function(input, output) {

}

shinyApp(ui, server)


