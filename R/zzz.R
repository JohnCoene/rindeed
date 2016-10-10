setup_env <- new.env(hash = TRUE)

.onAttach <- function(libname = find.package("rindeed"), pkgname = "rindeed") {
  packageStartupMessage("help('rindeed') for examples")
}