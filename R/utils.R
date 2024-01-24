is_installed <- function(pkg) {
  isTRUE(requireNamespace(pkg, quietly = TRUE))
}

as_tibble <- function(x) {
  if (getOption("treasury.use_tibble", TRUE) && is_installed("tibble")) {
    tibble::as_tibble(x)
  } else {
    x
  }
}
