# Example shiny app docker file
# https://blog.sellorm.com/2021/04/25/shiny-app-in-docker/

# get shiny serveR and a version of R from the rocker project
FROM rocker/shiny:4.2.1

# system libraries
# Try to only install system libraries you actually need
# Package Manager is a good resource to help discover system deps
RUN apt-get update && apt-get install -y \
    libcurl4-gnutls-dev \
    libssl-dev
  

# install R packages required 
# Change the packages list to suit your needs
RUN R -e 'install.packages(c(\
              "leaflet", \
              "shiny" \
            ), \
            repos="https://packagemanager.rstudio.com/cran/__linux__/focal/2022-09-22"\
          )'


# copy the app directory into the image
COPY ./shiny-app/* /srv/shiny-server/

# run app
CMD ["/usr/bin/shiny-server"]
