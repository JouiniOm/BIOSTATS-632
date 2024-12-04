# ploting a Country

## Description

ploting a Country
This function is the same as in HW1 just in a package

## Usage

```r
plot_cp(dat, est, iso_code, CI = 95)
```

## Arguments

* `dat`: the observed data for modern contraceptive use
* `est`: the estimated data for modern contraceptive use
* `iso_code`: The ISO Code of the country you are searching for
* `CI`: default confidence intervall is 95% it can also take an 80% and NA

## Value

The ggplot that will be created by the function

## Examples

```r
plot_cp(dat_example, est_example, iso_code = 4, CI = 95)
```

