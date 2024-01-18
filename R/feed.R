#' Return the daily treasury par yield curve rates
#'
#' @param date `character(1)` or `numeric(1)` date in format yyyy or yyyymm.
#'   If `NULL`, all data is returned. Default `NULL`.
#' @references <https://home.treasury.gov/treasury-daily-interest-rate-xml-feed>
#' @export
tr_yield_curve <- function(date = NULL) {
  entries <- treasury("daily_treasury_yield_curve", date) |>
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
  data$maturity <- gsub("BC_", "", data$maturity) |> tolower()
  data <- data[data$maturity != "BC_30YEARDISPLAY", ]
  data$maturity <- gsub("(\\d+)(\\w+)", "\\1 \\2", data$maturity)
  as_tibble(data)
}

#' Return the daily treasury bill rates
#'
#' @param date `character(1)` or `numeric(1)` date in format yyyy or yyyymm.
#'   If `NULL`, all data is returned. Default `NULL`.
#' @references <https://home.treasury.gov/treasury-daily-interest-rate-xml-feed>
#' @export
tr_bill_rates <- function(date = NULL) {
  entries <- treasury("daily_treasury_bill_rates", date) |>
    xml2::xml_find_all(".//m:properties")
  data <- lapply(entries, \(entry) {
    date <- entry |>
      xml2::xml_find_all(".//d:INDEX_DATE") |>
      xml2::xml_text() |>
      as.Date()
    values <- entry |>
      xml2::xml_find_all("./*[starts-with(name(), 'd:ROUND_B1_')]")
    data.frame(
      date = date,
      type = values |> xml2::xml_name(),
      value = values |> xml2::xml_double()
    )
  })
  data <- do.call(rbind, data)
  data$type <- tolower(gsub("ROUND_B1_", "", data$type))
  data$type <- gsub("_2$", "", data$type)
  maturity <- strsplit(data$type, "_")
  data$type <- vapply(maturity, "[[", NA_character_, 1L)
  data$maturity <- vapply(maturity, "[[", NA_character_, 2L)
  data$maturity <- gsub("wk", " weeks", data$maturity)
  data <- data[c("date", "type", "maturity", "value")]
  as_tibble(data)
}

#' Return the daily treasury long-term rates
#'
#' @param date `character(1)` or `numeric(1)` date in format yyyy or yyyymm.
#'   If `NULL`, all data is returned. Default `NULL`.
#' @references <https://home.treasury.gov/treasury-daily-interest-rate-xml-feed>
#' @export
tr_long_term_rate <- function(date = NULL) {
  entries <- treasury("daily_treasury_long_term_rate", date) |>
    xml2::xml_find_all(".//m:properties")
  data <- lapply(entries, \(entry) {
    date <- entry |>
      xml2::xml_find_all(".//d:QUOTE_DATE") |>
      xml2::xml_text() |>
      as.Date()
    rate_type <- entry |>
      xml2::xml_find_all(".//d:RATE_TYPE") |>
      xml2::xml_text()
    rate <- entry |>
      xml2::xml_find_all(".//d:RATE") |>
      xml2::xml_double()
    data.frame(date = date, rate_type = rate_type, rate = rate)
  })
  data <- do.call(rbind, data)
  data$rate_type <- tolower(data$rate_type)
  data$rate_type <- gsub("^bc_", "", data$rate_type)
  data$rate_type <- gsub("_", " ", data$rate_type)
  data$rate_type <- gsub("(\\d+)(year?)", "\\1 \\2", data$rate_type)
  as_tibble(data)
}

#' Return the daily treasury par real yield curve rates
#'
#' @param date `character(1)` or `numeric(1)` date in format yyyy or yyyymm.
#'   If `NULL`, all data is returned. Default `NULL`.
#' @references <https://home.treasury.gov/treasury-daily-interest-rate-xml-feed>
#' @export
tr_real_yield_curve <- function(date = NULL) {
  entries <- treasury("daily_treasury_real_yield_curve", date) |>
    xml2::xml_find_all(".//m:properties")
  data <- lapply(entries, \(entry) {
    date <- entry |>
      xml2::xml_find_all(".//d:NEW_DATE") |>
      xml2::xml_text() |>
      as.Date()
    values <- entry |> xml2::xml_find_all("./*[starts-with(name(), 'd:TC_')]")
    data.frame(
      date = date,
      maturity = values |> xml2::xml_name(),
      rate = values |> xml2::xml_double()
    )
  })
  data <- do.call(rbind, data)
  data$maturity <- gsub("TC_", "", data$maturity) |> tolower()
  data$maturity <- gsub("(\\d+)(\\w+)", "\\1 \\2", data$maturity)
  as_tibble(data)
}

#' Return the daily treasury real long-term rates
#'
#' @param date `character(1)` or `numeric(1)` date in format yyyy or yyyymm.
#'   If `NULL`, all data is returned. Default `NULL`.
#' @references <https://home.treasury.gov/treasury-daily-interest-rate-xml-feed>
#' @export
tr_real_long_term <- function(date = NULL) {
  entries <- treasury("daily_treasury_real_long_term", date) |>
    xml2::xml_find_all(".//m:properties")
  data <- lapply(entries, \(entry) {
    date <- entry |>
      xml2::xml_find_all(".//d:QUOTE_DATE") |>
      xml2::xml_text() |>
      as.Date()
    rate <- entry |>
      xml2::xml_find_all(".//d:RATE") |>
      xml2::xml_double()
    data.frame(date = date, rate = rate)
  })
  data <- do.call(rbind, data)
  as_tibble(data)
}

treasury <- function(data, date = NULL) {
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
    req_perform() |>
    resp_body_xml()
}
