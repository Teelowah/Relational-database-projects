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

DROP DATABASE number_guess;
--
-- Name: number_guess; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE number_guess WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE number_guess OWNER TO freecodecamp;

\connect number_guess

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
-- Name: user_information; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.user_information (
    user_id integer NOT NULL,
    username character varying(22) NOT NULL,
    games_played integer,
    best_game integer
);


ALTER TABLE public.user_information OWNER TO freecodecamp;

--
-- Name: user_information_user_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.user_information_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_information_user_id_seq OWNER TO freecodecamp;

--
-- Name: user_information_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.user_information_user_id_seq OWNED BY public.user_information.user_id;


--
-- Name: user_information user_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.user_information ALTER COLUMN user_id SET DEFAULT nextval('public.user_information_user_id_seq'::regclass);


--
-- Data for Name: user_information; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.user_information VALUES (1, 'Tee', 2, 7);
INSERT INTO public.user_information VALUES (3, 'user_1785530372910', 2, 613);
INSERT INTO public.user_information VALUES (2, 'user_1785530372911', 5, 41);
INSERT INTO public.user_information VALUES (5, 'user_1785530409677', 2, 623);
INSERT INTO public.user_information VALUES (4, 'user_1785530409678', 5, 81);
INSERT INTO public.user_information VALUES (7, 'user_1785530472346', 2, 265);
INSERT INTO public.user_information VALUES (6, 'user_1785530472347', 5, 557);
INSERT INTO public.user_information VALUES (9, 'user_1785530642586', 2, 325);
INSERT INTO public.user_information VALUES (8, 'user_1785530642587', 5, 425);


--
-- Name: user_information_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.user_information_user_id_seq', 9, true);


--
-- Name: user_information user_information_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.user_information
    ADD CONSTRAINT user_information_pkey PRIMARY KEY (user_id);


--
-- Name: user_information user_information_username_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.user_information
    ADD CONSTRAINT user_information_username_key UNIQUE (username);


--
-- PostgreSQL database dump complete
--

