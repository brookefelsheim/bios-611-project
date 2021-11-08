.PHONY: clean
clean:
	rm -rf derived_data/
	rm -rf figures/
	rm -rf logs/
	rm -f report.pdf

.PHONY: all
all: report.pdf\
	derived_data/yearly_emissions.csv\
	figures/emissions_pc_plot.png\
	logs/emissions_pc_summary.txt\
	figures/ghg_emissions_trends_top_10_plot.png\
	logs/top_10_countries_emissions.txt

.PHONY: shiny_app
shiny_app: derived_data/yearly_emissions.csv scripts/shiny_app.R
	Rscript scripts/shiny_app.R ${PORT}

report.pdf: report.Rmd figures/emissions_pc_plot.png\
	figures/ghg_emissions_trends_top_10_plot.png
	Rscript -e "if (!tinytex::is_tinytex()) {tinytex::install_tinytex()}"
	Rscript -e "rmarkdown::render('report.Rmd',output_format='pdf_document')"

derived_data/yearly_emissions.csv:\
	source_data/air_and_climate/ch4_emissions.csv\
	source_data/air_and_climate/co2_emissions.csv\
	source_data/air_and_climate/n2o_emissions.csv\
	source_data/air_and_climate/nox_emissions.csv\
	source_data/air_and_climate/so2_emissions.csv\
	source_data/air_and_climate/ghg_emissions.csv\
	scripts/combine_yearly_emissions_data.R
	Rscript scripts/combine_yearly_emissions_data.R

figures/emissions_pc_plot.png logs/emissions_pc_summary.txt:\
	derived_data/yearly_emissions.csv scripts/emissions_PCA.R
	Rscript scripts/emissions_PCA.R

figures/ghg_emissions_trends_top_10_plot.png logs/top_10_countries_emissions.txt:\
	derived_data/yearly_emissions.csv scripts/explore_emissions_trends.R
	Rscript scripts/explore_emissions_trends.R

