FROM rocker/verse
MAINTAINER Brooke Felsheim <brookefelsheim@gmail.com>
RUN R -e "install.packages('tidyverse')"
RUN R -e "install.packages('shiny')"
RUN R -e "install.packages('rmarkdown')"
RUN R -e "install.packages('markdown')"
RUN R -e "install.packages('tinytex')"
