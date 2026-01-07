--
-- PostgreSQL database dump
--

\restrict U6esz0YFWFadOpZLCaveAtoBYWTOfeHz14PXZp3cNlSetYvPXafzyhkGpMtytNA

-- Dumped from database version 18.1 (Debian 18.1-1.pgdg13+2)
-- Dumped by pg_dump version 18.1 (Debian 18.1-1.pgdg13+2)

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

--
-- Name: pg_trgm; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_trgm WITH SCHEMA public;


--
-- Name: EXTENSION pg_trgm; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_trgm IS 'text similarity measurement and index searching based on trigrams';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: emprunt; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.emprunt (
    id_emprunt integer NOT NULL,
    id_etud integer NOT NULL,
    isbn character(13) NOT NULL,
    date_emprunt date NOT NULL,
    date_retour date,
    amende numeric(5,2) DEFAULT 0
);


ALTER TABLE public.emprunt OWNER TO postgres;

--
-- Name: emprunt_id_emprunt_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.emprunt_id_emprunt_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.emprunt_id_emprunt_seq OWNER TO postgres;

--
-- Name: emprunt_id_emprunt_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.emprunt_id_emprunt_seq OWNED BY public.emprunt.id_emprunt;


--
-- Name: etudiant; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.etudiant (
    id_etud integer NOT NULL,
    nom character varying(50) NOT NULL,
    prenom character varying(50) NOT NULL,
    email character varying(100) NOT NULL,
    date_inscription date DEFAULT CURRENT_DATE,
    solde_amende numeric(5,2) DEFAULT 0,
    CONSTRAINT etudiant_solde_amende_check CHECK ((solde_amende >= (0)::numeric))
);


ALTER TABLE public.etudiant OWNER TO postgres;

--
-- Name: etudiant_id_etud_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.etudiant_id_etud_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.etudiant_id_etud_seq OWNER TO postgres;

--
-- Name: etudiant_id_etud_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.etudiant_id_etud_seq OWNED BY public.etudiant.id_etud;


--
-- Name: livre; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.livre (
    isbn character(13) NOT NULL,
    titre character varying(200) NOT NULL,
    editeur character varying(100),
    annee integer,
    exemplaires_dispo integer DEFAULT 1,
    CONSTRAINT livre_annee_check CHECK (((1900 < annee) AND (annee < 2027))),
    CONSTRAINT livre_exemplaires_dispo_check CHECK ((exemplaires_dispo >= 0))
);


ALTER TABLE public.livre OWNER TO postgres;

--
-- Name: v_emprunts_retard; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.v_emprunts_retard AS
 SELECT e.id_etud,
    e.nom,
    e.prenom,
    l.titre,
    emp.date_emprunt,
    emp.date_retour,
    emp.amende
   FROM ((public.emprunt emp
     JOIN public.etudiant e ON ((emp.id_etud = e.id_etud)))
     JOIN public.livre l ON ((emp.isbn = l.isbn)))
  WHERE (emp.date_retour > (emp.date_emprunt + '14 days'::interval));


ALTER VIEW public.v_emprunts_retard OWNER TO postgres;

--
-- Name: v_stats_livres; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.v_stats_livres AS
 SELECT l.isbn,
    l.titre,
    count(e.id_emprunt) AS nb_emprunts,
    round(((100.0 * (l.exemplaires_dispo)::numeric) / ((l.exemplaires_dispo + count(e.id_emprunt)))::numeric), 2) AS pourcentage_dispo
   FROM (public.livre l
     LEFT JOIN public.emprunt e ON ((l.isbn = e.isbn)))
  GROUP BY l.isbn, l.titre, l.exemplaires_dispo;


ALTER VIEW public.v_stats_livres OWNER TO postgres;

--
-- Name: emprunt id_emprunt; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.emprunt ALTER COLUMN id_emprunt SET DEFAULT nextval('public.emprunt_id_emprunt_seq'::regclass);


--
-- Name: etudiant id_etud; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etudiant ALTER COLUMN id_etud SET DEFAULT nextval('public.etudiant_id_etud_seq'::regclass);


--
-- Data for Name: emprunt; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.emprunt (id_emprunt, id_etud, isbn, date_emprunt, date_retour, amende) FROM stdin;
41	1	9780131103627	2024-01-01	2024-01-10	0.00
42	2	9780132350884	2024-01-02	2024-01-12	0.00
43	3	9780134494166	2024-01-03	2024-01-14	0.00
44	4	9781491950357	2024-01-04	2024-01-15	0.00
45	5	9781449331818	2024-01-05	2024-01-16	0.00
46	6	9780596007126	2024-01-06	2024-01-17	0.00
47	7	9780131177055	2024-01-07	2024-01-18	0.00
48	8	9780136083252	2024-01-08	2024-01-19	0.00
49	9	9780201485677	2024-01-09	2024-01-20	0.00
50	10	9780133594140	2024-01-10	2024-01-21	0.00
51	11	9780137903955	2024-01-11	2024-01-22	0.00
52	12	9780135974445	2024-01-12	2024-01-23	0.00
53	13	9781492037255	2024-01-13	2024-01-24	0.00
54	14	9780596517748	2024-01-14	2024-01-25	0.00
55	15	9780134757599	2024-01-15	2024-01-26	0.00
56	16	9780131873254	2024-01-16	2024-01-27	0.00
57	17	9780131103627	2024-01-17	2024-01-28	0.00
58	18	9780132350884	2024-01-18	2024-01-29	0.00
59	19	9780134494166	2024-01-19	2024-01-30	0.00
60	20	9781491950357	2024-01-20	2024-01-31	0.00
61	21	9781449331818	2024-01-21	2024-02-01	0.00
62	22	9780596007126	2024-01-22	2024-02-02	0.00
63	23	9780131177055	2024-01-23	2024-02-03	0.00
64	24	9780136083252	2024-01-24	2024-02-04	0.00
65	25	9780201485677	2024-01-25	2024-02-05	0.00
66	1	9780133594140	2024-01-26	2024-02-06	0.00
67	2	9780137903955	2024-01-27	2024-02-07	0.00
68	3	9780135974445	2024-01-28	2024-02-08	0.00
69	4	9781492037255	2024-01-29	2024-02-09	0.00
70	5	9780596517748	2024-01-30	2024-02-10	0.00
71	6	9780134757599	2024-02-01	\N	0.00
72	7	9780131873254	2024-02-02	\N	0.00
73	8	9780131103627	2024-02-03	\N	0.00
74	9	9780132350884	2024-02-04	\N	0.00
75	10	9780134494166	2024-02-05	\N	0.00
76	1	9781491950357	2024-01-01	2024-01-20	3.00
77	4	9781449331818	2024-01-02	2024-01-25	5.50
78	7	9780596007126	2024-01-03	2024-01-22	4.00
79	21	9780131177055	2024-01-04	2024-01-24	5.00
80	22	9780136083252	2024-01-05	2024-01-26	5.50
81	1	9780131103627	2026-01-07	\N	0.00
\.


--
-- Data for Name: etudiant; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.etudiant (id_etud, nom, prenom, email, date_inscription, solde_amende) FROM stdin;
1	Martin	Léa	lea.martin@univ.fr	2026-01-06	2.50
2	Durand	Paul	paul.durand@univ.fr	2026-01-06	0.00
3	Bernard	Alice	alice.bernard@univ.fr	2026-01-06	0.00
4	Petit	Lucas	lucas.petit@univ.fr	2026-01-06	1.00
5	Robert	Emma	emma.robert@univ.fr	2026-01-06	0.00
6	Richard	Noah	noah.richard@univ.fr	2026-01-06	0.00
7	Dubois	Chloé	chloe.dubois@univ.fr	2026-01-06	3.50
8	Moreau	Hugo	hugo.moreau@univ.fr	2026-01-06	0.00
9	Laurent	Inès	ines.laurent@univ.fr	2026-01-06	0.00
10	Simon	Adam	adam.simon@univ.fr	2026-01-06	0.00
11	Michel	Camille	camille.michel@univ.fr	2026-01-06	0.00
12	Garcia	Lina	lina.garcia@univ.fr	2026-01-06	0.00
13	Fournier	Tom	tom.fournier@univ.fr	2026-01-06	0.00
14	Roux	Sarah	sarah.roux@univ.fr	2026-01-06	0.00
15	Girard	Nathan	nathan.girard@univ.fr	2026-01-06	0.00
16	Andre	Julie	julie.andre@univ.fr	2026-01-06	0.00
17	Lefevre	Ethan	ethan.lefevre@univ.fr	2026-01-06	0.00
18	Mercier	Manon	manon.mercier@univ.fr	2026-01-06	0.00
19	Blanc	Louis	louis.blanc@univ.fr	2026-01-06	0.00
20	Guerin	Zoé	zoe.guerin@univ.fr	2026-01-06	0.00
21	Boyer	Maxime	maxime.boyer@univ.fr	2026-01-06	4.00
22	Chevalier	Anna	anna.chevalier@univ.fr	2026-01-06	0.00
23	Francois	Leo	leo.francois@univ.fr	2026-01-06	0.00
24	Legrand	Mila	mila.legrand@univ.fr	2026-01-06	0.00
25	Perrin	Jules	jules.perrin@univ.fr	2026-01-06	0.00
\.


--
-- Data for Name: livre; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.livre (isbn, titre, editeur, annee, exemplaires_dispo) FROM stdin;
9780201633610	Design Patterns	Addison-Wesley	1994	0
9780262033848	Introduction to Algorithms	MIT Press	2009	0
9780134685991	Effective Java	Addison-Wesley	2018	1
9780131101630	Structure and Interpretation of Computer Programs	MIT Press	1996	0
9780131103627	The C Programming Language	Prentice Hall	1988	2
9780132350884	Clean Code	Prentice Hall	2008	3
9780134494166	Clean Architecture	Prentice Hall	2017	2
9781491950357	Learning Python	O’Reilly	2013	2
9781449331818	JavaScript: The Good Parts	O’Reilly	2008	2
9780596007126	Head First Design Patterns	O’Reilly	2004	2
9780131177055	Database System Concepts	McGraw-Hill	2010	2
9780136083252	Operating System Concepts	Wiley	2011	2
9780201485677	Refactoring	Addison-Wesley	1999	2
9780133594140	Computer Networks	Pearson	2013	2
9780137903955	Artificial Intelligence	Pearson	2020	2
9780135974445	Software Engineering	Pearson	2014	2
9781492037255	Fluent Python	O’Reilly	2015	2
9780596517748	Programming Python	O’Reilly	2010	2
9780134757599	Algorithms	Addison-Wesley	2011	2
9780131873254	Advanced Programming in Unix	Addison-Wesley	2004	2
\.


--
-- Name: emprunt_id_emprunt_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.emprunt_id_emprunt_seq', 81, true);


--
-- Name: etudiant_id_etud_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.etudiant_id_etud_seq', 25, true);


--
-- Name: emprunt emprunt_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.emprunt
    ADD CONSTRAINT emprunt_pkey PRIMARY KEY (id_emprunt);


--
-- Name: etudiant etudiant_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etudiant
    ADD CONSTRAINT etudiant_email_key UNIQUE (email);


--
-- Name: etudiant etudiant_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etudiant
    ADD CONSTRAINT etudiant_pkey PRIMARY KEY (id_etud);


--
-- Name: livre livre_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.livre
    ADD CONSTRAINT livre_pkey PRIMARY KEY (isbn);


--
-- Name: idx_date_emprunt; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_date_emprunt ON public.emprunt USING btree (date_emprunt);


--
-- Name: idx_etudiant_nom_trgm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_etudiant_nom_trgm ON public.etudiant USING gin (nom public.gin_trgm_ops);


--
-- Name: idx_nom; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_nom ON public.etudiant USING btree (nom);


--
-- Name: emprunt emprunt_id_etud_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.emprunt
    ADD CONSTRAINT emprunt_id_etud_fkey FOREIGN KEY (id_etud) REFERENCES public.etudiant(id_etud) ON DELETE RESTRICT;


--
-- Name: emprunt emprunt_isbn_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.emprunt
    ADD CONSTRAINT emprunt_isbn_fkey FOREIGN KEY (isbn) REFERENCES public.livre(isbn) ON DELETE RESTRICT;


--
-- Name: TABLE emprunt; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.emprunt TO bibliothecaire;
GRANT SELECT,INSERT ON TABLE public.emprunt TO etudiant_ro;


--
-- Name: SEQUENCE emprunt_id_emprunt_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT USAGE ON SEQUENCE public.emprunt_id_emprunt_seq TO bibliothecaire;
GRANT USAGE ON SEQUENCE public.emprunt_id_emprunt_seq TO etudiant_ro;


--
-- Name: TABLE etudiant; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.etudiant TO bibliothecaire;
GRANT SELECT ON TABLE public.etudiant TO etudiant_ro;


--
-- Name: SEQUENCE etudiant_id_etud_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT USAGE ON SEQUENCE public.etudiant_id_etud_seq TO bibliothecaire;


--
-- Name: TABLE livre; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.livre TO bibliothecaire;
GRANT SELECT ON TABLE public.livre TO etudiant_ro;


--
-- Name: TABLE v_emprunts_retard; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.v_emprunts_retard TO PUBLIC;


--
-- Name: TABLE v_stats_livres; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.v_stats_livres TO PUBLIC;


--
-- PostgreSQL database dump complete
--

\unrestrict U6esz0YFWFadOpZLCaveAtoBYWTOfeHz14PXZp3cNlSetYvPXafzyhkGpMtytNA

