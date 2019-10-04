test_that("mappers actually work", {
  test_list <- list(x = c(1, 2, 3), y = c(-1, -2, -3))

  expect_equal(
    .map(test_list, sum),
    list(x = sum(test_list$x), y = sum(test_list$y))
  )

  expect_identical(
    .map_dbl(test_list, sum),
    c(x = sum(test_list$x), y = sum(test_list$y))
  )

  expect_identical(
    .map_int(test_list, function(x) sum(as.integer(x))),
    c(x = sum(as.integer(test_list$x)), y = sum(as.integer(test_list$y)))
  )

  expect_identical(
    .map_chr(test_list, paste0, collapse = " "),
    c(x = paste0(test_list$x, collapse = " "),
      y = paste0(test_list$y, collapse = " "))
  )

  expect_identical(
    .map_lgl(test_list, function(x) all(x > 0)),
    c(x = all(test_list$x > 0), y = all(test_list$y > 0))
  )
})
