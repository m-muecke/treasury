#' Return the daily treasury par yield curve rates
#'
#' @param date `character(1)` or `numeric(1)` date in format yyyy or yyyymm.
#'   If `NULL`, all data is returned. Default `NULL`.
#' @returns A `data.frame()` with columns `date`, `maturity` and `rate` or
#'   `NULL` when no entries were found.
#' @references <https://home.treasury.gov/treasury-daily-interest-rate-xml-feed>
#' @family treasury data
#' @export
#' @examples
#' \donttest{
#' # get data for a single month
#' tr_yield_curve("202201")
#' # or for the entire year
#' tr_yield_curve(2022)
#' }
tr_yield_curve <- function(date = NULL) {
  data <- treasury("daily_treasury_yield_curve", date, parse_yield_curve)
  if (is.null(data)) {
    return()
  }
  data <- clean_yield_curve(data)
  as_tibble(data)
}

parse_yield_curve <- function(x) {
  date <- x |>
    xml2::xml_find_all(".//d:NEW_DATE") |>
    xml2::xml_text() |>
    as.Date()
  values <- xml2::xml_find_all(x, "./*[starts-with(name(), 'd:BC_')]")
  data.frame(
    date = date,
    maturity = xml2::xml_name(values),
    rate = xml2::xml_double(values)
  )
}

clean_yield_curve <- function(data) {
  data <- data[data$maturity != "BC_30YEARDISPLAY", ]
  data$maturity <- tolower(data$maturity)
  data$maturity <- gsub("bc_", "", data$maturity, fixed = TRUE)
  data$maturity <- gsub("(\\d+)(\\w+)", "\\1 \\2", data$maturity)
  data
}

#' Return the daily treasury bill rates
#'
#' @inheritParams tr_yield_curve
#' @inherit tr_yield_curve references
#' @returns A `data.frame()` with columns `date`, `type`, `maturity` and `value`
#'   or `NULL` when no entries were found.
#' @family treasury data
#' @export
#' @examples
#' \donttest{
#' # get data for a single month
#' tr_bill_rates("202201")
#' # or for the entire year
#' tr_bill_rates(2022)
#' }
tr_bill_rates <- function(date = NULL) {
  data <- treasury("daily_treasury_bill_rates", date, parse_bill_rates)
  if (is.null(data)) {
    return()
  }
  data <- clean_bill_rates(data)
  as_tibble(data)
}

parse_bill_rates <- function(x) {
  date <- x |>
    xml2::xml_find_all(".//d:INDEX_DATE") |>
    xml2::xml_text() |>
    as.Date()
  values <- xml2::xml_find_all(x, "./*[starts-with(name(), 'd:ROUND_B1_')]")
  data.frame(
    date = date,
    type = xml2::xml_name(values),
    value = xml2::xml_double(values)
  )
}

clean_bill_rates <- function(data) {
  data$type <- tolower(data$type)
  data$type <- gsub("round_b1_", "", data$type, fixed = TRUE)
  data$type <- gsub("_2$", "", data$type)
  maturity <- strsplit(data$type, "_", fixed = TRUE)
  data$type <- vapply(maturity, "[[", NA_character_, 1L)
  data$maturity <- vapply(maturity, "[[", NA_character_, 2L)
  data$maturity <- gsub("wk", " weeks", data$maturity, fixed = TRUE)
  data[c("date", "type", "maturity", "value")]
}

#' Return the daily treasury long-term rates
#'
#' @inheritParams tr_yield_curve
#' @inherit tr_yield_curve references
#' @returns A `data.frame()` with columns `date`, `rate_type` and `rate` or
#'   `NULL` when no entries were found.
#' @family treasury data
#' @export
#' @examples
#' \donttest{
#' # get data for a single month
#' tr_long_term_rate("202201")
#' # or for the entire year
#' tr_long_term_rate(2022)
#' }
tr_long_term_rate <- function(date = NULL) {
  data <- treasury("daily_treasury_long_term_rate", date, parse_long_term_rate)
  if (is.null(data)) {
    return()
  }
  data <- clean_long_term_rate(data)
  as_tibble(data)
}

parse_long_term_rate <- function(x) {
  date <- x |>
    xml2::xml_find_all(".//d:QUOTE_DATE") |>
    xml2::xml_text() |>
    as.Date()
  rate_type <- x |>
    xml2::xml_find_all(".//d:RATE_TYPE") |>
    xml2::xml_text()
  rate <- x |>
    xml2::xml_find_all(".//d:RATE") |>
    xml2::xml_double()
  data.frame(date = date, rate_type = rate_type, rate = rate)
}

clean_long_term_rate <- function(data) {
  data$rate_type <- tolower(data$rate_type)
  data$rate_type <- gsub("^bc_", "", data$rate_type)
  data$rate_type <- gsub("_", " ", data$rate_type, fixed = TRUE)
  data$rate_type <- gsub("(\\d+)(year?)", "\\1 \\2", data$rate_type)
  data
}

#' Return the daily treasury par real yield curve rates
#'
#' @inheritParams tr_yield_curve
#' @inherit tr_yield_curve references
#' @returns A `data.frame()` with columns `date`, `maturity` and `rate` or
#'   `NULL` when no entries where found.
#' @family treasury data
#' @export
#' @examples
#' \donttest{
#' # get data for a single month
#' tr_real_yield_curve("202201")
#' # or for the entire year
#' tr_real_yield_curve(2022)
#' }
tr_real_yield_curve <- function(date = NULL) {
  data <- treasury(
    "daily_treasury_real_yield_curve", date, parse_real_yield_curve
  )
  if (is.null(data)) {
    return()
  }
  data <- clean_real_yield_curves(data)
  as_tibble(data)
}

parse_real_yield_curve <- function(x) {
  date <- x |>
    xml2::xml_find_all(".//d:NEW_DATE") |>
    xml2::xml_text() |>
    as.Date()
  values <- xml2::xml_find_all(x, "./*[starts-with(name(), 'd:TC_')]")
  data.frame(
    date = date,
    maturity = xml2::xml_name(values),
    rate = xml2::xml_double(values)
  )
}

clean_real_yield_curves <- function(data) {
  data$maturity <- tolower(data$maturity)
  data$maturity <- gsub("tc_", "", data$maturity, fixed = TRUE)
  data$maturity <- gsub("(\\d+)(\\w+)", "\\1 \\2", data$maturity)
  data
}

#' Return the daily treasury real long-term rates
#'
#' @inheritParams tr_yield_curve
#' @inherit tr_yield_curve references
#' @returns A `data.frame()` with columns `date` and `rate` or `NULL` when no
#'   entries where found.
#' @family treasury data
#' @export
#' @examples
#' \donttest{
#' # get data for a single month
#' tr_real_long_term("202201")
#' # or for the entire year
#' tr_real_long_term(2022)
#' }
tr_real_long_term <- function(date = NULL) {
  data <- treasury("daily_treasury_real_long_term", date, parse_real_long_term)
  if (is.null(data)) {
    return()
  }
  as_tibble(data)
}

parse_real_long_term <- function(x) {
  date <- x |>
    xml2::xml_find_all(".//d:QUOTE_DATE") |>
    xml2::xml_text() |>
    as.Date()
  rate <- x |>
    xml2::xml_find_all(".//d:RATE") |>
    xml2::xml_double()
  data.frame(date = date, rate = rate)
}

treasury <- function(data, date, fn) {
  resps <- tr_make_request(data, date)
  tr_process_response(resps, fn)
}

tr_make_request <- function(data, date) {
  if (!is.null(date)) {
    date <- as.character(date)
    if (!(length(date) == 1L && grepl("^\\d{4,6}$", date))) {
      stop(
        "`date` must be a single value in format yyyy or yyyymm",
        call. = FALSE
      )
    }
  } else {
    date <- "all"
  }

  nm <- "field_tdr_date_value"
  if (nchar(date) == 6L) {
    nm <- paste(nm, "month", sep = "_")
  }
  req <- request("https://home.treasury.gov/resource-center/data-chart-center/interest-rates/pages/xml") |> # nolint
    req_user_agent("treasury (https://m-muecke.github.io/treasury)") |>
    req_url_query(data = data, "{nm}" := date) # nolint

  if (date == "all") {
    req_perform_iterative(req,
      iterate_with_offset("page", start = 0L, resp_complete = is_complete),
      max_reqs = Inf
    )
  } else {
    req_perform(req)
  }
}

tr_process_response <- function(resps, fn) {
  if (inherits(resps, "list")) {
    resps |>
      resps_successes() |>
      resps_data(\(resp) tr_parse_response(resp, fn))
  } else {
    tr_parse_response(resps, fn)
  }
}

is_complete <- function(resp) {
  entries <- resp |>
    resp_body_xml() |>
    xml2::xml_find_all(".//m:properties")
  length(entries) == 0L
}

tr_parse_response <- function(resp, fn) {
  entries <- resp |>
    resp_body_xml() |>
    xml2::xml_find_all(".//m:properties")
  if (length(entries) == 0L) {
    return()
  }
  data <- lapply(entries, fn)
  do.call(rbind, data)
}
