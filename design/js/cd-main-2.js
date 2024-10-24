$(function () {
    // Inicializar eventos externos
    function ini_events(ele) {
        ele.each(function () {
            var eventObject = {
                title: $.trim($(this).text()) // usar el texto del elemento como título del evento
            }

            $(this).data('eventObject', eventObject)

            $(this).draggable({
                zIndex: 1070,
                revert: true, // hará que el evento vuelva a su posición original
                revertDuration: 0  // después del arrastre
            })
        })
    }

    ini_events($('#external-events div.external-event'));

    var Calendar = FullCalendar.Calendar;
    var Draggable = FullCalendar.Draggable;

    var containerEl = document.getElementById('external-events');
    var calendarEl = document.getElementById('calendar');

    // Inicializar eventos externos
    new Draggable(containerEl, {
        itemSelector: '.external-event',
        eventData: function (eventEl) {
            return {
                title: eventEl.innerText,
                backgroundColor: window.getComputedStyle(eventEl, null).getPropertyValue('background-color'),
                borderColor: window.getComputedStyle(eventEl, null).getPropertyValue('background-color'),
                textColor: window.getComputedStyle(eventEl, null).getPropertyValue('color'),
            };
        }
    });

    var calendar = new Calendar(calendarEl, {
        headerToolbar: {
            left: 'prev,next today',
            center: 'title',
            right: 'dayGridMonth,timeGridWeek,timeGridDay'
        },
        themeSystem: 'bootstrap',
        editable: true,
        droppable: true, // permite que se suelten eventos
        events: [],  // Vacío al inicio
        eventDidMount: function (info) {
            info.el.addEventListener('dblclick', function () {
                Swal.fire({
                    title: '¿Qué deseas hacer?',
                    showDenyButton: true,
                    showCancelButton: true,
                    confirmButtonText: 'Eliminar',
                    denyButtonText: 'Consultar',
                    cancelButtonText: 'Cancelar',
                }).then((result) => {
                    if (result.isConfirmed) {
                        // Eliminar la cita del servidor
                        fetch(`/api/cita/eliminar/${info.event.id}`, {
                            method: 'DELETE',
                            headers: {
                                'Content-Type': 'application/json'
                            }
                        })
                        .then(response => response.json())
                        .then(data => {
                            if (data.success) {
                                info.event.remove();  // Eliminar del calendario
                                Swal.fire('Eliminado!', '', 'success');
                            } else {
                                Swal.fire('Error al eliminar', '', 'error');
                            }
                        })
                        .catch(error => {
                            console.error('Error al eliminar la cita:', error);
                            Swal.fire('Error al eliminar', '', 'error');
                        });
                    } else if (result.isDenied) {
                        window.location.href = 'C:/ProyectTechMedic/pages/menu/consulta.html';
                    }
                });
            });
        },
    });

    calendar.render();

    // Cargar citas al inicializar el calendario
    const user = JSON.parse(localStorage.getItem('user'));
    if (user) {
        cargarCitas(user);
    }

    function cargarCitas(user) {
        const tipoUsuario = user.id_tipo_usuario;
        const idUsuario = user.id_usuario;

        if (tipoUsuario === 2) {
            fetch(`/api/cita/getIdDoctor?id_usuario=${idUsuario}`)
                .then(response => {
                    if (!response.ok) throw new Error('No se pudo obtener el ID del doctor');
                    return response.json();
                })
                .then(data => {
                    const idDoctor = data.id_doctor;
                    cargarCitasPorDoctor(idDoctor);
                })
                .catch(error => console.error('Error al obtener el ID del doctor:', error));
        } else {
            cargarCitasPorUsuario(idUsuario);
        }
    }

    function cargarCitasPorDoctor(idDoctor) {
        const apiUrl = `/api/cita/citasDoctor?id_doctor=${idDoctor}`;
        
        // Mapeo de clases CSS a colores hexadecimales
        const colorMap = {
            'text-danger': '#dc3545', // Rojo
            'text-warning': '#ffc107', // Amarillo
            'text-success': '#28a745', // Verde
            'text-info': '#17a2b8',    // Cian
            // Agrega más clases y colores según sea necesario
        };
    
        fetch(apiUrl)
            .then(response => {
                if (!response.ok) throw new Error('Error al cargar citas');
                return response.json();
            })
            .then(citas => {
                citas.forEach(cita => {
                    const fechaHora = new Date(cita.fecha_hora);
                    const formattedTime = formatAMPM(fechaHora); // Formatear la hora a 12 horas
    
                    // Obtener el color correspondiente o usar un color por defecto
                    const color = colorMap[cita.color_cita] || '#3c8dbc'; // Usa el color mapeado o un color por defecto
    
                    calendar.addEvent({
                        id: cita.id_cita, // Agregar el ID de la cita
                        title: `${cita.nombre_paciente} ${cita.apellido_paciente} - Asistente: ${cita.nombre_asistente || 'No asignado'}`, // Añadir asistente al título
                        start: fechaHora.toISOString(),
                        allDay: false,
                        backgroundColor: color, // Aplicar el color mapeado
                        borderColor: color, // Aplicar el color mapeado
                        textColor: '#fff'
                    });
                });
            })
            .catch(error => console.error('Error al cargar citas del doctor:', error));
    }
    
    function cargarCitasPorUsuario(idUsuario) {
        const apiUrl = `/api/cita/citasUsuario?id_usuario=${idUsuario}`;
    
        const colorMap = {
            'text-danger': '#dc3545', // Rojo
            'text-warning': '#ffc107', // Amarillo
            'text-success': '#28a745', // Verde
            'text-info': '#17a2b8',    // Cian
            // Agrega más clases y colores según sea necesario
        };
    
        fetch(apiUrl)
            .then(response => {
                if (!response.ok) throw new Error('Error al cargar citas');
                return response.json();
            })
            .then(citas => {
                citas.forEach(cita => {
                    const fechaHora = new Date(cita.fecha_hora);
                    const formattedTime = formatAMPM(fechaHora);
                    const color = colorMap[cita.color_cita] || '#3c8dbc';
    
                    calendar.addEvent({
                        id: cita.id_cita, // Agregar el ID de la cita
                        title: `${cita.nombre_paciente} ${cita.apellido_paciente} - Doctor: ${cita.nombre_doctor} ${cita.apellido_doctor}`, // Mostrar el doctor
                        start: fechaHora.toISOString(),
                        allDay: false,
                        backgroundColor: color,
                        borderColor: color,
                        textColor: '#fff'
                    });
                });
            })
            .catch(error => console.error('Error al cargar citas del usuario:', error));
    }
    

    // Formatear hora a 12 horas
    function formatAMPM(date) {
        let hours = date.getHours();
        const minutes = date.getMinutes();
        const ampm = hours >= 12 ? 'PM' : 'AM';
        hours = hours % 12;
        hours = hours ? hours : 12; // la hora '0' debe mostrarse como '12'
        const strTime = hours + ':' + (minutes < 10 ? '0' + minutes : minutes) + ' ' + ampm;
        return strTime;
    }

    $('#add-new-event').click(function (e) {
        e.preventDefault();
    
        // Obtener el título, la fecha, la hora, y el color del evento
        var title = $('#new-event').val();
        var time = $('#new-event-time').val();
        var date = $('#new-event-date').val();
        
        var paciente = $('#id-paciente').val(); 
        var doctor = $('#select-doctor').val(); 
        var asistente = $('#select-asistente').val(); 
        var id_usuario = $('#id_usuario').val();
    
        var selectedDate = new Date(date + 'T' + time);
        var startDate = new Date(selectedDate);
    
        // Agregar el evento al calendario con el color seleccionado
        calendar.addEvent({
            title: title,
            start: startDate,
            allDay: false,
            backgroundColor: currColor,  // Usar el color seleccionado
            borderColor: currColor,      // Usar el color seleccionado
            textColor: '#fff'            // Color del texto
        });
    
        // Enviar la cita al servidor con el color
        fetch('/cita/agregarCita', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                titulo: title,
                fecha: date,
                hora: time,
                id_paciente: paciente,
                id_doctor: doctor,
                id_asistente: asistente || null, 
                id_usuario: id_usuario,
                color: currColor // Agregar el color de la cita
            })
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                console.log(data.success);
            } else {
                console.log(data.error);
            }
        });
    
        // Limpiar campos
        $('#new-event').val('');
        $('#new-event-time').val('');
        $('#new-event-date').val('');
        $('#id-paciente').val('');
        $('#select-doctor').val('');
        $('#select-asistente').val('');
    });
    
    

    var currColor = '#3c8dbc';
    $('#color-chooser > li > a').click(function (e) {
        e.preventDefault();
        currColor = $(this).css('color');
        $('#add-new-event').css({
            'background-color': currColor,
            'border-color': currColor
        });
    });

});
