const express = require('express');
const client = require('./db'); // Asegúrate de que este archivo existe y exporta el cliente de PostgreSQL
const router = express.Router();
const sgMail = require('@sendgrid/mail');

router.get('/getIdDoctor', async (req, res) => {
    const { id_usuario } = req.query;
    
    // Verificar que id_usuario haya sido proporcionado
    if (!id_usuario) {
        return res.status(400).json({ message: 'ID de usuario es requerido' });
    }

    const idUsuarioInt = parseInt(id_usuario);
    if (isNaN(idUsuarioInt)) {
        return res.status(400).json({ message: 'ID de usuario inválido' });
    }

    try {
        if (!client._connected) {
            await client.connect();
        }

        const result = await client.query('SELECT id_doctor FROM doctor WHERE id_usuario = $1', [idUsuarioInt]);

        if (result.rows.length > 0) {
            console.log("Respuesta del servidor:", { id_doctor: result.rows[0].id_doctor }); // Log de la respuesta
            res.status(200).json({ id_doctor: result.rows[0].id_doctor });
        } else {
            res.status(404).json({ message: 'Doctor no encontrado' });
        }
    } catch (error) {
        console.error('Error al obtener id_doctor:', error.stack || error);
        res.status(500).json({ message: 'Error del servidor al obtener el ID del doctor' });
    }
});


router.get('/doctoresAsistentes', async (req, res) => {
    const { id_usuario } = req.query; // Cambiar de id_asistente a id_usuario

    // Verificar que id_usuario sea un número válido
    if (!id_usuario || isNaN(parseInt(id_usuario))) {
        return res.status(400).json({ message: 'ID de asistente inválido' });
    }

    try {
        const query = `
            SELECT d.id_doctor, u.nombre, u.apellido 
            FROM doctor d
            INNER JOIN usuario u ON d.id_usuario = u.id_usuario
            JOIN asistente_doctor ad ON d.id_doctor = ad.id_doctor
            WHERE ad.id_usuario = $1
        `;
        const result = await client.query(query, [parseInt(id_usuario)]); // Convertir a entero

        res.json(result.rows);
    } catch (error) {
        console.error('Error al obtener doctores asociados a asistente:', error.message);
        res.status(500).json({ message: 'Error del servidor' });
    }
});


router.get('/asistentesDoctor', async (req, res) => {
    const { id_doctor } = req.query;

    // Verificar que id_doctor sea un número válido
    if (!id_doctor || isNaN(parseInt(id_doctor))) {
        return res.status(400).json({ message: 'ID de doctor inválido' });
    }

    try {
        const query = `
            SELECT ad.id_us_doc, ad.id_usuario, u.nombre, u.apellido
            FROM asistente_doctor ad
            JOIN usuario u ON ad.id_usuario = u.id_usuario
            WHERE ad.id_doctor = $1
            AND u.id_tipo_usuario = 3
            AND ad.estado = true
        `;
        
        const result = await client.query(query, [parseInt(id_doctor)]); // Convertir a entero

        if (result.rows.length > 0) {
            res.json(result.rows); // Retorna los asistentes encontrados
        } else {
            res.json([]); // Retorna un array vacío si no hay asistentes
        }
    } catch (error) {
        console.error('Error al obtener asistentes asociados a doctor:', error.message);
        res.status(500).json({ message: 'Error al obtener los datos del doctor' });
    }
});

sgMail.setApiKey('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'); // Asegúrate de usar tu API Key de SendGrid

// Endpoint para agregar cita
router.post('/agregarCita', async (req, res) => {
    const { id_paciente, id_doctor, id_centro_medico, id_usuario, fecha_hora, estado, color } = req.body;

    // Validación de los campos obligatorios
    if (!id_paciente || !id_doctor || !id_centro_medico || !fecha_hora) {
        return res.status(400).json({ message: 'Todos los campos obligatorios deben ser completados' });
    }

    try {
        const query = `
            INSERT INTO cita (id_paciente, id_doctor, id_centro_medico, id_usuario, fecha_hora, estado, color)
            VALUES ($1, $2, $3, $4, $5, $6, $7) RETURNING *
        `;
        const values = [id_paciente, id_doctor, id_centro_medico, id_usuario || null, fecha_hora, estado, color];
        const result = await client.query(query, values);

        if (result.rows.length > 0) {
            // Cita agregada correctamente, ahora enviamos el correo
            const cita = result.rows[0];

            // Obtener información del paciente y doctor
            const pacienteQuery = await client.query('SELECT nombre, apellido, correo FROM paciente WHERE id_paciente = $1', [id_paciente]);
            const doctorQuery = await client.query('SELECT u.nombre AS nombre_doctor, u.apellido AS apellido_doctor FROM doctor d JOIN usuario u ON d.id_usuario = u.id_usuario WHERE d.id_doctor = $1', [id_doctor]);

            const nombreCompletoPaciente = `${pacienteQuery.rows[0].nombre} ${pacienteQuery.rows[0].apellido}`;
            const correoPaciente = pacienteQuery.rows[0].correo;
            const nombreCompletoDoctor = `${doctorQuery.rows[0].nombre_doctor} ${doctorQuery.rows[0].apellido_doctor}`;

            // Extraer fecha y hora en un formato adecuado
            const fechaCita = new Date(fecha_hora).toLocaleDateString();
            const horaCita = new Date(fecha_hora).toLocaleTimeString();

            // Solo enviar correo si el paciente tiene un correo registrado
            if (correoPaciente) {
                // Enviar el correo usando la función enviarCorreo
                await enviarCorreo({
                    correoPaciente,
                    nombreCompletoPaciente,
                    nombreCompletoDoctor,
                    fechaCita,
                    horaCita
                });
                res.status(201).json({ message: 'Cita agregada y correo enviado correctamente' });
            } else {
                res.status(201).json({ message: 'Cita agregada, pero el paciente no tiene un correo registrado' });
            }
        } else {
            res.status(400).json({ message: 'Error al agregar la cita' });
        }
    } catch (error) {
        console.error('Error al agregar la cita:', error.message);
        res.status(500).json({ message: 'Error al agregar la cita' });
    }
});

// Función para enviar correo usando SendGrid
async function enviarCorreo({ correoPaciente, nombreCompletoPaciente, nombreCompletoDoctor, fechaCita, horaCita }) {
    const mensaje = {
        to: correoPaciente, // Correo del paciente
        from: 'tecnologiamedicinaltechmedic@gmail.com', // Correo desde el cual se envía
        subject: 'TechMedic - Cita Agendada',
        text: `Hola ${nombreCompletoPaciente}, se ha agendado una cita. \n\nDoctor: ${nombreCompletoDoctor}\nFecha: ${fechaCita}\nHora: ${horaCita}`,
        html: `<p>Hola <strong>${nombreCompletoPaciente}</strong>,</p>
               <p>Tiene una cita agendada en la Clínica Baez Soto & Especialidades, con el <strong>Dr. ${nombreCompletoDoctor}</strong>.<br>
               <strong>Fecha:</strong> ${fechaCita}<br>
               <strong>Hora:</strong> ${horaCita}</p>
               <p>Saludos,<br>Equipo de TechMedic</p>`
    };

    try {
        await sgMail.send(mensaje);
        console.log('Correo enviado correctamente a:', correoPaciente);
    } catch (error) {
        console.error('Error al enviar el correo:', error);
    }
}




router.get('/citasUsuario', async (req, res) => {
    const { id_usuario } = req.query;

    // Verificar que id_usuario sea un número válido
    if (!id_usuario || isNaN(parseInt(id_usuario))) {
        return res.status(400).json({ message: 'ID de usuario inválido' });
    }

    try {
        const query = `
            SELECT 
                c.id_cita, 
                c.fecha_hora, 
                c.estado, 
                p.nombre AS nombre_paciente, 
                p.apellido AS apellido_paciente,
                u.nombre AS nombre_doctor,
                u.apellido AS apellido_doctor,
                c.color AS color_cita 
            FROM 
                cita c
            JOIN 
                paciente p ON c.id_paciente = p.id_paciente
            JOIN 
                doctor d ON c.id_doctor = d.id_doctor -- Relacionar cita con doctor
            JOIN 
                usuario u ON d.id_usuario = u.id_usuario -- Relacionar doctor con usuario
            WHERE 
                c.id_usuario = $1
            ORDER BY 
                c.fecha_hora
        `;

        const values = [parseInt(id_usuario)];
        const result = await client.query(query, values);

        if (result.rows.length > 0) {
            res.json(result.rows); // Retorna las citas encontradas
        } else {
            res.json([]); // Retorna un array vacío si no hay citas
        }
    } catch (error) {
        console.error('Error al obtener las citas del usuario:', error.message);
        res.status(500).json({ message: 'Error al obtener las citas del usuario' });
    }
});


router.get('/citasDoctor', async (req, res) => {
    const { id_doctor } = req.query;

    // Verificar que id_doctor sea un número válido
    if (!id_doctor || isNaN(parseInt(id_doctor))) {
        return res.status(400).json({ message: 'ID de doctor inválido' });
    }

    try {
        const query = `
            SELECT c.id_cita, c.fecha_hora, c.estado, 
                   p.nombre AS nombre_paciente, 
                   p.apellido AS apellido_paciente, 
                   u.nombre AS nombre_asistente, 
                   u.apellido AS apellido_asistente,
                   c.color AS color_cita
            FROM cita c
            JOIN paciente p ON c.id_paciente = p.id_paciente
            LEFT JOIN usuario u ON c.id_usuario = u.id_usuario -- Asegúrate de que haya una relación entre cita y usuario
            WHERE c.id_doctor = $1
            ORDER BY c.id_cita
        `;
        const result = await client.query(query, [parseInt(id_doctor)]); // Convertir a entero

        if (result.rows.length > 0) {
            res.json(result.rows); // Retorna las citas encontradas
        } else {
            return res.status(404).json({ error: 'No se encontraron citas para el doctor' });
        }
    } catch (error) {
        console.error('Error al cargar citas del doctor:', error.message);
        res.status(500).json({ message: 'Error al cargar citas' });
    }
});

router.delete('/eliminar/:id', async (req, res) => {
    const idCita = req.params.id;

    try {
        // Eliminar la cita de la base de datos usando el ID
        const result = await client.query('DELETE FROM cita WHERE id_cita = $1', [idCita]);

        // Verificar si se eliminó alguna fila
        if (result.rowCount > 0) {
            return res.json({ success: true, message: 'Cita eliminada correctamente' });
        } else {
            return res.status(404).json({ success: false, message: 'Cita no encontrada' });
        }
    } catch (error) {
        console.error('Error al eliminar la cita:', error);
        return res.status(500).json({ success: false, message: 'Error al eliminar la cita' });
    }
});


module.exports = router;
