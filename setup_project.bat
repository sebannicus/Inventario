@echo off

echo Verificando Python...
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo Python no est├í instalado. Por favor, inst├ílalo antes de continuar.
    exit /b
)

echo Instalando pip si es necesario...
python -m ensurepip --upgrade

echo Creando un entorno virtual...
if not exist "venv" (
    python -m venv venv
) else (
    echo El entorno virtual ya existe. Usando el existente...
)

echo Activando el entorno virtual...
call venv\Scripts\activate

echo Actualizando pip...
pip install --upgrade pip

echo Instalando dependencias del proyecto...
pip install -r requirements.txt

echo Verificando e instalando mysqlclient...
pip show mysqlclient >nul 2>&1
if %errorlevel% neq 0 (
    echo Instalando mysqlclient...
    pip install mysqlclient
) else (
    echo mysqlclient ya est├í instalado.
)

echo Aplicando migraciones de la base de datos...
python manage.py migrate

echo ┬íEl proyecto est├í listo para ejecutarse!
pause
