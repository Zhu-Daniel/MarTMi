library(XML)
# fn <- 'Test2.mm'
# xmlText <- paste(readLines(fn), " ", collapse="")
# xmlChildren(xmlText)
# fileName <- 'Test2.mm'

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





PrintNode <- function(node, depth=0){
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
  clines <- sapply(child_nodes, PrintNode, depth=depth+1)
  rv <- c(hline, nline, clines)
  return(rv)
}
# curr <- n1.all[[1]]
# header <- xmlAttrs(curr)["TEXT"]
# notes <- xmlChildren(curr)$richcontent
# note_nodes <- xpathApply(curr, '/node/richcontent[@TYPE="NOTEdff"]')
# notes <- sapply(note_nodes, xmlValue)
# PrintNotes <- function(notes){
#   
# }


#################################################
# Input: 
# Out: 
#################################################
PrintRMDFile <- function(mm_fn, out_rmd_fn=get_martmi_cfg('rmd_name')){
  out <- PrintNode(FindFN(mm_fn))
  

  fn <- trimws(out[[1]][[1]])
  
  rmd_out <- c(
    '---
title: "R Notebook"
output: html_notebook
---', 
    unlist(out[-1], r=T)
  )
  # if (is.null(new_title)){
  #   orig_name <- out$TEXT
  #   orig_base <- sub("\\.[Rr]md$", "", orig_name)
  #   # tools::file_path_sans_ext(orig_name)
  #   rv <- list(code = rmd_out, name = orig_base)
  # } else {
  #   rv <- list(code = rmd_out, name = new_title)
  # }
  
  writeLines(con = out_rmd_fn, rmd_out)
  
}

