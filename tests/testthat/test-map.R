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

























test_that("0 length input gives 0 length output", {
  out1 <- .map(list(), identity)
  expect_equal(out1, list())

  out2 <- .map(NULL, identity)
  expect_equal(out2, list())
})

test_that("map() always returns a list", {
  expect_is(.map(mtcars, mean), "list")
})


test_that("logical and integer NA become correct double NA", {
  expect_identical(
    .map_dbl(list(NA, NA_integer_), identity),
    c(NA_real_, NA_real_)
  )
})


test_that("map_if() always return a list", {
  df <- data.frame(x = 1, y = "a", stringsAsFactors = FALSE)
  expect_identical(.map_if(df, is.character, function(x) "out"),
                   list(x = 1, y = "out"))
})


test_that("map_if requires predicate functions", {
  expect_error(.map_if(1:3, function(.x) NA, function(.x) "foo"))
})

test_that("`.else` maps false elements", {
  expect_identical(.map_if(-1:1, function(.x) .x > 0, paste,
                          .else = function(.x) "bar", "suffix"),
                   list("bar", "bar", "1 suffix"))
})
