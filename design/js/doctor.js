const express = require('express');
const client = require('./db'); // Asegúrate de que este archivo existe y exporta el cliente de PostgreSQL
const router = express.Router();

// Ruta para obtener la lista de doctores
router.get('/doctores', async (req, res) => {
    try {
        const doctorListQuery = `
            SELECT d.id_doctor, u.nombre, u.apellido
            FROM doctor d
            JOIN usuario u ON d.id_usuario = u.id_usuario
            ORDER BY d.id_doctor;
        `;
        const doctorListResult = await client.query(doctorListQuery);
        res.json(doctorListResult.rows);
    } catch (err) {
        console.error('Error al obtener doctores:', err.message);
        res.status(500).json({ error: 'Error al obtener doctores' });
    }
});

router.get('/:id_usuario', async (req, res) => {
    const { id_usuario } = req.params;

    try {
        const doctorQuery = `
            SELECT d.exequatur, ARRAY_AGG(e.especialidad) AS especialidades
            FROM doctor d
            JOIN doctor_especialidad de ON d.id_doctor = de.id_doctor
            JOIN especialidad e ON de.id_especialidad = e.id_especialidad
            WHERE d.id_usuario = $1
            GROUP BY d.exequatur
        `;

        const doctorResult = await client.query(doctorQuery, [id_usuario]);

        if (doctorResult.rows.length > 0) {
            res.status(200).json(doctorResult.rows[0]); 
        } else {
            res.status(404).json({ message: 'Doctor no encontrado' });
        }
    } catch (error) {
        console.error('Error al obtener los datos del doctor', error);
        res.status(500).json({ message: 'Error al obtener los datos del doctor' });
    }
});



module.exports = router;
