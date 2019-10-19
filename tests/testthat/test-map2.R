context("map2")

test_that("map2 inputs must be same length", {
  expect_error(.map2(1:3, 2:3, function(...) NULL))
})

test_that("map2 can't simplify if elements longer than length 1", {
  expect_error(
    .map2_int(1:4, 5:8, range)
  )
})

test_that("fails on non-vectors", {
  expect_error(.map2(environment(), "a", identity))
  expect_error(.map2("a", environment(), identity))
})

test_that("map2 takes only names from x", {
  x1 <- 1:3
  x2 <- .set_names(x1)

  expect_equal(names(.map2(x1, x2, `+`)), NULL)
  expect_equal(names(.map2(x2, x1, `+`)), names(x2))
})

test_that("map2 always returns a list", {
  expect_is(.map2(mtcars, rep(0, length(mtcars)), function(.x, .y) mtcars),
            "list")
})







test_that("imap is special case of map2", {
  x <- .set_names(1:3)
  expect_identical(.imap(x, paste), .map2(x, names(x), paste))
})

test_that("imap always returns a list", {
  x <- .set_names(1:3)
  expect_is(.imap(x, paste), "list")
})

test_that("atomic vector imap works", {
  x <- .set_names(1:3)
  expect_true(all(.imap_lgl(x, `==`)))
  expect_length(.imap_chr(x, paste), 3)
  expect_equal(.imap_int(x, function(.x, .y) .x + as.integer(.y)), x * 2)
  expect_equal(.imap_dbl(x, function(.x, .y) .x + as.numeric(.y)), x * 2)
})

