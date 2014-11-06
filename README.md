Acortador de Urls y Estadisticas ![travis](https://travis-ci.org/alu0100700435/my-tiny-url.svg?branch=master)
=========
Sistemas y Tecnologías web
---------------------------

### Objetivo

Hacer que la aplicacion [My Tiny Url], creada con anterioridad, ofrezca estadisticas de las urls acortadas. Mostrando el numero de visitas totales, por día, y por paises. También se incluyen las estadisticas por región, y ofrece un mapa de localización de las visitas. 

Para poder implementar los graficos estadisticos se usará [chartkick], la cual esta implementada en JavaScript.

###Funcionamiento

Hay dos formas posibles de ver el funcionamiento de la aplicación, una mediante la web, gracias a Heroku, y otra desde local.

1. Visualización en Heroku
    
    Para poder ver la aplicación en dicha plataforma, haz click [aquí].
    Una vez ahí acorta tu url, o si quieres guardarlas ¡registrate!, lo podrás hacer mediante Google, Github o Facebook o twitter.

2. Visualización en local

    Primero se ha de clonar el repositorio de github [my-tiny-url], de la siguiente forma: 
    
    ```sh
    user@ubuntu-hp:~$ git clone git@github.com:alu0100700435/my-tiny-url.git
    ```
    Una vez clonado el repositorio, y situado en el directorio, modifique el archivo config_filled.yml con sus claves(recomendado). Y a continuación ejecuta bundler:
    
    ```sh
    user@ubuntu-hp:~/my-tiny-url$ bundle install
    ```
    
    Una vez hecho todo lo anterior, procede a ejecutar *rake server*, y por defecto se empezará a ejecutar.
    
    Una vez en ejecución, abre el navegador y escribe en la barra de direcciones *localhost:9292* y accederás a la web de la aplicación:
    
    ![ejemplo navegador](https://raw.githubusercontent.com/alu0100700435/my-tiny-url/gh-pages/public/img/ejemplo.png)
    
Y una vez acortadas, mira las estadisticas!
    
    
[chartkick]:http://ankane.github.io/chartkick/
[aquí]:http://my-tiny-url-2.herokuapp.com
[my-tiny-url]:https://github.com/alu0100700435/my-tiny-url.git
[My Tiny Url]://my-tiny-url.herokuapp.com
