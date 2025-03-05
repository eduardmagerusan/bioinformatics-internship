#Custom Function
temp_conv <- function(temp_f) {
  temp_c <- (temp_f - 32) * 5 / 9
  temp_k = temp_c + 273.15
  return(temp_k)
}

#Nesting Function
round(temp_conv(70), digits = 1)

