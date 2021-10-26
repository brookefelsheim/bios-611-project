.PHONY: shiny_app
shiny_app: shiny_app.R
	Rscript shiny_app.R ${PORT}