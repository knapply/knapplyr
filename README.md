
<!-- README.Rmd generates README.md. -->

# `{knapplyr}`

<!-- badges: start -->

[![Lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![GitHub last
commit](https://img.shields.io/github/last-commit/knapply/knapplyr.svg)](https://github.com/knapply/knapplyr/commits/master)
[![Codecov test
coverage](https://codecov.io/gh/knapply/knapplyr/branch/master/graph/badge.svg)](https://codecov.io/gh/knapply/knapplyr?branch=master)
[![AppVeyor build
status](https://ci.appveyor.com/api/projects/status/github/knapply/knapplyr?branch=master&svg=true)](https://ci.appveyor.com/project/knapply/knapplyr)
[![Travis-CI Build
Status](https://travis-ci.org/knapply/knapplyr.svg?branch=master)](https://travis-ci.org/knapply/knapplyr)
[![License: GPL
v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
[![Depends](https://img.shields.io/badge/Depends-GNU_R%3E=3.1-blue.svg)](https://www.r-project.org/)
[![GitHub code size in
bytes](https://img.shields.io/github/languages/code-size/knapply/knapplyr.svg)](https://github.com/knapply/knapplyr)
[![HitCount](http://hits.dwyl.io/knapply/knapplyr.svg)](http://hits.dwyl.io/knapply/knapplyr)
<!-- badges: end -->

Utility functions to facilitate robust R programming that are
*heavily*-inspired by `{purrr}`.

`{knapplyr}` is meant to serve as a controlled environment for
development and testing. The functions are not so much intended to be
imported elsewhere, but instead to make it easy to have sane, tested,
dependency-free utilities that can be easily used as internal, utility
functions in other packages.

This is mainly for personal purposes, but if you’d like to use it, just
add the `/R/knapply-utils.R` file to your package’s `/R` folder. The
functions will then be accessible just like any of your package’s other
functions.

# Default-ers

<table>

<thead>

<tr>

<th style="text-align:left;">

{knapply} Function

</th>

<th style="text-align:left;">

Example

</th>

<th style="text-align:left;">

Result

</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:left;">

`%||%`

</td>

<td style="text-align:left;">

`NULL %||% "common default NULL replacement"`

</td>

<td style="text-align:left;">

`common default NULL replacement`

</td>

</tr>

<tr>

<td style="text-align:left;">

`%{NULL}%`

</td>

<td style="text-align:left;">

`NULL %{NULL}% "alternate NULL replacement"`

</td>

<td style="text-align:left;">

`alternate NULL replacement`

</td>

</tr>

<tr>

<td style="text-align:left;">

`%{}%`

</td>

<td style="text-align:left;">

`character(0) %{}% "default empty replacement"`

</td>

<td style="text-align:left;">

`default empty replacement`

</td>

</tr>

<tr>

<td style="text-align:left;">

`%{NA}%`

</td>

<td style="text-align:left;">

`NA %{NA}% "default NA replacement"`

</td>

<td style="text-align:left;">

`default NA replacement`

</td>

</tr>

<tr>

<td style="text-align:left;">

`%{""}%`

</td>

<td style="text-align:left;">

`"" %{""}% "default empty string replacement"`

</td>

<td style="text-align:left;">

`default empty string replacement`

</td>

</tr>

</tbody>

</table>

## `.map*()`-ers

``` r
l1 <- list(a = 1:3, b = -1:-3)
l1
```

    #> $a
    #> [1] 1 2 3
    #> 
    #> $b
    #> [1] -1 -2 -3

``` r
.map(l1, as.character)
```

    #> $a
    #> [1] "1" "2" "3"
    #> 
    #> $b
    #> [1] "-1" "-2" "-3"

``` r
.map_chr(l1, paste, collapse = ", ")
```

    #>            a            b 
    #>    "1, 2, 3" "-1, -2, -3"

``` r
.map_int(l1, sum)
```

    #>  a  b 
    #>  6 -6

``` r
.map_dbl(l1, function(x) sum(x) * 2.5)
```

    #>   a   b 
    #>  15 -15

``` r
.map_lgl(l1, function(x) all(x > 0))
```

    #>     a     b 
    #>  TRUE FALSE

## `.map2*()`-ers

``` r
l2 <- list(a = 4:6, b = -4:-6)
l2
```

    #> $a
    #> [1] 4 5 6
    #> 
    #> $b
    #> [1] -4 -5 -6

``` r
.map2(l1, l2, c)
```

    #> $a
    #> [1] 1 2 3 4 5 6
    #> 
    #> $b
    #> [1] -1 -2 -3 -4 -5 -6

``` r
.map2_chr(l1, l2, paste, collapse = " | ")
```

    #>                       a                       b 
    #>       "1 4 | 2 5 | 3 6" "-1 -4 | -2 -5 | -3 -6"

``` r
.map2_int(l1, l2, min)
```

    #>  a  b 
    #>  1 -6

``` r
.map2_dbl(l1, l2, function(x, y) sort(c(x, y))[[1L]])
```

    #>  a  b 
    #>  1 -6

``` r
.map2_lgl(l1, l2, function(x, y) all(c(x, y) > 0))
```

    #>     a     b 
    #>  TRUE FALSE

``` r
n <- .set_names("named")
n
```

    #>   named 
    #> "named"
