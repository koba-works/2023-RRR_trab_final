# graf_vendas_prod_benef
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)

ui <- fluidPage(
  titlePanel("Valor total das vendas de Produção Beneficiada por ano e UF"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("ano", "Ano base:", min = min(dados_vendaProdBenef$ano_base), max = max(dados_vendaProdBenef$ano_base), value = max(dados_vendaProdBenef$ano_base))
    ),
    mainPanel(
      plotOutput("grafico")
    )
  )
)

server <- function(input, output) {
  output$grafico <- renderPlot({
    dados_venda_filtrado <- subset(dados_vendaProdBenef, ano_base == input$ano)
    ggplot(dados_venda_filtrado, aes(x = uf, y = valor_venda_r, fill = factor(ano_base))) + 
      geom_bar(stat = "identity") +
      labs(x = "UF", y = "Valor de venda (R$)", fill = "Ano") +
      theme_bw() +
      # scale_y_continuous(labels = scales::comma_format()) +
      scale_x_discrete(limits = c("AC", "AL", "AM", "AP", "BA", "CE", "DF", "ES", "GO", "MA", "MG", "MS", "MT", "PA", "PB", "PE", "PI", "PR", "RJ", "RN", "RO", "RR", "RS", "SC", "SE", "SP", "TO"))
  })
}

shinyApp(ui, server)
