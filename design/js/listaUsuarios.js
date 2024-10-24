const client = require('./db');

const buscarUsuarios = async (searchQuery) => {
  try {
    const query = `
      SELECT u.id_usuario, 
             u.id_centro_medico, 
             u.id_tipo_usuario, 
             u.nombre, 
             u.apellido, 
             u.cedula, 
             u.fecha_nacimiento, 
             u.sexo, 
             u.correo, 
             u.estado, 
             u.celular, 
             u.telefono,
             d.exequatur, 
             ARRAY_AGG(e.especialidad) AS especialidades  -- Agrupar todas las especialidades
      FROM usuario u
      LEFT JOIN doctor d ON u.id_usuario = d.id_usuario
      LEFT JOIN doctor_especialidad de ON d.id_doctor = de.id_doctor  -- Relación con la tabla doctor_especialidad
      LEFT JOIN especialidad e ON de.id_especialidad = e.id_especialidad  -- Relación con la tabla especialidad
      WHERE u.id_tipo_usuario IN (1, 2, 3) -- Solo obtener administradores, doctores y asistentes
        AND (
          CAST(u.id_usuario AS TEXT) ILIKE $1 OR
          u.nombre ILIKE $1 OR
          u.apellido ILIKE $1 OR
          CAST(u.cedula AS TEXT) ILIKE $1 OR
          u.correo ILIKE $1 OR
          CAST(u.celular AS TEXT) ILIKE $1 OR
          CAST(u.estado AS TEXT) ILIKE $1 OR
          e.especialidad ILIKE $1  -- Añadir la búsqueda por especialidad
        )
      GROUP BY u.id_usuario, d.exequatur
      ORDER BY u.id_usuario;
    `;
    const values = [`%${searchQuery}%`];
    const result = await client.query(query, values);
    return result.rows;
  } catch (err) {
    console.error('Error ejecutando la búsqueda de usuarios:', err.message);
    return [];
  }
};

module.exports = { buscarUsuarios };
