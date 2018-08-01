#' @title Generates the extra nodes for input files
#'
#' @description The function checks each line of the Markdown file for any input that corresponds with the regex expression associated with it in configure.yml and displays it in a seperate node in Mindmap.
#'
#' @param x The codeblock that is being processed at the moment from the Markdown file
#' @param bg.color The background color of the additional input node. Currently set to light blue.
#' @param fg.color The text color of the additional input node. Currently set to black.
#' @param pattern The regex pattern that would be used to obtain the input.
#'
#' @return An additional node in the Mindmap file after the header under which the input is associated where the line of code introducing the input is displayed. If there are no input that fall under the regex pattern, the functions returns nothing.
in_nodes <- function(x, bg.color="#00cccc", fg.color="#000000", pattern = get_martmi_cfg('in_node')){

  inhigh <- grep(pattern, x, v=T)
  if (length(inhigh)>0){
    rv <- unlist(lapply(inhigh, function(x){
      startnode(paste0('IN: ',x), bg.color=bg.color, fg.color=fg.color)
    }))
    return(rv)
  }
  else {
    return('')
  }
}

#' @title Displays any output of the Markdown file.
#'
#' @description The function is used on each line of the Markdown file to locate any output by using the regex pattern provided in configure.yml and to display it in an additional node in Mindmap.
#'
#' @param x The codeblock that is being processed at the moment in the Markdown file.
#' @param bg.color The background color of the additional output node. Currently set to light green
#' @param fg.color The text color of the additional output node. Currently set to blue.
#' @param pattern The regex pattern that would be used in obtaining the output.
#'
#' @return An additional node in the Mindmap file after the header under which the output is associated where the line of code introducing the output is displayed. If there are no output that fall under the regex pattern, the functions returns nothing.
out_nodes <- function(x, bg.color="#99ff99", fg.color='#0000ff', pattern =get_martmi_cfg('out_node')){

  outhigh <- grep(pattern, x, v=T)


  if (length(outhigh)>0){
    rv <- unlist(lapply(outhigh, function(x){
      c( startnode(paste0('OUT: ',x), bg.color=bg.color, fg.color=fg.color, endnode = F),
         #runs img_node here, since it is an output of the .rmd file
         img_node(x),
         endnode()
      )
    }))
    return(rv)
  }
  else {
    return('')
  }
}

