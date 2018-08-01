#' @title Convert R Markdown/Markdown file(s) to Mindmap file(s).
#'
#' @description This function will convert a Markdown file to a Mindmap file, with the location of the headers determined by the number of pound signs before each codeblock, and inserts in the codeblock as notes and any input and output as extra nodes. Any graphs present in the output will also be displayed in an extra node. The function can also accept multiple Markdown files as an input and will combine them all together into one Mindmap file.
#'
#' @param fn The Markdown file that will be processed to a Mindmap file.
#' @param output.fn The name of the generated Mindmap file.
#' @param title The tite of the Mindmap file in the center
#'
#' @return A Mindmap file
#'
#' @examples Print_MM_Map(fn = system.file('example_project','src', 'NetworkPlotOne.Rmd',package = "MarkdownNMindmap"), output.fn = 'Mindmap.mm', title = 'Mind map')
#' @export Print_MM_Map
Print_MM_Map <- function(fn, output.fn = get_martmi_cfg('mm_name'), title = get_martmi_cfg('main_title')){
  require(stringr)
  if (file_test('-d', fn)){
    mult_fn <- dir(fn, pattern="\\.[Rr]md$", f=T)
  }
  else if (file_test('-f', fn)){
    mult_fn <- fn
  }
  else{
    stop(sprintf("The file or the directory %s does not exist!\n", fn))
  }
  mid_code <- lapply(mult_fn,function(x){PrintMap(rmd_info=rmd_parser(x))})
  rv <- c(mm_heading(title=title), unlist(mid_code), mm_ending(),collapse='\n')
  writeLines(rv, output.fn)
  invisible(rv)

}


