#' dataflows
#'
#' @return
#' @export
#' @description Returns the dataflows for UNICEF database
#' @examples \code{dataflows()}
dataflows <- function(){
  url <- "https://sdmx.data.unicef.org/ws/public/sdmxapi/rest/dataflow/all/all/latest/?format=sdmx-2.1&detail=full&references=none"

  page <- xml2::read_xml(url)

  data_flow_id <- xml2::xml_attr(xml2::xml_find_all(page, "//str:Structure/Ref"),"id")

  data_flow_agencyID <- xml2::xml_attr(xml2::xml_find_all(page, "//str:Dataflow"),"agencyID")

  data_flow_name <- xml2::xml_text(xml2::xml_find_all(page, "//str:Dataflow/com:Name"))

  dataflow <- xml2::xml_attr(xml2::xml_find_all(page, "//str:Dataflow"),"id")

  data.frame(data_flow_name, dataflow, data_flow_id, data_flow_agencyID)
}


#' get_data
#'
#' @param dataflow
#' @param filter
#' @param start
#' @param end
#' @details When writing \code{filter}, write in a list form that includes vectors for each objects: \code{list(c("DZA"),c("2"),c(NA),c(NA),c(NA))}
#' @return
#' @export
#' @description Returns the dataset for the selected dataflow and filtered information
#' @examples \code{get_data("CAP 2030", filter = list(c("DZA"),c("2"),c(NA),c(NA),c(NA)), start = 2020, end = 2020)}
get_data <- function(dataflow, filter = NULL, start = NULL, end = NULL){
  data <- dataflows()

  agencyID <- data[data[,2]==dataflow,4]

  if(length(filter)==0){
    vec_1 <- "all"
  }else{
    if(is.na(filter[[1]])){
      vec_1 = ""
    }else{
      vec_1 <- filter[[1]]
    }
    for (i in 2:length(filter)) {
      if(is.na(filter[[i]])){
        vec_1 = paste0(vec_1,".")
      }else{
        vec_1 = paste0(vec_1, ".", filter[[i]])
      }
    }
  }

  if(is.null(start) && is.null(end)){
    url <- gsub(" ","",paste0("https://sdmx.data.unicef.org/ws/public/sdmxapi/rest/data/",agencyID,",",dataflow,",1.0/",vec_1,"?format=sdmx-compact-2.1"))
  }else{
    url <- gsub(" ","",paste0("https://sdmx.data.unicef.org/ws/public/sdmxapi/rest/data/",agencyID,",",dataflow,",1.0/",vec_1,"?startPeriod=",start,"&endPeriod=",end))
  }

  page <- xml2::read_xml(url)

  main <- xml2::xml_children(xml2::xml_find_all(page, "//message:DataSet"))

  list_1 <- list()

  for(i in 1:length(main)){
    d_child <- xml2::xml_children(main[i])
    attr <- d_child |>
      purrr::map(~names(xml2::xml_attrs(.))) |>
      unlist() |>
      unique()
    data <- data.frame(matrix(ncol = length(attr), nrow = length(d_child)))

    for(a in 1:length(attr)){
      data[,a] <- xml2::xml_attr(d_child, attr[a])
    }
    names(data) <- attr
    list_1[[i]] <- data
  }
  list_1
}











