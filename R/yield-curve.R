#' Download Treasury Coupon Issues and Corporate Bond Yield Curves
#'
#' @description
#' The Yield Curve for Treasury Nominal Coupon Issues (TNC yield curve) is derived from
#' Treasury nominal notes and bonds. The Yield Curve for Treasury Real Coupon Issues
#' (TRC yield curve) is derived from Treasury Inflation-Protected Securities (TIPS).
#' The Treasury Breakeven Inflation Curve (TBI curve) is derived from the TNC and TRC
#' yield curves combined.
#'
#' @param x `character(1)`. Must be one of the following options:
#'   * `"hqm"`: The Treasury High Quality Market (HQM) Corporate Bond Yield Curve.
#'   * `"tnc"`: The Treasury Nominal Coupon-Issue (TNC) Yield Curve.
#'   * `"trc"`: The Treasury Real Coupon-Issue (TRC) Yield Curve.
#'   * `"tbi"`: The Treasury Breakeven Inflation (TBI) Curve.
#' @param type `character(1)`. Either `"monthly"` or `"end-of-month"`.
#'   Default is `"monthly"`.
#' @param year `integer(1)`. Year to download. Default is `NULL`.
#'   If `NULL`, then all available years are downloaded.
#' @returns
#' A `data.frame()` containing the treasury rates.
#' @family yield curve
#' @source <https://home.treasury.gov/data/treasury-coupon-issues-and-corporate-bond-yield-curves>
#' @export
#' @examples
#' \dontrun{
#' # TBI Treasury Curve Breakeven Rates
#' tr_curve_rate("tbi")
#' tr_curve_rate("trc", "end-of-month", 2024L)
#' # TRC Treasury Yield Curve Par Yields, Monthly Average
#' tr_par_yields("trc")
#' # TNC Treasury Yield Curve Forward Rates, End of Month
#' tr_forward_rate("tnc", "end-of-month")
#' }
tr_curve_rate <- function(x = c("hqm", "tnc", "trc", "tbi"),
                          type = c("monthly", "end-of-month"),
                          year = NULL) {
  stopifnot(is_count_or_null(year))
  x <- match.arg(x)
  type <- match.arg(type)
  start_year <- switch(x,
    hqm = 1984L,
    tnc = 1978L,
    trc = 2003L,
    tbi = 2003L
  )
  x <- if (type == "monthly") x else paste0(x, "eom")
  years <- seq.int(start_year, 2027L, by = 5L)
  if (!is.null(year)) {
    years <- years[findInterval(year, years)]
  }
  urls <- vapply(years, \(year) {
    sprintf(
      "https://home.treasury.gov/system/files/226/%s_%02d_%02d.%s",
      x,
      year %% 100L,
      (year + 4L) %% 100L,
      if (year >= 2023L && !startsWith(x, "hqm")) "xlsx" else "xls"
    )
  }, NA_character_)
  if (x == "hqmeom") {
    urls <- sub("88\\.xls$", "88_0.xls", urls)
  }

  months <- rep.int(month.name, 5L)
  res <- lapply(seq_along(urls), \(i) {
    tf <- tempfile()
    on.exit(unlink(tf), add = TRUE)
    utils::download.file(urls[[i]], destfile = tf, quiet = TRUE, mode = "wb")
    res <- readxl::read_excel(tf, skip = 4L, .name_repair = \(nms) {
      year <- years[[i]]
      years <- rep(year:(year + 4L), each = 12L)
      nms <- paste(months, years, sep = "-")
      nms <- c("maturity", "tmp", nms)
      nms
    })
    res <- res[, -2L]
    res <- tidyr::pivot_longer(res, -maturity,
      names_to = "yearmonth", values_to = "rate", values_drop_na = TRUE
    )
    res$yearmonth <- as.Date(paste("01", res$yearmonth, sep = "-"), format = "%d-%B-%Y")
    res[c("yearmonth", "maturity", "rate")]
  })
  do.call(rbind, res)
}

#' @rdname tr_curve_rate
#' @export
tr_par_yields <- function(x = c("hqm", "tnc", "trc"),
                          type = c("monthly", "end-of-month")) {
  x <- match.arg(x)
  type <- match.arg(type)

  if (x == "hqm") {
    nms <- c("yearmonth", "tmp", "2 years", "5 years", "10 years", "30 years")
  } else {
    nms <- c(
      "yearmonth", "tmp", "2 years", "3 years", "5 years", "7 years", "10 years",
      "20 years", "30 years"
    )
  }

  if (type == "monthly") {
    sfx <- if (x == "tnc") "_qh_pars_1" else "_qh_pars"
  } else {
    sfx <- "eom_qh_pars"
  }
  x <- paste0(x, sfx)

  download_data(x, nms, 6L, "maturity", "par_yield")
}

#' @rdname tr_curve_rate
#' @export
tr_forward_rate <- function(x = c("tnc", "trc", "tbi"),
                            type = c("monthly", "end-of-month")) {
  x <- match.arg(x)
  type <- match.arg(type)

  if (type == "monthly") {
    sfx <- if (x == "tnc") "_qh_forwards_0" else "_qh_forwards"
  } else {
    sfx <- "eom_qh_forwards"
  }
  x <- paste0(x, sfx)

  nms <- c(
    "yearmonth",
    "tmp",
    "2-year forward rate 2 years hence",
    "5-year forward rate 5 years hence",
    "10-year forward rate 10 years hence",
    "1-year forward rate 30 years hence"
  )
  download_data(x, nms, 6L, "type", "forward_rate")
}

download_data <- function(x, col_names, skip, names_to, values_to) {
  url <- sprintf("https://home.treasury.gov/system/files/226/%s.xls", x)
  tf <- tempfile()
  on.exit(unlink(tf), add = TRUE)
  utils::download.file(url, destfile = tf, quiet = TRUE, mode = "wb")
  res <- readxl::read_excel(tf, col_names = col_names, skip = skip)
  res <- res[, -2L]
  res <- tidyr::pivot_longer(res, -yearmonth,
    names_to = names_to, values_to = values_to
  )
  res$yearmonth <- as.Date(paste("01", res$yearmonth), format = "%d %B %Y")
  res
}
