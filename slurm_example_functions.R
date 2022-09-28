simulation_wrapper <- function (params) {
  ## Extract parameter values
  n <- params$n
  lower <- params$lower
  upper <- params$upper

  ## Run the simulation
  r <- runif(params$n[id],params$lower[id],params$upper[id])

  ## Return the results
  r
}
