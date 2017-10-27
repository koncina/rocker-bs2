FROM rocker/tidyverse

MAINTAINER Eric KONCINA <mail@koncina.eu>

LABEL version="0.1"
LABEL description="Docker image to build the biostat2 website"

ARG DEBIAN_FRONTEND=noninteractive
# To avoid being trapped in the pager during knitting...
# Maybe there is a better way?
RUN sed -i 's/usr\/bin\/pager/bin\/cat/g' /usr/local/lib/R/etc/Renviron
# Using bash for rstudio user
RUN sed -i 's/\/home\/rstudio:/\/home\/rstudio:\/bin\/bash/g' /etc/passwd

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y apt-utils
RUN apt-get install -y ssh curl gnupg gnupg2

# Required for gganimate
RUN apt-get install -y ffmpeg imagemagick

RUN Rscript -e 'devtools::install_github("koncina/unilur")'
RUN Rscript -e 'devtools::install_github("koncina/iosp@dev")'
RUN Rscript -e 'devtools::install_github("koncina/bs2site")'

ENV BS2_DEPLOY=1

