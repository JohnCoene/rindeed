[![Travis-CI Build Status](https://travis-ci.org/JohnCoene/rindeed.svg?branch=master)](https://travis-ci.org/JohnCoene/rindeed)
[![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/JohnCoene/rindeed?branch=master&svg=true)](https://ci.appveyor.com/project/JohnCoene/rindeed)
[![Coverage Status](https://img.shields.io/coveralls/JohnCoene/rindeed.svg)](https://coveralls.io/r/JohnCoene/rindeed?branch=master)

rindeed
=======

Scrape [indeed.com](www.indeed.com) search results.

### Install

``` r
devtools::install_github("JohnCoene/rindeed")
```

### Functions

1.  `in_setup` - setup session
2.  `in_scrape` - scrape
3.  `in_settings` - get settings

### Examples

``` r
library(rindeed)

in_setup(country = "China")
bd_ny <- in_scrape(q = "大数据分析", l = "北京", p = 2)

my_settings <- in_settings()

in_setup(country = "US")
da_us <- in_scrape("data analyst")
ds_ny <- in_scrape("data scientist", "New York")

head(ds_ny, 2)
```

| job.title                | company        | summary                                                                                                                                                             | date       | location                                     | url                                                                       |
|:-------------------------|:---------------|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------|:-----------|:---------------------------------------------|:--------------------------------------------------------------------------|
| Data Scientist           | Verizon        | Familiarity and experience with creating analytical data sets. Master’s Degree in Statistics, Math, Economics, Engineering, Computer Science, Business Analytics... | 2 days ago | New York, NY 10003 (Greenwich Village area)  | <http://www.indeed.com/rc/clk?jk=cdb4ec912f0a7ad7&fccid=f7029f63fe5c906e> |
| Data Scientist / Modeler | Morgan Stanley | The Modeling team and other MSSM project based teams such as Core Analytics and Core Electronic Trading provide quantitative solutions to multiple....              | 2 days ago | New York, NY 10032 (Washington Heights area) | <http://www.indeed.com/rc/clk?jk=f0b32c73f8383044&fccid=0c39fb2c91742dcf> |
