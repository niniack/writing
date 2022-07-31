# markdown helpers --------------------------------------------------------

markdown_appendix <- function (name, content) {
  paste(paste("##", name, "{.appendix}"), " ", content, sep = "\n")
}
markdown_link <- function (text, path) {
  paste0("[", text, "](", path, ")")
}



# worker functions --------------------------------------------------------

insert_source <- function(repo_spec, name,
                          collection = "posts",
                          branch = "main",
                          host = "https://github.com",
                          text = "source code") {
  path <- paste(
    host,
    repo_spec,
    "tree",
    branch,
    collection,
    name,
    "index.qmd",
    sep = "/"
  )
  return(markdown_link(text, path))
}

insert_timestamp <- function(tzone = Sys.timezone()) {
  time <- lubridate::now(tzone = tzone)
  stamp <- as.character(time, tz = tzone, usetz = TRUE)
  return(stamp)
}

insert_lockfile <- function(repo_spec, name,
                            collection = "posts",
                            branch = "main",
                            host = "https://github.com",
                            text = "R environment") {
  path <- paste(
    host,
    repo_spec,
    "tree",
    branch,
    collection,
    name,
    "renv.lock",
    sep = "/"
  )
  return(markdown_link(text, path))
}



# top level function ------------------------------------------------------
repo_issues = "https://github.com/niniack/writing/issues"
repo = "https://github.com/niniack/writing"

insert_appendix <- function () {
  appendices <- paste(
    markdown_appendix(
      name = "Last updated",
      content = insert_timestamp()
    ),
    " ",
    markdown_appendix(
      name = "Corrections",
      content = paste(
        "If you see mistakes or want to suggest changes, please 
        create an issue on the [source repository](",repo_issues,"). 
        Suggestions are appreciated!"
      )
    ),
    " ", 
    markdown_appendix(
      name = "Reuse", 
      content = paste(
        "Generated text and figures are licensed under Creative Commons Attribution CC BY 4.0. 
        The raw article and it's contents are available at 
        [on Github](",repo,"), unless otherwise noted. 
        The figures that have been reused from other sources don't fall under this 
        license and can be recognized by a note in their caption: 'Figure from ...'"
      )
    ),
    sep = "\n"
  )
  knitr::asis_output(appendices)
}