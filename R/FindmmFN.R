#' @title Finds Mindmap filename.
#'
#' @description Searches for the file name of the Mindmap file that the user desires to convert to a Markdown file.
#'
#' @param fileName The filename of the Mindmap file.
#'
#' @return
FindFN <- function(fileName){
  require(XML)
  doc <- xmlTreeParse(fileName)

  rootnode <- xmlRoot(doc)

  # xmlAttrs(xmlChildren(xmlChildren(rootnode)[[1]])[[1]])

  # n1 <- xpathApply(rootnode, "/map/node[1]")
  # xmlAttrs(n1[[1]])

  RMDnode <- xpathApply(rootnode, "/map/node[1]/node[1]")

  #   n1.all <- xpathApply(rootnode, "/map/node[1]/node[1]/node[3]")
  #   xmlValue(n1.all[[1]])
  rv <- RMDnode[[1]]
  return(rv)

}
