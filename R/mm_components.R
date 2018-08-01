#' @title Closes off the remaining nodes in the Mindmap.
#'
#' @description Writes '</node>' and '</map>' to properly close off the XML file that define the Mindmap.
#'
#' @return The Mindmap file with the ending added on.
mm_ending <- function(){
  mindmap <- c(endnode(1), '</map>')
  return(mindmap)
}

#' @title Writes the beginning of the Mindmap file
#'
#' @description Prints the map element and the desired title.
#'
#' @param title The desired title of the Mindmap. Can be changed in configure.yml.
#'
#' @return The beginning of the Mindmap file.
mm_heading <- function(title = get_martmi_cfg('main_title')){
  mindmap <- '<map version ="1.0.1">'
  mindmap <- c(mindmap, startnode(title, endnode=F))
  return(mindmap)
}
