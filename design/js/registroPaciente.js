const pool = require('./db'); 

const registrarPaciente = async (req, res) => {
    const {
        nombre, apellido, cedula, fecha_nacimiento, correo, sexo, telefono, nacionalidad, ciudad, direccion,
        celular, userType, nombre_familiar, cedula_familiar, correo_familiar, telefono_familiar, celular_familiar
    } = req.body;

    const menor = userType === 'menor' ? true : false;

    try {
        const result = await pool.query(`
            INSERT INTO paciente (
                nombre, apellido, cedula, fecha_nacimiento, correo, sexo, telefono, nacionalidad, ciudad, direccion, celular, menor,
                nombre_familiar, cedula_familiar, correo_familiar, telefono_familiar, celular_familiar
            ) VALUES (
                $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12,
                $13, $14, $15, $16, $17
            ) RETURNING id_paciente
        `, [
            nombre, apellido, cedula || null, fecha_nacimiento, correo, sexo, telefono, nacionalidad, ciudad, direccion, celular,
            menor, nombre_familiar, cedula_familiar, correo_familiar, telefono_familiar, celular_familiar
        ]);

       
        const { id_paciente } = result.rows[0];

     
        res.status(201).json({ success: true, message: 'Paciente registrado exitosamente', id_paciente });
    } catch (error) {
        console.error(error);
        res.status(500).json({ success: false, error: 'Error al registrar paciente' });
    }
};

module.exports = { registrarPaciente };
