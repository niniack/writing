FROM r-base:latest

# Install dependencies for linux
RUN apt-get update
RUN apt-get -y install build-essential libcurl4-gnutls-dev libxml2-dev libssl-dev \
    wget curl git ghostscript git


RUN R -e "options(Ncpus = 4); \
    install.packages('quarto'); \
    install.packages('tidyverse'); \
    install.packages('palmerpenguins'); \
    install.packages('DiagrammeR'); \
    install.packages('ruta');"

RUN git clone https://github.com/quarto-dev/quarto-cli
RUN cd quarto-cli && ./configure-linux.sh

# Make shared volume 
RUN mkdir -p /github/workspace
WORKDIR /github/workspace

# Render sequentially
CMD for FILE in ./articles/*.qmd; do \
# https://unix.stackexchange.com/questions/264962/print-lines-of-a-file-between-two-matching-patterns
frontmatter=$(sed -n '/---/,/---/p' $FILE); \
# https://stackoverflow.com/questions/25114517/bash-how-to-preserve-newline-in-sed-command-output
# Rscript -e "quarto::quarto_render('$FILE', output_format = \"all\")"; \
quarto render $FILE --to html; \
newf="$(basename -- $FILE .qmd).html"; \
mv ./articles/$newf ./$newf; \
# https://stackoverflow.com/questions/10587615/unix-command-to-prepend-text-to-a-file/47399735#47399735
printf '%s\n%s\n' "$frontmatter" "$(cat $newf)" > $newf; \
done;