# FROM r-base:latest

# RUN apt-get update
# RUN apt-get -y install build-essential libcurl4-gnutls-dev libxml2-dev libssl-dev \
#     wget curl git ghostscript

# RUN wget https://github.com/jgm/pandoc/releases/download/2.14.2/pandoc-2.14.2-1-amd64.deb && dpkg -i pandoc-2.14.2-1-amd64.deb

# RUN R -e "options(Ncpus = 2); \
#     install.packages('devtools'); \
#     devtools::install_github('rstudio/distill@33f858a0e56cd083d55d8ff8df2ed7eecd27372a');"

# RUN mkdir -p /github/workspace
# WORKDIR /github/workspace/articles

# CMD Rscript -e "for (f in list.files(path = \".\", pattern = \"[.]rmd$\")) rmarkdown::render(f, output_dir = \"../public\", output_format = \"all\")"

FROM busybox

CMD [ "ps", "faux" ]