Inventario Web
Inventario Web es una aplicación desarrollada en Django que permite gestionar el inventario de productos. Ofrece funcionalidades para registrar productos, realizar movimientos de entrada y salida, y visualizar el historial de movimientos, todo asociado al stock de cada producto.

Características
Gestión de productos:
Crear, editar, eliminar (lógicamente) y restaurar productos.
Gestión de movimientos:
Registrar movimientos de entrada y salida de productos.
Validación de stock para salidas (no permite registrar si no hay suficiente inventario).
Reportes:
Exportación de productos y movimientos en formato CSV y PDF.
Sistema de autenticación para acceso seguro.
Interfaz amigable con soporte para vistas JSON.
Requisitos
Python 3.12 o superior.
MySQL (o MariaDB) como base de datos.
Bibliotecas adicionales especificadas en requirements.txt.
Instalación
Clona este repositorio:

bash
Copiar código
git clone https://github.com/tu_usuario/tu_repositorio.git
cd tu_repositorio
Configura un entorno virtual:

bash
Copiar código
python -m venv venv
source venv/bin/activate # En Windows: venv\Scripts\activate
Instala las dependencias:

bash
Copiar código
pip install -r requirements.txt
Configura la base de datos en el archivo settings.py:

Establece las credenciales y el nombre de la base de datos en la sección DATABASES.
Aplica las migraciones:

bash
Copiar código
python manage.py migrate
Ejecuta el servidor:

bash
Copiar código
python manage.py runserver
Uso
Acceso: Ingresa a http://127.0.0.1:8000/ en tu navegador.
Gestión de productos:
Navega a la sección de productos para agregar o editar productos existentes.
Movimientos:
Registra movimientos de entrada o salida desde la página de detalles de cada producto.
Reportes:
Exporta datos de inventario desde las vistas de productos y movimientos.
Estructura de la Base de Datos
Tabla Producto
id: Identificador único.
nombre: Nombre del producto.
descripcion: Descripción detallada.
cantidad: Cantidad disponible en el inventario.
precio: Precio unitario.
imagen: Imagen opcional del producto.
is_active: Estado del producto (activo/inactivo).
Tabla MovimientoInventario
id: Identificador único.
producto: Relación con la tabla de productos.
tipo: Entrada o salida.
cantidad: Cantidad registrada en el movimiento.
fecha: Fecha y hora del movimiento.
responsable: Usuario que realizó el movimiento.
Contribuciones
¡Las contribuciones son bienvenidas! Por favor, abre un "Issue" o envía un "Pull Request" si deseas contribuir al proyecto.
