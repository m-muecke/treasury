is_count <- function(x, null_ok = FALSE) {
  if (null_ok && is.null(x)) {
    return(TRUE)
  }
  is.numeric(x) && length(x) == 1L && is.finite(x) && as.integer(x) == x && x > 0L
}

require_namespace <- function(pkg) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    stop(
      sprintf("Please install the %s package to use this function.", pkg),
      call. = FALSE
    )
  }
}

xml_date <- function(x, xpath) {
  x |>
    xml2::xml_find_all(xpath) |>
    xml2::xml_text() |>
    as.Date()
}
