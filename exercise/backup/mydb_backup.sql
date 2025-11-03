--
-- PostgreSQL database dump
--

\restrict QF2qOcZURmSZIAXUXYuofREmUeXHczbcKOFZaYW9mevXSncTZLYgX491IfdVSei

-- Dumped from database version 17.6
-- Dumped by pg_dump version 17.6

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
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
-- Name: Users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Users" (
);


ALTER TABLE public."Users" OWNER TO postgres;

--
-- Name: test1; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.test1 (
    a boolean,
    b text
);


ALTER TABLE public.test1 OWNER TO postgres;

--
-- Data for Name: Users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Users"  FROM stdin;
\.


--
-- Data for Name: test1; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.test1 (a, b) FROM stdin;
t	sic est
f	non est
\.


--
-- PostgreSQL database dump complete
--

\unrestrict QF2qOcZURmSZIAXUXYuofREmUeXHczbcKOFZaYW9mevXSncTZLYgX491IfdVSei

