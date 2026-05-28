--
-- PostgreSQL database dump
--

-- Dumped from database version 12.22 (Ubuntu 12.22-0ubuntu0.20.04.4)
-- Dumped by pg_dump version 12.22 (Ubuntu 12.22-0ubuntu0.20.04.4)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE universe;
--
-- Name: universe; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE universe WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE universe OWNER TO freecodecamp;

\connect universe

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: galaxy; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.galaxy (
    galaxy_id integer NOT NULL,
    name character varying(30) NOT NULL,
    description text,
    has_life boolean,
    is_spherical boolean,
    age_in_millions_of_years integer,
    planet_types integer,
    galaxy_types integer,
    distance_from_earth numeric(5,2)
);


ALTER TABLE public.galaxy OWNER TO freecodecamp;

--
-- Name: moon; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.moon (
    moon_id integer NOT NULL,
    name character varying(30) NOT NULL,
    planet_id integer NOT NULL,
    description text,
    has_life boolean,
    is_spherical boolean,
    age_in_millions_of_years integer,
    nearby_planets integer,
    distance_from_earth numeric(5,2)
);


ALTER TABLE public.moon OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.moon_moon_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.moon_moon_id_seq OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.moon_moon_id_seq OWNED BY public.moon.moon_id;


--
-- Name: planet; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.planet (
    planet_id integer NOT NULL,
    name character varying(30) NOT NULL,
    star_id integer,
    description text,
    has_life boolean,
    is_spherical boolean,
    age_in_millions_of_years integer,
    planet_type integer,
    distance_from_earth numeric(5,2)
);


ALTER TABLE public.planet OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.planet_planet_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.planet_planet_id_seq OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.planet_planet_id_seq OWNED BY public.planet.planet_id;


--
-- Name: planet_type; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.planet_type (
    planet_type_id integer NOT NULL,
    name character varying(30) NOT NULL,
    description text
);


ALTER TABLE public.planet_type OWNER TO freecodecamp;

--
-- Name: planet_type_planet_type_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.planet_type_planet_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.planet_type_planet_type_id_seq OWNER TO freecodecamp;

--
-- Name: planet_type_planet_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.planet_type_planet_type_id_seq OWNED BY public.planet_type.planet_type_id;


--
-- Name: star; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.star (
    star_id integer NOT NULL,
    name character varying(30) NOT NULL,
    galaxy_id integer NOT NULL,
    description text,
    has_life boolean,
    is_spherical boolean,
    age_in_millions_of_years integer,
    surrounding_planets integer,
    distance_from_earth numeric(5,2)
);


ALTER TABLE public.star OWNER TO freecodecamp;

--
-- Name: star_galaxy_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.star_galaxy_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.star_galaxy_id_seq OWNER TO freecodecamp;

--
-- Name: star_galaxy_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.star_galaxy_id_seq OWNED BY public.star.galaxy_id;


--
-- Name: star_star_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.star_star_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.star_star_id_seq OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.star_star_id_seq OWNED BY public.star.star_id;


--
-- Name: moon moon_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon ALTER COLUMN moon_id SET DEFAULT nextval('public.moon_moon_id_seq'::regclass);


--
-- Name: planet planet_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet ALTER COLUMN planet_id SET DEFAULT nextval('public.planet_planet_id_seq'::regclass);


--
-- Name: planet_type planet_type_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet_type ALTER COLUMN planet_type_id SET DEFAULT nextval('public.planet_type_planet_type_id_seq'::regclass);


--
-- Name: star star_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star ALTER COLUMN star_id SET DEFAULT nextval('public.star_star_id_seq'::regclass);


--
-- Name: star galaxy_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star ALTER COLUMN galaxy_id SET DEFAULT nextval('public.star_galaxy_id_seq'::regclass);


--
-- Data for Name: galaxy; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.galaxy VALUES (1, 'Milky', 'Earth Galaxy', true, true, 10, NULL, NULL, 500.27);
INSERT INTO public.galaxy VALUES (2, 'Andro', 'Second Discovered Galaxy', true, true, 10, NULL, NULL, 700.35);
INSERT INTO public.galaxy VALUES (3, 'Palo', 'Third Discovered Galaxy', false, true, 10, NULL, NULL, 700.35);
INSERT INTO public.galaxy VALUES (4, 'Marolo', 'Fourth Discovered Galaxy', false, true, 10, NULL, NULL, 800.35);
INSERT INTO public.galaxy VALUES (5, 'Stulendo', 'Fifth Discovered Galaxy', false, true, 10, NULL, NULL, 850.35);
INSERT INTO public.galaxy VALUES (6, 'Wariolo', 'Sixth Discovered Galaxy', false, true, 10, NULL, NULL, 900.35);


--
-- Data for Name: moon; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.moon VALUES (1, 'Wiggley', 1, 'Squiggle Moon', false, false, 8, 1, 100.98);
INSERT INTO public.moon VALUES (2, 'Wigglesworth', 1, 'Smaller Squiggle Moon', false, false, 8, 1, 100.98);
INSERT INTO public.moon VALUES (3, 'Elphonso', 2, 'Petite Moon', false, false, 8, 2, 150.98);
INSERT INTO public.moon VALUES (4, 'Blorf', 3, 'Lime Moon', false, false, 10, 2, 200.98);
INSERT INTO public.moon VALUES (5, 'Snookums', 4, 'Pink Moon', false, false, 10, 2, 200.98);
INSERT INTO public.moon VALUES (6, 'Boozy', 4, 'Beer Shaped  Moon', false, false, 10, 2, 200.98);
INSERT INTO public.moon VALUES (7, 'Cleetus', 4, 'Oval Moon', false, false, 10, 2, 250.98);
INSERT INTO public.moon VALUES (8, 'Pi', 5, 'Pi Shaped Moon', false, false, 10, 2, 300.98);
INSERT INTO public.moon VALUES (9, 'Li', 5, 'Link  Moon', false, false, 10, 2, 300.98);
INSERT INTO public.moon VALUES (10, 'Blobber', 5, 'Blob Moon', false, false, 10, 2, 350.98);
INSERT INTO public.moon VALUES (11, 'Boo', 6, 'Boo Moon', false, false, 10, 1, 600.98);
INSERT INTO public.moon VALUES (12, 'Hoo', 6, 'Hoo Moon', false, false, 10, 1, 600.98);
INSERT INTO public.moon VALUES (13, 'Woo', 6, 'Woo Moon', false, false, 10, 1, 600.98);
INSERT INTO public.moon VALUES (14, 'Badoo', 6, 'Badoo Moon', false, false, 10, 1, 600.98);
INSERT INTO public.moon VALUES (15, 'Wahoo', 6, 'Wahoo Moon', false, false, 10, 1, 600.98);
INSERT INTO public.moon VALUES (16, 'Zip', 7, 'Lightining Moon', false, false, 10, 1, 700.98);
INSERT INTO public.moon VALUES (17, 'Zap', 7, 'Lightining Moon', false, false, 10, 1, 700.98);
INSERT INTO public.moon VALUES (18, 'Zop', 7, 'Lightining Moon', false, false, 10, 1, 700.98);
INSERT INTO public.moon VALUES (19, 'Zapee', 7, 'Lightining Moon', false, false, 10, 1, 700.98);
INSERT INTO public.moon VALUES (20, 'Zipee', 7, 'Lightining Moon', false, false, 10, 1, 700.98);
INSERT INTO public.moon VALUES (21, 'Zopeee', 7, 'Lightining Moon', false, false, 10, 1, 700.98);


--
-- Data for Name: planet; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.planet VALUES (1, 'Mars', 1, 'Rocky Red', false, true, 10, 1, 100.69);
INSERT INTO public.planet VALUES (2, 'Venus', 1, 'Orange Rock', false, true, 10, 1, 120.69);
INSERT INTO public.planet VALUES (3, 'Jupyter', 1, 'Gas Giant', false, true, 10, 1, 150.69);
INSERT INTO public.planet VALUES (4, 'Uranus', 1, 'Big Blue', false, true, 10, 2, 160.69);
INSERT INTO public.planet VALUES (5, 'Pluto', 1, 'Small Planet', false, true, 10, 2, 170.69);
INSERT INTO public.planet VALUES (6, 'Scuba', 2, 'Water Planet', true, true, 10, 3, 300.69);
INSERT INTO public.planet VALUES (7, 'Baluba', 2, 'Big Water Planet', true, true, 10, 3, 350.69);
INSERT INTO public.planet VALUES (8, 'Hoho', 2, 'Hollow Planet', false, true, 10, 2, 400.69);
INSERT INTO public.planet VALUES (9, 'Nether', 3, 'Dark Planet', false, true, 10, 2, 700.69);
INSERT INTO public.planet VALUES (10, 'Netherite', 3, 'Small Dark Planet', false, true, 10, 2, 750.69);
INSERT INTO public.planet VALUES (11, 'Oob', 4, 'Planet of Goo', false, true, 10, 2, 800.69);
INSERT INTO public.planet VALUES (12, 'Palhala', 4, 'Unknown Planet', false, true, 10, 2, 850.69);


--
-- Data for Name: planet_type; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.planet_type VALUES (1, 'Rocky', 'Desolate rock planet');
INSERT INTO public.planet_type VALUES (2, 'Forest', 'Planet with plants and forests');
INSERT INTO public.planet_type VALUES (3, 'Water', 'Planet of water');


--
-- Data for Name: star; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.star VALUES (1, 'Sun', 1, 'Milky Star', false, true, 10, NULL, 10.25);
INSERT INTO public.star VALUES (2, 'Plasma', 2, 'Andro Star', false, true, 10, NULL, 100.25);
INSERT INTO public.star VALUES (3, 'Booma', 3, 'Palo Star', false, true, 10, NULL, 200.25);
INSERT INTO public.star VALUES (4, 'Booma Prime', 3, 'Palo Star', false, true, 10, NULL, 300.25);
INSERT INTO public.star VALUES (5, 'Morosta', 4, 'Marolo Star', false, true, 10, NULL, 700.25);
INSERT INTO public.star VALUES (6, 'Stusta', 5, 'Stulendo Star', false, true, 10, NULL, 850.25);


--
-- Name: moon_moon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.moon_moon_id_seq', 21, true);


--
-- Name: planet_planet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.planet_planet_id_seq', 12, true);


--
-- Name: planet_type_planet_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.planet_type_planet_type_id_seq', 3, true);


--
-- Name: star_galaxy_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.star_galaxy_id_seq', 1, false);


--
-- Name: star_star_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.star_star_id_seq', 6, true);


--
-- Name: galaxy galaxy_galaxy_id_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_galaxy_id_key UNIQUE (galaxy_id);


--
-- Name: galaxy galaxy_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_pkey PRIMARY KEY (galaxy_id);


--
-- Name: moon moon_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_name_key UNIQUE (name);


--
-- Name: moon moon_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_pkey PRIMARY KEY (moon_id);


--
-- Name: planet planet_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_name_key UNIQUE (name);


--
-- Name: planet planet_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_pkey PRIMARY KEY (planet_id);


--
-- Name: planet_type planet_type_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet_type
    ADD CONSTRAINT planet_type_name_key UNIQUE (name);


--
-- Name: planet_type planet_type_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet_type
    ADD CONSTRAINT planet_type_pkey PRIMARY KEY (planet_type_id);


--
-- Name: star star_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_name_key UNIQUE (name);


--
-- Name: star star_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_pkey PRIMARY KEY (star_id);


--
-- Name: moon moon_planet_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_planet_id_fkey FOREIGN KEY (planet_id) REFERENCES public.planet(planet_id);


--
-- Name: planet planet_star_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_star_id_fkey FOREIGN KEY (star_id) REFERENCES public.star(star_id);


--
-- Name: star star_galaxy_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_galaxy_id_fkey FOREIGN KEY (galaxy_id) REFERENCES public.galaxy(galaxy_id);


--
-- PostgreSQL database dump complete
--

