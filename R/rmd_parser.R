#' @title Processes Markdown file to generate key information.
#'
#' @description Takes information from the Markdown file such as headers and turns it into a list to conver the Markdown file into a Mindmap file.
#'
#' @param fn The name of the Markdown file that is to be processed into a Mindmap file.
#'
#' @return A list with the filename, heading names, and codeblocks of the Markdown file.
#'
#' @examples rmd_parser('src/NetworkPlotOne.rmd')
rmd_parser <- function(fn){
  require(stringr)
  ##### Definition of a new value that is equal to the input filename.
  .RMD_FN. <<- fn
  input <- readLines(fn)
  # Extract pound loc.
  poundloc <- grep('^#+', input)
  # Finds the beginning and end of the codeblocks.
  bcktckloc <- grep('^```', input)
  a<-bcktckloc[seq(1,length(bcktckloc), by=2)]
  b<-bcktckloc[seq(2,length(bcktckloc), by=2)]

  f <- function(x){
    any(x >= a & x <= b)

  }

  tobermv <- sapply(poundloc, f)

  header_linepos <- poundloc[!tobermv]

  headers <- input[header_linepos]

  codeblock <- sapply(header_linepos, function(x) NULL)
  for (x in 1:length(a)){
    if (any(header_linepos<a[x])){
      i <- max(which(header_linepos < a[x]))
      codeblock[[i]] <- input[a[x]:b[x]]
    }

  }
  everything <- list(filename=fn, header=headers, codebloc=codeblock)
  return(everything)
}
