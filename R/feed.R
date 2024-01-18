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
  stopifnot(is.character(data), length(data) == 1L)
  stopifnot(
    is.null(date) ||
      is.character(date) || is.numeric(date) && length(date) == 1L
  )
  date <- date %||% "all"
  date <- as.character(date)
  nm <- if (grepl("[0-9]{6}", date)) {
    "field_tdr_date_value_month"
  } else {
    "field_tdr_date_value"
  }
  request("https://home.treasury.gov/resource-center/data-chart-center/interest-rates/pages/xml") |>
    req_user_agent("treasury (https://m-muecke.github.io/treasury)") |>
    req_url_query(data = data, "{nm}" := date) |>
    req_perform() |>
    resp_body_xml()
}
