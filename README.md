
[![Travis-CI Build Status](https://travis-ci.org/JohnCoene/rindeed.svg?branch=master)](https://travis-ci.org/JohnCoene/rindeed)
[![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/JohnCoene/rindeed?branch=master&svg=true)](https://ci.appveyor.com/project/JohnCoene/rindeed)
[![Coverage Status](https://img.shields.io/coveralls/JohnCoene/rindeed.svg)](https://coveralls.io/r/JohnCoene/rindeed?branch=master)

rindeed
=======

Scrape [indeed.com](www.indeed.com) search results.

### Examples

``` r
library(rindeed)
in_setup(country = "us")

ds <- in_scrape("data scientist", "United States")
da <- in_scrape("data analyst", "New York", 2)
head(da, 2)
```

| job.title                                                      | company        | summary                                                                                                                                                      | date       | location     | url                                                                       |
|:---------------------------------------------------------------|:---------------|:-------------------------------------------------------------------------------------------------------------------------------------------------------------|:-----------|:-------------|:--------------------------------------------------------------------------|
| Data Analyst                                                   | SoluStaff      | SoluStaff is seeking a Data Analyst for our client in NYC. Will be a part of the Data Assurance and Data Migration effort....                                | 2 days ago | New York, NY | <http://www.indeed.com/rc/clk?jk=bd8b659199408b7c&fccid=f30351debac492cd> |
| CIB-Rapid Prototyping Data Scientist – Vice President - New... | JPMorgan Chase | Experience in practical data processing, data mining, text mining and information retrieval tasks. Experience of scalable data management tools including... | 2 days ago | New York, NY | <http://www.indeed.com/rc/clk?jk=5f640268ad5d2605&fccid=c46d0116f6e69eae> |
