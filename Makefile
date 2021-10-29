.PHONY: clean
clean:
	rm -rf derived_data/
	rm -rf figures/
	rm -rf logs/

.PHONY: all
all: derived_data/long_CO2_emissions.csv

.PHONY: shiny_app
shiny_app: derived_data/yearly_emissions.csv shiny_app.R
	Rscript shiny_app.R ${PORT}

derived_data/yearly_emissions.csv: source_data/Air\ and\ Climate/CH4_emissions.csv\
	source_data/Air\ and\ Climate/CO2_emissions.csv\
	source_data/Air\ and\ Climate/N2O_emissions.csv\
	source_data/Air\ and\ Climate/NOX_emissions.csv\
	source_data/Air\ and\ Climate/SO2_emissions.csv\
	source_data/Air\ and\ Climate/GHG_emissions.csv\
	combine_yearly_emissions_data.R
	Rscript combine_yearly_emissions_data.R

