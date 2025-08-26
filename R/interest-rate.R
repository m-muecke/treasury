#' Daily treasury par yield curve rates
#'
#' @description
#' This par yield curve, which relates the par yield on a security to its time to
#' maturity, is based on the closing market bid prices on the most recently auctioned
#' Treasury securities in the over-the-counter market. The par yields are derived from
#' input market prices, which are indicative quotations obtained by the Federal Reserve
#' Bank of New York at approximately 3:30 PM each business day.
#'
#' @param date (`NULL` | `character(1)` | `numeric(1)`)\cr
#'   Date in format yyyy or yyyymm. If `NULL`, all data is returned. Default `NULL`.
#' @returns A [data.table::data.table()] containing the rates or `NULL` when no entries were found.
#' @source <https://home.treasury.gov/treasury-daily-interest-rate-xml-feed>
#' @family interest rate
#' @export
#' @examples
#' \donttest{
#' # get data for a single month
#' tr_yield_curve("202201")
#' # or for the entire year
#' tr_yield_curve(2022)
#' }
tr_yield_curve <- function(date = NULL) {
  dt <- treasury("daily_treasury_yield_curve", date, parse_yield_curve)
  if (is.null(dt)) {
    return()
  }
  clean_yield_curve(dt)
}

parse_yield_curve <- function(x) {
  date <- x |>
    xml2::xml_find_all(".//d:NEW_DATE") |>
    xml2::xml_text() |>
    as.Date()
  values <- xml2::xml_find_all(x, "./*[starts-with(name(), 'd:BC_')]")
  data.table(
    date = date,
    maturity = xml2::xml_name(values),
    rate = xml2::xml_double(values)
  )
}

clean_yield_curve <- function(dt) {
  dt <- dt[maturity != "BC_30YEARDISPLAY"]
  dt[, maturity := gsub("bc_", "", tolower(maturity), fixed = TRUE)]
  dt[, maturity := gsub("(\\d+)(\\w+)", "\\1 \\2", maturity)][]
}

#' Daily treasury bill rates
#'
#' @description
#' These rates are the daily secondary market quotations on the most recently
#' auctioned Treasury Bills for each maturity tranche (4-week, 8-week, 13-week,
#' 17-week, 26-week, and 52-week) for which Treasury currently issues new
#' bills.
#'
#' @details
#' Market quotations are obtained at approximately 3:30 PM each business
#' day by the Federal Reserve Bank of New York. The Bank Discount rate is the
#' rate at which a bill is quoted in the secondary market and is based on the
#' par value, amount of the discount and a 360-day year. The Coupon Equivalent,
#' also called the Bond Equivalent, or the Investment Yield, is the bill's
#' yield based on the purchase price, discount, and a 365- or 366-day year. The
#' Coupon Equivalent can be used to compare the yield on a discount bill to the
#' yield on a nominal coupon security that pays semiannual interest with the
#' same maturity date.
#'
#' @section Deprecated functions:
#' [tr_bill_rates()] has been deprecated and will be removed in a future version. Please use
#' [tr_bill_rate()] instead.
#'
#' @inherit tr_yield_curve
#' @family interest rate
#' @export
#' @examples
#' \donttest{
#' # get data for a single month
#' tr_bill_rate("202201")
#' # or for the entire year
#' tr_bill_rate(2022)
#' }
tr_bill_rate <- function(date = NULL) {
  dt <- treasury("daily_treasury_bill_rates", date, parse_bill_rate)
  if (is.null(dt)) {
    return()
  }
  clean_bill_rate(dt)
}

#' @rdname tr_bill_rate
#' @export
tr_bill_rates <- function(date = NULL) {
  .Deprecated("tr_bill_rate")
  tr_bill_rate(date)
}

parse_bill_rate <- function(x) {
  date <- x |>
    xml2::xml_find_all(".//d:INDEX_DATE") |>
    xml2::xml_text() |>
    as.Date()
  values <- xml2::xml_find_all(x, "./*[starts-with(name(), 'd:ROUND_B1_')]")
  data.table(
    date = date,
    type = xml2::xml_name(values),
    value = xml2::xml_double(values)
  )
}

clean_bill_rate <- function(dt) {
  dt[, type := gsub("round_b1_", "", tolower(type), fixed = TRUE)]
  dt[, type := gsub("_2$", "", type)]
  dt[, maturity := strsplit(type, "_", fixed = TRUE)]
  dt[, type := vapply(maturity, `[[`, "", 1L)]
  dt[, maturity := vapply(maturity, `[[`, "", 2L)]
  dt[, maturity := gsub("wk", " weeks", maturity, fixed = TRUE)]
  dt[, c("date", "type", "maturity", "value")][]
}

#' Daily treasury long-term rates
#'
#' @description
#' Treasury ceased publication of the 30-year constant maturity series on
#' February 18, 2002 and resumed that series on February 9, 2006.
#' To estimate a 30-year rate during that time frame, this series includes the
#' Treasury 20-year Constant Maturity rate and an "adjustment factor," which may be
#' added to the 20-year rate to estimate a 30-year rate during the period of time in
#' which Treasury did not issue the 30-year bonds.
#'
#' @inherit tr_yield_curve
#' @family interest rate
#' @export
#' @examples
#' \donttest{
#' # get data for a single month
#' tr_long_term_rate("202212")
#' # or for the entire year
#' tr_long_term_rate(2022)
#' }
tr_long_term_rate <- function(date = NULL) {
  dt <- treasury("daily_treasury_long_term_rate", date, parse_long_term_rate)
  if (is.null(dt)) {
    return()
  }
  clean_long_term_rate(dt)
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
  data.table(date = date, rate_type = rate_type, rate = rate)
}

clean_long_term_rate <- function(dt) {
  dt[, rate_type := gsub("^bc_", "", tolower(rate_type))]
  dt[, rate_type := gsub("_", " ", rate_type, fixed = TRUE)]
  dt[, rate_type := gsub("(\\d+)(year?)", "\\1 \\2", rate_type)][]
}

#' Daily treasury par real yield curve rates
#'
#' @description
#' The par real curve, which relates the par real yield on a Treasury Inflation
#' Protected Security (TIPS) to its time to maturity, is based on the closing market
#' bid prices on the most recently auctioned TIPS in the over-the-counter market.
#' The par real yields are derived from input market prices, which are indicative
#' quotations obtained by the Federal Reserve Bank of New York at approximately 3:30 PM
#' each business day. Treasury began publishing this series on January 2, 2004.
#' At that time Treasury released 1 year of historical data.
#'
#' @inherit tr_yield_curve
#' @family interest rate
#' @export
#' @examples
#' \donttest{
#' # get data for a single month
#' tr_real_yield_curve("202201")
#' # or for the entire year
#' tr_real_yield_curve(2022)
#' }
tr_real_yield_curve <- function(date = NULL) {
  dt <- treasury("daily_treasury_real_yield_curve", date, parse_real_yield_curve)
  if (is.null(dt)) {
    return()
  }
  clean_real_yield_curves(dt)
}

parse_real_yield_curve <- function(x) {
  date <- x |>
    xml2::xml_find_all(".//d:NEW_DATE") |>
    xml2::xml_text() |>
    as.Date()
  values <- xml2::xml_find_all(x, "./*[starts-with(name(), 'd:TC_')]")
  data.table(
    date = date,
    maturity = xml2::xml_name(values),
    rate = xml2::xml_double(values)
  )
}

clean_real_yield_curves <- function(dt) {
  dt[, maturity := gsub("tc_", "", tolower(maturity), fixed = TRUE)]
  dt[, maturity := gsub("(\\d+)(\\w+)", "\\1 \\2", maturity)][]
}

#' Daily treasury real long-term rate averages
#'
#' @description
#' The Long-Term Real Rate Average is the unweighted average of bid real yields
#' on all outstanding TIPS with remaining maturities of more than 10 years and
#' is intended as a proxy for long-term real rates.
#'
#' @inherit tr_yield_curve
#' @family interest rate
#' @export
#' @examples
#' \dontrun{
#' # get data for a single month
#' tr_real_long_term("202201")
#' # or for the entire year
#' tr_real_long_term(2022)
#' }
tr_real_long_term <- function(date = NULL) {
  treasury("daily_treasury_real_long_term", date, parse_real_long_term)
}

parse_real_long_term <- function(x) {
  date <- x |>
    xml2::xml_find_all(".//d:QUOTE_DATE") |>
    xml2::xml_text() |>
    as.Date()
  rate <- x |>
    xml2::xml_find_all(".//d:RATE") |>
    xml2::xml_double()
  data.table(date = date, rate = rate)
}

treasury <- function(data, date, fn) {
  resps <- tr_make_request(data, date)
  tr_process_response(resps, fn)
}

tr_make_request <- function(data, date) {
  if (!is.null(date)) {
    date <- as.character(date)
    if (length(date) != 1L || !grepl("^\\d{4,6}$", date)) {
      stop("`date` must be a single value in format yyyy or yyyymm", call. = FALSE)
    }
  } else {
    date <- "all"
  }

  nm <- "field_tdr_date_value"
  if (nchar(date) == 6L) {
    nm <- paste(nm, "month", sep = "_")
  }
  req <- request(
    "https://home.treasury.gov/resource-center/data-chart-center/interest-rates/pages/xml" # nolint
  ) |>
    req_user_agent("treasury (https://m-muecke.github.io/treasury)") |>
    req_url_query(data = data, "{nm}" := date) # nolint

  if (date == "all") {
    req_perform_iterative(
      req,
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
  rbindlist(lapply(entries, fn))
}
