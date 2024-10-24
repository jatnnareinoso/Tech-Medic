const client = require('./db');

const obtenerPerfilesPacientes = async () => {
  try {
    const query = `
      SELECT id_paciente, nombre, apellido, cedula, fecha_nacimiento, correo, sexo, telefono, nacionalidad, ciudad,
      direccion, menor, observacion, nombre_familiar, cedula_familiar, correo_familiar, telefono_familiar, celular_familiar, estado, celular
      FROM paciente
      ORDER BY id_paciente;
    `;
    const result = await client.query(query);
    
    return result.rows;
  } catch (err) {
    console.error('Error al obtener perfiles de usuarios:', err.message);
    return [];
  }
};

const actualizarPaciente = async (id_paciente, datosActualizados) => {
  const {
    nombre, apellido, cedula, correo, fecha_nacimiento, sexo, telefono, celular, nacionalidad, ciudad,
    direccion, menor, observacion, nombre_familiar, cedula_familiar, correo_familiar, telefono_familiar, celular_familiar, estado
  } = datosActualizados;
  
  try {
    const query = `
      UPDATE paciente
      SET nombre = $1, apellido = $2, cedula = $3, correo = $4, fecha_nacimiento = $5, sexo = $6, telefono = $7, celular = $8, nacionalidad = $9,
          ciudad = $10, direccion = $11, menor = $12, observacion = $13, nombre_familiar = $14, cedula_familiar = $15, correo_familiar = $16,
          telefono_familiar = $17, celular_familiar = $18, estado = $19
      WHERE id_paciente = $20
    `;
    const result = await client.query(query, [
      nombre, apellido, cedula, correo, fecha_nacimiento, sexo, telefono, celular,
      nacionalidad, ciudad, direccion, menor, observacion, nombre_familiar, cedula_familiar, correo_familiar, telefono_familiar, celular_familiar, estado, id_paciente
    ]);
    
    if (result.rowCount > 0) {
      return { mensaje: 'Paciente actualizado exitosamente' };
    } else {
      return { error: 'Paciente no encontrado' };
    }
  } catch (err) {
    console.error('Error al actualizar paciente:', err.message);
    return { error: 'Error al actualizar el paciente' };
  }
};

const buscarPacientes = async (searchQuery) => {
  try {
    const query = `
      SELECT * FROM paciente
      WHERE CAST(id_paciente AS TEXT) ILIKE $1
        OR nombre ILIKE $1 
        OR apellido ILIKE $1 
        OR CAST(cedula AS TEXT) ILIKE $1
        OR CAST(fecha_nacimiento AS TEXT) ILIKE $1
        OR correo ILIKE $1
        OR sexo ILIKE $1
        OR CAST(telefono AS TEXT) ILIKE $1
        OR nacionalidad ILIKE $1
        OR ciudad ILIKE $1
        OR direccion ILIKE $1
        OR CAST(menor AS TEXT) ILIKE $1
        OR observacion ILIKE $1
        OR nombre_familiar ILIKE $1
        OR CAST(cedula_familiar AS TEXT) ILIKE $1
        OR correo_familiar ILIKE $1
        OR CAST(telefono_familiar AS TEXT) ILIKE $1
        OR CAST(celular_familiar AS TEXT) ILIKE $1
        OR CAST(estado AS TEXT) ILIKE $1
        OR CAST(celular AS TEXT) ILIKE $1
        OR observacion ILIKE $1
    `;
    const values = [`%${searchQuery}%`];
    const result = await client.query(query, values);

    return result.rows;
  } catch (err) {
    console.error('Error ejecutando la búsqueda de pacientes:', err.message);
    return [];
  }
};

const buscarPacientesCitas = async (searchQuery) => {
    try {
        const query = `
            SELECT * FROM paciente
            WHERE nombre ILIKE $1
            OR CAST(cedula AS TEXT) ILIKE $1
        `;
        const values = [`%${searchQuery}%`]; // Agregando comodines para coincidencias parciales
        const result = await client.query(query, values);

        return result.rows;
    } catch (err) {
        console.error('Error ejecutando la búsqueda de pacientes:', err.message);
        return [];
    }
};


module.exports = { obtenerPerfilesPacientes, actualizarPaciente, buscarPacientes, buscarPacientesCitas };
