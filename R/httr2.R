treasury_user_agent <- function() {
  sprintf("treasury/%s", utils::packageVersion("treasury"))
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
    req_user_agent(treasury_user_agent()) |>
    req_url_query(data = data, "{nm}" := date) |> # nolint
    req_retry(max_tries = 3L) |>
    req_tr_cache()

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

tr_entries <- function(resp) {
  resp |>
    resp_body_xml() |>
    xml2::xml_find_all(".//m:properties")
}

is_complete <- function(resp) {
  length(tr_entries(resp)) == 0L
}

tr_parse_response <- function(resp, fn) {
  entries <- tr_entries(resp)
  if (length(entries) == 0L) {
    return()
  }
  rbindlist(lapply(entries, fn))
}
