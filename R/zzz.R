
.onAttach <- function(libname = find.package("rindeed"), pkgname = "rindeed") {
  packageStartupMessage("help('rindeed') for examples")
}

.onUnload <- function(libpath = find.package("oRion")) {
  options(base.url = NULL, accept = NULL)
}

.onDetach <- function(libpath = find.package("oRion")) {
  options(base.url = NULL, accept = NULL)
}