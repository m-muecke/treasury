#' Return the daily treasury par yield curve rates
#'
#' @param date `character(1)` or `numeric(1)` date in format yyyy or yyyymm.
#'   If `NULL`, all data is returned. Default `NULL`.
#' @references <https://home.treasury.gov/treasury-daily-interest-rate-xml-feed>
#' @family treasury data
#' @export
tr_yield_curve <- function(date = NULL) {
  data <- treasury("daily_treasury_yield_curve", date, \(entries) {
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
  })
  if (is.null(data)) {
    return()
  }
  data <- data[data$maturity != "BC_30YEARDISPLAY", ]
  data$maturity <- tolower(data$maturity)
  data$maturity <- gsub("bc_", "", data$maturity)
  data$maturity <- gsub("(\\d+)(\\w+)", "\\1 \\2", data$maturity)
  as_tibble(data)
}

#' Return the daily treasury bill rates
#'
#' @inheritParams tr_yield_curve
#' @inherit tr_yield_curve references
#' @family treasury data
#' @export
tr_bill_rates <- function(date = NULL) {
  data <- treasury("daily_treasury_bill_rates", date, \(entries) {
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
  })
  if (is.null(data)) {
    return()
  }
  data$type <- tolower(data$type)
  data$type <- gsub("round_b1_", "", data$type)
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
#' @inheritParams tr_yield_curve
#' @inherit tr_yield_curve references
#' @returns A `data.frame()` with columns `date`, `rate_type` and `rate` or
#'   `NULL` when no entries were found.
#' @family treasury data
#' @export
tr_long_term_rate <- function(date = NULL) {
  data <- treasury("daily_treasury_long_term_rate", date, \(entries) {
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
  })
  if (is.null(data)) {
    return()
  }
  data$rate_type <- tolower(data$rate_type)
  data$rate_type <- gsub("^bc_", "", data$rate_type)
  data$rate_type <- gsub("_", " ", data$rate_type)
  data$rate_type <- gsub("(\\d+)(year?)", "\\1 \\2", data$rate_type)
  as_tibble(data)
}

#' Return the daily treasury par real yield curve rates
#'
#' @inheritParams tr_yield_curve
#' @inherit tr_yield_curve references
#' @returns A `data.frame()` with columns `date`, `maturity` and `rate` or
#'   `NULL` when no entries where found.
#' @family treasury data
#' @export
tr_real_yield_curve <- function(date = NULL) {
  data <- treasury("daily_treasury_real_yield_curve", date, \(entries) {
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
  })
  if (is.null(data)) {
    return()
  }
  data$maturity <- tolower(data$maturity)
  data$maturity <- gsub("tc_", "", data$maturity)
  data$maturity <- gsub("(\\d+)(\\w+)", "\\1 \\2", data$maturity)
  as_tibble(data)
}

#' Return the daily treasury real long-term rates
#'
#' @inheritParams tr_yield_curve
#' @inherit tr_yield_curve references
#' @returns A `data.frame()` with columns `date` and `rate`.
#' @family treasury data
#' @export
tr_real_long_term <- function(date = NULL) {
  data <- treasury("daily_treasury_real_long_term", date, \(entries) {
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
  })
  if (is.null(data)) {
    return()
  }
  as_tibble(data)
}

treasury <- function(data, date, resp_data) {
  resps <- tr_make_request(data, date)
  tr_process_response(resps, resp_data)
}

tr_make_request <- function(data, date) {
  if (!is.null(date)) {
    date <- as.character(date)
    if (!(length(date) == 1L && grepl("^[0-9]{4,6}$", date))) {
      stop("`date` must be a single value in format yyyy or yyyymm")
    }
  } else {
    date <- "all"
  }

  if (nchar(date) == 6L) {
    nm <- "field_tdr_date_value_month"
  } else {
    nm <- "field_tdr_date_value"
  }
  req <- request("https://home.treasury.gov/resource-center/data-chart-center/interest-rates/pages/xml") |> # nolint
    req_user_agent("treasury (https://m-muecke.github.io/treasury)") |>
    req_url_query(data = data, "{nm}" := date)

  if (date == "all") {
    req_perform_iterative(req,
      iterate_with_offset("page", start = 0, resp_complete = is_complete),
      max_reqs = Inf
    )
  } else {
    req_perform(req)
  }
}

tr_process_response <- function(resps, resp_data) {
  if (inherits(resps, "list")) {
    data <- resps |> resps_data(\(resp) {
      resp |>
        tr_parse_response() |>
        resp_data()
    })
    return(data)
  }
  data <- tr_parse_response(resps)
  if (length(data) == 0L) {
    return()
  }
  resp_data(data)
}

is_complete <- function(resp) {
  length(tr_parse_response(resp)) == 0
}

tr_parse_response <- function(resp) {
  resp |>
    resp_body_xml() |>
    xml2::xml_find_all(".//m:properties")
}
