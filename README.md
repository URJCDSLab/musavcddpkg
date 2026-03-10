# musavcddpkg

## Proceso de creación de este paquete tras crear el repositorio vacío en GitHub.

Es necesario tener instalados los paquetes {usethis} {devtools} y {roxygen2}. {usethis} automatiza tareas, pero se pueden realizar también "a mano".

1. Crear carpeta con el archivo `app.R`

```r
usethis::use_r("app.R")
```

2. Crear archivo DESCRIPTION

```r
usethis::use_description()
```

3. Crear archivo NAMESPACE

```r
 usethis::use_namespace()
```

4. Añadir archivo de documentación del paquete.

```r
usethis::use_package_doc()
```

5. Añadir dependencias de paquetes a DESCRIPTION:

```r
usethis::use_package("shiny")
usethis::use_package("bslib")
usethis::use_package("reactable")
usethis::use_package("ggplot2")
usethis::use_package("dplyr")
usethis::use_package("lubridate")
```

6. Importar funciones de los paquetes anteriores para que estén disponibles desde nuestro paquete. Dos formas:

  - Importando el paquete entero añadiendo a la documentación del paquete las líneas:


```r
#' @import shiny
```

  - Importando las funciones específicas que se van a utilizar:


```r
usethis::use_import_from("lubridate", "year")
```

El segundo método (preferido) automáticamente añade lo necesario al archivo `NAMESPACE` (observa el resultado). El primer método no se recomienda ya que "sobrecarga" el paquete innecesariamente. Mejor importar funciones independientes, o bien usar la sintaxis paquete::funcion() en el código del paquete.