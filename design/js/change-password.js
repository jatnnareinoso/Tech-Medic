const express = require('express');
const router = express.Router();
const pool = require('./db'); 

router.post('/change-password', async (req, res) => {
    const { userId, currentPassword, newPassword } = req.body;  

    try {
        const result = await pool.query('SELECT password, id_tipo_usuario FROM usuario WHERE id_usuario = $1', [userId]);

        if (result.rows.length === 0) {
            return res.status(404).json({ message: 'Usuario no encontrado' });
        }

        const user = result.rows[0];

        if (currentPassword !== user.password) {
            return res.status(400).json({ message: 'Contraseña actual incorrecta' });
        }

        await pool.query('UPDATE usuario SET password = $1 WHERE id_usuario = $2', [newPassword, userId]);

        res.status(200).json({ message: 'Contraseña cambiada exitosamente', id_tipo_usuario: user.id_tipo_usuario });
    } catch (error) {
        console.error('Error al cambiar la contraseña:', error);
        res.status(500).json({ message: 'Error interno del servidor' });
    }
});

module.exports = router;
