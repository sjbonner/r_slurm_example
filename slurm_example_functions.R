simulation_wrapper <- function (params) {
  ## Extract parameter values
  n <- params$n
  lower <- params$lower
  upper <- params$upper

  ## Run the simulation
  r <- runif(n, lower, upper)

  ## Return the results
  r
}
