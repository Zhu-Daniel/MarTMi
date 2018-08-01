#' @title Writes the heading of each node in the Mindmap file.
#'
#' @description Writes the beginning and ending of each node of the Mindmap file in XML.
#'
#' @param x The header that the function is currently processing.
#' @param endnode logical. If true, executes the function endnode().
#' @param codeblock The codeblock under the header being processed.
#' @param bg.color The background color of the nodes. Currently set to white.
#' @param fg.color The text color of the nodes. Currently set to black.
#' @param style The node style of the Mindmap. Currently set as bubble.
#'
#' @return The Mindmap code for the set of headers/codeblock the program was on.
startnode <- function(x, endnode=T, codeblock=NULL, bg.color="#ffffff", fg.color="#000000", style='bubble'){
  part1 <- sprintf('<node BACKGROUND_COLOR="%s" COLOR="%s" STYLE="%s" TEXT="', bg.color, fg.color, style)


  rv <- c(part1, mm_escape(x), '">', codenode(codeblock))


  if(endnode) rv <- c(rv, endnode())
  return(rv)
}

#' @title Provide the ending to a node in Mindmap.
#'
#' @description Writes '</node>' based on the input in order to end the nodes created in the Mindmap file.
#'
#' @param n The number of times '</node>' will be written.
#'
#' @return '</node>' printed n times.
endnode <- function(n=1) {
  rv <- paste0(rep('</node>', n), collapse = '')
  return(rv)
}
#' @title Prints code as notes under nodes.
#'
#' @description Prints XML elements in order to display the codeblock in Mindmap as a note of the title node/header they are written under in Markdown.
#'
#' @param x The current block of code that the function is processing.
#'
#' @return Properly formatted XML of the codeblock.
codenode <- function(x){
  if(is.null(x)) return("")

  require('htmltools')
  pre_code <- '<richcontent TYPE="NOTE"><html>
  <head>
  </head>
  <body>
  <pre>'
  post_code <-'</pre>
  </body>
  </html>
  </richcontent>'

  any_in <- in_nodes(x)
  any_out <- out_nodes(x)
  rv <- c(pre_code, htmlEscape(x), post_code, any_in, any_out)

  return(rv)
}
