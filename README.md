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

El resto de dependencias de la aplicación se puede completar con estos "imports":

```r
usethis::use_import_from("bslib", "nav_panel")
usethis::use_import_from("reactable", c("reactableOutput", "reactable", "renderReactable"))
usethis::use_import_from("ggplot2", c("ggplot", "geom_line", "aes"))
usethis::use_import_from("dplyr", c("filter", "group_by", "summarise"))
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

Arriba habíamos creado el archivo `app.R`, donde se ha copiado el código principal de la aplicación (creación de UI y Server, que se podría separar en dos archivos). Añadimos un ejemplo de módulo, donde se ha copiado el módulo de ejemplo, sacándolo del script principal.

```r
usethis::use_r("modulo_seleccion.R")
```

El código de la aplicación hay que encapsularlo dentro de una función, véase el código definitivo de `app.R`. Si se ha separado el código de UI y el de Server, se puede crear otro script con la función que llame a `shinyAppp()`.

## Despliegue como paquete

Si queremos desplegar una aplicación de este estilo por ejemplo en posit connect cloud o en shinyapps.io, es necesario crear un nuevo archivo `app.R` en el directorio raíz del proyecto (no en la carpeta R) con el siguiente contenido:

```r
pkgload::load_all(".")
myApp()
```

En este caso, es mejor añadir también {pkgload} al archivo `DESCRIPTION`:

```r
usethis::use_package("pkgload")
```

## Acceso a bases de datos y otros recursos

Si la aplicación accede a bases de datos, los datos de la conexión se deben cargar al iniciar la aplicación. Se puede poner el código en un script aparte dentro de la carpeta R, dentro del script de la app, o dentro de la función `.onLoad()`. Esta función se suele meter en un script llamado `zzz.R` por si necesita alguna función de las creadas en otros scripts. 

Además, es importante que las credenciales de acceso no estén dentro del código, sino como variables de entorno en el archivo `.Renviron`, que en ningún caso se comparte en los repositorios (añadir a `.gitignore`). En este ejemplo ilustrativo se comparte para ver la estructura, faltaría añadir los datos reales en local para que funcione.

Si la aplicación va a utilizar otros archivos que deban ser accesibles desde la aplicación (por ejemplo, una imagen con el logotipo de la aplicación), en la función `onLoad()` se incluye también el código necesario para acceder a estos archivos, que estarán dentro de la carpeta `inst` del paquete.
