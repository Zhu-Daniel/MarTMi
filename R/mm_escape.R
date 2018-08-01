#' @title Escapes the codeblock.
#'
#' @description Escapes the special characters '\"' and "'" within the codeblock so that the characters appear in the Mindmap notes section.
#'
#' @param str The portion of code that is being processed by the function.
#'
#' @return Escaped version of the codeblock.
mm_escape <- function(str){
  rv <- htmltools::htmlEscape(str)
  rv <- gsub('\"', '&quot;', rv)
  rv <- gsub("'", '&apos;', rv)
  return(rv)
}
