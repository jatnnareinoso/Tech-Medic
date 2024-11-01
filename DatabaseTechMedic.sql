PGDMP                  	    |        	   techmedic    16.2    16.2 o    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    32949 	   techmedic    DATABASE     �   CREATE DATABASE techmedic WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Spanish_Dominican Republic.1252';
    DROP DATABASE techmedic;
                postgres    false            �            1259    32961    accesos    TABLE     �   CREATE TABLE public.accesos (
    id_acessos integer NOT NULL,
    modulo character varying(50),
    estado boolean DEFAULT true
);
    DROP TABLE public.accesos;
       public         heap    postgres    false            �            1259    33044    accesos_usuario    TABLE     �   CREATE TABLE public.accesos_usuario (
    id_acc_usuario integer NOT NULL,
    id_accesos integer NOT NULL,
    id_usuario integer NOT NULL,
    id_centro_medico integer NOT NULL,
    estado boolean DEFAULT true
);
 #   DROP TABLE public.accesos_usuario;
       public         heap    postgres    false            �            1259    41997    asistente_doctor    TABLE     �   CREATE TABLE public.asistente_doctor (
    id_us_doc integer NOT NULL,
    id_usuario integer NOT NULL,
    id_doctor integer NOT NULL,
    estado boolean DEFAULT true
);
 $   DROP TABLE public.asistente_doctor;
       public         heap    postgres    false            �            1259    42013    asistente_doctor_id_us_doc_seq    SEQUENCE     �   ALTER TABLE public.asistente_doctor ALTER COLUMN id_us_doc ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.asistente_doctor_id_us_doc_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999
    CACHE 1
);
            public          postgres    false    245            �            1259    32950    centro_medico    TABLE     �   CREATE TABLE public.centro_medico (
    id_centro_medico integer NOT NULL,
    centro_medico character varying(50) NOT NULL,
    observacion character varying(100),
    estado boolean DEFAULT true NOT NULL
);
 !   DROP TABLE public.centro_medico;
       public         heap    postgres    false            �            1259    33780 "   centro_medico_id_centro_medico_seq    SEQUENCE     �   ALTER TABLE public.centro_medico ALTER COLUMN id_centro_medico ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.centro_medico_id_centro_medico_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999
    CACHE 1
);
            public          postgres    false    215            �            1259    33143    cita    TABLE       CREATE TABLE public.cita (
    id_cita integer NOT NULL,
    id_paciente integer NOT NULL,
    id_doctor integer NOT NULL,
    id_centro_medico integer NOT NULL,
    id_usuario integer NOT NULL,
    fecha_hora timestamp with time zone,
    estado boolean,
    color character varying
);
    DROP TABLE public.cita;
       public         heap    postgres    false            �            1259    33781    cita_id_cita_seq    SEQUENCE     �   ALTER TABLE public.cita ALTER COLUMN id_cita ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.cita_id_cita_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999
    CACHE 1
);
            public          postgres    false    226            �            1259    33202    consulta    TABLE     K  CREATE TABLE public.consulta (
    id_consulta integer NOT NULL,
    id_paciente integer NOT NULL,
    id_doctor integer NOT NULL,
    id_tipo_consulta integer NOT NULL,
    id_usuario integer NOT NULL,
    motivo character varying,
    descripcion character varying,
    fecha_hora timestamp with time zone,
    estado boolean
);
    DROP TABLE public.consulta;
       public         heap    postgres    false            �            1259    33782    consulta_id_consulta_seq    SEQUENCE     �   ALTER TABLE public.consulta ALTER COLUMN id_consulta ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.consulta_id_consulta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999
    CACHE 1
);
            public          postgres    false    228            �            1259    33229    diagnostico    TABLE        CREATE TABLE public.diagnostico (
    id_diagnostico integer NOT NULL,
    id_consulta integer NOT NULL,
    descripcion character varying,
    pruebas character varying,
    observacion character varying,
    fecha_diagnostico date,
    estado boolean
);
    DROP TABLE public.diagnostico;
       public         heap    postgres    false            �            1259    33783    diagnostico_id_diagnostico_seq    SEQUENCE     �   ALTER TABLE public.diagnostico ALTER COLUMN id_diagnostico ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.diagnostico_id_diagnostico_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999
    CACHE 1
);
            public          postgres    false    229            �            1259    33067    doctor    TABLE     �   CREATE TABLE public.doctor (
    id_doctor integer NOT NULL,
    id_centro_medico integer NOT NULL,
    id_usuario integer NOT NULL,
    exequatur numeric,
    observacion character varying,
    estado boolean DEFAULT true
);
    DROP TABLE public.doctor;
       public         heap    postgres    false            �            1259    33090    doctor_especialidad    TABLE     �   CREATE TABLE public.doctor_especialidad (
    id_us_esp integer NOT NULL,
    id_doctor integer NOT NULL,
    id_especialidad integer NOT NULL,
    estado boolean DEFAULT true
);
 '   DROP TABLE public.doctor_especialidad;
       public         heap    postgres    false            �            1259    33785 !   doctor_especialidad_id_us_esp_seq    SEQUENCE     �   ALTER TABLE public.doctor_especialidad ALTER COLUMN id_us_esp ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.doctor_especialidad_id_us_esp_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999
    CACHE 1
);
            public          postgres    false    224            �            1259    33784    doctor_id_doctor_seq    SEQUENCE     �   ALTER TABLE public.doctor ALTER COLUMN id_doctor ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.doctor_id_doctor_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999
    CACHE 1
);
            public          postgres    false    223            �            1259    32983    especialidad    TABLE     �   CREATE TABLE public.especialidad (
    id_especialidad integer NOT NULL,
    especialidad character varying,
    descripcion character varying,
    estado boolean DEFAULT true
);
     DROP TABLE public.especialidad;
       public         heap    postgres    false            �            1259    33786     especialidad_id_especialidad_seq    SEQUENCE     �   ALTER TABLE public.especialidad ALTER COLUMN id_especialidad ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.especialidad_id_especialidad_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999
    CACHE 1
);
            public          postgres    false    220            �            1259    33170    notificaciones    TABLE     &  CREATE TABLE public.notificaciones (
    id_notificaciones integer NOT NULL,
    id_paciente integer NOT NULL,
    id_cita integer NOT NULL,
    id_usuario integer NOT NULL,
    correo character varying,
    fecha_envio date,
    contenido character varying,
    estado boolean DEFAULT true
);
 "   DROP TABLE public.notificaciones;
       public         heap    postgres    false            �            1259    33787 $   notificaciones_id_notificaciones_seq    SEQUENCE     �   ALTER TABLE public.notificaciones ALTER COLUMN id_notificaciones ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.notificaciones_id_notificaciones_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999
    CACHE 1
);
            public          postgres    false    227            �            1259    32967    paciente    TABLE     �  CREATE TABLE public.paciente (
    id_paciente integer NOT NULL,
    nombre character varying(50),
    apellido character varying(50),
    cedula character varying(20),
    fecha_nacimiento date,
    correo character varying(30),
    sexo character varying(15),
    telefono numeric(15,0),
    nacionalidad character varying(30),
    ciudad character varying(30),
    direccion character varying(100),
    menor boolean,
    observacion character varying(100),
    nombre_familiar character varying(50),
    cedula_familiar character varying(20),
    correo_familiar character varying(30),
    telefono_familiar character varying(15),
    celular_familiar character varying(15),
    estado boolean DEFAULT true,
    celular character varying
);
    DROP TABLE public.paciente;
       public         heap    postgres    false            �            1259    33789    paciente_id_paciente_seq    SEQUENCE     �   ALTER TABLE public.paciente ALTER COLUMN id_paciente ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.paciente_id_paciente_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999
    CACHE 1
);
            public          postgres    false    218            �            1259    33241    receta    TABLE     
  CREATE TABLE public.receta (
    id_receta integer NOT NULL,
    id_diagnostico integer NOT NULL,
    medicamentos character varying,
    cantidad character varying,
    dosis character varying,
    dias character varying,
    fecha_receta date,
    imagen bytea
);
    DROP TABLE public.receta;
       public         heap    postgres    false            �            1259    33790    receta_id_receta_seq    SEQUENCE     �   ALTER TABLE public.receta ALTER COLUMN id_receta ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.receta_id_receta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999
    CACHE 1
);
            public          postgres    false    230            �            1259    32975    tipo_consulta    TABLE     �   CREATE TABLE public.tipo_consulta (
    id_tipo_consulta integer NOT NULL,
    consulta character varying,
    descripcion character varying,
    estado boolean DEFAULT true
);
 !   DROP TABLE public.tipo_consulta;
       public         heap    postgres    false            �            1259    33791 "   tipo_consulta_id_tipo_consulta_seq    SEQUENCE     �   ALTER TABLE public.tipo_consulta ALTER COLUMN id_tipo_consulta ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.tipo_consulta_id_tipo_consulta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999
    CACHE 1
);
            public          postgres    false    219            �            1259    32956    tipo_usuario    TABLE     �   CREATE TABLE public.tipo_usuario (
    id_tipo_usuario integer NOT NULL,
    usuario character varying(50),
    estado boolean DEFAULT true
);
     DROP TABLE public.tipo_usuario;
       public         heap    postgres    false            �            1259    33792     tipo_usuario_id_tipo_usuario_seq    SEQUENCE     �   ALTER TABLE public.tipo_usuario ALTER COLUMN id_tipo_usuario ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.tipo_usuario_id_tipo_usuario_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999
    CACHE 1
);
            public          postgres    false    216            �            1259    33026    usuario    TABLE     �  CREATE TABLE public.usuario (
    id_usuario integer NOT NULL,
    id_centro_medico integer NOT NULL,
    id_tipo_usuario integer NOT NULL,
    nombre character varying,
    apellido character varying,
    cedula character varying,
    fecha_nacimiento date,
    sexo character varying,
    correo character varying,
    password character varying,
    usuario character varying,
    estado boolean DEFAULT true,
    celular character varying,
    telefono character varying
);
    DROP TABLE public.usuario;
       public         heap    postgres    false            �            1259    33108    usuario_centro_medico    TABLE     �   CREATE TABLE public.usuario_centro_medico (
    id_us_cent integer NOT NULL,
    id_usuario integer NOT NULL,
    id_centro_medico integer NOT NULL,
    estado boolean DEFAULT true
);
 )   DROP TABLE public.usuario_centro_medico;
       public         heap    postgres    false            �            1259    33794 $   usuario_centro_medico_id_us_cent_seq    SEQUENCE     �   ALTER TABLE public.usuario_centro_medico ALTER COLUMN id_us_cent ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.usuario_centro_medico_id_us_cent_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999
    CACHE 1
);
            public          postgres    false    225            �            1259    33793    usuario_id_usuario_seq    SEQUENCE     �   ALTER TABLE public.usuario ALTER COLUMN id_usuario ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.usuario_id_usuario_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999
    CACHE 1
);
            public          postgres    false    221            x          0    32961    accesos 
   TABLE DATA           =   COPY public.accesos (id_acessos, modulo, estado) FROM stdin;
    public          postgres    false    217   �       }          0    33044    accesos_usuario 
   TABLE DATA           k   COPY public.accesos_usuario (id_acc_usuario, id_accesos, id_usuario, id_centro_medico, estado) FROM stdin;
    public          postgres    false    222   	�       �          0    41997    asistente_doctor 
   TABLE DATA           T   COPY public.asistente_doctor (id_us_doc, id_usuario, id_doctor, estado) FROM stdin;
    public          postgres    false    245   &�       v          0    32950    centro_medico 
   TABLE DATA           ]   COPY public.centro_medico (id_centro_medico, centro_medico, observacion, estado) FROM stdin;
    public          postgres    false    215   ��       �          0    33143    cita 
   TABLE DATA           x   COPY public.cita (id_cita, id_paciente, id_doctor, id_centro_medico, id_usuario, fecha_hora, estado, color) FROM stdin;
    public          postgres    false    226   ��       �          0    33202    consulta 
   TABLE DATA           �   COPY public.consulta (id_consulta, id_paciente, id_doctor, id_tipo_consulta, id_usuario, motivo, descripcion, fecha_hora, estado) FROM stdin;
    public          postgres    false    228   N�       �          0    33229    diagnostico 
   TABLE DATA           �   COPY public.diagnostico (id_diagnostico, id_consulta, descripcion, pruebas, observacion, fecha_diagnostico, estado) FROM stdin;
    public          postgres    false    229   k�       ~          0    33067    doctor 
   TABLE DATA           i   COPY public.doctor (id_doctor, id_centro_medico, id_usuario, exequatur, observacion, estado) FROM stdin;
    public          postgres    false    223   ��                 0    33090    doctor_especialidad 
   TABLE DATA           \   COPY public.doctor_especialidad (id_us_esp, id_doctor, id_especialidad, estado) FROM stdin;
    public          postgres    false    224   ��       {          0    32983    especialidad 
   TABLE DATA           Z   COPY public.especialidad (id_especialidad, especialidad, descripcion, estado) FROM stdin;
    public          postgres    false    220   G�       �          0    33170    notificaciones 
   TABLE DATA           �   COPY public.notificaciones (id_notificaciones, id_paciente, id_cita, id_usuario, correo, fecha_envio, contenido, estado) FROM stdin;
    public          postgres    false    227   E�       y          0    32967    paciente 
   TABLE DATA             COPY public.paciente (id_paciente, nombre, apellido, cedula, fecha_nacimiento, correo, sexo, telefono, nacionalidad, ciudad, direccion, menor, observacion, nombre_familiar, cedula_familiar, correo_familiar, telefono_familiar, celular_familiar, estado, celular) FROM stdin;
    public          postgres    false    218   b�       �          0    33241    receta 
   TABLE DATA           v   COPY public.receta (id_receta, id_diagnostico, medicamentos, cantidad, dosis, dias, fecha_receta, imagen) FROM stdin;
    public          postgres    false    230   ��       z          0    32975    tipo_consulta 
   TABLE DATA           X   COPY public.tipo_consulta (id_tipo_consulta, consulta, descripcion, estado) FROM stdin;
    public          postgres    false    219   ��       w          0    32956    tipo_usuario 
   TABLE DATA           H   COPY public.tipo_usuario (id_tipo_usuario, usuario, estado) FROM stdin;
    public          postgres    false    216   ̟       |          0    33026    usuario 
   TABLE DATA           �   COPY public.usuario (id_usuario, id_centro_medico, id_tipo_usuario, nombre, apellido, cedula, fecha_nacimiento, sexo, correo, password, usuario, estado, celular, telefono) FROM stdin;
    public          postgres    false    221   �       �          0    33108    usuario_centro_medico 
   TABLE DATA           a   COPY public.usuario_centro_medico (id_us_cent, id_usuario, id_centro_medico, estado) FROM stdin;
    public          postgres    false    225   ��       �           0    0    asistente_doctor_id_us_doc_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('public.asistente_doctor_id_us_doc_seq', 26, true);
          public          postgres    false    246            �           0    0 "   centro_medico_id_centro_medico_seq    SEQUENCE SET     P   SELECT pg_catalog.setval('public.centro_medico_id_centro_medico_seq', 2, true);
          public          postgres    false    231            �           0    0    cita_id_cita_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.cita_id_cita_seq', 46, true);
          public          postgres    false    232            �           0    0    consulta_id_consulta_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.consulta_id_consulta_seq', 1, false);
          public          postgres    false    233            �           0    0    diagnostico_id_diagnostico_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('public.diagnostico_id_diagnostico_seq', 1, false);
          public          postgres    false    234            �           0    0 !   doctor_especialidad_id_us_esp_seq    SEQUENCE SET     Q   SELECT pg_catalog.setval('public.doctor_especialidad_id_us_esp_seq', 111, true);
          public          postgres    false    236            �           0    0    doctor_id_doctor_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.doctor_id_doctor_seq', 41, true);
          public          postgres    false    235            �           0    0     especialidad_id_especialidad_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('public.especialidad_id_especialidad_seq', 15, true);
          public          postgres    false    237            �           0    0 $   notificaciones_id_notificaciones_seq    SEQUENCE SET     S   SELECT pg_catalog.setval('public.notificaciones_id_notificaciones_seq', 1, false);
          public          postgres    false    238            �           0    0    paciente_id_paciente_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.paciente_id_paciente_seq', 8, true);
          public          postgres    false    239            �           0    0    receta_id_receta_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.receta_id_receta_seq', 1, false);
          public          postgres    false    240            �           0    0 "   tipo_consulta_id_tipo_consulta_seq    SEQUENCE SET     Q   SELECT pg_catalog.setval('public.tipo_consulta_id_tipo_consulta_seq', 1, false);
          public          postgres    false    241            �           0    0     tipo_usuario_id_tipo_usuario_seq    SEQUENCE SET     N   SELECT pg_catalog.setval('public.tipo_usuario_id_tipo_usuario_seq', 3, true);
          public          postgres    false    242            �           0    0 $   usuario_centro_medico_id_us_cent_seq    SEQUENCE SET     S   SELECT pg_catalog.setval('public.usuario_centro_medico_id_us_cent_seq', 1, false);
          public          postgres    false    244            �           0    0    usuario_id_usuario_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.usuario_id_usuario_seq', 61, true);
          public          postgres    false    243            �           2606    33295    accesos accesos_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.accesos
    ADD CONSTRAINT accesos_pkey PRIMARY KEY (id_acessos);
 >   ALTER TABLE ONLY public.accesos DROP CONSTRAINT accesos_pkey;
       public            postgres    false    217            �           2606    33289 $   accesos_usuario accesos_usuario_pkey 
   CONSTRAINT     n   ALTER TABLE ONLY public.accesos_usuario
    ADD CONSTRAINT accesos_usuario_pkey PRIMARY KEY (id_acc_usuario);
 N   ALTER TABLE ONLY public.accesos_usuario DROP CONSTRAINT accesos_usuario_pkey;
       public            postgres    false    222            �           2606    42002 &   asistente_doctor asistente_doctor_pkey 
   CONSTRAINT     k   ALTER TABLE ONLY public.asistente_doctor
    ADD CONSTRAINT asistente_doctor_pkey PRIMARY KEY (id_us_doc);
 P   ALTER TABLE ONLY public.asistente_doctor DROP CONSTRAINT asistente_doctor_pkey;
       public            postgres    false    245            �           2606    33750     centro_medico centro_medico_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY public.centro_medico
    ADD CONSTRAINT centro_medico_pkey PRIMARY KEY (id_centro_medico);
 J   ALTER TABLE ONLY public.centro_medico DROP CONSTRAINT centro_medico_pkey;
       public            postgres    false    215            �           2606    33739    cita cita_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY public.cita
    ADD CONSTRAINT cita_pkey PRIMARY KEY (id_cita);
 8   ALTER TABLE ONLY public.cita DROP CONSTRAINT cita_pkey;
       public            postgres    false    226            �           2606    33412    consulta consulta_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public.consulta
    ADD CONSTRAINT consulta_pkey PRIMARY KEY (id_consulta);
 @   ALTER TABLE ONLY public.consulta DROP CONSTRAINT consulta_pkey;
       public            postgres    false    228            �           2606    33726    diagnostico diagnostico_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.diagnostico
    ADD CONSTRAINT diagnostico_pkey PRIMARY KEY (id_diagnostico);
 F   ALTER TABLE ONLY public.diagnostico DROP CONSTRAINT diagnostico_pkey;
       public            postgres    false    229            �           2606    33480 ,   doctor_especialidad doctor_especialidad_pkey 
   CONSTRAINT     q   ALTER TABLE ONLY public.doctor_especialidad
    ADD CONSTRAINT doctor_especialidad_pkey PRIMARY KEY (id_us_esp);
 V   ALTER TABLE ONLY public.doctor_especialidad DROP CONSTRAINT doctor_especialidad_pkey;
       public            postgres    false    224            �           2606    33703    doctor doctor_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY public.doctor
    ADD CONSTRAINT doctor_pkey PRIMARY KEY (id_doctor);
 <   ALTER TABLE ONLY public.doctor DROP CONSTRAINT doctor_pkey;
       public            postgres    false    223            �           2606    33486    especialidad especialidad_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY public.especialidad
    ADD CONSTRAINT especialidad_pkey PRIMARY KEY (id_especialidad);
 H   ALTER TABLE ONLY public.especialidad DROP CONSTRAINT especialidad_pkey;
       public            postgres    false    220            �           2606    33505 "   notificaciones notificaciones_pkey 
   CONSTRAINT     o   ALTER TABLE ONLY public.notificaciones
    ADD CONSTRAINT notificaciones_pkey PRIMARY KEY (id_notificaciones);
 L   ALTER TABLE ONLY public.notificaciones DROP CONSTRAINT notificaciones_pkey;
       public            postgres    false    227            �           2606    33680    paciente paciente_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public.paciente
    ADD CONSTRAINT paciente_pkey PRIMARY KEY (id_paciente);
 @   ALTER TABLE ONLY public.paciente DROP CONSTRAINT paciente_pkey;
       public            postgres    false    218            �           2606    33557    receta receta_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY public.receta
    ADD CONSTRAINT receta_pkey PRIMARY KEY (id_receta);
 <   ALTER TABLE ONLY public.receta DROP CONSTRAINT receta_pkey;
       public            postgres    false    230            �           2606    33565     tipo_consulta tipo_consulta_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY public.tipo_consulta
    ADD CONSTRAINT tipo_consulta_pkey PRIMARY KEY (id_tipo_consulta);
 J   ALTER TABLE ONLY public.tipo_consulta DROP CONSTRAINT tipo_consulta_pkey;
       public            postgres    false    219            �           2606    33669    tipo_usuario tipo_usuario_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY public.tipo_usuario
    ADD CONSTRAINT tipo_usuario_pkey PRIMARY KEY (id_tipo_usuario);
 H   ALTER TABLE ONLY public.tipo_usuario DROP CONSTRAINT tipo_usuario_pkey;
       public            postgres    false    216            �           2606    33624 0   usuario_centro_medico usuario_centro_medico_pkey 
   CONSTRAINT     v   ALTER TABLE ONLY public.usuario_centro_medico
    ADD CONSTRAINT usuario_centro_medico_pkey PRIMARY KEY (id_us_cent);
 Z   ALTER TABLE ONLY public.usuario_centro_medico DROP CONSTRAINT usuario_centro_medico_pkey;
       public            postgres    false    225            �           2606    33630    usuario usuario_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (id_usuario);
 >   ALTER TABLE ONLY public.usuario DROP CONSTRAINT usuario_pkey;
       public            postgres    false    221            �           2606    33296    accesos_usuario id_accesos_pk    FK CONSTRAINT     �   ALTER TABLE ONLY public.accesos_usuario
    ADD CONSTRAINT id_accesos_pk FOREIGN KEY (id_accesos) REFERENCES public.accesos(id_acessos);
 G   ALTER TABLE ONLY public.accesos_usuario DROP CONSTRAINT id_accesos_pk;
       public          postgres    false    4784    217    222            �           2606    33771    doctor id_centro_medico    FK CONSTRAINT     �   ALTER TABLE ONLY public.doctor
    ADD CONSTRAINT id_centro_medico FOREIGN KEY (id_centro_medico) REFERENCES public.centro_medico(id_centro_medico);
 A   ALTER TABLE ONLY public.doctor DROP CONSTRAINT id_centro_medico;
       public          postgres    false    4780    215    223            �           2606    33751    usuario id_centro_medico_pk    FK CONSTRAINT     �   ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT id_centro_medico_pk FOREIGN KEY (id_centro_medico) REFERENCES public.centro_medico(id_centro_medico);
 E   ALTER TABLE ONLY public.usuario DROP CONSTRAINT id_centro_medico_pk;
       public          postgres    false    4780    221    215            �           2606    33756 )   usuario_centro_medico id_centro_medico_pk    FK CONSTRAINT     �   ALTER TABLE ONLY public.usuario_centro_medico
    ADD CONSTRAINT id_centro_medico_pk FOREIGN KEY (id_centro_medico) REFERENCES public.centro_medico(id_centro_medico);
 S   ALTER TABLE ONLY public.usuario_centro_medico DROP CONSTRAINT id_centro_medico_pk;
       public          postgres    false    4780    215    225            �           2606    33761 #   accesos_usuario id_centro_medico_pk    FK CONSTRAINT     �   ALTER TABLE ONLY public.accesos_usuario
    ADD CONSTRAINT id_centro_medico_pk FOREIGN KEY (id_centro_medico) REFERENCES public.centro_medico(id_centro_medico);
 M   ALTER TABLE ONLY public.accesos_usuario DROP CONSTRAINT id_centro_medico_pk;
       public          postgres    false    215    222    4780            �           2606    33766    cita id_centro_medico_pk    FK CONSTRAINT     �   ALTER TABLE ONLY public.cita
    ADD CONSTRAINT id_centro_medico_pk FOREIGN KEY (id_centro_medico) REFERENCES public.centro_medico(id_centro_medico);
 B   ALTER TABLE ONLY public.cita DROP CONSTRAINT id_centro_medico_pk;
       public          postgres    false    4780    215    226            �           2606    33740    notificaciones id_cita_pk    FK CONSTRAINT     |   ALTER TABLE ONLY public.notificaciones
    ADD CONSTRAINT id_cita_pk FOREIGN KEY (id_cita) REFERENCES public.cita(id_cita);
 C   ALTER TABLE ONLY public.notificaciones DROP CONSTRAINT id_cita_pk;
       public          postgres    false    4802    227    226            �           2606    33413    diagnostico id_consulta_pk    FK CONSTRAINT     �   ALTER TABLE ONLY public.diagnostico
    ADD CONSTRAINT id_consulta_pk FOREIGN KEY (id_consulta) REFERENCES public.consulta(id_consulta);
 D   ALTER TABLE ONLY public.diagnostico DROP CONSTRAINT id_consulta_pk;
       public          postgres    false    4806    229    228            �           2606    33727    receta id_diagnostico_pk    FK CONSTRAINT     �   ALTER TABLE ONLY public.receta
    ADD CONSTRAINT id_diagnostico_pk FOREIGN KEY (id_diagnostico) REFERENCES public.diagnostico(id_diagnostico);
 B   ALTER TABLE ONLY public.receta DROP CONSTRAINT id_diagnostico_pk;
       public          postgres    false    230    4808    229            �           2606    42008    asistente_doctor id_doctor_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.asistente_doctor
    ADD CONSTRAINT id_doctor_fk FOREIGN KEY (id_doctor) REFERENCES public.doctor(id_doctor);
 G   ALTER TABLE ONLY public.asistente_doctor DROP CONSTRAINT id_doctor_fk;
       public          postgres    false    223    4796    245            �           2606    33704    cita id_doctor_pk    FK CONSTRAINT     z   ALTER TABLE ONLY public.cita
    ADD CONSTRAINT id_doctor_pk FOREIGN KEY (id_doctor) REFERENCES public.doctor(id_doctor);
 ;   ALTER TABLE ONLY public.cita DROP CONSTRAINT id_doctor_pk;
       public          postgres    false    223    226    4796            �           2606    33709    consulta id_doctor_pk    FK CONSTRAINT     ~   ALTER TABLE ONLY public.consulta
    ADD CONSTRAINT id_doctor_pk FOREIGN KEY (id_doctor) REFERENCES public.doctor(id_doctor);
 ?   ALTER TABLE ONLY public.consulta DROP CONSTRAINT id_doctor_pk;
       public          postgres    false    4796    228    223            �           2606    33714     doctor_especialidad id_doctor_pk    FK CONSTRAINT     �   ALTER TABLE ONLY public.doctor_especialidad
    ADD CONSTRAINT id_doctor_pk FOREIGN KEY (id_doctor) REFERENCES public.doctor(id_doctor);
 J   ALTER TABLE ONLY public.doctor_especialidad DROP CONSTRAINT id_doctor_pk;
       public          postgres    false    224    4796    223            �           2606    33492 &   doctor_especialidad id_especialidad_pk    FK CONSTRAINT     �   ALTER TABLE ONLY public.doctor_especialidad
    ADD CONSTRAINT id_especialidad_pk FOREIGN KEY (id_especialidad) REFERENCES public.especialidad(id_especialidad);
 P   ALTER TABLE ONLY public.doctor_especialidad DROP CONSTRAINT id_especialidad_pk;
       public          postgres    false    224    4790    220            �           2606    33681    cita id_paciente_pk    FK CONSTRAINT     �   ALTER TABLE ONLY public.cita
    ADD CONSTRAINT id_paciente_pk FOREIGN KEY (id_paciente) REFERENCES public.paciente(id_paciente);
 =   ALTER TABLE ONLY public.cita DROP CONSTRAINT id_paciente_pk;
       public          postgres    false    218    226    4786            �           2606    33686    consulta id_paciente_pk    FK CONSTRAINT     �   ALTER TABLE ONLY public.consulta
    ADD CONSTRAINT id_paciente_pk FOREIGN KEY (id_paciente) REFERENCES public.paciente(id_paciente);
 A   ALTER TABLE ONLY public.consulta DROP CONSTRAINT id_paciente_pk;
       public          postgres    false    4786    218    228            �           2606    33691    notificaciones id_paciente_pk    FK CONSTRAINT     �   ALTER TABLE ONLY public.notificaciones
    ADD CONSTRAINT id_paciente_pk FOREIGN KEY (id_paciente) REFERENCES public.paciente(id_paciente);
 G   ALTER TABLE ONLY public.notificaciones DROP CONSTRAINT id_paciente_pk;
       public          postgres    false    218    227    4786            �           2606    33566    consulta id_tipo_consulta_pk    FK CONSTRAINT     �   ALTER TABLE ONLY public.consulta
    ADD CONSTRAINT id_tipo_consulta_pk FOREIGN KEY (id_tipo_consulta) REFERENCES public.tipo_consulta(id_tipo_consulta);
 F   ALTER TABLE ONLY public.consulta DROP CONSTRAINT id_tipo_consulta_pk;
       public          postgres    false    228    4788    219            �           2606    33670    usuario id_tipo_usuario_pk    FK CONSTRAINT     �   ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT id_tipo_usuario_pk FOREIGN KEY (id_tipo_usuario) REFERENCES public.tipo_usuario(id_tipo_usuario);
 D   ALTER TABLE ONLY public.usuario DROP CONSTRAINT id_tipo_usuario_pk;
       public          postgres    false    4782    216    221            �           2606    33651    doctor id_usuario    FK CONSTRAINT     }   ALTER TABLE ONLY public.doctor
    ADD CONSTRAINT id_usuario FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario);
 ;   ALTER TABLE ONLY public.doctor DROP CONSTRAINT id_usuario;
       public          postgres    false    4792    221    223            �           2606    42003    asistente_doctor id_usuario_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.asistente_doctor
    ADD CONSTRAINT id_usuario_fk FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario);
 H   ALTER TABLE ONLY public.asistente_doctor DROP CONSTRAINT id_usuario_fk;
       public          postgres    false    221    4792    245            �           2606    33631 #   usuario_centro_medico id_usuario_pk    FK CONSTRAINT     �   ALTER TABLE ONLY public.usuario_centro_medico
    ADD CONSTRAINT id_usuario_pk FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario);
 M   ALTER TABLE ONLY public.usuario_centro_medico DROP CONSTRAINT id_usuario_pk;
       public          postgres    false    221    225    4792            �           2606    33636    accesos_usuario id_usuario_pk    FK CONSTRAINT     �   ALTER TABLE ONLY public.accesos_usuario
    ADD CONSTRAINT id_usuario_pk FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario);
 G   ALTER TABLE ONLY public.accesos_usuario DROP CONSTRAINT id_usuario_pk;
       public          postgres    false    221    4792    222            �           2606    33641    cita id_usuario_pk    FK CONSTRAINT     ~   ALTER TABLE ONLY public.cita
    ADD CONSTRAINT id_usuario_pk FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario);
 <   ALTER TABLE ONLY public.cita DROP CONSTRAINT id_usuario_pk;
       public          postgres    false    226    221    4792            �           2606    33646    consulta id_usuario_pk    FK CONSTRAINT     �   ALTER TABLE ONLY public.consulta
    ADD CONSTRAINT id_usuario_pk FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario);
 @   ALTER TABLE ONLY public.consulta DROP CONSTRAINT id_usuario_pk;
       public          postgres    false    228    221    4792            �           2606    33656    notificaciones id_usuario_pk    FK CONSTRAINT     �   ALTER TABLE ONLY public.notificaciones
    ADD CONSTRAINT id_usuario_pk FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario);
 F   ALTER TABLE ONLY public.notificaciones DROP CONSTRAINT id_usuario_pk;
       public          postgres    false    4792    227    221            x      x������ � �      }      x������ � �      �   [   x����@��)&ZòG/)#�+���&r!��@7�b����bMkG:Rg���G���H���7]��*���<+�>�� 5~3�3��      v   ^   x�3�t�9�6/39Q�)1�J!8�$_AM��� 5931'3%1%���/3/�4/���ˈ�95��(_���ʔ��|�0�@j^bQf�B��#��=... {N X      �   ?  x���Mn� ��p
_�����d�Vԍ�����m�0����<x�C\t�Ѕ�Hz���81L =����݇��9�Š'���h�C���XrlcRaC;�2&�=6f�2��a�=�k����C�Ԙ����J�&��P"ٯ+G2v(S��X�9k��^'%bu����yc{>��������lN?cb�7sIsb����On����\盧h���\��h^j����\}nL���Т,M�PY��PU3�X����nB� 74���lx�G
�b��\�u�"FTb��_E,x�8�y��0V      �      x������ � �      �      x������ � �      ~   �   x�5Qɍ�0{+��ò��T0el�X�v�|DK�2EE���M��'9���Z�#��\a{�$��r�Y�5]~_@ހfK���YrH�u�(5�8�����|酀��v���\��Ж���W�������M�{�p���L_��*�;O^[�#7	�t!:u|e0v �q$������)�eo5���Uwi[L&x{�x���;�D�Ib%�u՜?"��z�%ƕ��]0��\��d�P襖g��y��8�Y�         �   x�-��1�r0[��+�c�`^nq:&�f��`���G`\���p�.
��|NJAw%+����!Jm�j��Sm��#i�9�X�&�46(�bt�H����vGen�-�݋��jݧ��B7I"��pݬw&�:K�چ6�������5��������^��>r      {   �  x��V�nG��_1p L=�[ ئ`�����沉y��q �7
(�1�s��ݑ{:J��vof����{�yw.�mtq�>��1�\�$�B�[6�֑L�Ƒ��jo�)���l����畑`]���G�ΰ_S�۸җ�R���^hӧ\��?%Q!/�@��<��sƻ3Y@��C��%{�iWN^t�R�e�C�:��N�`�U���Ϡm��S�y�YI�:B����9�#�=�n�m=$��6�h�d�T8d��PJR���͒�@	+����7,!�6��M�h	?�,��lv+ci���:}�e�>cN6Lw���U)n̘�ғF���M�wU���R�c�A�
�Fc�<i�-}�C��X�9��4賈��(eD���	������6[Nj6:����"��Z����/Aa��}������X8�(�2���`���4���9�<Nߥ��e`���94��ay���J���
y5}�o�tvֽ�Mh��|-�a���Ď�>Է������㯼l+�!/(#�5��H��u�;nn<{�]\�Z�+�� �O6 D�JDm��!fq\!���B�V�[��|@ԷF�y���.v�jz䩁�����D;w�J��'jњ�Km����^�������h=���o��TK��k��fܪ#pB�7��R~;�n��+|-}�����Ϳ�3�Ɓ�3�3��u&��{ �H�2���K�t���������L2}M��m��Nw�BP�r/s�N�4ݧA��[a��w>��`���Dڹ�V]:b�5�ze�L[�B��0:aC�L�A������(HTv����z+2�0��5�6b����D���`U�ޔ�R���1�u3��ΓfM�x�M�����4oBYgA��O�_\�Q+|���C���Fb^���]��g�+w{�JX�,딸hz�����L^�Dz+��|��/}�8���#O�	_uD�(�Mw�߂�U�ʹ캕q2��ͬ��o(�ܿ�'''����&      �      x������ � �      y      x��UMr�0^˧���,�;B�2:e6l^m%��V+;@�q�z�\�';M���T�Hz��{�d^��P:����:�z���
n��?	S9c�љT�ڤ��B���H7�x�n��g�o�+��ֵ�Vh�y�y�׺Z o�~���+��Yn�������X��B�Bk����z�����B��鲟�KY@����" ��t������F�Y����)㤌��x�	B�Q��]��U�EAk:��`FK�kK�n7�?-}��k�����}�a=��ml��{�t^Y�R=@Ň�5#�&#�\"41,9S*��(�^����m�V6���M\�¨,��LʲT$��NY,� õ�)r\ߐ܌N�Aʥ���/+�r��t>���S�!�з�1�����9&�%P�鲟�K89w_-%�_�7�bȵ�ϥ�0�y�2�) �qˤ�9t妾� �w �OD ��ε�RY|�]��GG���)�w�14=W?W�4�>�j�������b7�;��F?3��<%h�]�<�\�)�0�ol�M��,}��=��B9#��SA@M��� E����9��%�춲?��(L�ưȃ�L�<#5w�}[�x��2)��'Gs&���L�+�aKE���Y"f#��~R#1�P�d~�V���qpYU&C^������!�Ŧ��}���h:;1+g������jl�xktG��'�M�L���G����9���]��L��F�8'ЩqJ�+q�e�ytҞC� ���T��2'>��"K>�%I�p�      �      x������ � �      z      x������ � �      w   9   x�3�tL����,.)JL�/�,�2�t�O.3�9��2�y%�
e%�e�@�=... ��I      |   �  x��X͎�6>�O�p�_����ۙL#�A���V3�:�dH�Y��s�a�G����?2ew�$��,}�*���8�V�����NO�[�uG�]Ӻj���N_�����_+*��K�TŬQk��\U�����~�\\�	f��v�wm�M3�/�\�>V�Z!c����Cs�d���k���On\U?�[��nBD�[Aň��5��G75`!����CN�v�aH+׌�a��0�~�>��A�kYs�\�5���/|�����-�R��+�Є����_ܾ�W�������6�t�ѧ�`��O����'4l[8Ϋ��s�/����y�F��nt�տ|7}ڧ fX�5�>�����i~�΀x�\Hnⶹ��&"xp�;�C�&)���ҀcN)���TΎ�w�.��V��,c)�F1kѻV�e�����돭�����n_��)	�R��r�S2��"yA6��!��I�.(%�rQ�{�Z`���.��VV �3��JCh�g�	��q��~*%gCaEo��8��M��MdV��fr��ׇ�9�gKX�6��<A)gDE���P����w�s.'�0��B�U9�`��D���wv��P���;�T��:d|���_D�1K,F'5���>@�4l旬 ̧ �e�Q��Y�lcՃ;���G�N��я�;:$=�5Hϑ��8��`6F+Sq��n�ۦzI_c ���f�#� lXt.:����4(��~c��4.�>�����!�]���QLyP�Yd�dDD~��0�n<��9�6�^�KƷ o�����f��m�2�	���@�Q�D8np��}p�,2��+�� .<����Ѵ���:l�������yR��LtGK�������
����9<���F���/4�ԥN��.W��E��et��m��"���%+ y�Z�q�ت�D�8ItO~<.��[&tj�b��.�t��VB�C����x�D�Q�a�:��5�д�?R��ZƢ����q��s��q\�S<P�&��e������yw�/��]�	���<��fl$=�����IB��ʠ�	�io��:����W�;X�94eD�Eh��E.���v%�Ëh]>g�Yו��\J"�q�o;���nlN�;�f�D����L����� oo����)�7�\#2�1P8��!�:�
�Ӯ�L�.�`
��RW`��㰒���4ibE����I�u�⭮�fid�_�]Y�9�%2���V]�7�↨
��Q�σ�0f0�4���xs�� |�şS�*4�z��A��HFZ�Έ����@|��<qp�arxɩ������}@�18�A�dQ���	
����s�qu�2s�U�?� m8�qH�,��۞�컇��n0`��/��t"�Ɓ��x��эnW*��25^�����)�� ��l�JA��)�߇�=��y@�@�M�/G�X��CB�U�A��&�yRQ�޿NG�yX���`�HT�2�m��F�}�E���h b�Ѻ~#X⑆�X��Z����0ǜCh~9z����B�_���m�{�9�2H�r���r
J�۞qY
���ă i¢b�O���Ϯ�0w�
e�NMZ�i�/��s��R���-aI��@c�W>�2�Ү��޿5�Sc%�N��V�����l�y��/�o�q���#Q�7;ף������[=��zB��L�M�<��d���M��-�)�lQZ�l�c26c��Jb�:���Y�Ul"�+�)�3��I/�a.���p�D�\��W�� �?܁pD�KIDt��?��_�k�T�bO0�㿝�$Nh����s�~Aly�߇���wM���Ͻ�B���.\T/	.'�F��'�U��P{$	��������u�م{v��P�ʖ��!�p��Y�r%�3	N��!�O��      �      x������ � �     