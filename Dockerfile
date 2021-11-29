FROM rocker/verse
MAINTAINER Brooke Felsheim <brookefelsheim@gmail.com>
RUN R -e "install.packages('tidyverse')"
RUN R -e "install.packages('shiny')"
RUN R -e "install.packages('rmarkdown')"
RUN R -e "install.packages('markdown')"
RUN R -e "install.packages('tinytex'); tinytex::install_tinytex(dir='/opt/tinytex')"
RUN R -e "install.packages('readxl')"
RUN R -e "install.packages('GGally')"
RUN R -e "install.packages('ggpubr')"
RUN R -e "install.packages('gridGraphics')"
RUN R -e "install.packages('glmnet')"
RUN R -e "install.packages('caret')"
RUN R -e "install.packages('ROCR')"