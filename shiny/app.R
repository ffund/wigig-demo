library(shiny)
library(shinythemes)
library(ggplot2)
library(R.utils)

ui <- fluidPage(
	theme = shinytheme("cerulean"),
	#shinythemes::themeSelector(),
	fluidRow(
		 column(6,
                        h3("Throughput"),
                        plotOutput("pltTput")
			),
                 column(6,
                        h3("RSSI"),
                        plotOutput("pltRSSI")
                        )
		 ),
	fluidRow(
		 column(6,
			h3("TX antenna pattern"),
			plotOutput("pltSector")
			),
		 column(6,
			h3("Ping delay"),
			plotOutput("pltPing")
			)
		 )

)		

# Define server logic to plot various variables against mpg ----
server <- function(input, output) {
	datPing <- reactiveFileReader( 
		intervalMillis = 500,
		session = NULL, 
		filePath = "/tmp/ping.csv", 
		readFunc = read.csv, header=FALSE, fill=TRUE, col.names=c("ts", "rtt") #,nrows=30, skip=countLines("/tmp/ping.csv")-30
	)
        datBf <- reactiveFileReader(
                intervalMillis = 500,
                session = NULL,
                filePath = "/tmp/bf.csv",
                readFunc = read.csv, header=FALSE, fill=TRUE, col.names=c("ts", "sector","sqi","rssi","txmcs","txtput","goodrx","goodtx")# ,nrows=30, skip=countLines("/tmp/bf.csv")-30
        )
	output$pltTput<-renderPlot({
		g <- ggplot(datBf(), aes(x=ts)) + theme_minimal()
		g <- g + geom_line(aes(y=goodtx), linetype="solid", colour="blue") + geom_point(aes(y=goodtx), colour="blue") 
		g <- g + geom_line(aes(y=goodrx), linetype="solid", colour="darkred") + geom_point(aes(y=goodrx), colour="darkred")
                g <- g + geom_line(aes(y=txtput), linetype="dashed", colour="blue") + geom_point(aes(y=txtput), colour="blue")          
		g <- g + scale_y_continuous("Throughput (Mbps)")
		g <- g + scale_x_continuous("Timestamp", 
					    limits=c(as.numeric(Sys.time())-10,
						     as.numeric(Sys.time()))
					    )
		g
	}
	)
        output$pltRSSI<-renderPlot({
                g <- ggplot(datBf(), aes(x=ts, y=rssi))
                g <- g + geom_point(colour="darkgreen") + geom_line(colour="darkgreen") + theme_minimal()
                g <- g + scale_y_continuous("RSSI (dBM)")
                g <- g + scale_x_continuous("Time",
                                            limits=c(as.numeric(Sys.time())-10,
                                                     as.numeric(Sys.time()))
                                            )
                g
        }
        )
        output$pltPing<-renderPlot({
                g <- ggplot(datPing(), aes(x=ts, y=rtt)) 
                g <- g + geom_point(colour="purple") + geom_line(colour="purple") + theme_minimal()
                g <- g + scale_y_continuous("Round trip time (ms)")
                g <- g + scale_x_continuous("Time", 
                                            limits=c(as.numeric(Sys.time())-10,
                                                     as.numeric(Sys.time()))
                                            )
                g
        }
        )
	output$pltSector<-renderImage({
		sector <- as.numeric(tail(datBf()$sector, 1))
		list(src = paste("www/sector-", sector, ".png", sep=""),
		     	filetype = "image/png",
			width="100%",
			alt = paste("sector-", 2, ".png", sep="")
		)
	}, deleteFile = FALSE)
}

shinyApp(ui, server)


