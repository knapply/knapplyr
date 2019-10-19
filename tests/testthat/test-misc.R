

test_that(".iseq works", {
  expect_equal(.iseq(letters),
               seq_along(letters))
  expect_equal(.iseq(.set_names(letters)),
               letters)
})

test_that("defaulte-rs work", {
  expect_equal(NULL %||% "face",
               "face")

  expect_equal(NULL %{NULL}% "face",
               "face")

  expect_equal("face" %||% NULL,
               "face")

  expect_equal("face" %{}% NULL,
               "face")

  expect_equal(character() %{}% NA,
               NA)

  expect_equal("" %{""}% "what",
               "what")

  expect_equal(NA %{NA}% NULL,
               NULL)
})

test_that("is-ers work", {
  expect_true(.is_empty(NULL))
  expect_false(.is_scalar(NULL))
  expect_true(.is_scalar(""))
  expect_true(.is_scalar_chr(""))
  expect_true(.is_scalar_int(1L))
  expect_true(.is_scalar_dbl(2))
  expect_true(.is_scalar_lgl(FALSE))
  expect_true(.is_scalar_num(1L))
})

test_that("misc-ers work", {
  expect_equal(
    .keep(-10:10, function(.x) .x > 0),
    1:10
  )
  expect_equal(
    .discard(list(NA, 1), is.na),
    list(1)
  )
  expect_equal(
    .compact(list(NULL, 1)),
    list(1)
  )
})
