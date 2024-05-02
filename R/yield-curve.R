tr_hqm <- function(x = c("average", "end-of-month")) {
  x <- match.arg(x)
  x <- if (x == "average") "hqm" else "hqmeom"
  start_year <- seq(1984L, 2028L, by = 5L)
  urls <- vapply(start_year, \(year) {
    sprintf(
      "https://home.treasury.gov/system/files/226/%s_%02d_%02d.xls",
      x, year %% 100L, (year + 4L) %% 100L
    )
  }, NA_character_)
  if (x == "hqmeom") {
    urls[[1L]] <- sub("88\\.xls$", "88_0.xls", urls[[1L]])
  }

  months <- rep.int(month.name, 5L)
  res <- lapply(seq_along(urls), \(i) {
    tf <- tempfile(fileext = ".xls")
    on.exit(unlink(tf), add = TRUE)
    utils::download.file(urls[[i]], destfile = tf, quiet = TRUE, mode = "wb")
    res <- readxl::read_xls(tf, skip = 4L, .name_repair = \(nms) {
      year <- start_year[[i]]
      years <- rep(year:(year + 4L), each = 12L)
      nms <- paste(months, years, sep = "-")
      nms <- c("maturity", "tmp", nms)
      nms
    })
    res <- res[, -2L]
    res <- tidyr::pivot_longer(res, -maturity,
      names_to = "yearmonth", values_to = "yield", values_drop_na = TRUE
    )
    res$yearmonth <- paste("01", res$yearmonth, sep = "-") |> as.Date("%d-%B-%Y")
    res[c("yearmonth", "maturity", "yield")]
  })
  do.call(rbind, res)
}

tr_hqm_pars <- function(x = c("average", "end-of-month")) {
  x <- match.arg(x)
  x <- if (x == "average") "hqm" else "hqmeom"
  url <- sprintf("https://home.treasury.gov/system/files/226/%s_qh_pars.xls", x)
  tf <- tempfile(fileext = ".xls")
  on.exit(unlink(tf), add = TRUE)
  utils::download.file(url, destfile = tf, quiet = TRUE, mode = "wb")
  res <- readxl::read_xls(tf,
    col_names = c("yearmonth", "tmp", "2 years", "5 years", "10 years", "30 years"),
    skip = 6L
  )
  res <- res[, -2L]
  res <- tidyr::pivot_longer(res, -yearmonth,
    names_to = "maturity", values_to = "yield"
  )
  res$yearmonth <- paste("01", res$yearmonth) |> as.Date("%d %B %Y")
  res
}

tr_tnc <- function() {
  # TODO: there is an edge case for 1976-1977
  start_year <- seq(1978L, 2027L, by = 5L)
  urls <- vapply(start_year, \(year) {
    sprintf(
      "https://home.treasury.gov/system/files/226/tnc_%02d_%02d.xls",
      year %% 100L, (year + 4L) %% 100L
    )
  }, NA_character_)

  months <- rep.int(month.name, 5L)
  res <- lapply(seq_along(urls), \(i) {
    tf <- tempfile(fileext = ".xls")
    on.exit(unlink(tf), add = TRUE)
    utils::download.file(urls[[i]], destfile = tf, quiet = TRUE, mode = "wb")
    res <- readxl::read_xls(tf, skip = 4L, .name_repair = \(nms) {
      year <- start_year[[i]]
      years <- rep(year:(year + 4L), each = 12L)
      nms <- paste(months, years, sep = "-")
      nms <- c("maturity", "tmp", nms)
      nms
    })
    res <- res[, -2L]
    res <- tidyr::pivot_longer(res, -maturity,
      names_to = "yearmonth", values_to = "yield", values_drop_na = TRUE
    )
    res$yearmonth <- paste("01", res$yearmonth, sep = "-") |> as.Date("%d-%B-%Y")
    res[c("yearmonth", "maturity", "yield")]
  })
  do.call(rbind, res)
}
