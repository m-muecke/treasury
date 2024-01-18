#' Return the daily treasury par yield curve rates
#'
#' @param date `character(1)` or `numeric(1)` date in format yyyy or yyyymm.
#'   If `NULL`, all data is returned. Default `NULL`.
#' @references <https://home.treasury.gov/treasury-daily-interest-rate-xml-feed>
#' @export
tr_yield_curve <- function(date = NULL) {
  treasury("daily_treasury_yield_curve", date)
}

#' Return the daily treasury bill rates
#'
#' @param date `character(1)` or `numeric(1)` date in format yyyy or yyyymm.
#'   If `NULL`, all data is returned. Default `NULL`.
#' @references <https://home.treasury.gov/treasury-daily-interest-rate-xml-feed>
#' @export
tr_bill_rates <- function(date = NULL) {
  treasury("daily_treasury_bill_rates", date)
}

#' Return the daily treasury long-term rates
#'
#' @param date `character(1)` or `numeric(1)` date in format yyyy or yyyymm.
#'   If `NULL`, all data is returned. Default `NULL`.
#' @references <https://home.treasury.gov/treasury-daily-interest-rate-xml-feed>
#' @export
tr_long_term_rate <- function(date = NULL) {
  treasury("daily_treasury_long_term_rate", date)
}

#' Return the daily treasury par real yield curve rates
#'
#' @param date `character(1)` or `numeric(1)` date in format yyyy or yyyymm.
#'   If `NULL`, all data is returned. Default `NULL`.
#' @references <https://home.treasury.gov/treasury-daily-interest-rate-xml-feed>
#' @export
tr_real_yield_curve <- function(date = NULL) {
  treasury("daily_treasury_real_yield_curve", date)
}

#' Return the daily treasury real long-term rates
#'
#' @param date `character(1)` or `numeric(1)` date in format yyyy or yyyymm.
#'   If `NULL`, all data is returned. Default `NULL`.
#' @references <https://home.treasury.gov/treasury-daily-interest-rate-xml-feed>
#' @export
tr_real_long_term <- function(date = NULL) {
  treasury("daily_treasury_real_long_term", date)
}

treasury <- function(data, date = NULL) {
  tr_make_request(data, date) |>
    tr_process_response()
}

tr_make_request <- function(data, date = NULL) {
  stopifnot(is.character(data), length(data) == 1L)
  stopifnot(
    is.null(date) ||
      is.character(date) || is.numeric(date) && length(date) == 1L
  )
  date <- date %||% "all"
  date <- as.character(date)
  if (grepl("[0-9]{6}", date)) {
    nm <- "field_tdr_date_value_month"
  } else {
    nm <- "field_tdr_date_value"
  }
  request("https://home.treasury.gov/resource-center/data-chart-center/interest-rates/pages/xml") |>
    req_user_agent("treasury (https://m-muecke.github.io/treasury)") |>
    req_url_query(data = data, "{nm}" := date) |>
    req_perform()
}

tr_process_response <- function(resp) {
  entries <- resp |>
    resp_body_xml() |>
    xml2::xml_find_all(".//m:properties")

  data <- lapply(entries, \(entry) {
    date <- entry |>
      xml2::xml_find_all(".//d:NEW_DATE") |>
      xml2::xml_text() |>
      as.Date()
    values <- entry |> xml2::xml_find_all("./*[starts-with(name(), 'd:BC_')]")
    data.frame(
      date = date,
      maturity = values |> xml2::xml_name(),
      rate = values |> xml2::xml_double()
    )
  })
  data <- do.call(rbind, data)

  data <- data[data$maturity != "BC_30YEARDISPLAY", ]
  data$maturity <- tolower(gsub("BC_", "", data$maturity))
  data$maturity <- gsub("(\\d+)(\\w+)", "\\1-\\2", data$maturity)
  as_tibble(data)
}
