.PHONY: clean
clean:
	rm -rf derived_data/
	rm -rf figures/
	rm -rf logs/
	rm -f report.pdf

.PHONY: all
all: report.pdf\
	derived_data/yearly_emissions.csv\
	derived_data/long_sector_emissions.csv\
	derived_data/long_yearly_forest_area.csv\
	derived_data/yearly_hazardous_waste.csv\
	derived_data/long_yearly_municipal_recycled.csv\
	derived_data/natural_disaster_occurrences.csv\
	derived_data/natural_disaster_deaths.csv\
	figures/emissions_pc_plot.png\
	logs/emissions_pc_summary.txt\
	figures/ghg_emissions_trends_top_10_plot.png\
	logs/top_10_countries_emissions.txt

.PHONY: shiny_app
shiny_app: derived_data/yearly_emissions.csv\
	derived_data/long_sector_emissions.csv\
	derived_data/long_yearly_forest_area.csv\
	derived_data/yearly_hazardous_waste.csv\
	derived_data/long_yearly_municipal_recycled.csv\
	derived_data/natural_disaster_occurrences.csv\
	derived_data/natural_disaster_deaths.csv\
	scripts/shiny_app.R
	Rscript scripts/shiny_app.R ${PORT}

report.pdf: report.Rmd\
	figures/emissions_pc_plot.png\
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

derived_data/long_sector_emissions.csv:\
	source_data/air_and_climate/ghg_emissions_by_sector.csv\
	scripts/lengthen_sector_emissions.R
	Rscript scripts/lengthen_sector_emissions.R

derived_data/long_yearly_forest_area.csv:\
	source_data/forests/forest_area.csv\
	scripts/lengthen_yearly_forest_area.R
	Rscript scripts/lengthen_yearly_forest_area.R

derived_data/yearly_hazardous_waste.csv:\
	source_data/waste/hazardous_waste_generated.csv\
	source_data/waste/hazardous_waste_incinerated.csv\
	source_data/waste/hazardous_waste_landfilled.csv\
	source_data/waste/hazardous_waste_recycled.csv\
	source_data/waste/hazardous_waste_treated_or_disposed.csv\
	scripts/combine_yearly_hazardous_waste_data.R
	Rscript scripts/combine_yearly_hazardous_waste_data.R

derived_data/long_yearly_municipal_recycled.csv:\
	source_data/waste/percentage_of_municipal_waste_collected_which_is_recycled.csv\
	scripts/lengthen_yearly_municipal_recycled.R
	Rscript scripts/lengthen_yearly_municipal_recycled.R

derived_data/natural_disaster_occurrences.csv:\
	source_data/natural_disasters/climatological_disasters.csv\
	source_data/natural_disasters/geophysical_disasters.csv\
	source_data/natural_disasters/hydrological_disasters.csv\
	source_data/natural_disasters/meteorological_disasters.csv\
	scripts/combine_natural_disaster_occurrences_data.R
	Rscript scripts/combine_natural_disaster_occurrences_data.R

derived_data/natural_disaster_deaths.csv:\
	source_data/natural_disasters/climatological_disasters.csv\
	source_data/natural_disasters/geophysical_disasters.csv\
	source_data/natural_disasters/hydrological_disasters.csv\
	source_data/natural_disasters/meteorological_disasters.csv\
	scripts/combine_natural_disaster_deaths_data.R
	Rscript scripts/combine_natural_disaster_deaths_data.R

figures/emissions_pc_plot.png logs/emissions_pc_summary.txt:\
	derived_data/yearly_emissions.csv scripts/emissions_PCA.R
	Rscript scripts/emissions_PCA.R

figures/ghg_emissions_trends_top_10_plot.png logs/top_10_countries_emissions.txt:\
	derived_data/yearly_emissions.csv scripts/explore_emissions_trends.R
	Rscript scripts/explore_emissions_trends.R

