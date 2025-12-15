const db = require('../config/db');
const jwt = require('jsonwebtoken');

const login = async (req, res) => {
    const { email, password } = req.body;

    if (!email || !password) {
        return res.status(400).json({ message: 'Por favor ingrese email y contraseña' });
    }

    try {
        // Buscar usuario por email
        const [users] = await db.query('SELECT * FROM usuario WHERE email = ?', [email]);

        if (users.length === 0) {
            return res.status(401).json({ message: 'Credenciales incorrectas' });
        }

        const user = users[0];

        // Verificar contraseña
        // NOTA: En un entorno real, las contraseñas deben estar hasheadas (ej. bcrypt).
        // Según los datos proporcionados, están en texto plano.
        if (password !== user.password) {
            return res.status(401).json({ message: 'Credenciales incorrectas' });
        }

        if (!user.activo) {
            return res.status(403).json({ message: 'Usuario inactivo. Contacte al administrador.' });
        }

        // Generar Token JWT
        const token = jwt.sign(
            { 
                id: user.id, 
                rol: user.rol, 
                nombre: user.nombre 
            },
            process.env.JWT_SECRET,
            { expiresIn: '8h' }
        );

        // Responder con token y datos del usuario
        res.json({
            message: 'Login exitoso',
            token,
            rol: user.rol,
            usuario: {
                id: user.id,
                nombre: user.nombre,
                email: user.email,
                rol: user.rol
            }
        });

    } catch (error) {
        console.error('Error en login:', error);
        res.status(500).json({ message: 'Error en el servidor' });
    }
};

module.exports = {
    login
};
