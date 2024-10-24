const express = require('express');
const client = require('./db');
const router = express.Router();

router.get('/doctoresAsociados/:userId', async (req, res) => {
    const userId = req.params.userId; 

    const query = `
        SELECT d.id_doctor, u.nombre, u.apellido
        FROM doctor d
        INNER JOIN usuario u ON d.id_usuario = u.id_usuario
        LEFT JOIN asistente_doctor ad ON d.id_doctor = ad.id_doctor
        WHERE ad.id_usuario = $1
    `;

    try {
        const result = await client.query(query, [userId]);

        console.log('Resultados de la consulta:', result.rows);

        res.json(result.rows);
    } catch (error) {
        console.error('Error al obtener doctores:', error);
        res.status(500).send('Error al obtener doctores');
    }
});

module.exports = router;

