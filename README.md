# 🏥 Sistema de Gestión Clínica Veterinaria SENA

Este es un proyecto Full Stack desarrollado como parte del programa de Análisis y Desarrollo de Software. Implementa una arquitectura cliente-servidor utilizando **Node.js/Express** para el backend y **React/Vite** para el frontend, con persistencia de datos en **MySQL**.

## 📋 Características Principales

- **API RESTful** completa con Node.js y Express.
- **Autenticación JWT** (JSON Web Tokens) segura.
- **CRUD de Usuarios** (Crear, Leer, Actualizar, Eliminar).
- **Frontend Moderno** con React, Tailwind CSS y Lucide Icons.
- **Gestión de Estado** con Context API.
- **Base de Datos Relacional** MySQL.

---

## 🚀 Guía de Instalación y Configuración

Sigue estos pasos para poner en marcha el proyecto en tu entorno local.

### 1. Prerrequisitos

Asegúrate de tener instalado:
- [Node.js](https://nodejs.org/) (v18 o superior recomendado)
- [MySQL Server](https://dev.mysql.com/downloads/mysql/)
- [Git](https://git-scm.com/)

### 2. Configuración de la Base de Datos 🗄️

El script de creación de la base de datos se encuentra en la carpeta `database`.

1.  Abre tu cliente de MySQL favorito (MySQL Workbench, DBeaver, o línea de comandos).
2.  Localiza el archivo SQL en este proyecto:
    ```
    database/Crud_Usuarios_Clinic.sql
    ```
3.  Ejecuta el contenido de este script para crear la base de datos `Crud_Usuarios_Clinic` y la tabla `usuario`.
4.  El script también inserta un usuario administrador por defecto:
    - **Email:** `admin@clinicaveterinaria.com`
    - **Password:** `admin123`

### 3. Configuración del Backend (Servidor) 🖥️

1.  Navega a la carpeta del backend:
    ```bash
    cd backend
    ```
2.  Instala las dependencias:
    ```bash
    npm install
    ```
3.  Crea un archivo `.env` en la raíz de la carpeta `backend` con tus credenciales de base de datos:
    ```env
    PORT=3000
    DB_HOST=localhost
    DB_USER=tu_usuario_mysql
    DB_PASSWORD=tu_contraseña_mysql
    DB_NAME=Crud_Usuarios_Clinic
    JWT_SECRET=tu_clave_secreta_super_segura
    ```
4.  Inicia el servidor en modo desarrollo:
    ```bash
    npm run dev
    ```
    *El servidor correrá en `http://localhost:3000`*

### 4. Configuración del Frontend (Cliente) 💻

1.  Abre una nueva terminal y navega a la carpeta del frontend:
    ```bash
    cd frontend
    ```
2.  Instala las dependencias:
    ```bash
    npm install
    ```
3.  Inicia la aplicación de React:
    ```bash
    npm run dev
    ```
    *La aplicación se abrirá en `http://localhost:5173`*

---

## 🧪 Probando la Aplicación

1.  Abre tu navegador en `http://localhost:5173`.
2.  Inicia sesión con las credenciales de administrador:
    - **Usuario:** `admin@clinicaveterinaria.com`
    - **Contraseña:** `admin123`
3.  Navega a la sección **"Usuarios"** para probar el CRUD:
    - **Crear:** Usa el botón "Nuevo Usuario" para abrir el panel lateral.
    - **Leer:** Verás la lista de usuarios cargada desde MySQL.
    - **Actualizar:** Usa el botón de lápiz para editar.
    - **Eliminar:** Usa el botón de basura para borrar (con confirmación).
    - **Estado:** Cambia el switch de activo/inactivo directamente en la tabla.

## 🛠️ Tecnologías Utilizadas

- **Backend:** Node.js, Express, MySQL2, JWT, BcryptJS, Cors.
- **Frontend:** React, Vite, TypeScript, Tailwind CSS, Axios, React Router DOM.
- **Herramientas:** Postman (para pruebas de API), Git.

## 📄 Estructura del Proyecto

```
clinica-veterinaria-sena/
├── backend/                # Servidor Node.js
│   ├── src/
│   │   ├── config/         # Configuración DB
│   │   ├── controllers/    # Lógica de negocio
│   │   ├── routes/         # Definición de endpoints
│   │   └── ...
│   └── server.js           # Punto de entrada
├── frontend/               # Cliente React
│   ├── src/
│   │   ├── components/     # Componentes UI (TablaUsuarios, Login...)
│   │   ├── context/        # AuthContext
│   │   └── ...
│   └── ...
└── database/               # Scripts SQL
    └── Crud_Usuarios_Clinic.sql
```

---
Desarrollado para la recuperación de Node.js - SENA 2025.
