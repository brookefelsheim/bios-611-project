.PHONY: clean
clean:
	rm -rf derived_data/
	rm -rf figures/
	rm -rf logs/
	rm -f report.pdf

.PHONY: all
all: report.pdf\
	derived_data/yearly_emissions.csv\
	derived_data/long_yearly_emissions.csv\
	derived_data/long_sector_emissions.csv\
	derived_data/long_yearly_forest_area.csv\
	derived_data/yearly_hazardous_waste.csv\
	derived_data/long_yearly_hazardous_waste.csv\
	derived_data/long_yearly_municipal_recycled.csv\
	derived_data/natural_disaster_occurrences.csv\
	derived_data/long_natural_disaster_occurrences.csv\
	derived_data/natural_disaster_deaths.csv\
	derived_data/long_natural_disaster_deaths.csv\
	derived_data/long_yearly_energy_per_capita.csv\
	derived_data/long_yearly_renewable_percentage.csv\
	derived_data/long_yearly_precipitation.csv\
	derived_data/long_yearly_gdp.csv\
	derived_data/long_yearly_gni_by_gender.csv\
	derived_data/yearly_happiness.csv\
	derived_data/long_yearly_happiness.csv\
	derived_data/all_predictive_data.csv\
	figures/emissions_pc_plot.png\
	logs/emissions_pc_summary.txt\
	figures/ghg_emissions_trends_top_10_plot.png\
	logs/top_10_countries_emissions.txt

.PHONY: shiny_app
shiny_app: derived_data/long_yearly_emissions.csv\
	derived_data/long_sector_emissions.csv\
	derived_data/long_yearly_forest_area.csv\
	derived_data/long_yearly_hazardous_waste.csv\
	derived_data/long_yearly_municipal_recycled.csv\
	derived_data/long_natural_disaster_occurrences.csv\
	derived_data/long_natural_disaster_deaths.csv\
	derived_data/long_yearly_energy_per_capita.csv\
	derived_data/long_yearly_renewable_percentage.csv\
	derived_data/long_yearly_precipitation.csv\
	derived_data/long_yearly_gdp.csv\
	derived_data/long_yearly_gni_by_gender.csv\
	derived_data/long_yearly_happiness.csv\
	scripts/shiny_app.R
	Rscript scripts/shiny_app.R ${PORT}

report.pdf: report.Rmd\
	figures/emissions_pc_plot.png\
	figures/ghg_emissions_trends_top_10_plot.png\
	build_report.R
	Rscript build_report.R

derived_data/yearly_emissions.csv:\
	source_data/air_and_climate/ch4_emissions.csv\
	source_data/air_and_climate/co2_emissions.csv\
	source_data/air_and_climate/n2o_emissions.csv\
	source_data/air_and_climate/nox_emissions.csv\
	source_data/air_and_climate/so2_emissions.csv\
	source_data/air_and_climate/ghg_emissions.csv\
	scripts/combine_yearly_emissions_data.R
	Rscript scripts/combine_yearly_emissions_data.R

derived_data/long_yearly_emissions.csv:\
	derived_data/yearly_emissions.csv\
	scripts/lengthen_yearly_emissions.R
	Rscript scripts/lengthen_yearly_emissions.R

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

derived_data/long_yearly_hazardous_waste.csv:\
	derived_data/yearly_hazardous_waste.csv\
	scripts/lengthen_yearly_hazardous_waste.R
	Rscript scripts/lengthen_yearly_hazardous_waste.R

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

derived_data/long_natural_disaster_occurrences.csv:\
	derived_data/natural_disaster_occurrences.csv\
	scripts/lengthen_natural_disaster_occurrences.R
	Rscript scripts/lengthen_natural_disaster_occurrences.R

derived_data/natural_disaster_deaths.csv:\
	source_data/natural_disasters/climatological_disasters.csv\
	source_data/natural_disasters/geophysical_disasters.csv\
	source_data/natural_disasters/hydrological_disasters.csv\
	source_data/natural_disasters/meteorological_disasters.csv\
	scripts/combine_natural_disaster_deaths_data.R
	Rscript scripts/combine_natural_disaster_deaths_data.R

derived_data/long_natural_disaster_deaths.csv:\
	derived_data/natural_disaster_deaths.csv\
	scripts/lengthen_natural_disaster_deaths.R
	Rscript scripts/lengthen_natural_disaster_deaths.R

derived_data/long_yearly_energy_per_capita.csv:\
	source_data/energy_and_minerals/energy_supply_per_capita.csv\
	scripts/lengthen_yearly_energy_per_capita.R
	Rscript scripts/lengthen_yearly_energy_per_capita.R

derived_data/long_yearly_renewable_percentage.csv:\
	source_data/energy_and_minerals/renewable_elec_production_percentage.csv\
	scripts/lengthen_yearly_renewable_percentage.R
	Rscript scripts/lengthen_yearly_renewable_percentage.R
	
derived_data/long_yearly_precipitation.csv:\
	source_data/inland_water_resources/precipitation.csv\
	scripts/lengthen_yearly_precipitation.R
	Rscript scripts/lengthen_yearly_precipitation.R

derived_data/long_yearly_gdp.csv:\
	source_data/economy/income_by_country.xlsx\
	scripts/lengthen_yearly_gdp.R
	Rscript scripts/lengthen_yearly_gdp.R

derived_data/long_yearly_gni_by_gender.csv:\
	source_data/economy/income_by_country.xlsx\
	scripts/lengthen_yearly_gni_by_gender.R
	Rscript scripts/lengthen_yearly_gni_by_gender.R

derived_data/yearly_happiness.csv:\
	source_data/happiness/2015.csv\
	source_data/happiness/2016.csv\
	source_data/happiness/2017.csv\
	source_data/happiness/2018.csv\
	source_data/happiness/2019.csv\
	scripts/combine_yearly_happiness_data.R
	Rscript scripts/combine_yearly_happiness_data.R

derived_data/long_yearly_happiness.csv:\
	derived_data/yearly_happiness.csv\
	scripts/lengthen_yearly_happiness.R
	Rscript scripts/lengthen_yearly_happiness.R

derived_data/all_predictive_data.csv:\
	source_data/air_and_climate/ghg_emissions.csv\
	source_data/biodiversity/terrestrial_marine_protected_areas.csv\
	source_data/energy_and_minerals/energy_indicators.csv\
	source_data/forests/forest_area.csv\
	source_data/land_and_agriculture/agricultural_land.csv\
	source_data/economy/income_by_country.xlsx\
	derived_data/yearly_happiness.csv\
	scripts/combine_all_predictive_data.R
	Rscript scripts/combine_all_predictive_data.R

figures/emissions_pc_plot.png logs/emissions_pc_summary.txt:\
	derived_data/yearly_emissions.csv scripts/emissions_PCA.R
	Rscript scripts/emissions_PCA.R

figures/ghg_emissions_trends_top_10_plot.png logs/top_10_countries_emissions.txt:\
	derived_data/yearly_emissions.csv scripts/explore_emissions_trends.R
	Rscript scripts/explore_emissions_trends.R


