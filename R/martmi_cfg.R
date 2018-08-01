#' @title Obtains the desired regex from configure.yml.
#'
#' @description The function finds the desired regex from configure.yml based on the list attribute being called. If there is no regex command inputted for the component name of the list, it will call set_martmi_cfg to reset all of the configurations. If the component name does not exist in the first place, an error would be displayed.
#'
#' @param cur_config The function for which the configuration is wanted.
#'
#' @return The desired regex command for the particular function.
get_martmi_cfg <- function(cur_config){
  require(yaml)
  grep_edit <- yaml.load_file(system.file('example_project', 'configure.yml', package = 'MarkdownNMindmap'))
  if (is.null(grep_edit[[cur_config]])){
    stop(sprintf('The configure for %s does not exist!', cur_config))
  }
  options(MarTMi_CFG = grep_edit[[cur_config]])

  Confignow <- getOption('MarTMi_CFG')
  if (is.null(Confignow)){
    set_martmi_cfg()
    grep_edit <- yaml.load_file(system.file('example_project', 'configure.yml', package = 'MarkdownNMindmap'))
    options(MarTMi_CFG = grep_edit[[cur_config]])
    rv <- getOption('MarTMi_CFG')
    return(rv)
  }
  else {
    grep_edit <- yaml.load_file(system.file('example_project', 'configure.yml', package = 'MarkdownNMindmap'))
    options(MarTMi_CFG = grep_edit[[cur_config]])
    rv <- getOption('MarTMi_CFG')
    return(rv)
  }
}

#' @title Resets the regex commands to original package form.
#'
#' @description Upon being called upon, this command would reimplement the original regex commands that were writtenin configure.yml. This function is executed if any of the sections are left blank in configure.yml.
set_martmi_cfg <- function(){
  require(yaml)
  rv <- list(rmd2mm=list(in_node="(<-|=) *(.+::)?(read(\\.*|_).{3,}?|scan *)\\(", out_node="(graphs/.+\\..{3,}|*(.+::)?(write(\\.*|_).{3,}?)\\(|^ *(ProjectTemplate::)?cache *\\()",img_node="[\"'](graphs/.+\\..{3,})[\"']", main_title="Mind Map", mm_name = "Mindmap.mm"), mm2rmd=list(rmd_name="src/mm_output.Rmd" ))
  writeLines(as.yaml(rv), con = 'configure.yml')
}

