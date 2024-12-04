#' ploting a Country
#' This function is the same as in HW1 just in a package
#' @param dat the observed data for modern contraceptive use
#' @param est the estimated data for modern contraceptive use
#' @param iso_code The ISO Code of the country you are searching for
#' @param CI default confidence intervall is 95\% it can also take an 80\% and NA
#'
#' @return The ggplot that will be created by the function
#' @export
#'
#' @examples plot_cp(dat_example, est_example, iso_code = 4, CI = 95)
plot_cp <- function(dat,est, iso_code, CI = 95) {
  dat_temp <- dat %>%
    mutate(ref_time =  (start_date + end_date)/2) %>%
    filter(is_in_union == "Y") %>%
    mutate(contraceptive_use_modern = contraceptive_use_modern * 100)


  # Prepare  temp est data to get country
  est_temp <- est %>%
    rename(iso_country = iso) %>%
    filter(iso_country == iso_code)

  # Prepare temp observed data
  dat_temp <- dat_temp %>%
    filter(division_numeric_code == iso_code)

  # Start plot with estimates (lines)
  p_temp <- ggplot() +
    geom_point(
      data = dat_temp,
      aes(x = ref_time, y = contraceptive_use_modern)) +
    labs(
      x = "Time",
      y = "Modern use (%)",
      title = paste("mCPR in", est_temp$`Country or area`[1]))

  # Conditional CI layers
  if (is.na(CI)== T) {
    p <- p_temp +
      geom_line(data = est_temp,
                aes(x = Year, y = Median))
  }
  else if (CI == 80) {
    p <- p_temp + geom_smooth(data = est_temp, stat = "identity", aes(x= Year, y = Median,  ymin = L80, ymax = U80), alpha = 0.3) +
      geom_line(data = est_temp,
                aes(x = Year, y = Median),
                color = "blue")
  }
  else {
    p <- p_temp + geom_smooth(data = est_temp, stat = "identity", aes(x= Year, y = Median, ymin = L95, ymax = U95), alpha = 0.3) +
      geom_line(data = est_temp,
                aes(x = Year, y = Median),
                color = "blue")
  }
  return(p)
}
