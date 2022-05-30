FROM r-base:latest

RUN apt-get update
RUN apt-get -y install build-essential libcurl4-gnutls-dev libxml2-dev libssl-dev \
    wget curl git ghostscript

RUN wget https://github.com/jgm/pandoc/releases/download/2.14.2/pandoc-2.14.2-1-amd64.deb && dpkg -i pandoc-2.14.2-1-amd64.deb

# Devtools installation
RUN R -e "options(Ncpus = 2); \
          install.packages('devtools');"

# Distill tools
RUN R -e "devtools::install_github('rstudio/distill@33f858a0e56cd083d55d8ff8df2ed7eecd27372a');"

# For graphing/diagrams
RUN R -e "devtools::install_github('rich-iannone/DiagrammeR');"

# For autoencoders
RUN R -e "devtools::install_github('fdavidcl/ruta');"
    
RUN mkdir -p /github/workspace
WORKDIR /github/workspace

# CMD Rscript -e "for (f in list.files(path = \".\", pattern = \"[.]rmd$\")) rmarkdown::render(f, output_dir = \"../\", output_format = \"all\")"

CMD for FILE in ./articles/*.rmd; do \
# https://unix.stackexchange.com/questions/264962/print-lines-of-a-file-between-two-matching-patterns
frontmatter=$(sed -n '/---/,/---/p' $FILE); \
# https://stackoverflow.com/questions/25114517/bash-how-to-preserve-newline-in-sed-command-output
# echo "$frontmatter"; \
Rscript -e "rmarkdown::render('$FILE', output_dir = \"./\", output_format = \"all\")"; \
newf="$(basename -- $FILE .rmd).html"; \
# https://stackoverflow.com/questions/10587615/unix-command-to-prepend-text-to-a-file/47399735#47399735
printf '%s\n%s\n' "$frontmatter" "$(cat $newf)" > $newf; \
done;