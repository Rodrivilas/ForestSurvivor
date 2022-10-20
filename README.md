Forest Survivor - 2do Parcial

Rodrigo Viladegut Alurralde 51113
Luciano Paniagua Mallea 52334

El videojuegojuego que desarrollamos se basa en un tipico juego de plataformas en el motor grafico de Godot, que cuenta con un personaje principal, enemigos que se mueven por el mapa, monedas que son parte del objetivo del personaje principal y el mapa. Para ejecutar el proyecto solo se debe ejecutar el archivo .exe, y si se quiere ver el código, debemos descargar e importar el proyecto de Github al Godot local.

Al comenzar a jugar, el usuario debe recolectar todas las monedas del mapa evitando morir. Este morirá si los enemigos chocan con el personaje prinicpal o si este cae fuera del mapa. Si es que este muere, se debera poner pausa con el botón ESC y reiniciar el juego, tambien entramos a pantalla completa con F11. El personaje principal podrá matar a los enemigos con su habilidad de disparo, la cual funciona con la tecla SPACE o boton izquierdo del mouse.

Para las animaciones usamos los tipicos AnimationPlayer y los organizamos en un AnimationTree, para que estas animaciones estes respectivamente organizadas y sean responsivas a lo que pase en pantalla.
Luego usamos Sprites y Collisions shapes para hacer las colisiones, ademas de usar el RayCast2D para que cada personaje este ubicado correctamente sobre el poligono que es el mapa. Esta parte ademas usa layers para saber con que debe interactuar.



