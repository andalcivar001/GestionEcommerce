# Sistema Administrativo de Comercio Electronico

Aplicacion Flutter orientada a la gestion operativa de una tienda online. El proyecto permite administrar autenticacion de usuarios, perfil, categorias, subcategorias, productos, clientes, pedidos y pagos, integrando una arquitectura basada en `BLoC`, casos de uso e inyeccion de dependencias.

## Descripcion General

Este sistema fue construido para centralizar las tareas mas comunes de un ecommerce en una sola aplicacion:

- Inicio de sesion y registro de usuarios.
- Actualizacion de perfil e informacion personal.
- Gestion de categorias y subcategorias.
- Registro, edicion, consulta y eliminacion de productos.
- Gestion de clientes.
- Creacion y administracion de pedidos.
- Registro y consulta de pagos por pedido.
- Escaneo de codigos con QR o barras.
- Generacion e impresion de documentos PDF.

Su enfoque principal es ofrecer una experiencia administrativa clara, moderna y agil para equipos que necesiten operar una tienda virtual desde una app multiplataforma.

## Caracteristicas Principales

- Interfaz desarrollada en Flutter con enfoque mobile-first.
- Manejo de estado con `flutter_bloc`.
- Arquitectura por capas: `presentation`, `domain`, `data` y `di`.
- Inyeccion de dependencias con `get_it` e `injectable`.
- Persistencia local de sesion con `shared_preferences`.
- Consumo de servicios remotos HTTP.
- Carga y captura de imagenes con `image_picker`.
- Geolocalizacion y geocodificacion para direccionamiento.
- Escaneo de codigos con `mobile_scanner`.
- Exportacion e impresion de comprobantes en PDF.

## Modulos del Sistema

### 1. Autenticacion

- Inicio de sesion.
- Registro de nuevos usuarios.
- Almacenamiento local de sesion.
- Cierre de sesion.

### 2. Perfil

- Actualizacion de nombre, telefono y fecha de nacimiento.
- Cambio de imagen de perfil.

### 3. Categorias y Subcategorias

- Creacion, actualizacion, listado y eliminacion.
- Relacion entre categorias y subcategorias.

### 4. Productos

- Creacion y edicion de productos.
- Busqueda y consulta.
- Asociacion con categoria y subcategoria.
- Soporte para imagenes y codigo alterno.

### 5. Clientes

- Registro y actualizacion de clientes.
- Seleccion de provincia y ciudad.

### 6. Pedidos

- Creacion de pedidos.
- Seleccion de cliente.
- Agregado de productos.
- Consulta de pedidos por usuario.
- Visualizacion de detalle.

### 7. Pagos de Pedidos

- Registro de pagos por orden.
- Edicion y eliminacion de pagos.
- Consulta por orden.
- Integracion con metodos de pago y entidades financieras.

### 8. Utilidades

- Escaner QR y de codigo de barras.
- Generacion de PDF.
- Toasts y dialogos de confirmacion.

## Manual de Usuario

### Objetivo del sistema

La aplicacion permite gestionar de forma centralizada los elementos esenciales de una tienda online, desde el acceso del usuario hasta el registro de pedidos y pagos.

### Flujo basico de uso

1. Iniciar sesion con una cuenta registrada.
2. Acceder al panel principal.
3. Gestionar catalogo, clientes y pedidos segun el rol o flujo operativo definido en backend.
4. Registrar pagos asociados a los pedidos.
5. Consultar informacion actualizada desde los listados y formularios del sistema.

### Funcionalidades para el usuario final o administrativo

#### Inicio de sesion

- El usuario ingresa su correo y contrasena.
- Si las credenciales son correctas, accede al modulo principal.
- La sesion puede mantenerse usando almacenamiento local.

#### Registro de usuario

- Permite crear una cuenta nueva con datos personales.
- Solicita nombre, correo, telefono, contrasena y fecha de nacimiento.

#### Gestion de perfil

- El usuario puede actualizar sus datos personales.
- Puede cambiar su foto de perfil.

#### Gestion de categorias

- Permite crear nuevas categorias para organizar productos.
- Desde el listado se pueden editar o eliminar registros existentes.

#### Gestion de subcategorias

- Permite vincular subcategorias a una categoria principal.
- Facilita una clasificacion mas detallada del catalogo.

#### Gestion de productos

- Permite registrar productos con informacion comercial y organizativa.
- Se pueden consultar, modificar o eliminar desde el listado.

#### Gestion de clientes

- Permite registrar clientes para asociarlos a pedidos.
- Incluye datos personales y ubicacion.

#### Gestion de pedidos

- Permite crear pedidos para clientes.
- Se pueden agregar productos al pedido.
- Incluye consulta y seguimiento del pedido.

#### Gestion de pagos

- Permite registrar pagos relacionados a una orden.
- Incluye entidad financiera y metodo de pago cuando aplica.
- Facilita llevar el control del estado financiero del pedido.

### Perfil de usuario recomendado

Este sistema esta orientado a:

- Administradores de tienda.
- Personal operativo o comercial.
- Usuarios que necesiten controlar catalogo, clientes y pedidos desde una sola app.

## Manual Tecnico

### Tecnologias utilizadas

- Flutter
- Dart
- `flutter_bloc`
- `get_it`
- `injectable`
- `shared_preferences`
- `http`
- `image_picker`
- `geolocator`
- `geocoding`
- `mobile_scanner`
- `pdf`
- `printing`

### Estructura del proyecto

El proyecto sigue una organizacion por capas:

```text
lib/
  main.dart
  injection.dart
  src/
    data/
    di/
    domain/
    presentation/
```

#### `presentation`

Contiene la interfaz de usuario, paginas, widgets, estados BLoC y eventos.

#### `domain`

Contiene modelos, contratos de repositorio y casos de uso.

#### `data`

Contiene implementaciones de repositorios, datasources locales y servicios remotos.

#### `di`

Contiene la configuracion del modulo de inyeccion de dependencias.

### Arquitectura

La aplicacion utiliza una arquitectura basada en capas y responsabilidades separadas:

1. La capa `presentation` interactua con `Bloc`.
2. Los `Bloc` consumen `UseCases`.
3. Los `UseCases` dependen de interfaces de repositorio.
4. La capa `data` implementa esos repositorios y se comunica con servicios remotos o almacenamiento local.

Este enfoque mejora la mantenibilidad, facilita pruebas y permite escalar modulos de forma ordenada.

### Manejo de estado

El proyecto usa `flutter_bloc` para:

- Manejar eventos de interfaz.
- Validar formularios.
- Controlar estados de carga, exito y error.
- Desacoplar la logica de negocio de la UI.

La inicializacion global de blocs se realiza desde [BlocProviders.dart](/c:/proyectoFlutter/pruebas/frontend/ecommerce_prueba/lib/src/presentation/BlocProviders.dart).

### Inyeccion de dependencias

La app usa `get_it` e `injectable` para registrar:

- Servicios remotos.
- Repositorios.
- Casos de uso.
- Dependencias compartidas como almacenamiento local y token de sesion.

Archivos principales:

- [injection.dart](/c:/proyectoFlutter/pruebas/frontend/ecommerce_prueba/lib/injection.dart)
- [appModule.dart](/c:/proyectoFlutter/pruebas/frontend/ecommerce_prueba/lib/src/di/appModule.dart)

Cuando se hagan cambios en las dependencias inyectables, regenerar los archivos con:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

Durante desarrollo tambien puede usarse:

```bash
flutter pub run build_runner watch --delete-conflicting-outputs
```

### Rutas principales

Las rutas registradas actualmente incluyen:

- `login`
- `register`
- `home`
- `profile/info`
- `category/form`
- `subcategory/form`
- `product/form`
- `client/form`
- `order/form`
- `qrScanner`
- `order/payment/list`
- `order/payment/form`

Estas rutas se configuran en [main.dart](/c:/proyectoFlutter/pruebas/frontend/ecommerce_prueba/lib/main.dart).

## Requisitos Previos

Antes de ejecutar el proyecto, asegurese de tener instalado:

- Flutter SDK
- Dart SDK
- Android Studio o Visual Studio Code
- Un emulador Android, simulador iOS o dispositivo fisico

Verifique la instalacion con:

```bash
flutter doctor
```

## Instalacion y Ejecucion

### 1. Clonar el repositorio

```bash
git clone <URL_DEL_REPOSITORIO>
cd ecommerce_prueba
```

### 2. Instalar dependencias

```bash
flutter pub get
```

### 3. Generar archivos de inyeccion

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### 4. Ejecutar la aplicacion

```bash
flutter run
```

### 5. Compilar version release

```bash
flutter build apk --release
```

## Configuracion de Permisos

### Android

Para conexiones HTTP y HTTPS en ciertos escenarios, validar que el manifiesto incluya:

```xml
<uses-permission android:name="android.permission.INTERNET" />
```

Y si el backend requiere trafico no cifrado:

```xml
android:usesCleartextTraffic="true"
```

### iOS

Para acceso a galeria y camara, agregar en `ios/Runner/Info.plist`:

```xml
<key>NSPhotoLibraryUsageDescription</key>
<string>Requiere permisos para acceder a la galeria de fotos</string>
<key>NSCameraUsageDescription</key>
<string>Requiere permisos para acceder a la camara</string>
```

## Dependencias Relevantes

### Productividad y arquitectura

- `flutter_bloc`: manejo de estado.
- `injectable`: generacion de registros de dependencias.
- `get_it`: contenedor de dependencias.
- `equatable`: comparacion eficiente de estados y modelos.

### Datos y almacenamiento

- `http`: consumo de APIs.
- `shared_preferences`: persistencia local de sesion.
- `collection`: utilidades para colecciones.

### Multimedia y dispositivos

- `image_picker`: camara y galeria.
- `mobile_scanner`: lectura de QR y codigos.
- `vibration`: retroalimentacion fisica.

### Ubicacion

- `geolocator`: obtencion de coordenadas.
- `geocoding`: traduccion de coordenadas a ubicaciones.

### Reportes

- `pdf`: construccion de documentos PDF.
- `printing`: impresion y vista previa.

### Utilidades

- `intl`: formateo de fechas y valores.
- `path`: manejo de rutas de archivos.

## Consideraciones Tecnicas

- La sesion del usuario se almacena localmente y se reutiliza para recuperar el token.
- La configuracion de servicios depende de la inyeccion definida en `appModule.dart`.
- El proyecto trabaja con formularios validados desde `Bloc` y `BlocFormItem`.
- Algunas funcionalidades dependen de backend y disponibilidad de endpoints remotos.
- El comportamiento exacto de roles y permisos depende de la API conectada al sistema.

## Posibles Mejoras Futuras

- Documentacion de endpoints consumidos.
- Capturas de pantalla del sistema.
- Pruebas unitarias y de integracion.
- Configuracion por ambientes (`dev`, `qa`, `prod`).
- Manejo de variables sensibles mediante archivos de configuracion seguros.
- Publicacion automatizada con CI/CD.

## Autor

Desarrollado por Andres Alcivar.  
Todos los derechos reservados 2026.
