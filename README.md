# Recetas
Esta aplicación muestra diferentes recetas de platos conocidos en el mundo. Conectándose a un servidor remoto la aplicación puede ofrecerte lo básico para conocer mucho acerca recetas universales.

## Funcionalidades principales
 - **Filtra** los resultados por nombre e ingredientes.
 - **Detalla** las recetas con descripción, ingredientes y preparación.
 - **Amplia** la fotografía desde el detalle de la receta.
 - **Ubica** en un mapa el origen geográfico aproximado de la receta y lo señala con un marcador.

## Requerimientos
- Xcode 14 
- Cocoapods
- iOS 15+

## Arquitectura
Se utilizó **MVVM** y se implementaron pruebas unitarias mayormente en los ViewModels alcanzando +80% de covertura.


## Extensiones de terceros

A continuación se nombran las **extensiones de terceros** que se utilizan por medio de cocoapods. Para utilizar este repositorio debes instalar Cocoapods. [Haz clic aquí para instalar Cocoapods](https://cocoapods.org/#install). 

- Alamofire: Conectándose a un servidor remoto REST por medio Alamofire obtenemos las recetas. Los datos son manejados en una capa que instancia Alamofire que es la clase **NetworkCall**. Así las peticiones son realizadas hacia el backend y viceversa.
- SDWebImage: Útil para realizar peticiones asíncronas y obtener imágenes desde urls remotas, además cuenta con otras características en la utilería con imágenes.
- NVActivityIndicatorView: Utilizado para hacer configurar un agradable número de animaciones de indicadores de carga. Integrado en la aplicación fue utilizado para indicar durante las peticiones o momentos de carga de la aplicación.

## Patrones de diseño
Se utilizó la combinación y adaptación de patrones de diseño conocidos como:
- Singleton
- Cadena de responsabilidades
- Factory

## Otras características
- Aparte de los mocks para las pruebas en la aplicación se utilizó [mockable.io](https://www.mockable.io/) para disponibilizar los datos via REST.
- Fácil recarga deslizando hacia abajo en la vista principal.
- Compatible en dark mode
- Genera un mensaje cuando no hay conexión a internet durante las peticiones de red.

