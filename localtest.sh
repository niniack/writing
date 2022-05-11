for FILE in ./articles/*; do \
# https://unix.stackexchange.com/questions/264962/print-lines-of-a-file-between-two-matching-patterns
frontmatter=$(sed -n '/---/,/---/p' $FILE); \
# https://stackoverflow.com/questions/25114517/bash-how-to-preserve-newline-in-sed-command-output
# echo "$frontmatter"; \
Rscript -e "rmarkdown::render('$FILE', output_dir = \"./\", output_format = \"all\")"; \
newf="$(basename -- $FILE .rmd).html"; \
# https://stackoverflow.com/questions/10587615/unix-command-to-prepend-text-to-a-file/47399735#47399735
printf '%s\n%s\n' "$frontmatter" "$(cat $newf)" > $newf; \
done;