-- Generado por Oracle SQL Developer Data Modeler 4.2.0.932
--   en:        2017-09-24 20:10:30 CDT
--   sitio:      Oracle Database 11g
--   tipo:      Oracle Database 11g



CREATE TABLE cargo (
    id_cargo                      NUMBER(8) NOT NULL,
    nombre_cargo                  VARCHAR2(30) NOT NULL,
    salario_minimo                NUMBER(10) NOT NULL,
    funcionario_rut_funcionario   VARCHAR2(10) NOT NULL
);

CREATE UNIQUE INDEX cargo__idx ON
    cargo ( funcionario_rut_funcionario ASC );

ALTER TABLE cargo ADD CONSTRAINT cargo_pk PRIMARY KEY ( id_cargo );

CREATE TABLE departamento (
    id_depto       NUMBER(8) NOT NULL,
    nombre_depto   VARCHAR2(255) NOT NULL
);

ALTER TABLE departamento ADD CONSTRAINT departamento_pk PRIMARY KEY ( id_depto );

CREATE TABLE estado (
    id_estado            NUMBER(8) NOT NULL,
    nombre_estado        VARCHAR2(15) NOT NULL,
    permiso_id_permiso   NUMBER(8) NOT NULL
);

COMMENT ON COLUMN estado.id_estado IS
    'Numero unico primario y relacionador de un campo dentro de la tabla Estado.';

COMMENT ON COLUMN estado.nombre_estado IS
    'Nombre de uno de los posibles estados de un permiso determinado.';

ALTER TABLE estado ADD CONSTRAINT estado_pk PRIMARY KEY ( id_estado );

CREATE TABLE funcionario (
    rut_funcionario                VARCHAR2(10) NOT NULL,
    primer_nombre                  VARCHAR2(10) NOT NULL,
    segundo_nombre                 VARCHAR2(10) NOT NULL,
    primer_apellido                VARCHAR2(10) NOT NULL,
    segundo_apellido               VARCHAR2(10) NOT NULL,
    telefono_funionario            VARCHAR2(10) NOT NULL,
    sexo_funionario                VARCHAR2(9) NOT NULL,
    correo_funionario              VARCHAR2(15),
    usuario_id_usuario             NUMBER(8) NOT NULL,
    cargo_id_cargo                 NUMBER(8) NOT NULL,
    departamento_id_depto          NUMBER(8) NOT NULL,
    historial_cargo_fecha_inicio   DATE NOT NULL
);

COMMENT ON COLUMN funcionario.rut_funcionario IS
    'Identificador  unico e irrpetible de cada funcionario. No pueden existir 2 o mas iguales.';

COMMENT ON COLUMN funcionario.primer_nombre IS
    'Primer nombre del funionario.';

COMMENT ON COLUMN funcionario.segundo_nombre IS
    'Segundo nombre del funionario.';

COMMENT ON COLUMN funcionario.primer_apellido IS
    'Primer apellido  del funionario';

COMMENT ON COLUMN funcionario.segundo_apellido IS
    'Segundo  apellido  del funionario';

COMMENT ON COLUMN funcionario.telefono_funionario IS
    'Numero telefonico indicado por el funcionario.';

COMMENT ON COLUMN funcionario.sexo_funionario IS
    'Sexo del Funcionario,puede ser Femenino o Masculino';

CREATE UNIQUE INDEX funcionario__idx ON
    funcionario ( cargo_id_cargo ASC );

CREATE UNIQUE INDEX funcionario__idxv1 ON
    funcionario ( historial_cargo_fecha_inicio ASC );

CREATE UNIQUE INDEX funcionario__idxv2 ON
    funcionario ( usuario_id_usuario ASC );

ALTER TABLE funcionario ADD CONSTRAINT funcionario_pk PRIMARY KEY ( rut_funcionario );

CREATE TABLE historial_cargo (
    fecha_inicio                  DATE NOT NULL,
    fecha_termino                 DATE,
    cargo_id_cargo                NUMBER(8) NOT NULL,
    funcionario_rut_funcionario   VARCHAR2(10) NOT NULL
);

CREATE UNIQUE INDEX historial_cargo__idx ON
    historial_cargo ( funcionario_rut_funcionario ASC );

ALTER TABLE historial_cargo ADD CONSTRAINT historial_cargo_pk PRIMARY KEY ( fecha_inicio );

CREATE TABLE hora_extra (
    id_hora_extra                 NUMBER(8) NOT NULL,
    cantidad_hora                 NUMBER(3) NOT NULL,
    mes_id_mes                    NUMBER(8) NOT NULL,
    funcionario_rut_funcionario   VARCHAR2(10) NOT NULL
);

COMMENT ON COLUMN hora_extra.id_hora_extra IS
    'Numero único e irrepetible asociado a una fila de Horas';

COMMENT ON COLUMN hora_extra.cantidad_hora IS
    'Cantidad de horas extras realizadas por un funcionario.';

ALTER TABLE hora_extra ADD CONSTRAINT hora_extra_pk PRIMARY KEY ( id_hora_extra );

CREATE TABLE mes (
    id_mes       NUMBER(8) NOT NULL,
    nombre_mes   VARCHAR2(15) NOT NULL
);

COMMENT ON COLUMN mes.id_mes IS
    'Numero del mes del año del registro. Es unico e Irrepetible su valor minimo es 1 y su valor máximo es 12.';

ALTER TABLE mes ADD CONSTRAINT mes_pk PRIMARY KEY ( id_mes );

CREATE TABLE motivo (
    id_motivo            NUMBER(8) NOT NULL,
    nombre_motivo        VARCHAR2(15) NOT NULL,
    descripcion_motivo   VARCHAR2(255) NOT NULL,
    permiso_id_permiso   NUMBER(8) NOT NULL
);

COMMENT ON COLUMN motivo.id_motivo IS
    'Numero unico e irrepetible que va relacionado a una fila de la tabla motivo.';

COMMENT ON COLUMN motivo.nombre_motivo IS
    'Nombre del motivo por el cuál el funcionario presenta solicitud del permiso';

COMMENT ON COLUMN motivo.descripcion_motivo IS
    'Descripción del motivo por el cuál el funcionario presenta solicitud del permiso';

CREATE UNIQUE INDEX motivo__idx ON
    motivo ( permiso_id_permiso ASC );

ALTER TABLE motivo ADD CONSTRAINT motivo_pk PRIMARY KEY ( id_motivo );

CREATE TABLE perfil (
    id_perfil            NUMBER(8) NOT NULL,
    nombre_perfil        VARCHAR2(15) NOT NULL,
    descripcion_perfil   VARCHAR2(255) NOT NULL,
    usuario_id_usuario   NUMBER(8) NOT NULL
);

COMMENT ON COLUMN perfil.id_perfil IS
    'Numero unico e irrepetible asociado a una fila de la tabla perfil';

COMMENT ON COLUMN perfil.nombre_perfil IS
    'Nombre del perfil en el cual se ha inciado sesión.';

COMMENT ON COLUMN perfil.descripcion_perfil IS
    'Descripion y caracteristicas de el perfil al que se asocia. ';

CREATE UNIQUE INDEX perfil__idx ON
    perfil ( usuario_id_usuario ASC );

ALTER TABLE perfil ADD CONSTRAINT perfil_pk PRIMARY KEY ( id_perfil );

CREATE TABLE permiso (
    id_permiso           NUMBER(8) NOT NULL,
    pdf_permiso          BLOB,
    resolucion_permiso   VARCHAR2(255),
    motivo_id_motivo     NUMBER(8) NOT NULL,
    tipo_id_tipo         NUMBER(8) NOT NULL,
    usuario_id_usuario   NUMBER(8) NOT NULL
);

COMMENT ON COLUMN permiso.id_permiso IS
    'Numero interno primario de la tabla y unico para cada permiso registrado en la base de datos.';

COMMENT ON COLUMN permiso.pdf_permiso IS
    'El documento del permiso en formato *.pdf  y se almacena en la base de datos en formato binario para ser codificado completamente al ser guardado y faciitar su llamada. '
;

COMMENT ON COLUMN permiso.resolucion_permiso IS
    'Almacena el resultado de la resoluión resultante de la solicitud de permiso enviada por algun funcionario.';

CREATE UNIQUE INDEX permiso__idx ON
    permiso ( motivo_id_motivo ASC );

CREATE UNIQUE INDEX permiso__idxv1 ON
    permiso ( tipo_id_tipo ASC );

ALTER TABLE permiso ADD CONSTRAINT permiso_pk PRIMARY KEY ( id_permiso );

CREATE TABLE tipo (
    id_tipo              NUMBER(8) NOT NULL,
    nombre_tipo          VARCHAR2(15) NOT NULL,
    descripcion_tipo     VARCHAR2(50) NOT NULL,
    permiso_id_permiso   NUMBER(8) NOT NULL
);

COMMENT ON COLUMN tipo.id_tipo IS
    'Numero del Tipo Unico e irrepetible dentro de la tabla.';

COMMENT ON COLUMN tipo.nombre_tipo IS
    'Nombre del tipo de Permiso que se esta solicitando.';

COMMENT ON COLUMN tipo.descripcion_tipo IS
    'Descripcón del tipo de Permiso que se esta solicitando.';

CREATE UNIQUE INDEX tipo__idx ON
    tipo ( permiso_id_permiso ASC );

ALTER TABLE tipo ADD CONSTRAINT tipo_pk PRIMARY KEY ( id_tipo );

CREATE TABLE usuario (
    id_usuario                    NUMBER(8) NOT NULL,
    nombre_usuario                VARCHAR2(30) NOT NULL,
    clave_usuario                 VARCHAR2(255) NOT NULL,
    funcionario_rut_funcionario   VARCHAR2(10) NOT NULL,
    perfil_id_perfil              NUMBER(8) NOT NULL
);

COMMENT ON COLUMN usuario.nombre_usuario IS
    'Nombre del usuario que ingresa al sistema,asociado a un funcionario.';

COMMENT ON COLUMN usuario.clave_usuario IS
    'Clave de ingreso de un usuario.';

CREATE UNIQUE INDEX usuario__idx ON
    usuario ( perfil_id_perfil ASC );

CREATE UNIQUE INDEX usuario__idxv1 ON
    usuario ( funcionario_rut_funcionario ASC );

ALTER TABLE usuario ADD CONSTRAINT usuario_pk PRIMARY KEY ( id_usuario );

ALTER TABLE cargo ADD CONSTRAINT cargo_funcionario_fk FOREIGN KEY ( funcionario_rut_funcionario )
    REFERENCES funcionario ( rut_funcionario );

ALTER TABLE estado ADD CONSTRAINT estado_permiso_fk FOREIGN KEY ( permiso_id_permiso )
    REFERENCES permiso ( id_permiso );

ALTER TABLE funcionario ADD CONSTRAINT funcionario_cargo_fk FOREIGN KEY ( cargo_id_cargo )
    REFERENCES cargo ( id_cargo );

ALTER TABLE funcionario ADD CONSTRAINT funcionario_departamento_fk FOREIGN KEY ( departamento_id_depto )
    REFERENCES departamento ( id_depto );

ALTER TABLE funcionario ADD CONSTRAINT funcionario_historial_cargo_fk FOREIGN KEY ( historial_cargo_fecha_inicio )
    REFERENCES historial_cargo ( fecha_inicio );

ALTER TABLE funcionario ADD CONSTRAINT funcionario_usuario_fk FOREIGN KEY ( usuario_id_usuario )
    REFERENCES usuario ( id_usuario );

ALTER TABLE historial_cargo ADD CONSTRAINT historial_cargo_cargo_fk FOREIGN KEY ( cargo_id_cargo )
    REFERENCES cargo ( id_cargo );

ALTER TABLE historial_cargo ADD CONSTRAINT historial_cargo_funcionario_fk FOREIGN KEY ( funcionario_rut_funcionario )
    REFERENCES funcionario ( rut_funcionario );

ALTER TABLE hora_extra ADD CONSTRAINT hora_extra_funcionario_fk FOREIGN KEY ( funcionario_rut_funcionario )
    REFERENCES funcionario ( rut_funcionario );

ALTER TABLE hora_extra ADD CONSTRAINT hora_extra_mes_fk FOREIGN KEY ( mes_id_mes )
    REFERENCES mes ( id_mes );

ALTER TABLE motivo ADD CONSTRAINT motivo_permiso_fk FOREIGN KEY ( permiso_id_permiso )
    REFERENCES permiso ( id_permiso );

ALTER TABLE perfil ADD CONSTRAINT perfil_usuario_fk FOREIGN KEY ( usuario_id_usuario )
    REFERENCES usuario ( id_usuario );

ALTER TABLE permiso ADD CONSTRAINT permiso_motivo_fk FOREIGN KEY ( motivo_id_motivo )
    REFERENCES motivo ( id_motivo );

ALTER TABLE permiso ADD CONSTRAINT permiso_tipo_fk FOREIGN KEY ( tipo_id_tipo )
    REFERENCES tipo ( id_tipo );

ALTER TABLE permiso ADD CONSTRAINT permiso_usuario_fk FOREIGN KEY ( usuario_id_usuario )
    REFERENCES usuario ( id_usuario );

ALTER TABLE tipo ADD CONSTRAINT tipo_permiso_fk FOREIGN KEY ( permiso_id_permiso )
    REFERENCES permiso ( id_permiso );

ALTER TABLE usuario ADD CONSTRAINT usuario_funcionario_fk FOREIGN KEY ( funcionario_rut_funcionario )
    REFERENCES funcionario ( rut_funcionario );

ALTER TABLE usuario ADD CONSTRAINT usuario_perfil_fk FOREIGN KEY ( perfil_id_perfil )
    REFERENCES perfil ( id_perfil );



-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            12
-- CREATE INDEX                            12
-- ALTER TABLE                             30
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
