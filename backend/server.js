require('dotenv').config();
const express = require('express');
const cors = require('cors');
const db = require('./src/config/db'); // Importar conexión a BD

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(cors());
app.use(express.json());

// Routes
app.get('/api/health', (req, res) => {
    res.json({ 
        status: "ok", 
        message: "API funcionando",
        timestamp: new Date().toISOString()
    });
});

// Start server
app.listen(PORT, () => {
    console.log(`\n🚀 Servidor corriendo en el puerto ${PORT}`);
    console.log(`➜  Local:   http://localhost:${PORT}`);
    console.log(`➜  Health:  http://localhost:${PORT}/api/health\n`);
});
