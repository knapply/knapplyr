# // Copyright (C) 2019 Brendan Knapp
# //
# // knapplyr, version 0.1
# //
# // {knapplyr} is an opinionated collection of functions to facilitate robust,
# // safe R programming. It is heavily inspired by the {purrr} package.
# //
# // The goal is to provide a set of easy, copy/paste-able, dependency-free
# // utility functions to use in other packages.
# //
# // See <https://github.com/knapply/knapplyr> for more info.

.iseq <- function(.x) {
  nms <- names(.x)
  if (is.null(nms)) seq_along(.x) else nms
}

.set_names <- function(.x, nm = .x) {
  `names<-`(.x, nm)
}


# default-ers ==================================================================
`%||%` <- function(.lhs, .rhs) {
  if (is.null(.lhs)) .rhs else .lhs
}


`%{}%` <- function(.lhs, .rhs) {
  if (length(.lhs)) .lhs else .rhs
}


`%{""}%` <- function(.lhs, .rhs) {
  if (nchar(.lhs)) .lhs else .rhs
}


`%{NA}%` <- function(.lhs, .rhs) {
  if (is.na(.lhs)) .rhs else .lhs
}


`%{NULL}%` <- `%||%`

# apply-ers/map-ers ============================================================
.map <- function(.x, .f, ...) {
  lapply(.x, .f, ...)
}

#* vec map-ers =================================================================
.map_template <- function(.x, .f, ..., .template) {
  out <- vapply(.x, .f, FUN.VALUE = .template, ..., USE.NAMES = FALSE)
  names(out) <- names(.x)
  out
}

.map_chr <- function(.x, .f, ...) {
  .map_template(.x, .f, ..., .template = character(1L))
}

.map_lgl <- function(.x, .f, ...) {
  .map_template(.x, .f, ..., .template = logical(1L))
}

.map_int <- function(.x, .f, ...) {
  .map_template(.x, .f, ..., .template = integer(1L))
}

.map_dbl <- function(.x, .f, ...) {
  .map_template(.x, .f, ..., .template = double(1L))
}

#* map2-ers ========================================================================
.map2 <- function(.x, .y, .f, ...) {
  if (length(.x) != length(.y)) {
    stop("`.x` and `.y` must be the same length", call. = FALSE)
  }
  out <- mapply(.f, .x, .y, ..., SIMPLIFY = FALSE, USE.NAMES = FALSE)
  if (all(names(.x) == names(.y))) {
    names(out) <- names(.x)
  }
  out
}

#** vec map2-ers
.map2_template <- function(.x, .y, .f, ..., .template) {
  init <- mapply(.f, .x, .y, ..., SIMPLIFY = FALSE, USE.NAMES = FALSE)
  # as.vector(init, mode = "TEMPLATE GOES HERE AS CHARACTER")
  # vapply(init, `[[`, .template, 1L, USE.NAMES = FALSE)
  out <- vapply(init, unlist, .template, use.names = FALSE, USE.NAMES = FALSE)
  if (all(names(.x) == names(.y))) {
    names(out) <- names(.x)
  }
  out
}


.map2_chr <- function(.x, .y, .f, ...) {
  .map2_template(.x, .y, .f, ..., .template = "")
}

.map2_lgl <- function(.x, .y, .f, ...) {
  .map2_template(.x, .y, .f, ..., .template = FALSE)
}

.map2_int <- function(.x, .y, .f, ...) {
  .map2_template(.x, .y, .f, ..., .template = 0L)
}

.map2_dbl <- function(.x, .y, .f, ...) {
  .map2_template(.x, .y, .f, ..., .template = 0.)
}

# imap-ers ====================================================================
.imap <- function(.x, .f, ...) {
  .map2(.x, .iseq(.x), .f, ...)
}

.imap_chr <- function(.x, .f, ...) {
  .map2_chr(.x, .iseq(.x), .f, ...)
}

.imap_lgl <- function(.x, .f, ...) {
  .map2_lgl(.x, .iseq(.x), .f, ...)
}

.imap_int <- function(.x, .f, ...) {
  .map2_int(.x, .iseq(.x), .f, ...)
}

.imap_dbl <- function(.x, .f, ...) {
  .map2_dbl(.x, .iseq(.x), .f, ...)
}

# map_if-ers ===================================================================
.map_if <- function(.x, .p, .f, ..., .else = NULL) {
  out <- as.list(.x)
  to_map <- .map_lgl(out, .p)
  if (!is.logical(to_map) | any(is.na(to_map))) {
    stop("`.p` must be a function that returns a logical, non-`NA` vector.")
  }
  out[to_map] <- .map(out[to_map], .f, ...)
  if (!is.null(.else)) {
    out[!to_map] <- .else(out[!to_map])
  }
  out
}

# is-ers =======================================================================
.is_empty <- function(.x) {
  length(.x) == 0L
}

.is_scalar <- function(.x) {
  length(.x) == 1L
}

.is_scalar_chr <- function(.x) {
  is.character(.x) && length(.x) == 1L
}

.is_scalar_lgl <- function(.x) {
  is.logical(.x) && length(.x) == 1L
}

.is_scalar_int <- function(.x) {
  is.integer(.x) && length(.x) == 1L
}

.is_scalar_dbl <- function(.x) {
  is.double(.x) && length(.x) == 1L
}

.is_scalar_num <- function(.x) {
  is.numeric(.x) && length(.x) == 1L
}


# misc. purrr-ers
.keep <- function(.x, .f, ...) {
  .x[.map_lgl(.x, .f, ...)]
}

.discard <- function(.x, .f, ...) {
  .x[!.map_lgl(.x, .f, ...)]
}

.compact <- function(.x) {
  Filter(length, .x)
}
