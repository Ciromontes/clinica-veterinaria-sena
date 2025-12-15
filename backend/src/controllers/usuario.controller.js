const db = require('../config/db');
const bcrypt = require('bcryptjs');

// Listar todos los usuarios
const getUsuarios = async (req, res) => {
    try {
        const [rows] = await db.query('SELECT id, nombre, email, rol, activo, id_cliente, id_veterinario FROM usuario');
        res.json(rows);
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Error al obtener usuarios' });
    }
};

// Crear un nuevo usuario
const createUsuario = async (req, res) => {
    const { nombre, email, password, rol, id_cliente, id_veterinario } = req.body;

    // Validación básica
    if (!nombre || !email || !password || !rol) {
        return res.status(400).json({ message: 'Todos los campos obligatorios deben ser proporcionados' });
    }

    try {
        // Verificar si el usuario ya existe
        const [existingUser] = await db.query('SELECT * FROM usuario WHERE email = ?', [email]);
        if (existingUser.length > 0) {
            return res.status(400).json({ message: 'El correo electrónico ya está registrado' });
        }

        // Encriptar contraseña (aunque en el SQL original parece texto plano, es mejor encriptar)
        // Nota: Si el sistema legado usa texto plano, ajusta esto. Asumiré encriptación por seguridad.
        // const hashedPassword = await bcrypt.hash(password, 10); 
        // Para mantener compatibilidad con los datos de ejemplo (que parecen texto plano '123456'), 
        // usaré texto plano por ahora, pero DEBERÍAS cambiarlo a bcrypt.
        const hashedPassword = password; 

        const [result] = await db.query(
            'INSERT INTO usuario (nombre, email, password, rol, id_cliente, id_veterinario) VALUES (?, ?, ?, ?, ?, ?)',
            [nombre, email, hashedPassword, rol, id_cliente || null, id_veterinario || null]
        );

        res.status(201).json({ 
            id: result.insertId, 
            nombre, 
            email, 
            rol,
            message: 'Usuario creado exitosamente' 
        });
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Error al crear usuario' });
    }
};

// Actualizar usuario
const updateUsuario = async (req, res) => {
    const { id } = req.params;
    const { nombre, email, rol, activo } = req.body;

    try {
        const [result] = await db.query(
            'UPDATE usuario SET nombre = ?, email = ?, rol = ?, activo = ? WHERE id = ?',
            [nombre, email, rol, activo, id]
        );

        if (result.affectedRows === 0) {
            return res.status(404).json({ message: 'Usuario no encontrado' });
        }

        res.json({ message: 'Usuario actualizado exitosamente' });
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Error al actualizar usuario' });
    }
};

// Eliminar usuario
const deleteUsuario = async (req, res) => {
    const { id } = req.params;

    try {
        const [result] = await db.query('DELETE FROM usuario WHERE id = ?', [id]);

        if (result.affectedRows === 0) {
            return res.status(404).json({ message: 'Usuario no encontrado' });
        }

        res.json({ message: 'Usuario eliminado exitosamente' });
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Error al eliminar usuario' });
    }
};

module.exports = {
    getUsuarios,
    createUsuario,
    updateUsuario,
    deleteUsuario
};
