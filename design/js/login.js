const pool = require('./db');

const defaultPassword = 'tecnologiamedicinal'; 

const login = async (req, res) => {
    const { usuario, password } = req.body;

    try {
        const result = await pool.query('SELECT * FROM usuario WHERE usuario = $1', [usuario]);

        if (result.rows.length === 0) {
            return res.status(401).json({ error: 'Nombre de usuario o contraseña incorrectos' });
        }

        const user = result.rows[0];

        if (password !== user.password) {
            return res.status(401).json({ error: 'Contraseña incorrecta' });
        }

        if (password === defaultPassword) {
            return res.json({
                redirectUrl: '../pages/password.html', 
                usuario: {
                    id_usuario: user.id_usuario,
                    nombre: user.nombre,
                    apellido: user.apellido,
                    correo: user.correo,
                    id_tipo_usuario: user.id_tipo_usuario
                }
            });
        }

        let redirectUrl = '../pages/profileUser.html';  

        if (user.id_tipo_usuario === 2) {
            redirectUrl = '../pages/profileDC.html';  
        } else if (user.id_tipo_usuario === 1) {
            redirectUrl = '../pages/profileAdmin.html'; 
        }

        return res.json({
            redirectUrl,
            usuario: {
                id_usuario: user.id_usuario,
                nombre: user.nombre,
                apellido: user.apellido,
                correo: user.correo,
                id_tipo_usuario: user.id_tipo_usuario,
                fecha_nacimiento: user.fecha_nacimiento,
                sexo: user.sexo,
                celular: user.celular,
                telefono: user.telefono,
                cedula: user.cedula,
                usuario: user.usuario
            }
        });
    } catch (error) {
        console.error(error);
        return res.status(500).json({ error: 'Error en el servidor' });
    }
};

module.exports = { login };
