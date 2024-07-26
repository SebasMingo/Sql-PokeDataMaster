-- Crear tablas
CREATE TABLE batallas
(
     id serial NOT NULL,
    entrenador_1_id integer,
    entrenador_2_id integer,
    pokemon_1_id integer,
    pokemon_2_id integer,
    fecha date,
    resultado character varying(50) COLLATE pg_catalog."default",
    CONSTRAINT batallas_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public.entrenadores
(
    id serial NOT NULL,
    nombre character varying(50) COLLATE pg_catalog."default" NOT NULL,
    edad integer,
    ciudad character varying(50) COLLATE pg_catalog."default",
    CONSTRAINT entrenadores_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public.entrenadores_pokemon
(
    entrenador_id integer NOT NULL,
    pokemon_id integer NOT NULL,
    CONSTRAINT entrenadores_pokemon_pkey PRIMARY KEY (entrenador_id, pokemon_id)
);

CREATE TABLE IF NOT EXISTS public.pokemon
(
    id serial NOT NULL,
    nombre character varying(50) COLLATE pg_catalog."default" NOT NULL,
    tipo character varying(20) COLLATE pg_catalog."default" NOT NULL,
    habilidad character varying(50) COLLATE pg_catalog."default",
    ataque integer,
    defensa integer,
    velocidad integer,
    CONSTRAINT pokemon_pkey PRIMARY KEY (id)
);

-- Definir claves foráneas
ALTER TABLE IF EXISTS public.batallas
    ADD CONSTRAINT batallas_entrenador_1_id_fkey FOREIGN KEY (entrenador_1_id)
    REFERENCES public.entrenadores (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;

ALTER TABLE IF EXISTS public.batallas
    ADD CONSTRAINT batallas_entrenador_2_id_fkey FOREIGN KEY (entrenador_2_id)
    REFERENCES public.entrenadores (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;

ALTER TABLE IF EXISTS public.batallas
    ADD CONSTRAINT batallas_pokemon_1_id_fkey FOREIGN KEY (pokemon_1_id)
    REFERENCES public.pokemon (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;

ALTER TABLE IF EXISTS public.batallas
    ADD CONSTRAINT batallas_pokemon_2_id_fkey FOREIGN KEY (pokemon_2_id)
    REFERENCES public.pokemon (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;

ALTER TABLE IF EXISTS public.entrenadores_pokemon
    ADD CONSTRAINT entrenadores_pokemon_entrenador_id_fkey FOREIGN KEY (entrenador_id)
    REFERENCES public.entrenadores (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;

ALTER TABLE IF EXISTS public.entrenadores_pokemon
    ADD FOREIGN KEY (pokemon_id)
    REFERENCES public.pokemon (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;

-- Insertar datos en la tabla de Pokemon
INSERT INTO Pokemon (id, nombre, tipo, habilidad, ataque, defensa, velocidad)
VALUES
    (1, 'Bulbasaur', 'Planta', 'Veneno', 49, 49, 45),
    (2, 'Ivysaur', 'Planta', 'Veneno', 62, 63, 60),
    (3, 'Venusaur', 'Planta', 'Veneno', 82, 83, 80),
    (4, 'Charmander', 'Fuego', NULL, 52, 43, 65),
    (5, 'Charmeleon', 'Fuego', NULL, 64, 58, 80),
    (6, 'Charizard', 'Fuego', 'Volador', 84, 78, 100),
    (7, 'Squirtle', 'Agua', NULL, 48, 65, 43),
    (8, 'Wartortle', 'Agua', NULL, 63, 80, 58),
    (9, 'Blastoise', 'Agua', NULL, 83, 100, 78),
    (10, 'Caterpie', 'Bicho', NULL, 30, 35, 45),
    (11, 'Metapod', 'Bicho', NULL, 20, 55, 30),
    (12, 'Butterfree', 'Bicho', 'Volador', 45, 50, 70),
    (13, 'Weedle', 'Bicho', 'Veneno', 35, 30, 50),
    (14, 'Kakuna', 'Bicho', 'Veneno', 25, 50, 35),
    (15, 'Beedrill', 'Bicho', 'Veneno', 90, 40, 75),
    (16, 'Pidgey', 'Normal', 'Volador', 45, 40, 56),
    (17, 'Pidgeotto', 'Normal', 'Volador', 60, 55, 71),
    (18, 'Pidgeot', 'Normal', 'Volador', 80, 75, 101),
    (19, 'Rattata', 'Normal', NULL, 56, 35, 72),
    (20, 'Raticate', 'Normal', NULL, 81, 60, 97);

-- Insertar datos en la tabla de Entrenadores
INSERT INTO Entrenadores (id, nombre, edad, ciudad)
VALUES
    (1, 'Ash Ketchum', 10, 'Pueblo Paleta'),
    (2, 'Misty', 12, 'Ciudad Celeste');

-- Relacionar entrenadores con Pokémon
INSERT INTO entrenadores_pokemon (entrenador_id, pokemon_id)
VALUES
    (1, 1), -- Ash tiene a Bulbasaur
    (2, 4); -- Misty tiene a Charmander

-- Seleccionar todos los Pokémon
SELECT * FROM Pokemon;

-- Seleccionar todos los entrenadores
SELECT * FROM Entrenadores;

-- Leer información específica
SELECT * FROM Pokemon WHERE nombre = 'Bulbasaur';

-- Actualizar datos de un Pokémon
UPDATE public.pokemon
SET nombre = 'Pikachu', tipo = 'Eléctrico', habilidad = 'Electricidad Estática', ataque = 90, defensa = 55, velocidad = 110
WHERE nombre = 'Raticate';

-- Mostrar detalles de Pokémon y sus entrenadores
SELECT E.nombre AS entrenador, P.nombre AS pokemon
FROM Entrenadores E
JOIN Entrenadores_Pokemon EP ON E.id = EP.entrenador_id
JOIN Pokemon P ON EP.pokemon_id = P.id;

-- Mostrar información sobre batallas
SELECT E1.nombre AS entrenador1, E2.nombre AS entrenador2, P1.nombre AS pokemon1, P2.nombre AS pokemon2, B.fecha, B.resultado
FROM Batallas B
JOIN Entrenadores E1 ON B.entrenador_1_id = E1.id
JOIN Entrenadores E2 ON B.entrenador_2_id = E2.id
JOIN Pokemon P1 ON B.pokemon_1_id = P1.id
JOIN Pokemon P2 ON B.pokemon_2_id = P2.id;

-- Insertar una batalla
INSERT INTO Batallas (entrenador_1_id, entrenador_2_id, pokemon_1_id, pokemon_2_id, fecha, resultado)
VALUES
(1, 2, 1, 4, '2024-07-20', 'Ash ganó');

-- Insertar un nuevo Pokémon
INSERT INTO Pokemon (id, nombre, tipo, habilidad, ataque, defensa, velocidad)
VALUES (26, 'Bulbasaur', 'Planta', 'Clorofila', 49, 49, 45);

-- Eliminar un Pokémon
DELETE FROM public.pokemon
WHERE nombre = 'Pidgey';
