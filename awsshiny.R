##########################
#     Test de Shiny      #
##########################

#################
#   Librerías   #
#################


suppressMessages(if(!require(readxl)){ install.packages("readxl")})
suppressMessages(if(!require(dplyr)){ install.packages("dplyr")})
suppressMessages(if(!require(DT)){ install.packages("DT")})
suppressMessages(if(!require(plyr)){ install.packages("plyr")})
suppressMessages(if(!require(readr)){ install.packages("readr")})
suppressMessages(if(!require(janitor)){ install.packages("janitor")})
suppressMessages(if(!require(shiny)){ install.packages("shiny")})
suppressMessages(if(!require(shinydashboard)){ install.packages("shinydashboard")})
suppressMessages(if(!require(formattable)){ install.packages("formattable")})

suppressMessages(library(readxl))
suppressMessages(library(dplyr))
suppressMessages(library(DT))
suppressMessages(library(plyr))
suppressMessages(library(readr))
suppressMessages(library(janitor))
suppressMessages(library(shiny))
suppressMessages(library(shinydashboard))

suppressMessages(library(formattable))

###############
#  Opciones   #
###############

  options(scipen=999)

###################################
#     Creación del dashboard      #
###################################

####################################
#  Parámetros: datos + dashboard   #
####################################

#############
#  Millones #
#############

Millones <- 1000000

################################
#  Delimitación años análisis  #
################################

Anos_analisis <- 2007

####################
#  Años referencia #
####################

Ano_actual    <- as.numeric(substr(Sys.Date(),1,4))
Ano_pasado_1  <- as.numeric(substr(Sys.Date(),1,4))-1  
Ano_pasado_2  <- as.numeric(substr(Sys.Date(),1,4))-2


####################
#  Mes referencia  #
####################

Mes_actual <- substr(Sys.Date(),6,7)

#######################
#  Faltante de meses  #
#######################

Faltante_mes <- 12 - as.numeric(substr(Sys.Date(),6,7))

######################
#  Gastos corrientes #
######################

Gastos.corrientes <- 1

######################
#   Regla Fiscal     #
######################

RF_GC <- 4.67

############################
#          header          #
############################

header <- dashboardHeader(title = "Regla Fiscal")

############################
#          sidebar         #
############################

############################
#          sidebar         #
############################

sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem("Presentacion",tabName = "inicio", icon = icon("chalkboard")),
    menuItem("Evolucion del presupuesto", icon = icon("chart-line"),
             startExpanded = FALSE,
             menuSubItem("Anuales", tabName = "HC1", icon = icon("chevron-circle-right")),
             menuSubItem("Mensuales", tabName = "HC2", icon = icon("chevron-circle-right")),
             menuSubItem("Por Titulo - anual", tabName = "HC3", icon = icon("chevron-circle-right")),
             menuSubItem("Por Titulo - Mensual", tabName = "HC4", icon = icon("chevron-circle-right"))
    ),
    menuItem("Analisis por clasificador", icon = icon("diagnoses"),
             startExpanded = FALSE,
             menuSubItem("GC --COG - ECO.2", tabName = "detalle1", icon = icon("line")),
             menuSubItem("Titulo --  COG - ECO.2", tabName = "detalle2", icon = icon("line"))
    ),
    menuItem("Indicadores del gastos", icon = icon("comment-dollar"),
             startExpanded = FALSE,
             menuSubItem("Gasto en el  GC", tabName = "index1", icon = icon("coins")),
             menuSubItem("Gasto: nominal - %_variacion", tabName = "index2", icon = icon("coins"))
             
    ),  
    
    menuItem("Proyecciones", icon = icon("bar-chart"),
             startExpanded = FALSE,
             menuSubItem("Pronostico -- GC", tabName = "pronos1", icon = icon("accusoft")),
             menuSubItem("Pronostico resumen GC", tabName = "pronos2", icon = icon("coins")),
             menuSubItem("Pronostico -- Titulo", tabName = "pronos3", icon = icon("accusoft")),
             menuSubItem("Pronostico resumen Titulo", tabName = "pronos4", icon = icon("coins"))
             
    ),
    menuItem("Indicadores de Riesgo", icon = icon("map-pin"),  
             startExpanded = FALSE,
             menuSubItem("Alertas", tabName = "alertas", icon = icon("exclamation-triangle")
             )
    ),
    
    menuItem("Evolucion RF", icon = icon("chart-line"),
             startExpanded = FALSE,
             menuSubItem("Bitacora de la evolucion de la RF", tabName = "creci1", icon = icon("comment-dollar")),
             menuSubItem("Evolucion grafica de la RF", tabName = "creci2", icon = icon("accusoft"))
             
    )
    
  )
)



############################
#          body            #
############################

###################
#   Declaración   #
###################

###################
#     The body    #
###################

############################
#          body            #
############################


body <- dashboardBody(
  tabItems(  
    
    
    #################
    #  Presentacion #  
    #################
    
    tabItem(tabName = "inicio",
            h2("Analisis de la verificacion de la Regla Fiscal para los gastos corrientes en el Gobierno Central")
    ),
    
    ###########################################
    #      Evolucion de los presupuestos      #
    ###########################################
    
    tabItem(tabName = "HC1",
            h2("Analisis de los presupuestos anuales en el Gobierno Central")
            
    ),
    
    tabItem(tabName = "HC2",
            h2("Analisis de los presupuestos mensaules en el Gobierno Central")
            
    ),
    
    tabItem(tabName = "HC3",
            h2("Analisis de los presupuestos anuales por Titulo")
            
    ),
    
    ##################################################
    #              Analisis por clasificador         #
    ##################################################  
    
    ######################
    #  Gobierno Central  #
    ######################
    
    tabItem(tabName = "detalle1",
            h2("Analisis del gasto segun Clasificador en el Gobierno Central")
    ),
    
    ######################
    #       Titulo       #
    ######################
    
    tabItem(tabName = "detalle2",
            h2("Analisis del gasto segun Clasificador por Titulo")
    ),
    
    
    
    ##################################################
    #              Indicadores del gasto             #
    ##################################################
    
    tabItem(tabName = "index1",
            fluidRow(
              h2("Analisis de los indicadores para los gastos corrientes en el Gobierno Central"),
              br(), br()
            )
    ),
    
    tabItem(tabName = "index2",
            fluidRow(
              box(
                h2("Analisis de la ejecucion en el gastos corrientes para el Gobierno Central")
              ),
              fluidRow(
                box(
                  h2("Analisis del % variacion en la jecucion del gastos corrientes en el Gobierno Central")
                )
                
                
              )
            )
    ),
    
    #################################
    #         Proyecciones          #
    #################################
    
    #######################
    #  Gobierno Central   #
    #######################
    
    tabItem(tabName = "pronos1",
            h2("Proyeccion del gasto corriente en el Gobierno Central")
            
    ),
    
    tabItem(tabName = "pronos2",
            h2(paste0("Proyeccion del gasto corriente en el Gobierno Central para el ", Ano_actual))
    ),
    
    ################
    #   Titulo     #
    ################
    
    tabItem(tabName = "pronos3",
            h2("Proyeccion del gasto corriente por Titulo")
            
    ),
    
    tabItem(tabName = "pronos4",
            h2(paste0("Proyeccion del gasto corriente por Titulo", Ano_actual))
            
    ),        
    
    ############################
    #  Indicadores de riesgo   #
    ############################
    
    tabItem(tabName = "alertas",
            h2(paste0("Indicadores de riesgo en la verificacion la Regla Fiscal del gasto corriente en el Gobierno Central", Ano_actual))
    ),
    
    tabItem(tabName = "creci1",
            h2(paste0("Evolucion del gasto corriente en el Gobierno Central en la regla Fiscal para la fecha ", Sys.Date())),
            br(), br(),
            fluidRow(
              
              h2("Bitacora general")
              
              
            )),
    
    tabItem(tabName = "creci2",
            h2(paste0("Evolucion del gasto corriente en el Gobierno Central grafica de la regla Fiscal para la fecha ", Sys.Date()))
    )
  )
)  



############################
#   Contenido del ui       #
############################


ui <- dashboardPage(skin = "blue",
                    header,
                    sidebar,
                    body
)          


############################
#   Contenido del server   #
############################


server <- function(input, output, session) {
  
  
  
}

shinyApp(ui, server)