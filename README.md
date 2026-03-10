# musavcddpkg

## Proceso de creación de este paquete tras crear el repositorio vacío en GitHub.

Es necesario tener instalados los paquetes {usethis} {devtools} y {roxygen2}. {usethis} automatiza tareas, pero se pueden realizar también "a mano".

1. Crear carpeta con el archivo `app.R`

```r
usethis::use_r("app.R")
```

  💡 Si vamos a programar la aplicación separando UI y Server, creamos los dos archivos `ui.R` y `server.R`.

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

El segundo método (preferido) automáticamente añade lo necesario al archivo `NAMESPACE` (observa el resultado). El primer método no se recomienda ya que "sobrecarga" el paquete innecesariamente. Mejor importar funciones independientes, o bien usar la sintaxis paquete::funcion() en el código del paquete. En todo caso, si lo usamos, hay que "documentar" el paquete para que se añada esa información al archivo `NAMESPACE`:

```r
devtools::document()
```

## Datos del paquete

Véase capítulo Data en R Packages: <https://r-pkgs.org/data.html>

Se puede acceder de varias formas a los datos que utiliza el paquete. Si la aplicación es autocontenida, lo mejor es incluir los datos como parte estructural del paquete en formato `.rda`. También se pueden incluir los datos "crudos". Para este paquete se ha realizado lo siguiente:

1. Crear un script que genera los datos a incluir en el archivo.

```r
usethis::use_data_raw("resultados")
```

  Esto crea una carpeta `data-raw` que se ignorará en el paquete una vez instalado, pero es útil a la hora de programar el paquete.
  
2. Dentro de esa carpeta se guarda el archivo de datos que se va a usar en el paquete, y en el script que se ha creado, se escribe el código que importa los datos al _workspace_, y el código que crea los datos para el paquete:

```r
resultados <- read.csv("data-raw/results.csv")
usethis::use_data(resultados, overwrite = TRUE)
```

  Esto es recomendable dejarlo en el script para una mejor trazabilidad. El código crea la carpeta `data` y guarda en formato `.rda` el objeto. Se pueden guardar en el paquete ficheros en otros formatos, en la carpeta `inst/extdata` en caso necesario.

## Código de la aplicación

Arriba habíamos creado el archivo `app.R`, donde se ha copiado el código principal de la aplicación (creación de UI y Server, que se podría separar en dos archivos). Añadimos un ejemplo de módulo, donde se ha copiado el módulo de ejemplo.

```r
usethis::use_r("modulo_seleccion.R")
```
