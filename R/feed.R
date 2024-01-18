#' Return the daily treasury par yield curve rates
#'
#' @references <https://home.treasury.gov/treasury-daily-interest-rate-xml-feed>
#' @export
tr_yield_curve <- function(date = NULL) {
  date <- date %||% "all"
  treasury("daily_treasury_yield_curve", field_tdr_date_value = date)
}

#' Return the daily treasury bill rates
#'
#' @references <https://home.treasury.gov/treasury-daily-interest-rate-xml-feed>
#' @export
tr_bill_rates <- function(date = NULL) {
  date <- date %||% "all"
  treasury("daily_treasury_bill_rates", field_tdr_date_value = date)
}

#' Return the daily treasury long-term rates
#'
#' @references <https://home.treasury.gov/treasury-daily-interest-rate-xml-feed>
#' @export
tr_long_term_rate <- function(date = NULL) {
  date <- date %||% "all"
  treasury("daily_treasury_long_term_rate", field_tdr_date_value = date)
}

#' Return the daily treasury par real yield curve rates
#'
#' @references <https://home.treasury.gov/treasury-daily-interest-rate-xml-feed>
#' @export
tr_real_yield_curve <- function(date = NULL) {
  date <- date %||% "all"
  treasury("daily_treasury_real_yield_curve", field_tdr_date_value = date)
}

#' Return the daily treasury real long-term rates
#'
#' @references <https://home.treasury.gov/treasury-daily-interest-rate-xml-feed>
#' @export
tr_real_long_term <- function(date = NULL) {
  date <- date %||% "all"
  treasury("daily_treasury_real_long_term", field_tdr_date_value = date)
}

treasury <- function(data, ...) {
  request("https://home.treasury.gov/resource-center/data-chart-center/interest-rates/pages/xml") |>
    req_user_agent("treasury (https://m-muecke.github.io/treasury)") |>
    req_url_query(data = data, ...) |>
    req_perform() |>
    resp_body_xml()
}
