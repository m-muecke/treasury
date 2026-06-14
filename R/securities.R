#' US Treasury marketable securities and auction results
#'
#' @description
#' Retrieve data on US Treasury marketable securities from the TreasuryDirect API.
#' `tr_auctions()` returns auction results for securities that have already been auctioned,
#' `tr_announcements()` returns securities whose auctions have been announced but not yet held, and
#' `tr_upcoming()` returns the upcoming auction schedule.
#'
#' @details
#' These functions return every field provided by the API (around 120 columns), with names
#' converted to snake case, date columns parsed to [Date] and numeric columns parsed to numeric.
#' Fields that do not apply to a given security type are returned as `NA`. The API returns at most
#' the 250 most recent matching securities.
#'
#' @param type (`NULL` | `character(1)`)\cr
#'   Security type to filter by, one of `"Bill"`, `"Note"`, `"Bond"`, `"CMB"`, `"TIPS"`, or
#'   `"FRN"`. If `NULL`, all types are returned. Default `NULL`.
#' @param days (`NULL` | `integer(1)`)\cr
#'   Restrict the results to securities from the last `days` days. If `NULL`, the most recent
#'   securities are returned. Default `NULL`.
#' @returns A [data.table::data.table()] containing the securities or `NULL` when no entries were
#'   found.
#' @source <https://www.treasurydirect.gov/webapis/webapisecurities/>
#' @family auction
#' @export
#' @examples
#' \donttest{
#' # auction results for the most recently auctioned notes
#' tr_auctions("Note")
#' # announced bill auctions
#' tr_announcements("Bill")
#' # upcoming auction schedule
#' tr_upcoming()
#' }
tr_auctions = function(type = NULL, days = NULL) {
  securities("auctioned", type, days)
}

#' @rdname tr_auctions
#' @export
tr_announcements = function(type = NULL, days = NULL) {
  securities("announced", type, days)
}

#' @rdname tr_auctions
#' @export
tr_upcoming = function(type = NULL) {
  securities("upcoming", type, NULL)
}

securities = function(endpoint, type, days) {
  type = type %&&% match.arg(type, c("Bill", "Note", "Bond", "CMB", "TIPS", "FRN"))
  stopifnot(is_count(days, null_ok = TRUE))
  dt = securities_request(endpoint, type, days)
  if (is.null(dt)) {
    return()
  }
  clean_securities(dt)
}

securities_request = function(endpoint, type = NULL, days = NULL) {
  res = request("https://www.treasurydirect.gov/TA_WS/securities") |>
    req_url_path_append(endpoint) |>
    req_user_agent(treasury_user_agent()) |>
    req_url_query(type = type, days = days, format = "json") |>
    req_retry(max_tries = 3L) |>
    req_tr_cache() |>
    req_perform() |>
    resp_body_json(simplifyVector = TRUE)

  if (length(res) == 0L) {
    return()
  }
  setDT(res)
}

clean_securities = function(dt) {
  setnames(dt, to_snake_case(names(dt)))
  nms = names(dt)
  is_date = endsWith(nms, "date") & vapply(dt, is_date_col, NA)
  date_cols = nms[is_date]
  other_cols = nms[!is_date]
  dt[, (date_cols) := lapply(.SD, \(x) as.Date(substr(x, 1L, 10L))), .SDcols = date_cols]
  dt[, (other_cols) := lapply(.SD, as_numeric_safe), .SDcols = other_cols]
  dt[]
}

is_date_col = function(x) {
  x = x[nzchar(x)]
  length(x) > 0L && all(grepl("^[0-9]{4}-[0-9]{2}-[0-9]{2}", x))
}
