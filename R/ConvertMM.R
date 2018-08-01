#' @title Converts the XML code of the Mindmap file to R code.
#'
#' @description Takes the XML code of the Mindmap and converts it into code that can be read by R Markdown - Each node is displayed as a header while the notes are displayed as codeblocks.
#'
#' @param node The XML code of the Mindmap file.
#' @param depth A method of keeping track of the location within the Mindmap file.
#'
#' @return The Mindmap file written in R.
ConvertMM <- function(node, depth=0){
  require(XML)
  hline <- ""
  header <- xmlAttrs(node)["TEXT"]
  if(!is.na(header)){
    # hline <- paste0(strrep('#', depth), header)
    hline <- trimws(header)
  }

  note_nodes <- xpathApply(node, '/node/richcontent[@TYPE="NOTE"]')
  nline <- ""
  if(length(note_nodes) > 0){
    nline <- sapply(note_nodes, xmlValue)
  }
  #myxml %>% xpathSApply('//book[@name[starts-with(., "hu")]]')
  child_nodes <- xpathApply(node, '/node/node[@TEXT[starts-with(., " #")]]')
  clines <- sapply(child_nodes, ConvertMM, depth=depth+1)
  rv <- c(hline, nline, clines)
  return(rv)
}
