.PHONY: clean
clean:
	rm -rf derived_data/
	rm -rf figures/
	rm -rf logs/

.PHONY: all
all: derived_data/yearly_emissions.csv\
	figures/emissions_pc_plot.png\
	logs/emissions_pc_summary.txt

.PHONY: shiny_app
shiny_app: derived_data/yearly_emissions.csv scripts/shiny_app.R
	Rscript scripts/shiny_app.R ${PORT}

derived_data/yearly_emissions.csv:\
	source_data/Air\ and\ Climate/CH4_emissions.csv\
	source_data/Air\ and\ Climate/CO2_emissions.csv\
	source_data/Air\ and\ Climate/N2O_emissions.csv\
	source_data/Air\ and\ Climate/NOX_emissions.csv\
	source_data/Air\ and\ Climate/SO2_emissions.csv\
	source_data/Air\ and\ Climate/GHG_emissions.csv\
	scripts/combine_yearly_emissions_data.R
	Rscript scripts/combine_yearly_emissions_data.R

figures/emissions_pc_plot.png logs/emissions_pc_summary.txt:\
	derived_data/yearly_emissions.csv scripts/emissions_PCA.R
	Rscript scripts/emissions_PCA.R

figures/ghg_emissions_trends_top_10_plot.png logs/top_10_countries_emissions.txt:\
	derived_data/yearly_emissions.csv scripts/explore_emissions_trends.R
	Rscript scripts/explore_emissions_trends.R

