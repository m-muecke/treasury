test_that("tr_curve_rate works", {
  expect_error(tr_curve_rate(NA))
  expect_error(tr_curve_rate(1L))
  expect_error(tr_curve_rate("hxm"))
  expect_error(tr_curve_rate(c("hqm", "hqm")))

  expect_error(tr_curve_rate("hqm", 1L))
  expect_error(tr_curve_rate("hqm", NA))
  expect_error(tr_curve_rate("hqm", "yearly"))
  expect_error(tr_curve_rate("hqm", c("monthly", "monthly")))

  expect_error(tr_curve_rate(year = -100L))
  expect_error(tr_curve_rate(year = "2024"))
  expect_error(tr_curve_rate(year = 202.5))
  expect_error(tr_curve_rate(year = NA))
})

test_that("tr_forward_rate works", {
  expect_error(tr_forward_rate(NA))
  expect_error(tr_forward_rate(1L))
  expect_error(tr_forward_rate("hxm"))
  expect_error(tr_forward_rate(c("tnc", "tnc")))

  expect_error(tr_forward_rate("tnc", 1L))
  expect_error(tr_forward_rate("tnc", NA))
  expect_error(tr_forward_rate("tnc", "yearly"))
  expect_error(tr_forward_rate("tnc", c("monthly", "monthly")))
})

test_that("tr_par_yields works", {
  expect_error(tr_par_yields(NA))
  expect_error(tr_par_yields(1L))
  expect_error(tr_par_yields("hxm"))
  expect_error(tr_par_yields(c("tnc", "tnc")))

  expect_error(tr_par_yields("tnc", 1L))
  expect_error(tr_par_yields("tnc", NA))
  expect_error(tr_par_yields("tnc", "yearly"))
  expect_error(tr_par_yields("tnc", c("monthly", "monthly")))
})
