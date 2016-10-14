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
options(stringsAsFactors = FALSE)
bd_ny <- in_scrape(q = "大数据分析", l = "北京", p = 2)

my_settings <- in_settings()

in_setup(country = "US")
da_us <- in_scrape("data analyst")
ds_ny <- in_scrape("data scientist", "New York")

head(ds_ny, 2)
```

| job.title      | company  | summary                                                                                                                                                             | date         | location                                    | url                                                                       |
|:---------------|:---------|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------|:-------------|:--------------------------------------------|:--------------------------------------------------------------------------|
| Data Scientist | Verizon  | Familiarity and experience with creating analytical data sets. Master’s Degree in Statistics, Math, Economics, Engineering, Computer Science, Business Analytics... | 3 days ago   | New York, NY 10003 (Greenwich Village area) | <http://www.indeed.com/rc/clk?jk=cdb4ec912f0a7ad7&fccid=f7029f63fe5c906e> |
| Data Scientist | Barclays | Or Master’s Degree in operations research, applied statistics, data mining, machine learning, physics or a related quantitative discipline....                      | 12 hours ago | New York, NY                                | <http://www.indeed.com/rc/clk?jk=da51764d46d036c7&fccid=057abf3fd357e717> |
