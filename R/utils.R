# // Copyright (C) 2019 Brendan Knapp
# // This file is part of knapplyr. See <https://github.com/knapply/knapplyr>


# apply-ers/map-ers ============================================================

#' @name .map
#' @title Apply/Map Operations
#'
#' @description Apply a function to each element of an R object.
#'
#' @param .x A (likely iterable) R object (e.g. list, atomic vector, etc.).
#' @param .f `<function>` Function to be applied to each element of `.x`.
#' @param ... Optional arguments to pass to `.f`.
#'
#' @seealso [lapply()], [vapply()], [purrr::map()]
#'
NULL


#' @rdname dot-map
#'
#' @export
.map <- function(.x, .f, ...) {
  lapply(.x, .f, ...)
}


.map_template <- function(.x, .f, ..., .template) {
  out <- vapply(.x, .f, .template, ..., USE.NAMES = FALSE)
  names(out) <- names(.x)
  out
}


#' @rdname dot-map
#' @export
.map_chr <- function(.x, .f, ...) {
  .map_template(.x, .f, ..., .template = character(1L))
}


#' @rdname dot-map
#' @export
.map_lgl <- function(.x, .f, ...) {
  .map_template(.x, .f, ..., .template = logical(1L))
}



#' @rdname dot-map
#' @export
.map_int <- function(.x, .f, ...) {
  .map_template(.x, .f, ..., .template = integer(1L))
}



#' @rdname dot-map
#' @export
.map_dbl <- function(.x, .f, ...) {
  .map_template(.x, .f, ..., .template = double(1L))
}



#' @name .map2
#'
#' @title Apply/Map Operations Using 2 arguments simultaneously.
#'
#' @description Apply a function to each pair of elements in 2 R objects.
#'
#' @inheritParams .map
#' @param .x,.y R objects of the same length (e.g. list, atomic vector, etc.).
#' @param .f `<function>` Function to be applied to each pair of elements in `.x`.
#' @param ... Optional arguments to pass to `.f`.
#'
NULL

#' @rdname dot-map2
#' @export
.map2 <- function(.x, .y, .f, ...) {
  mapply(.f, .x, .y, ..., SIMPLIFY = FALSE, USE.NAMES = FALSE)
}


.map2_template <- function(.x, .y, .f, ..., .template) {
  init <- mapply(.f, .x, .y, ..., SIMPLIFY = FALSE, USE.NAMES = FALSE)
  vapply(init, unlist, .template(1L), use.names = FALSE, USE.NAMES = FALSE)
  # as.vector(init, mode = "TEMPLATE GOES HERE AS CHARACTER")
  # vapply(init, `[[`, .template, 1L, USE.NAMES = FALSE)
}


#' @rdname dot-map2
#' @export
.map2_chr <- function(.x, .y, .f, ...) {
  .map2_template(.x, .y, .f, ..., .template = character(1L))
}

#' @rdname dot-map2
#' @export
.map2_lgl <- function(.x, .y, .f, ...) {
  .map2_template(.x, .y, .f, ..., .template = logical(1L))
}

#' @rdname dot-map2
#' @export
.map2_int <- function(.x, .y, .f, ...) {
  .map2_template(.x, .y, .f, ..., .template = integer(1L))
}

#' @rdname dot-map2
#' @export
.map2_dbl <- function(.x, .y, .f, ...) {
  .map2_template(.x, .y, .f, ..., .template = double(1L))
}



# as-ers =======================================================================
.as_chr <- function(.x) {
  out <- as.character(.x)
  names(out) <- names(.x)
  out
}


.as_lgl <- function(.x) {
  out <- as.logical(.x)
  names(out) <- names(.x)
  out
}


.as_int <- function(.x) {
  out <- as.integer(.x)
  names(out) <- names(.x)
  out
}


as_dbl <- function(.x) {
  out <- as.double(.x)
  names(out) <- names(.x)
  out
}








