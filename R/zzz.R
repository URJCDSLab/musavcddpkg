.onLoad <- function(libname, pkgname) {
  resources <- system.file("app/www", package = "musavcddpkg")
  addResourcePath("www", resources)

  # Ejemplo conexión a base de datos

  # con <<- DBI::dbConnect(
  #   RPostgres::Postgres(),
  #   host = Sys.getenv("HOST"),
  #   dbname = Sys.getenv("DB"),
  #   port = 5432,
  #   user = Sys.getenv("DBUSER"),
  #   password = Sys.getenv("PASSWORD")
  # )
}
