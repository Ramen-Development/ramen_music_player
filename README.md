# ramen_music_player

Music player using Flutter and Firebase

Using [just_audio](https://pub.dev/packages/just_audio) for audio functions.

## Instrucciones de uso
### Inicio de sesión
Al entrar ([Deploy aquí](https://ramen-development.github.io/ramen_music_player/)), veremos una pagina de inicio de sesión con varias maneras de ingresar
- Con tu cuenta previamente creada para Ramen Music Player
- Usando Facebook
- Usando Google
![Screenshot_20220509_210730](https://user-images.githubusercontent.com/47061294/167528023-fc255146-bbf1-4d7e-998b-ce0bce71c06c.png)  
### Registro interno
En caso de aun no tener cuenta propia dentro de nuestra plataforma puede ser creada desde el botón "New Ramen user? create account!", el cual al ser cliqueado te llevará a un sitio de registro.  
**No es necesario crear una cuenta desde este apartado si se desea ingresar con Google o con Facebook**
![Screenshot_20220509_211502](https://user-images.githubusercontent.com/47061294/167528799-6ec9e7f8-6f40-477f-bb54-e462574744ec.png)  
En esta sección hay que ingresar:
- Un nombre
- Correo electronico (se necesitará validar posteriormente)
- Contraseña
Al crear una cuenta con nosotros recibirás un correo electronico para confirmar la dirección registrada, de no ser validada la cuenta, se mostrará un aviso invitando a su activación dentro del sistema.
### Reestablecimiento de contraseña
En caso de haber olvidado tu contraseña, puedes reestablecerla dando clic al botón de "Forgot password?" dentro de la pantalla de inicio de sesión, esto activará un pop-up en el cual habrá que ingresar la dirección de correo electronico vinculada con nuestro sistema.  
**Este apartado solamente funciona con cuentas creadas por medio de nuestro sistema, no con cuentas de terceros (Facebook, Google)**
![Screenshot_20220509_211711](https://user-images.githubusercontent.com/47061294/167529282-9eb50abc-310f-4b01-b738-e53baf083804.png)  
Tras escribir el correo en este apartado recibiremos un correo electronico con las instrucciones para concluir con el reestablecimiento y poder ingresar nuevamente al sistema
### Uso del sistema
Una vez dentro del sistema, veremos una pantalla como la siguiente:
![Screenshot_20220509_212136](https://user-images.githubusercontent.com/47061294/167529809-58ccfe21-4f4f-4c42-b98d-93b9b88f7128.png)  
Esta pantalla tiene 6 partes escenciales que exploraremos a continuación
1. Lista de canciones
2. Datos de la canción actual
3. Controles de reproducción
4. Control de volumen
5. Menú de listas
6. Botón para cerrar sesión
#### 1. Lista de canciones
![image](https://user-images.githubusercontent.com/47061294/167530143-f373a649-01a7-450a-bbdd-2a3f323aee8e.png)  
En este apartado encontraremos el listado de las canciones en cola en la actual lista de reproducción seleccionada, podemos desplazarnos de arriba abajo para seleccionar la canción que deseemos escuchar
#### 2. Datos de la canción actual
![image](https://user-images.githubusercontent.com/47061294/167530342-57b44476-cd87-4fee-8653-23070df16a2d.png)  
En este apartado podemos observar los datos de la canción que se está reproduciendo actualmente:
- La foto de portada del disco
- El nombre de la canción
- Los nombres de artistas que participan en la canción
#### 3. Controles de reproducción
![image](https://user-images.githubusercontent.com/47061294/167530480-4f476de7-613b-4ce0-a063-3fbbb0813ae3.png)  
En este apartado podemos:
- Dar play/pausa a la canción actual
- Observar y manipular la posición de la canción arrastrando o dando clic en la barra de progreso
- Conocer cuanto dura y cuanto ha progresado la canción
- Ir a la canción siguiente/anterior
- Ciclar entre modo aleatorio y secuencial
- Ciclar entre no repetir, repetir toda la lista o repetir una sola canción
#### 4. Control de volumen
![image](https://user-images.githubusercontent.com/47061294/167530896-4b0a3771-ed95-436c-b84b-a3454ac4c2f2.png)  
En este apartado podemos deslizar el control para aumentar o reducir el volumen de la musica y al dar clic al icono de volumen, silenciar o reactivar el volumen de la musica  
**Apartado no disponible en la versión móvil**
#### 5. Menú de listas
Al dar clic en el botón situado en la parte superior izquierda abriremos el siguiente menú:  
![image](https://user-images.githubusercontent.com/47061294/167531083-c70fb4fd-4e9a-4477-a865-fb0fb3ad1547.png)  
Este menú nos presenta las listas de reproducción actualmente existentes y al elegir alguna veremos esa lista de canciones en nuestra vista principal, de la misma manera se actualizará la lista actual del reproductor y sus datos correspondientes.
#### 6. Botón para cerrar sesión
![image](https://user-images.githubusercontent.com/47061294/167531233-75bbc6d6-704b-414b-819e-48b756ce430c.png)  
Este botón situado en la parte superior derecha de la pantalla nos permite cerrar sesión correctamente.
En caso de no presionarlo se mantendrá nuestra sesión abierta la proxima vez que utilice nuestro sistema.
