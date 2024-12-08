#' @keywords internal
#' @import data.table
#' @importFrom httr2 iterate_with_offset
#' @importFrom httr2 req_perform
#' @importFrom httr2 req_perform_iterative
#' @importFrom httr2 req_url_query
#' @importFrom httr2 req_user_agent
#' @importFrom httr2 request
#' @importFrom httr2 resp_body_xml
#' @importFrom httr2 resps_data
#' @importFrom httr2 resps_successes
"_PACKAGE"

utils::globalVariables(c("maturity", "yearmonth", "rate_type", "type"))
