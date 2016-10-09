library(rindeed)

context("test all FUN")

test_that("in_scrape", {
  expect_error(in_setup(country = "wrong"))
  in_setup(base.url = "http://www.indeed.com")
  ds <- in_scrape("data scientist", "United States")
  expect_equal(nrow(ds), 10)
  Sys.sleep(20)
  da <- in_scrape("data analyst", "New York", 2)
  expect_equal(nrow(da), 20)
})