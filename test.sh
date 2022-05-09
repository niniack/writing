for filename in markdown/*.rmd; do
    echo $filename
    Rscript -e "rmarkdown::render('$filename')"
done
