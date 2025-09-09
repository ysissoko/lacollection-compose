--
-- PostgreSQL database dump
--

\restrict JqhzQUT3lq1n28EFCz7OFbvgVL0YPwqd11g4vErXlgYmUsCMoEiEF4Jln7OfKoq

-- Dumped from database version 17.5 (Debian 17.5-1.pgdg120+1)
-- Dumped by pg_dump version 17.6 (Ubuntu 17.6-1.pgdg22.04+1)

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
-- Name: accounts_accountstate_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.accounts_accountstate_enum AS ENUM (
    'NOT VERIFIED',
    'VERIFIED',
    'BLOCKED'
);


ALTER TYPE public.accounts_accountstate_enum OWNER TO postgres;

--
-- Name: options_type_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.options_type_enum AS ENUM (
    'AvantGarde',
    'Essentials'
);


ALTER TYPE public.options_type_enum OWNER TO postgres;

--
-- Name: profiles_gender_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.profiles_gender_enum AS ENUM (
    'Male',
    'Female'
);


ALTER TYPE public.profiles_gender_enum OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: accounts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.accounts (
    id integer NOT NULL,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT now() NOT NULL,
    email character varying,
    username character varying NOT NULL,
    password character varying NOT NULL,
    "loginAttempts" integer DEFAULT 0 NOT NULL,
    "accountState" public.accounts_accountstate_enum DEFAULT 'NOT VERIFIED'::public.accounts_accountstate_enum NOT NULL,
    "emailVerificationToken" character varying,
    "resetPasswordToken" character varying,
    "stripeCustomerId" character varying,
    "roleId" integer,
    "profileId" integer,
    "otpId" integer
);


ALTER TABLE public.accounts OWNER TO postgres;

--
-- Name: accounts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.accounts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.accounts_id_seq OWNER TO postgres;

--
-- Name: accounts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.accounts_id_seq OWNED BY public.accounts.id;


--
-- Name: areas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.areas (
    id integer NOT NULL,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT now() NOT NULL,
    title character varying NOT NULL,
    image character varying NOT NULL,
    "planeId" integer,
    "order" integer DEFAULT 999 NOT NULL
);


ALTER TABLE public.areas OWNER TO postgres;

--
-- Name: areas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.areas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.areas_id_seq OWNER TO postgres;

--
-- Name: areas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.areas_id_seq OWNED BY public.areas.id;


--
-- Name: options; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.options (
    id integer NOT NULL,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT now() NOT NULL,
    name character varying NOT NULL,
    image character varying NOT NULL,
    serial character varying NOT NULL,
    weight character varying NOT NULL,
    price character varying NOT NULL,
    palette character varying,
    type public.options_type_enum DEFAULT 'AvantGarde'::public.options_type_enum NOT NULL,
    "partId" integer,
    "order" integer DEFAULT 999 NOT NULL
);


ALTER TABLE public.options OWNER TO postgres;

--
-- Name: options_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.options_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.options_id_seq OWNER TO postgres;

--
-- Name: options_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.options_id_seq OWNED BY public.options.id;


--
-- Name: otp; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.otp (
    id integer NOT NULL,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT now() NOT NULL,
    code character varying NOT NULL,
    expiry timestamp without time zone NOT NULL
);


ALTER TABLE public.otp OWNER TO postgres;

--
-- Name: otp_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.otp_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.otp_id_seq OWNER TO postgres;

--
-- Name: otp_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.otp_id_seq OWNED BY public.otp.id;


--
-- Name: parts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.parts (
    id integer NOT NULL,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT now() NOT NULL,
    title character varying NOT NULL,
    "areaId" integer,
    "order" integer DEFAULT 999 NOT NULL
);


ALTER TABLE public.parts OWNER TO postgres;

--
-- Name: parts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.parts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.parts_id_seq OWNER TO postgres;

--
-- Name: parts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.parts_id_seq OWNED BY public.parts.id;


--
-- Name: permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.permissions (
    id integer NOT NULL,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT now() NOT NULL,
    action character varying NOT NULL,
    subject character varying NOT NULL,
    fields character varying,
    conditions text,
    inverted boolean,
    reason character varying,
    "roleId" integer
);


ALTER TABLE public.permissions OWNER TO postgres;

--
-- Name: permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.permissions_id_seq OWNER TO postgres;

--
-- Name: permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.permissions_id_seq OWNED BY public.permissions.id;


--
-- Name: planes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.planes (
    id integer NOT NULL,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT now() NOT NULL,
    name character varying NOT NULL,
    "order" integer DEFAULT 999 NOT NULL
);


ALTER TABLE public.planes OWNER TO postgres;

--
-- Name: planes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.planes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.planes_id_seq OWNER TO postgres;

--
-- Name: planes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.planes_id_seq OWNED BY public.planes.id;


--
-- Name: preferences; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.preferences (
    id integer NOT NULL,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT now() NOT NULL,
    "salesEmails" character varying,
    "accountId" integer
);


ALTER TABLE public.preferences OWNER TO postgres;

--
-- Name: preferences_bookmarks_options; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.preferences_bookmarks_options (
    "preferencesId" integer NOT NULL,
    "optionsId" integer NOT NULL
);


ALTER TABLE public.preferences_bookmarks_options OWNER TO postgres;

--
-- Name: preferences_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.preferences_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.preferences_id_seq OWNER TO postgres;

--
-- Name: preferences_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.preferences_id_seq OWNED BY public.preferences.id;


--
-- Name: preferences_planes_planes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.preferences_planes_planes (
    "preferencesId" integer NOT NULL,
    "planesId" integer NOT NULL
);


ALTER TABLE public.preferences_planes_planes OWNER TO postgres;

--
-- Name: profiles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.profiles (
    id integer NOT NULL,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT now() NOT NULL,
    firstname character varying NOT NULL,
    lastname character varying NOT NULL,
    bio character varying,
    gender public.profiles_gender_enum,
    "phoneNumber" character varying,
    address character varying,
    "photoUrl" character varying,
    "dateOfBirth" timestamp without time zone
);


ALTER TABLE public.profiles OWNER TO postgres;

--
-- Name: profiles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.profiles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.profiles_id_seq OWNER TO postgres;

--
-- Name: profiles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.profiles_id_seq OWNED BY public.profiles.id;


--
-- Name: roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.roles (
    id integer NOT NULL,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT now() NOT NULL,
    name character varying NOT NULL,
    description character varying
);


ALTER TABLE public.roles OWNER TO postgres;

--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.roles_id_seq OWNER TO postgres;

--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


--
-- Name: accounts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts ALTER COLUMN id SET DEFAULT nextval('public.accounts_id_seq'::regclass);


--
-- Name: areas id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.areas ALTER COLUMN id SET DEFAULT nextval('public.areas_id_seq'::regclass);


--
-- Name: options id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.options ALTER COLUMN id SET DEFAULT nextval('public.options_id_seq'::regclass);


--
-- Name: otp id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.otp ALTER COLUMN id SET DEFAULT nextval('public.otp_id_seq'::regclass);


--
-- Name: parts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.parts ALTER COLUMN id SET DEFAULT nextval('public.parts_id_seq'::regclass);


--
-- Name: permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permissions ALTER COLUMN id SET DEFAULT nextval('public.permissions_id_seq'::regclass);


--
-- Name: planes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.planes ALTER COLUMN id SET DEFAULT nextval('public.planes_id_seq'::regclass);


--
-- Name: preferences id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.preferences ALTER COLUMN id SET DEFAULT nextval('public.preferences_id_seq'::regclass);


--
-- Name: profiles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profiles ALTER COLUMN id SET DEFAULT nextval('public.profiles_id_seq'::regclass);


--
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- Data for Name: accounts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.accounts (id, "createdAt", "updatedAt", email, username, password, "loginAttempts", "accountState", "emailVerificationToken", "resetPasswordToken", "stripeCustomerId", "roleId", "profileId", "otpId") FROM stdin;
29	2025-07-23 21:43:11.858813	2025-07-23 21:43:11.858813	\N	GTOLED01	$2b$10$vV1KQq5G/HtZLeXFAr3A1OeAhE6tNwQIQXDH4hzZbovigxSyLcNxy	0	VERIFIED	\N	\N	\N	3	29	\N
30	2025-07-23 21:43:11.914422	2025-07-23 21:43:11.914422	\N	PDELES01	$2b$10$OGia4aK04x0Avx5hdjjUnuAuRBhk.rRu0h6tJBtoHAsfAtxMYvs82	0	VERIFIED	\N	\N	\N	3	30	\N
31	2025-07-23 21:43:11.972916	2025-07-23 21:43:11.972916	\N	JDESMA01	$2b$10$EU0hRH6rMtuqL4JlcJsN6OLBq0hWxohK2aYASG5Zbunv114.IGslq	0	VERIFIED	\N	\N	\N	3	31	\N
32	2025-07-23 21:43:12.0274	2025-07-23 21:43:12.0274	\N	YDESVI01	$2b$10$lnT8FFIPF5kL2yZZpZeAzOnGZwDG0jnXlZ57sfiZGRyI5XAffmT2.	0	VERIFIED	\N	\N	\N	3	32	\N
33	2025-07-23 21:43:12.080399	2025-07-23 21:43:12.080399	\N	JDETUR01	$2b$10$wdi4lb4dSTnqhSY25yXcJu6yBXnbYUz9.nX0tfrFpXgzBJHBccfLm	0	VERIFIED	\N	\N	\N	3	33	\N
34	2025-07-23 21:43:12.132187	2025-07-23 21:43:12.132187	\N	ALISSO01	$2b$10$UrPHD935ab/jgMam5b39relM2F1WXWdLVOV1JnYk6Rtsi2aZR2u5S	0	VERIFIED	\N	\N	\N	3	34	\N
35	2025-07-23 21:43:12.184921	2025-07-23 21:43:12.184921	\N	JDEVRI01	$2b$10$53woZpAo14P/8fzWpzCy8./ovlSdX1VEG1GHBHMf69W3H5dRJ7jya	0	VERIFIED	\N	\N	\N	3	35	\N
36	2025-07-23 21:43:12.238277	2025-07-23 21:43:12.238277	\N	EETIEN01	$2b$10$qNvBExbFHgmGzPlQcOwOVu6aFRyokG5LtriScnSQ3pXU/fTR/zA.K	0	VERIFIED	\N	\N	\N	3	36	\N
37	2025-07-23 21:43:12.290251	2025-07-23 21:43:12.290251	\N	IFAIN01	$2b$10$e9kOkm9oQ/aBSCcsxU/XveV4TOYXksG4d0kZneIDTaEFUV7Iu7RW2	0	VERIFIED	\N	\N	\N	3	37	\N
38	2025-07-23 21:43:12.341211	2025-07-23 21:43:12.341211	\N	PFLORE01	$2b$10$qqINXvfFJWLV55b3hbqeU.tkWgNsX2n8hSMt0xVyFW1sHqOeITf1a	0	VERIFIED	\N	\N	\N	3	38	\N
39	2025-07-23 21:43:12.394627	2025-07-23 21:43:12.394627	\N	RFRIED01	$2b$10$XRHl3LjIKc3M5/MT95/xmONexEMnxKfL2cmwNSHxnu.VZPrQ0NZeq	0	VERIFIED	\N	\N	\N	3	39	\N
40	2025-07-23 21:43:12.44704	2025-07-23 21:43:12.44704	\N	JGAUTH01	$2b$10$QlHas6AMrDBdUaufh0yMpO9uZvujCVwk1rJXacSSPbrQKdpPiFzf2	0	VERIFIED	\N	\N	\N	3	40	\N
41	2025-07-23 21:43:12.497944	2025-07-23 21:43:12.497944	\N	GGAUTI01	$2b$10$bBytGIE5b9cvspAOlPNQdOD7kShHw4MCVw5xbpDWdQNtBydrzrIDe	0	VERIFIED	\N	\N	\N	3	41	\N
42	2025-07-23 21:43:12.549564	2025-07-23 21:43:12.549564	\N	RLEMIR01	$2b$10$05ihfpxnf6tWDS3bn2v2DegAf1YRwgm8eiueud3lOzz.H240lMHvW	0	VERIFIED	\N	\N	\N	3	42	\N
43	2025-07-23 21:43:12.602312	2025-07-23 21:43:12.602312	\N	MGREEN01	$2b$10$dXNCZLsMMol4ow4EPsYjVu5He1e4df6P3ogp98lhwEWLgJMjcSVoi	0	VERIFIED	\N	\N	\N	3	43	\N
44	2025-07-23 21:43:12.6552	2025-07-23 21:43:12.6552	\N	AGOULA01	$2b$10$9xA57rfudsJMs2GgoBiU1eg7YZYwlmxSsX0RvYQ90s958UTmZ0P3u	0	VERIFIED	\N	\N	\N	3	44	\N
45	2025-07-23 21:43:12.707058	2025-07-23 21:43:12.707058	\N	THETIE01	$2b$10$vzPh/CmfSXDW9CLNjCiG.e7J4Ha7pHX0aFQbjiyFz4yO5jG1bvgha	0	VERIFIED	\N	\N	\N	3	45	\N
1	2025-07-23 18:29:29.940318	2025-09-08 20:45:22.881418	coralie.bordenave@dassault-aviation.com	CBORD	$2b$10$8EFkX6Q8KLMz16BxU6vCrO5Z178twvHQD9xc84qWC1ZWkRWD6klem	0	VERIFIED	\N	\N	\N	1	1	\N
5	2025-07-23 21:43:10.543828	2025-07-23 21:43:10.543828	\N	DAPPLE01	$2b$10$e7Yddi3L06Yt8oe1laWTqOjbcfKuHb8S6kzIGtxxxANAQGMud4eeC	0	VERIFIED	\N	\N	\N	3	5	\N
6	2025-07-23 21:43:10.60779	2025-07-23 21:43:10.60779	\N	SARDOU01	$2b$10$7VXCAztyN5Y.uiL39Br6FOCKlIlrg4gOCrfpdw/7RLtIB2AikrnNO	0	VERIFIED	\N	\N	\N	3	6	\N
7	2025-07-23 21:43:10.664334	2025-07-23 21:43:10.664334	\N	FGAYE01	$2b$10$1UxzK6qI/FDMDwzihM.NuepC4IL7r0dCvTzCaRIqQXALpHQ/1fv1G	0	VERIFIED	\N	\N	\N	3	7	\N
8	2025-07-23 21:43:10.724393	2025-07-23 21:43:10.724393	\N	RBACHE01	$2b$10$lNDt4.icTBSuIJRh1PoPDOEqqO76gk9spMpb4Bhd/ypQ1p6w1G47i	0	VERIFIED	\N	\N	\N	3	8	\N
9	2025-07-23 21:43:10.777114	2025-07-23 21:43:10.777114	\N	ANOUVE01	$2b$10$4bMvNPPZFODt/YGPWHpxn.qn1FolE7p4vH1Zi9h23HN61paW2Uffi	0	VERIFIED	\N	\N	\N	3	9	\N
10	2025-07-23 21:43:10.840889	2025-07-23 21:43:10.840889	\N	EDUFOU02	$2b$10$0zScKPMieywB3uWkfMlRROOXibLpd980jnJUv6vZOo3zSlmlYF2tK	0	VERIFIED	\N	\N	\N	3	10	\N
11	2025-07-23 21:43:10.899621	2025-07-23 21:43:10.899621	\N	CBRANA01	$2b$10$T1eIO6WuGaMj2L2IR/AlYeCAI0oUJvXsDqkqXq6u8pejok4xmwds.	0	VERIFIED	\N	\N	\N	3	11	\N
12	2025-07-23 21:43:10.9573	2025-07-23 21:43:10.9573	\N	CBROZI01	$2b$10$2X68PNlFf5DPOu5CuNr49O1sGSNBrWnLXcqOeJVUepWT4CIZDx3mC	0	VERIFIED	\N	\N	\N	3	12	\N
13	2025-07-23 21:43:11.012378	2025-07-23 21:43:11.012378	\N	JFEDIN01	$2b$10$4x1LOoTh.g46KeYky1JVcuSTIYiTCSnyTKGFfu3DHT8NLexC.i9e6	0	VERIFIED	\N	\N	\N	3	13	\N
14	2025-07-23 21:43:11.066015	2025-07-23 21:43:11.066015	\N	DDIKEN01	$2b$10$ltDdDRsop8DndZ7fYa6HtOtP2WvOkiLyNGp8m5BIOIkU6o5rRFUZa	0	VERIFIED	\N	\N	\N	3	14	\N
15	2025-07-23 21:43:11.121544	2025-07-23 21:43:11.121544	\N	MCANO01	$2b$10$ZnxBP8UHsTdQbAWfk98K3.r0ZglxsKYsJJJ3rpSzkfy4q/263IzaO	0	VERIFIED	\N	\N	\N	3	15	\N
16	2025-07-23 21:43:11.176055	2025-07-23 21:43:11.176055	\N	KPALEN01	$2b$10$sOvelE6t/w0zkqpXFIQpc.jKU59tBXDmb4xMKgSF.wBn0rajecw42	0	VERIFIED	\N	\N	\N	3	16	\N
17	2025-07-23 21:43:11.227443	2025-07-23 21:43:11.227443	\N	JHARPE02	$2b$10$rhNjwjaokTk2x5tYqNES.elnFTWTXEbxutuADJN098Q1e5KNzEieO	0	VERIFIED	\N	\N	\N	3	17	\N
18	2025-07-23 21:43:11.280911	2025-07-23 21:43:11.280911	\N	LWEBER01	$2b$10$vueQEX84c3OzmkaKaKWMmOGreQVuO25y1z67wngrFnrZPi1L2spyK	0	VERIFIED	\N	\N	\N	3	18	\N
19	2025-07-23 21:43:11.337026	2025-07-23 21:43:11.337026	\N	BBECKE04	$2b$10$CdCfpbpHqeT9dPMxeqc2W.AQqtwIQmjsszIrlw5icGNzUN2xlfJra	0	VERIFIED	\N	\N	\N	3	19	\N
20	2025-07-23 21:43:11.391896	2025-07-23 21:43:11.391896	\N	NAUBER01	$2b$10$XaeH8aFEQGyLmSNSFumDP.r97PR20Q8lS7PCSl0AsNy8wvaxlVwxi	0	VERIFIED	\N	\N	\N	3	20	\N
21	2025-07-23 21:43:11.445047	2025-07-23 21:43:11.445047	\N	JFRAIS01	$2b$10$U6O7U55UtY/8f//zclyvHuZA4VpTrUk9GxdwPiltFxthREPEEVEoW	0	VERIFIED	\N	\N	\N	3	21	\N
23	2025-07-23 21:43:11.549684	2025-07-23 21:43:11.549684	\N	BASHE01	$2b$10$vrJEn73.EB0iUn7Nnm/wIePC7b4KI7IJfZAWRGRhGC9QckEUqM4d6	0	VERIFIED	\N	\N	\N	3	23	\N
24	2025-07-23 21:43:11.600668	2025-07-23 21:43:11.600668	\N	DBAILE03	$2b$10$2RpiNaWKldD.IQK9lhYtVOVWI6RaDddOfwLXIunOYOfLcSm5/PZPG	0	VERIFIED	\N	\N	\N	3	24	\N
25	2025-07-23 21:43:11.653475	2025-07-23 21:43:11.653475	\N	TCARLI01	$2b$10$lSMGr9TkeHmU7yx2nNfyM.036GQH7D3UMRlDMC.OgCDaDcQ2GZwKG	0	VERIFIED	\N	\N	\N	3	25	\N
26	2025-07-23 21:43:11.704232	2025-07-23 21:43:11.704232	\N	NCHEN01	$2b$10$ut2/2ENz1a7piA.fphMGqewcMRbJCpEhqFV8lVUKM5/oEtKl04lmW	0	VERIFIED	\N	\N	\N	3	26	\N
27	2025-07-23 21:43:11.754836	2025-07-23 21:43:11.754836	\N	RCLOAT01	$2b$10$QDL0jpjdb/f6tF4it7RtdO7kpT/ektrzwBuVY2Tbzel8Y94L.rK1i	0	VERIFIED	\N	\N	\N	3	27	\N
28	2025-07-23 21:43:11.806888	2025-07-23 21:43:11.806888	\N	LFEREL01	$2b$10$fY3rWl920o3aqm6gaqVM1uBb7/ErAjalRvEkA4Hxl75t8A1E8pgd2	0	VERIFIED	\N	\N	\N	3	28	\N
46	2025-07-23 21:43:12.759356	2025-07-23 21:43:12.759356	\N	JJACOB01	$2b$10$8fTkP2hvmsNTMCQiiLYDgenF9Rl7KNdflkbCEJhv7M7N3L/O6.3r.	0	VERIFIED	\N	\N	\N	3	46	\N
47	2025-07-23 21:43:12.809971	2025-07-23 21:43:12.809971	\N	FLEBAS01	$2b$10$Y69Aw9XguO4338NrLd1IY.ZQi2VLWEXnlQ2nePF9n2p3U2r4oy5P.	0	VERIFIED	\N	\N	\N	3	47	\N
48	2025-07-23 21:43:12.860464	2025-07-23 21:43:12.860464	\N	DLECUL02	$2b$10$baVqJNS6mUiHfkRgQJtETORlFJtvhmSMu0DqGWgxZnZpSaScmK2r2	0	VERIFIED	\N	\N	\N	3	48	\N
49	2025-07-23 21:43:12.917483	2025-07-23 21:43:12.917483	\N	NMARTI01	$2b$10$DvaYjTi0mTuGbaCEp//QRuS.tBuvpc2Fw7csD/D8abu.NGRbItJwu	0	VERIFIED	\N	\N	\N	3	49	\N
50	2025-07-23 21:43:12.968902	2025-07-23 21:43:12.968902	\N	NMONCA01	$2b$10$BAZ723IgWVqk01aq1fq5buUCjRnkz9UduUndRXxHnRFS7IDIuCm72	0	VERIFIED	\N	\N	\N	3	50	\N
51	2025-07-23 21:43:13.019766	2025-07-23 21:43:13.019766	\N	RPESOA01	$2b$10$h7ID5QbyFUmdRDciGWn8V.GM6G7mbVtB.udY1nmD555ImntdJQH/2	0	VERIFIED	\N	\N	\N	3	51	\N
52	2025-07-23 21:43:13.072817	2025-07-23 21:43:13.072817	\N	XPONS01	$2b$10$4aCM.Pc6y2NNSm039LOIcOPz4LmJgQBVmQBGt1KChvBrHNf3UC9yi	0	VERIFIED	\N	\N	\N	3	52	\N
53	2025-07-23 21:43:13.123466	2025-07-23 21:43:13.123466	\N	DRAYNA01	$2b$10$n76k0popSvlFSzd593Zgs.Vy/Ud2fo9sv4stVkwDpvPC1.xCw3eZa	0	VERIFIED	\N	\N	\N	3	53	\N
54	2025-07-23 21:43:13.175984	2025-07-23 21:43:13.175984	\N	RREAVI01	$2b$10$kvOoXDaYwuY1LdiK0jgD0uVtfL3Nav9fik/5Z/LmADneMUZupoc.u	0	VERIFIED	\N	\N	\N	3	54	\N
55	2025-07-23 21:43:13.228811	2025-07-23 21:43:13.228811	\N	TROHAU01	$2b$10$/.vrPHFYR3QjqkWUg3dfBuN/BzH5EY.71pDx1ENSk2P2thtEhZ7S2	0	VERIFIED	\N	\N	\N	3	55	\N
56	2025-07-23 21:43:13.27941	2025-07-23 21:43:13.27941	\N	ESENAR01	$2b$10$XTNftGGtOodr1KM3k5Dobul3ceI0TYjV/Yf.81/Q3I.79IhsdX4c2	0	VERIFIED	\N	\N	\N	3	56	\N
57	2025-07-23 21:43:13.332047	2025-07-23 21:43:13.332047	\N	FVENTU01	$2b$10$Wav1ZJXD06KUZTttWnQHxeVWNPxpcnnS1hYx8A/4.JtDdR.Auvk1a	0	VERIFIED	\N	\N	\N	3	57	\N
58	2025-07-23 21:43:13.38488	2025-07-23 21:43:13.38488	\N	IVITTE01	$2b$10$T6pzB/Yec2Jx.s/oaqSxZuAHLSDXAhpmh.eIgOKcWRIz4i2UFiE4K	0	VERIFIED	\N	\N	\N	3	58	\N
59	2025-07-23 21:43:13.441024	2025-07-23 21:43:13.441024	\N	CWININ01	$2b$10$nkjtFUxbBEuscG9QVSXdReZga6drFToKiLJmga2Iy5t44haSXfyaC	0	VERIFIED	\N	\N	\N	3	59	\N
60	2025-07-23 21:43:13.493266	2025-07-23 21:43:13.493266	\N	JTAYLO06	$2b$10$F3zZ5RV3CIFfsUt1fiTvTO99gDCNTHCiDMZG5YxvgbRKkcjvK0ltS	0	VERIFIED	\N	\N	\N	3	60	\N
61	2025-07-23 21:43:13.543968	2025-07-23 21:43:13.543968	\N	VHUBER01	$2b$10$3owoNMfYxu3Qwc8WIgZCPOoLWmlSG/Tkb9TeETJmZlvoWDUVCVQY6	0	VERIFIED	\N	\N	\N	3	61	\N
62	2025-07-23 21:43:13.598121	2025-07-23 21:43:13.598121	\N	ACOCAT01	$2b$10$u36NmHHkqrOxDeHzLG3kmOMPmwYnNSjZglAeGo6O9YpRfjFUS8EPi	0	VERIFIED	\N	\N	\N	3	62	\N
67	2025-07-23 21:43:13.857247	2025-07-23 21:43:13.857247	\N	VLIMIT01	$2b$10$B/LX2LTZ2nRxzb9PkLWOxux7BC4Z06Bvtl4FaHn25pQTFJiQnUglC	0	VERIFIED	\N	\N	\N	3	67	\N
63	2025-07-23 21:43:13.649455	2025-07-23 21:43:13.649455	\N	FHOUSS01	$2b$10$RO.qhYX9EMDBheqnIqbBjuWskYsd/kJMEmOA3jbbRDiNFlPSV7M5S	0	VERIFIED	\N	\N	\N	3	63	\N
64	2025-07-23 21:43:13.702307	2025-07-23 21:43:13.702307	\N	MDUPIN01	$2b$10$9Urq1wdVyc5SFoj7d3iI2.ImDJv6skllxX1l5cleTp5zzaALy4Ajy	0	VERIFIED	\N	\N	\N	3	64	\N
65	2025-07-23 21:43:13.7527	2025-07-23 21:43:13.7527	\N	AJIMEN02	$2b$10$dxbZEaDpTQAJ8YGkNJpTrOrVz9ctQr.GknkAs1QpY3OlHU6VFl89K	0	VERIFIED	\N	\N	\N	3	65	\N
66	2025-07-23 21:43:13.804541	2025-07-23 21:43:13.804541	\N	SETCHE01	$2b$10$CA4XSI/iA0DXARWky4.0nuJB8X5Wrk9HZoJqI8H1.1r0P/LUXwurK	0	VERIFIED	\N	\N	\N	3	66	\N
22	2025-07-23 21:43:11.49813	2025-07-23 21:44:48.098557	\N	GAPOLL01	$2b$10$9s5bQ.lcZqTcLbT2hpZTaurEk36VqL8b8FNCDgpYX6FtkT/P8Z1l2	0	VERIFIED	\N	\N	\N	3	22	\N
\.


--
-- Data for Name: areas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.areas (id, "createdAt", "updatedAt", title, image, "planeId", "order") FROM stdin;
1	2025-07-23 18:25:23.052662	2025-07-23 18:25:23.052662	Galley bar 	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/HQ_Chapter1_EntryWay_L4960H35078bd.jpg	1	999
2	2025-07-23 18:25:23.071413	2025-07-23 18:25:23.071413	Forward lavatory	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/HQ_Chapter1_FwdLav_L4960H3507bd.jpg	1	999
3	2025-07-23 18:25:23.077378	2025-07-23 18:25:23.077378	Forward lounge	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/HQ_Chapter2_MainCabin_L4960H3507BD.jpg	1	999
4	2025-07-23 18:25:23.083829	2025-07-23 18:25:23.083829	Middle lounge	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/HQ_Chapter2-B_MiddleLounge_L4960H3507BD.jpg	1	999
5	2025-07-23 18:25:23.094383	2025-07-23 18:25:23.094383	Aft lounge	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/HQ_Chapter2-C_AftLounge_L4960H3507BD.jpg	1	999
6	2025-07-23 18:25:23.099577	2025-07-23 18:25:23.099577	Aft lavatory	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/HQ_Chapter3_AftLavatory_L3507H4960BD.jpg	1	999
7	2025-07-23 18:25:52.179285	2025-07-23 18:25:52.179285	entryway	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/F6X_SNxxx_DN_Sch01_HQ_View_EntryWay2_2023-01-05.jpg	2	999
8	2025-07-23 18:25:52.195634	2025-07-23 18:25:52.195634	forward lounge	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/HQ_View_CabinClub_L4960H3507_Night.jpg	2	999
9	2025-07-23 18:25:52.209111	2025-07-23 18:25:52.209111	middle lounge	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/HQ_View_CabinFWD_L4960H3507.jpg	2	999
10	2025-07-23 18:25:52.235282	2025-07-23 18:25:52.235282	aft lounge	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/F6X_SNxxx_DN_Sch01_HQ_View_DivanAFTView_2023-01-05_Coralie.jpg	2	999
11	2025-07-23 18:25:52.240695	2025-07-23 18:25:52.240695	aft lavatory	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/F6X_SNxxx_DN_Sch01_HQ_View_AftLavatory_2023-01-05_CORALIE.jpg	2	999
12	2025-07-23 18:26:44.221116	2025-07-23 18:26:44.221116	Entryway	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_08_CHAPITRE_2024-12-05.jpg	3	999
13	2025-07-23 18:26:44.241745	2025-07-23 18:26:44.241745	Cabin	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_04_CHAPITRE_2024-12-05.jpg	3	999
14	2025-07-23 18:26:44.252007	2025-07-23 18:26:44.252007	Aft Lavatory	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_02_CHAPITRE_2024-12-05.jpg	3	999
15	2025-07-23 18:27:01.611656	2025-07-23 18:27:01.611656	Forward Closet Finishing	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/HQ_CamChap_01_EntryWay_L4960H3507.jpg	4	999
16	2025-07-23 18:27:01.622279	2025-07-23 18:27:01.622279	Crew Rest Finishing	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/LQ_CamChap_01_CrewRest_L4960H3507.jpg	4	999
17	2025-07-23 18:27:01.630617	2025-07-23 18:27:01.630617	Forward Lavatory Finishing	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/HQ_CamChap_01_EntryWayFWDLav_L4960H3507.jpg	4	999
18	2025-07-23 18:27:01.638418	2025-07-23 18:27:01.638418	Galley Finishing	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/HQ_CamChap_01_EntryWay_L4960H3507.jpg	4	999
19	2025-07-23 18:27:01.653334	2025-07-23 18:27:01.653334	Club Lounge	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/HQ_CamChap_03_Lounge01ClubView_L4960H3507-01.jpg	4	999
20	2025-07-23 18:27:01.662999	2025-07-23 18:27:01.662999	Dining	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/HQ_CamChap_04_Lounge02Dining_L4960H3507.jpg	4	999
21	2025-07-23 18:27:01.670184	2025-07-23 18:27:01.670184	Meridian & Divan	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/HQ_CamChap_05_Lounge03Divan_L4960H3507co.jpg	4	999
22	2025-07-23 18:27:01.681427	2025-07-23 18:27:01.681427	Bedroom	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/HQ_CamCHAP_08_BedView_L4960H3507co.jpg	4	999
23	2025-07-23 18:27:01.696651	2025-07-23 18:27:01.696651	Falcon Privacy Suite Finishing	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/LQ_CamChap_06_Lounge04FPS02_L4960H3507co.jpg	4	999
24	2025-07-23 18:27:01.699488	2025-07-23 18:27:01.699488	Shower	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/LQ_CamCHAP_09_AftLavat_L4960H3507co.jpg	4	999
25	2025-07-23 18:27:01.719638	2025-07-23 18:27:01.719638	Bulkheads	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/LQ_CamCHAP_05b_ViewLH-Lounge1_LH-Club_L4960H3507.jpg	4	999
26	2025-07-23 18:27:01.737734	2025-07-23 18:27:01.737734	Classic Bathroom	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/HQ_CamChap_07_AftVanity01_L4960H3507.jpg	4	999
27	2025-07-23 18:27:01.752238	2025-07-23 18:27:01.752238	ENTRYWAY	https://api.dassaultfalcon.com/lacollection-smtp/photos/areas/HQ_CamChap_01_EntryWay_L4960H3507.jpg	4	999
28	2025-07-23 18:27:01.753025	2025-07-23 18:27:01.753025	MAIN CABIN	https://api.dassaultfalcon.com/lacollection-smtp/photos/areas/LQ_CamChap_02_CabinView_L4960H3507.jpg	4	999
29	2025-07-23 18:27:01.753807	2025-07-23 18:27:01.753807	AFT LAVATORY 	https://api.dassaultfalcon.com/lacollection-smtp/photos/areas/LQ_CamCHAP_09_AftLavat_L4960H3507.jpg	4	999
30	2025-07-23 18:27:01.754545	2025-07-23 18:27:01.754545	MAIN CABIN BULKHEAD 	https://api.dassaultfalcon.com/lacollection-smtp/photos/areas/LQ_CamCHAP_05b_ViewLH-Lounge1_LH-Club_L4960H3507.jpg	4	999
\.


--
-- Data for Name: options; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.options (id, "createdAt", "updatedAt", name, image, serial, weight, price, palette, type, "partId", "order") FROM stdin;
1	2025-07-23 18:25:23.057039	2025-07-23 18:25:23.057039	Stainless Steel	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_01-Entryway_Sink_L3507H4960_1011.jpg	6.210.1	In Package	In Package		Essentials	1	999
2	2025-07-23 18:25:23.059877	2025-07-23 18:25:23.059877	Glaskote	https://api.dassaultfalcon.com/lacollection-smtp/photos/parts/HQ_01-Entryway_Sink_L3507H4960_1010.jpg	6.210.12	0	7800	assets/images/palettes/Glaskote.png	Essentials	1	999
3	2025-07-23 18:25:23.063113	2025-07-23 18:25:23.063113	Solid Surface	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_01-Entryway_CounterTop_L3507H4960_1015.jpg	6.210.2a	In Package	In Package	assets/images/palettes/SolidSurface.png	Essentials	2	999
4	2025-07-23 18:25:23.06459	2025-07-23 18:25:23.06459	Stone	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_01-Entryway_CounterTop_L3507H4960_1016.jpg	6.210.2	5	45300	assets/images/palettes/Stone.png	AvantGarde	2	999
5	2025-07-23 18:25:23.067618	2025-07-23 18:25:23.067618	Carpet	https://api.dassaultfalcon.com/lacollection-smtp/photos/parts/HQ_01-Entryway_Flooring_L3507H4960_1021.jpg	6.500.0B	In Package	In Package	assets/images/palettes/Carpet.png	Essentials	3	999
6	2025-07-23 18:25:23.068775	2025-07-23 18:25:23.068775	Vinyl	https://api.dassaultfalcon.com/lacollection-smtp/photos/parts/HQ_01-Entryway_Flooring_L3507H4960_1022BD.jpg	6.500.2	22,4	$10,500	assets/images/palettes/Vinyl.png	Essentials	3	999
7	2025-07-23 18:25:23.069627	2025-07-23 18:25:23.069627	Stone	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_01-Entryway_Flooring_L3507H4960_1020BD.jpg	6.500.3B	32,3	$115,100	assets/images/palettes/Stone.png	AvantGarde	3	999
8	2025-07-23 18:25:23.070571	2025-07-23 18:25:23.070571	Wood Veneer	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_01-Entryway_Flooring_L3507H4960_1023BD.jpg	6.500.4B	10,9	$106,500	assets/images/palettes/Wood.png	AvantGarde	3	999
9	2025-07-23 18:25:23.073883	2025-07-23 18:25:23.073883	Glaskote	https://api.dassaultfalcon.com/lacollection-smtp/photos/parts/HQ_01-Entryway_FWDLavSink_L3507H4960_1010.jpg	6.210.12a	In Package	In Package	assets/images/palettes/Glaskote.png	Essentials	4	999
10	2025-07-23 18:25:23.075841	2025-07-23 18:25:23.075841	Solid Surface1	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_01-Entryway_FWDLavConterTop_L3507H4960_1015.jpg	6.210.3b	In Package	In Package	assets/images/palettes/SolidSurface.png	Essentials	5	999
11	2025-07-23 18:25:23.076613	2025-07-23 18:25:23.076613	Stone	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_01-Entryway_FWDLavConterTop_L3507H4960_1016BD.jpg	6.210.5 	1.5	18800	assets/images/palettes/Stone.png	AvantGarde	5	999
12	2025-07-23 18:25:23.078909	2025-07-23 18:25:23.078909	Wood Edge	assets/images/options/HQ_02-Cabin_ConsoleT_L3507H4960_1101.jpg	6.200.21	In Package	In Package	assets/images/palettes/Wood.png	Essentials	6	999
13	2025-07-23 18:25:23.079657	2025-07-23 18:25:23.079657	Painted Edge	assets/images/options/HQ_02-Cabin_ConsoleT_L3507H4960_1100.jpg	6.200.21a	0	30000	assets/images/palettes/Paint.png	AvantGarde	6	999
14	2025-07-23 18:25:23.081515	2025-07-23 18:25:23.081515	Wood Edge	assets/images/options/HQ_02-Cabin_SideLedge_L3507H4960_1102.jpg	6.300.40a	In Package	In Package	assets/images/palettes/Wood.png	Essentials	7	999
15	2025-07-23 18:25:23.082363	2025-07-23 18:25:23.082363	Upholstery	assets/images/options/HQ_02-Cabin_SideLedge_L3507H4960.jpg	6.300.41	In Package	In Package	assets/images/palettes/Upholstery.png	Essentials	7	999
16	2025-07-23 18:25:23.083127	2025-07-23 18:25:23.083127	Painted Edge	assets/images/options/HQ_02-Cabin_SideLedge_L3507H4960_1103.jpg	6.300.40	0	37000	assets/images/palettes/Paint.png	AvantGarde	7	999
17	2025-07-23 18:25:23.085246	2025-07-23 18:25:23.085246	Wood Edge	assets/images/options/HQ_02-Cabin_DiningT_L3507H4960_1101.jpg	6.300.31	In Package	In Package	assets/images/palettes/Wood.png	Essentials	8	999
18	2025-07-23 18:25:23.085954	2025-07-23 18:25:23.085954	Painted Edge	assets/images/options/HQ_02-Cabin_DiningT_L3507H4960_1100.jpg	6.300.31a	0	15000	assets/images/palettes/Paint.png	AvantGarde	8	999
19	2025-07-23 18:25:23.088254	2025-07-23 18:25:23.088254	Wood Door	assets/images/options/HQ_02-Cabin_Credenza_L3507H4960_1111.jpg	6.300.30	In Package	In Package	assets/images/palettes/Wood.png	Essentials	9	999
20	2025-07-23 18:25:23.089424	2025-07-23 18:25:23.089424	Leather Door	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_02-Cabin_Credenza_L3507H4960_1111221.jpg	6.300.31	0	No Charge	assets/images/palettes/Ultraleather.png	AvantGarde	9	999
21	2025-07-23 18:25:23.09081	2025-07-23 18:25:23.09081	Painted Door	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_02-Cabin_Credenza_L3507H4960_1109.jpg	6.300.32	0	10000	assets/images/palettes/Paint.png	AvantGarde	9	999
22	2025-07-23 18:25:23.092833	2025-07-23 18:25:23.092833	Wood	assets/images/options/HQ_02-Cabin_AFTMidCabDividerFWD_L3507H4960.jpg	6.300.8	In Package	In Package	assets/images/palettes/Wood.png	Essentials	10	999
23	2025-07-23 18:25:23.093652	2025-07-23 18:25:23.093652	Upholstery Insert	assets/images/options/HQ_02-Cabin_AFTMidCabDividerFWD-LH_L3507H4960.jpg	6.300.8g	0	10100	assets/images/palettes/Upholstery.png	AvantGarde	10	999
24	2025-07-23 18:25:23.096209	2025-07-23 18:25:23.096209	Wood Door	assets/images/options/HQ_03-Divan_StorageCab_L3507H4960.jpg	6.300.30R	In Package	In Package	assets/images/palettes/Wood.png	Essentials	11	999
25	2025-07-23 18:25:23.097758	2025-07-23 18:25:23.097758	Wood	assets/images/options/HQ_03-Divan_AFTLavBulkhead_L3507H4960_1111.jpg	6.400.1	In Package	In Package	assets/images/palettes/Wood.png	Essentials	12	999
26	2025-07-23 18:25:23.098616	2025-07-23 18:25:23.098616	Door Mirror	assets/images/options/HQ_03-Divan_AFTLavBulkhead_L3507H4960_1112.jpg	6.400.1B	6	No charge	\N	Essentials	12	999
27	2025-07-23 18:25:23.101484	2025-07-23 18:25:23.101484	Glaskote	assets/images/options/HQ_04-Lavatory_Sink_L3507H4960_1010.jpg	6.210.12b	In Package	In Package	assets/images/palettes/Glaskote.png	Essentials	13	999
28	2025-07-23 18:25:23.103215	2025-07-23 18:25:23.103215	Solid Surface	assets/images/options/HQ_04-Lavatory_CounterTop_L3507H4960_1015.jpg	6.210.3a	In Package	In Package	assets/images/palettes/SolidSurface.png	Essentials	14	999
29	2025-07-23 18:25:23.104065	2025-07-23 18:25:23.104065	Stone	assets/images/options/HQ_04-Lavatory_CounterTop_L3507H4960_1016.jpg	6.210.3	0,3	21400	assets/images/palettes/Stone.png	AvantGarde	14	999
30	2025-07-23 18:25:23.105781	2025-07-23 18:25:23.105781	Carpet	assets/images/options/HQ_04-Lavatory_Flooring_L3507H4960_1021.jpg	6.500.0a	In Package	In Package	assets/images/palettes/Carpet.png	Essentials	15	999
31	2025-07-23 18:25:23.106987	2025-07-23 18:25:23.106987	Vinyl	assets/images/options/HQ_04-Lavatory_Flooring_L3507H4960_1022.jpg	6.500.2a	8,8	8000	assets/images/palettes/Vinyl.png	Essentials	15	999
32	2025-07-23 18:25:23.108272	2025-07-23 18:25:23.108272	Wood Veneer	assets/images/options/HQ_04-Lavatory_Flooring_L3507H4960_1023.jpg	6.500.4a	3,5	91100	assets/images/palettes/Wood.png	AvantGarde	15	999
33	2025-07-23 18:25:23.109302	2025-07-23 18:25:23.109302	Stone	assets/images/options/HQ_04-Lavatory_Flooring_L3507H4960_1020.jpg	6.500.3a	13,9	99800	assets/images/palettes/Stone.png	AvantGarde	15	999
34	2025-07-23 18:25:23.111526	2025-07-23 18:25:23.111526	Mirror	assets/images/options/HQ_04-Lavatory_BulkheadFWD_L3507H4960_1112.jpg	6.400.2	In Package	In Package		Essentials	16	999
35	2025-07-23 18:25:23.112693	2025-07-23 18:25:23.112693	Ultraleather	assets/images/options/HQ_04-Lavatory_BulkheadFWD_L3507H4960_11121.jpg	6.400.2a	-0.2	No charge	assets/images/palettes/Ultraleather.png	Essentials	16	999
36	2025-07-23 18:25:23.113746	2025-07-23 18:25:23.113746	Wood	assets/images/options/HQ_04-Lavatory_BulkheadAFT_L3507H4960_1113.jpg	6.410.2	In Package	In Package	assets/images/palettes/Wood.png	Essentials	16	999
37	2025-07-23 18:25:23.114922	2025-07-23 18:25:23.114922	Ultraleather	assets/images/options/HQ_04-Lavatory_BulkheadAFT_L3507H4960_1114.jpg	6.410.2a	-0,1	No Charge	assets/images/palettes/Ultraleather.png	Essentials	16	999
38	2025-07-23 18:25:52.185455	2025-07-23 18:25:52.185455	Stainless steel	assets/images/options/HQ_01-Entryway_Sink_L3507H4960_1003_CORALIE.jpg	6.210.1	In Package	In Package	\N	Essentials	17	999
39	2025-07-23 18:25:52.187208	2025-07-23 18:25:52.187208	Glaskote	assets/images/options/HQ_01-Entryway_Sink_L3507H4960_1004_CORALIE.jpg	6.210.12	0	7800	assets/images/palettes/Glaskote.png	Essentials	17	999
40	2025-07-23 18:25:52.189623	2025-07-23 18:25:52.189623	Solid surface	assets/images/options/HQ_01-Entryway_CounterTop_L3507H4960_1006_CORALIE.jpg	6.210.2a	In Package	In Package	assets/images/palettes/SolidSurface.png	Essentials	18	999
41	2025-07-23 18:25:52.19047	2025-07-23 18:25:52.19047	Stone	assets/images/options/HQ_01-Entryway_CounterTop_L3507H4960_1005_CORALIE.jpg	6.210.2	-1,5	45300	assets/images/palettes/Stone.png	AvantGarde	18	999
42	2025-07-23 18:25:52.192309	2025-07-23 18:25:52.192309	Carpet	assets/images/options/HQ_01-Entryway_Flooring_L3507H4960_1007_CORALIE.jpg	6.500.0b	In Package	In Package	assets/images/palettes/Carpet.png	Essentials	19	999
43	2025-07-23 18:25:52.193095	2025-07-23 18:25:52.193095	Vinyl	assets/images/options/HQ_01-Entryway_Flooring_L3507H4960_1009_CORALIE.jpg	6.500.2	13,3	10500	assets/images/palettes/Vinyl.png	Essentials	19	999
44	2025-07-23 18:25:52.193861	2025-07-23 18:25:52.193861	Wood Veneer	assets/images/options/HQ_01-Entryway_Flooring_L3507H4960_1010_CORALIE.jpg	6.500.4b	7.4	106000	assets/images/palettes/Wood.png	AvantGarde	19	999
45	2025-07-23 18:25:52.194648	2025-07-23 18:25:52.194648	Stone	assets/images/options/HQ_01-Entryway_Flooring_L3507H4960_1008_CORALIE.jpg	6.500.3b	24.8	115100	assets/images/palettes/Stone.png	AvantGarde	19	999
46	2025-07-23 18:25:52.1985	2025-07-23 18:25:52.1985	Wood Edge	assets/images/options/HQ_02-Cabin_ConsoleT_L3507H4960_1001_CORALIE.jpg	6.200.21	In Package	In Package	assets/images/palettes/Wood.png	Essentials	20	999
47	2025-07-23 18:25:52.200458	2025-07-23 18:25:52.200458	Painted Edge	assets/images/options/HQ_02-Cabin_ConsoleT_L3507H4960_1002_CORALIE.jpg	6.200.21a	0	30000	assets/images/palettes/Paint.png	AvantGarde	20	999
48	2025-07-23 18:25:52.203598	2025-07-23 18:25:52.203598	Wood Edge	assets/images/options/HQ_02-Cabin_SideLedge_L3507H4960_1018_CORALIE.jpg	6.300.40a	In Package	In Package	assets/images/palettes/Wood.png	Essentials	21	999
49	2025-07-23 18:25:52.205184	2025-07-23 18:25:52.205184	Upholstery	assets/images/options/HQ_02-Cabin_SideLedge_L3507H4960_1018__TEXTILE_CORALIE.jpg	6.300.41	In Package	In Package	assets/images/palettes/Upholstery.png	Essentials	21	999
50	2025-07-23 18:25:52.206986	2025-07-23 18:25:52.206986	Painted Edge	assets/images/options/HQ_02-Cabin_SideLedge_L3507H4960_1019_CORALIE.jpg	6.300.40	0	37000	assets/images/palettes/Paint.png	AvantGarde	21	999
51	2025-07-23 18:25:52.212106	2025-07-23 18:25:52.212106	Wood Edge	assets/images/options/HQ_02-Cabin_DiningT_L3507H4960_1001.jpg	6.200.31	In Package	In Package	assets/images/palettes/Wood.png	Essentials	22	999
52	2025-07-23 18:25:52.213862	2025-07-23 18:25:52.213862	Painted Edge	assets/images/options/HQ_02-Cabin_DiningT_L3507H4960_1002.jpg	6.200.31a	0	15000	assets/images/palettes/Paint.png	AvantGarde	22	999
53	2025-07-23 18:25:52.217657	2025-07-23 18:25:52.217657	Wood Door	assets/images/options/HQ_02-Cabin_Credenza_L3507H4960_1017.jpg	6.300.30	In Package	In Package	assets/images/palettes/Wood.png	Essentials	23	999
54	2025-07-23 18:25:52.219138	2025-07-23 18:25:52.219138	Painted Door	assets/images/options/HQ_02-Cabin_Credenza_L3507H4960_1016.jpg	6.300.32	0	10000	assets/images/palettes/Paint.png	Essentials	23	999
55	2025-07-23 18:25:52.221095	2025-07-23 18:25:52.221095	Leather Door	assets/images/options/HQ_02-Cabin_Credenza_L3507H4960_1015.jpg	6.300.31	0	No Charge	assets/images/palettes/QuiltedLeather.png	AvantGarde	23	999
56	2025-07-23 18:25:52.225	2025-07-23 18:25:52.225	Wood	assets/images/options/HQ_02-Cabin_AFTMidCabDividerFWD_L3507H4960_1023.jpg	6.300.8	In Package	In Package	assets/images/palettes/Wood.png	Essentials	24	999
57	2025-07-23 18:25:52.226832	2025-07-23 18:25:52.226832	Mirror Insert	assets/images/options/HQ_02-Cabin_AFTMidCabDividerFWD_L3507H4960_1022.jpg	6.300.8h	1	11900		Essentials	24	999
58	2025-07-23 18:25:52.22842	2025-07-23 18:25:52.22842	Wood	assets/images/options/HQ_02-Cabin_AFTMidCabDividerAFT_L3507H4960-01.jpg	6.300.9	In Package	In Package	assets/images/palettes/Wood.png	Essentials	24	999
59	2025-07-23 18:25:52.230536	2025-07-23 18:25:52.230536	Mirror Insert	assets/images/options/HQ_02-Cabin_AFTMidCabDividerAFT_L3507H4960-02.jpg	6.300.9h	1	12300		Essentials	24	999
60	2025-07-23 18:25:52.233378	2025-07-23 18:25:52.233378	Upholstery Insert	assets/images/options/HQ_02-Cabin_AFTMidCabDividerFWD_L3507H4960_1021.jpg	6.300.8g	0	10100	assets/images/palettes/Upholstery.png	AvantGarde	24	999
61	2025-07-23 18:25:52.238024	2025-07-23 18:25:52.238024	Wood Door	assets/images/options/HQ_03-Divan_StorageCab_L3507H4960_1002.jpg	6.300.30R	In Package	In Package	assets/images/palettes/Wood.png	Essentials	25	999
62	2025-07-23 18:25:52.239436	2025-07-23 18:25:52.239436	Painted Door	assets/images/options/HQ_03-Divan_StorageCab_L3507H4960_1003.jpg	6.300.32R	0	10000	assets/images/palettes/Paint.png	Essentials	25	999
63	2025-07-23 18:25:52.243	2025-07-23 18:25:52.243	Glaskote	assets/images/options/HQ_04-Lavatory_Sink_L3507H4960_1000_CORALIE.jpg	6.210.12b	In Package	In Package	assets/images/palettes/Glaskote.png	Essentials	26	999
64	2025-07-23 18:25:52.247439	2025-07-23 18:25:52.247439	Solid Surface	assets/images/options/HQ_04-Lavatory_CounterTop02_2023-01-19_CORALIE.jpg	6.210.3a	In Package	In Package	assets/images/palettes/SolidSurface.png	Essentials	27	999
65	2025-07-23 18:25:52.249083	2025-07-23 18:25:52.249083	Stone	assets/images/options/HQ_04-Lavatory_CounterTop01_2023-01-19_CORALIE.jpg	6.210.3	2.5	21400	assets/images/palettes/Stone.png	AvantGarde	27	999
66	2025-07-23 18:25:52.253396	2025-07-23 18:25:52.253396	Carpet	assets/images/options/HQ_04-Lavatory_Flooring_L3507H4960_1014_CORALIE.jpg	6.500.0a	In Package	In Package	assets/images/palettes/Carpet.png	Essentials	28	999
67	2025-07-23 18:25:52.254955	2025-07-23 18:25:52.254955	Vinyl	assets/images/options/HQ_04-Lavatory_Flooring_L3507H4960_1013_CORALIE.jpg	6.500.2a	3.2	8000	assets/images/palettes/Vinyl.png	Essentials	28	999
68	2025-07-23 18:25:52.256451	2025-07-23 18:25:52.256451	Wood Veneer	assets/images/options/HQ_04-Lavatory_Flooring_L3507H4960_1011_CORALIE.jpg	6.500.4a	0.8	90600	assets/images/palettes/Wood.png	AvantGarde	28	999
69	2025-07-23 18:25:52.258545	2025-07-23 18:25:52.258545	Stone	assets/images/options/HQ_04-Lavatory_Flooring_L3507H4960_1012_CORALIE.jpg	6.500.3a	9.6	99800	assets/images/palettes/Stone.png	AvantGarde	28	999
70	2025-07-23 18:25:52.261632	2025-07-23 18:25:52.261632	Wood	assets/images/options/HQ_04-Lavatory_BulkheadFWD_L3507H4960_1007.jpg	6.400.2	In Package	In Package	assets/images/palettes/Wood.png	Essentials	29	999
71	2025-07-23 18:25:52.263216	2025-07-23 18:25:52.263216	Ultraleather	assets/images/options/HQ_04-Lavatory_BulkheadFWD_L3507H4960_1008.jpg	6.400.2a	-0.8	No charge	assets/images/palettes/Ultraleather.png	Essentials	29	999
72	2025-07-23 18:25:52.26531	2025-07-23 18:25:52.26531	Wood	assets/images/options/HQ_04-Lavatory_BulkheadAFT_L3507H4960_1007.jpg	6.410.2	In Package	In Package	assets/images/palettes/Wood.png	Essentials	29	999
73	2025-07-23 18:25:52.266677	2025-07-23 18:25:52.266677	Ultraleather	assets/images/options/HQ_04-Lavatory_BulkheadAFT_L3507H4960_1008.jpg	6.410.2a	-0.2	No charge	assets/images/palettes/Ultraleather.png	Essentials	29	999
74	2025-07-23 18:26:44.22482	2025-07-23 18:26:44.22482	Stainless Steel	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_13_TECH_2024-12-05.jpg	6.210.1	In Package	In Package		Essentials	30	999
75	2025-07-23 18:26:44.227308	2025-07-23 18:26:44.227308	Glaskote	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/F2L_SNxxx_DN_Scheme01_HQ_13_TECH_2024-12-05.jpg	6.210.12	0	7800	assets/images/palettes/Glaskote.png	Essentials	30	999
76	2025-07-23 18:26:44.229653	2025-07-23 18:26:44.229653	Solid Surface	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/F2L_SNxxx_DN_Scheme01_LQ_09_TECH_2024-12-05A.jpg	6.210.2a	0	In Package	assets/images/palettes/SolidSurface.png	Essentials	31	999
77	2025-07-23 18:26:44.23097	2025-07-23 18:26:44.23097	Stone	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/F2L_SNxxx_DN_Scheme01_LQ_09_TECH_2024-12-05.jpg	6.210.2	Standard	39200	assets/images/palettes/Stone.png	AvantGarde	31	999
78	2025-07-23 18:26:44.234656	2025-07-23 18:26:44.234656	Metal plated	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_12_TECH_2024-12-05.jpg	6.210.9a	0	In Package	assets/images/palettes/Stone.png	Essentials	32	999
79	2025-07-23 18:26:44.235782	2025-07-23 18:26:44.235782	Wood veneer	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_12_TECH_2024-12-05.jpg	6.210.9	Standard	No charge	assets/images/palettes/Wood.png	Essentials	32	999
80	2025-07-23 18:26:44.237507	2025-07-23 18:26:44.237507	Stainless steel	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_25_TECH_2024-12-05.jpg	6.500.10	In Package	In Package		Essentials	33	999
81	2025-07-23 18:26:44.238261	2025-07-23 18:26:44.238261	Glasskote	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_25_CHAPITRE_2024-12-05.jpg	6.500.1b	0.1	8700	assets/images/palettes/Glaskote.png	Essentials	33	999
82	2025-07-23 18:26:44.239856	2025-07-23 18:26:44.239856	Carpet	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_10_TECH_2024-12-05.jpg	6.500.0b	In Package	In Package	Carpet.png	Essentials	34	999
83	2025-07-23 18:26:44.24079	2025-07-23 18:26:44.24079	Vinyl	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_10_TECH_2024-12-05.jpg	6.500.2	10.6	10500	assets/images/palettes/Vinyl.png	Essentials	34	999
84	2025-07-23 18:26:44.243253	2025-07-23 18:26:44.243253	Wood veneer	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_05_CHAPITRE_2024-12-05.jpg	6.200.20	In Package	In Package	assets/images/palettes/Wood.png	Essentials	35	999
85	2025-07-23 18:26:44.244686	2025-07-23 18:26:44.244686	Wood vener	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_06_CHAPITRE_2024-12-05.jpg	6.200.30	In Package	In Package	assets/images/palettes/Wood.png	Essentials	36	999
86	2025-07-23 18:26:44.246031	2025-07-23 18:26:44.246031	Two (2), 1/8-Inch Metal Trim Strips and Vertical Join Seam below Tables	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_16_TECH_2024-12-05.jpg	6.300.5	In Package	In Package		Essentials	37	999
87	2025-07-23 18:26:44.24673	2025-07-23 18:26:44.24673	One (1), 1/8-Inch Metal Trim Strip and Vertical Join Seam below Tables	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_16_TECH_2024-12-05.jpg	6.300.5d	0.5	No charge		Essentials	37	999
88	2025-07-23 18:26:44.247466	2025-07-23 18:26:44.247466	Upholstery	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_19_TECH_2024-12-05.jpg	6.300.41	In Package	In Package		Essentials	37	999
89	2025-07-23 18:26:44.249033	2025-07-23 18:26:44.249033	Wood veneer	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_11_TECH_2024-12-05.jpg	6.300.7	In Package	In Package	assets/images/palettes/Wood.png	Essentials	38	999
90	2025-07-23 18:26:44.249747	2025-07-23 18:26:44.249747	One (1), 1/8-Inch Metal Trim Strip and Vertical Join Seam below Tables	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_14B_TECH_2024-12-05.jpg	6.400.1	0	In Package		Essentials	38	999
91	2025-07-23 18:26:44.250512	2025-07-23 18:26:44.250512	Wood Veneer with Door in Mirror	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_14_TECH_2024-12-05.jpg	6.400.1b	0	No charge		Essentials	38	999
92	2025-07-23 18:26:44.251264	2025-07-23 18:26:44.251264	Wood Veneer with Leather/Ultraleather insert	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_14_TECH_2024-12-05.jpg	6.400.1g	0.1	10100		AvantGarde	38	999
93	2025-07-23 18:26:44.253446	2025-07-23 18:26:44.253446	Glaskote	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_24_TECH_2024-12-05.jpg	6.210.12b	In Package	In Package	assets/images/palettes/Glaskote.png	Essentials	39	999
94	2025-07-23 18:26:44.255917	2025-07-23 18:26:44.255917	Solid Surface	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_21_TECH_2024-12-05.jpg	6.210.3a	In Package	In Package	assets/images/palettes/SolidSurface.png	Essentials	40	999
95	2025-07-23 18:26:44.257188	2025-07-23 18:26:44.257188	Stone	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_22_TECH_2024-12-05.jpg	6.210.3	1.6	21400	assets/images/palettes/Stone.png	AvantGarde	40	999
96	2025-07-23 18:26:44.260668	2025-07-23 18:26:44.260668	Carpet	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_23_TECH_2024-12-05.jpg	6.500.0a	In Package	In Package	assets/images/palettes/Carpet.png	Essentials	41	999
97	2025-07-23 18:26:44.262466	2025-07-23 18:26:44.262466	Vinyl	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_23_TECH_2024-12-05.jpg	6.500.2a	7.9	8000	assets/images/palettes/Vinyl.png	Essentials	41	999
98	2025-07-23 18:26:44.265403	2025-07-23 18:26:44.265403	Soft good	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_21_TECH_2024-12-05.jpg	6.400.2	In Package	In Package	assets/images/palettes/Wood.png	Essentials	42	999
99	2025-07-23 18:26:44.266964	2025-07-23 18:26:44.266964	Soft good	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_20_TECH_2024-12-05_V2.jpg	6.410.2	In Package	In Package	assets/images/palettes/Ultraleather.png	Essentials	42	999
100	2025-07-23 18:27:01.615088	2025-07-23 18:27:01.615088	Forward Entryway Closet Finishing: Wood Veneer /Paint with Wood Veneer/ Paint Door	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_01_EntryWCloset_L3507H4960_0036.jpg	6.240.10	In Package	In Package		Essentials	43	999
101	2025-07-23 18:27:01.616615	2025-07-23 18:27:01.616615	Forward Entryway Closet Finishing: Aft Side, Wood Veneer/ Paint	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_01_EntryWEntry_L3507H4960_0038.jpg	6.240.20	In Package	In Package		Essentials	43	999
102	2025-07-23 18:27:01.618127	2025-07-23 18:27:01.618127	Forward Entryway Closet Finishing: Wood Veneer /Paint with Mirror Door	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_01_EntryWCloset_L3507H4960_0035.jpg	6.240.11	1.4	Upgrade ($)		AvantGarde	43	999
103	2025-07-23 18:27:01.619459	2025-07-23 18:27:01.619459	Forward Entryway Closet Finishing: Aft Side, Wall Covering		6.240.21	-2.2	Upgrade ($)	assets/images/palettes/DecoFilm.png	AvantGarde	43	999
104	2025-07-23 18:27:01.624948	2025-07-23 18:27:01.624948	Crew Rest Forward Bulkhead Finishing: Forward Side, Wood Veneer / Paint	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_01_EntryWEntry_L3507H4960_0038.jpg	6.230.10	In Package	In Package		Essentials	45	999
105	2025-07-23 18:27:01.625969	2025-07-23 18:27:01.625969	Crew Rest Sliding Panel Finishing: Aft Face, Quilting	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_02_CrewRPanel_L3507H4960_0041.jpg	6.230.20	In Package	In Package		Essentials	45	999
106	2025-07-23 18:27:01.627325	2025-07-23 18:27:01.627325	Crew Rest Forward Bulkhead Finishing: Forward Side, Wall Covering	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_01_EntryWEntry_L3507H4960_0037.jpg	6.230.11	-2,2	Upgrade ($)	assets/images/palettes/DecoFilm.png	AvantGarde	45	999
107	2025-07-23 18:27:01.628455	2025-07-23 18:27:01.628455	Crew Rest Sliding Panel Finishing: Aft Face, Upholstery/Leather with Recess	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_02_CrewRPanel_L3507H4960_0040.jpg	6.230.21	-0,9	Upgrade ($)	assets/images/palettes/Ultraleather.png	AvantGarde	45	999
108	2025-07-23 18:27:01.629521	2025-07-23 18:27:01.629521	Crew Rest Sliding Panel Finishing: Aft Face, Upholstery/Leather	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_02_CrewRPanel_L3507H4960_0040BIS.jpg	6.230.22	Upgrade (Lbs)	Upgrade ($)	assets/images/palettes/Ultraleather.png	AvantGarde	45	999
109	2025-07-23 18:27:01.632773	2025-07-23 18:27:01.632773	Forward Lavatory Aft Bulkhead Finishing:  Forward Face, Wood Veneer/ Paint	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamChap_01_EntryWay_L4960H3507BIS.jpg	6.220.10	In Package	In Package	assets/images/palettes/Wood.png	Essentials	46	999
110	2025-07-23 18:27:01.634455	2025-07-23 18:27:01.634455	Sink : Glaskote	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_01_FWDLavat_L3507H4960_0031.jpg	6.210.12A	In Package	In Package	assets/images/palettes/Glaskote.png	Essentials	47	999
111	2025-07-23 18:27:01.636286	2025-07-23 18:27:01.636286	Forward Lavatory Backsplash Finishing: Solid Surface	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_01_FWDLavat_L3507H4960_0031.jpg	6.210.5	In Package	In Package	assets/images/palettes/SolidSurface.png	Essentials	48	999
112	2025-07-23 18:27:01.637245	2025-07-23 18:27:01.637245	Forward Lavatory Backsplash Finishing: Granite/Marble/Quartz	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_01_FWDLavat_L3507H4960_0030.jpg	6.210.5a	2.2	Upgrade ($)	assets/images/palettes/Stone.png	AvantGarde	48	999
113	2025-07-23 18:27:01.643806	2025-07-23 18:27:01.643806	Sink : Glaskote	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_01_GalleyCountSink_L3507H4960.jpg	6.210.12	In Package	In Package	assets/images/palettes/Glaskote.png	Essentials	50	999
114	2025-07-23 18:27:01.645913	2025-07-23 18:27:01.645913	Solid Surface	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_01_GalleyCountTop_L3507H4960_0030.jpg	6.210.2A	In Package	In Package	assets/images/palettes/SolidSurface.png	Essentials	51	999
115	2025-07-23 18:27:01.646834	2025-07-23 18:27:01.646834	Granite/Marble/Quartz	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_01_GalleyCountTop_L3507H4960_0031.jpg	6.210.2	4,0	Upgrade ($)	assets/images/palettes/Stone.png	AvantGarde	51	999
116	2025-07-23 18:27:01.648301	2025-07-23 18:27:01.648301	Carpet	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_01_EntryWFloor_L3507H4960_0034.jpg	6.500.0B	In Package	In Package	assets/images/palettes/Carpet.png	Essentials	52	999
117	2025-07-23 18:27:01.649137	2025-07-23 18:27:01.649137	Vinyl	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_01_EntryWFloor_L3507H4960_0033.jpg	6.500.2	21.1	Upgrade ($)	assets/images/palettes/Vinyl.png	Essentials	52	999
118	2025-07-23 18:27:01.649905	2025-07-23 18:27:01.649905	threshold plate: Polished Aluminium	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_03_CabinThreslholdP_L3507H4960_0045.jpg	6.500.10	In Package	In Package	assets/images/palettes/Metal.png	Essentials	52	999
119	2025-07-23 18:27:01.650733	2025-07-23 18:27:01.650733	Flooring: Granite/Marble/Quartz	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_01_EntryWFloor_L3507H4960_0032.jpg	6.500.3B	59,8	Upgrade ($)	assets/images/palettes/Stone.png	AvantGarde	52	999
120	2025-07-23 18:27:01.651549	2025-07-23 18:27:01.651549	Flooring: Hard Wood 	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_01_EntryWFloorWood_L3507H4960_WOOD.jpg	6.500.4B	22	Upgrade ($)	assets/images/palettes/Wood.png	AvantGarde	52	999
121	2025-07-23 18:27:01.652551	2025-07-23 18:27:01.652551	Threshold plate: Glaskote	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_03_CabinThreslholdP_L3507H4960_0044.jpg	6.500.1B	0	Upgrade ($)	assets/images/palettes/Glaskote.png	AvantGarde	52	999
122	2025-07-23 18:27:01.655042	2025-07-23 18:27:01.655042	Console Table Finishing: Wood Veneer/ Paint with Wood Veneer/ Paint Edge	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_02_ClubConsoleTable_L3507H4960.jpg	6.200.20A	In Package	In Package	assets/images/palettes/Wood.png	Essentials	53	999
123	2025-07-23 18:27:01.657612	2025-07-23 18:27:01.657612	Service Ledge Finishing: Upholstery/Leather w/ Seams	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_02_ClubSideWallFront_L3507H4960.jpg	6.300.40A	In Package	In Package	assets/images/palettes/Ultraleather.png	Essentials	54	999
124	2025-07-23 18:27:01.659778	2025-07-23 18:27:01.659778	Top Surface: Wood Veneer/ Paint	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_02_ClubSideWallTop_L3507H4960.jpg	6.300.41A	In Package	In Package	assets/images/palettes/Wood.png	Essentials	54	999
125	2025-07-23 18:27:01.661385	2025-07-23 18:27:01.661385	Sideledge Open Storage Interior: Upholstery/Leather	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_02_ClubSideWallInsert_L3507H4960.jpg	6.300.43A	In Package	In Package	assets/images/palettes/Ultraleather.png	Essentials	54	999
126	2025-07-23 18:27:01.665477	2025-07-23 18:27:01.665477	Wood Veneer/ Paint with Wood Veneer/ Paint Edge	https://api.dassaultfalcon.com/lacollection-smtp/photos/parts/HQ_CamChap_04_Lounge02Diningtable_L4960H3507.jpg	6.200.30A	In Package	In Package	assets/images/palettes/Wood.png	Essentials	55	999
127	2025-07-23 18:27:01.667198	2025-07-23 18:27:01.667198	Facade: Upholstery/Leather with Top Stitch	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_02_MidCabFacade_L3507H4960.jpg	6.300.30a	In Package	In Package	assets/images/palettes/Ultraleather.png	Essentials	56	999
128	2025-07-23 18:27:01.668617	2025-07-23 18:27:01.668617	Top: Wood Veneer/Paint	https://api.dassaultfalcon.com/lacollection-smtp/photos/parts/LQ_CamTECH_01_BedCredenza_L3507H4960_0045.jpg	6.300.31a	In Package	In Package	assets/images/palettes/Wood.png	Essentials	56	999
129	2025-07-23 18:27:01.669469	2025-07-23 18:27:01.669469	Top: Granite/Marble/Quartz	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_01_BedCredenza_L3507H4960_0046.jpg	6.300.31b	15.4	Upgrade ($)	assets/images/palettes/Stone.png	AvantGarde	56	999
130	2025-07-23 18:27:01.672025	2025-07-23 18:27:01.672025	Divan Lower Facade: Upholstery/Leather	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_04_DivanLowerFacade_L3507H4960.jpg	6.260.10	In Package	In Package	assets/images/palettes/Ultraleather.png	Essentials	57	999
131	2025-07-23 18:27:01.673805	2025-07-23 18:27:01.673805	Divan Headrest: Upholstery/Leather	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_04_DivanHeadrest_L3507H4960.jpg	6.260.20	In Package	In Package	assets/images/palettes/Ultraleather.png	Essentials	57	999
132	2025-07-23 18:27:01.675474	2025-07-23 18:27:01.675474	Divan Cushion: Upholstery/Leather	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_04_DivanCushion_L3507H4960.jpg	6.260.30	In Package	In Package	assets/images/palettes/Upholstery.png	Essentials	57	999
133	2025-07-23 18:27:01.677054	2025-07-23 18:27:01.677054	Divan Backrest: Upholstery/Leather	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_04_DivanBackrest_L3507H4960.jpg	6.260.40	In Package	In Package	assets/images/palettes/Upholstery.png	Essentials	57	999
134	2025-07-23 18:27:01.678414	2025-07-23 18:27:01.678414	Divan Armrest: Upholstery/Leather	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_04_DivanArmrest_L3507H4960.jpg	6.260.50	In Package	In Package	assets/images/palettes/Upholstery.png	Essentials	57	999
135	2025-07-23 18:27:01.680004	2025-07-23 18:27:01.680004	Divan Side Storage Top Surface: Wood Veneer/Paint	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_04_DivanSideStorage_L3507H4960.jpg	6.260.60	In Package	In Package	assets/images/palettes/Paint.png	Essentials	57	999
136	2025-07-23 18:27:01.685102	2025-07-23 18:27:01.685102	Bed Header Exterior: Quilting	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_01_BedBedHeader_L3507H4960_0034.jpg	6.270.10B	In Package	In Package	assets/images/palettes/QuiltedLeather.png	Essentials	58	999
137	2025-07-23 18:27:01.686751	2025-07-23 18:27:01.686751	Bed Header Exterior: Upholstery	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_01_BedBedHeader_L3507H4960_0035.jpg	6.270.11b	-0.7	Upgrade ($)	assets/images/palettes/Upholstery.png	AvantGarde	58	999
138	2025-07-23 18:27:01.690659	2025-07-23 18:27:01.690659	Facade: Upholstery/Leather w/ Top Stitc	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_02_MidCabFacade_L3507H4960.jpg	6.300.30A	In Package	In Package		Essentials	59	999
139	2025-07-23 18:27:01.692938	2025-07-23 18:27:01.692938	Top: Wood Veneer/ Paint	https://api.dassaultfalcon.com/lacollection-smtp/photos/parts/LQ_CamTECH_01_BedCredenza_L3507H4960_0045.jpg	6.300.31A	In Package	In Package	assets/images/palettes/Wood.png	Essentials	59	999
140	2025-07-23 18:27:01.694918	2025-07-23 18:27:01.694918	Multi-Purpose Storage Cabinet Top: Granite/Marble/Quartz	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_01_BedCredenza_L3507H4960_0046.jpg	6.300.31B	15.4	Upgrade ($)	assets/images/palettes/Stone.png	AvantGarde	59	999
141	2025-07-23 18:27:01.702178	2025-07-23 18:27:01.702178	Sink : Glaskote	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_02_AftVanityBackSplash_L3507H4960_0043.jpg	6.210.12B	In Package	In Package	assets/images/palettes/Glaskote.png	Essentials	61	999
142	2025-07-23 18:27:01.70463	2025-07-23 18:27:01.70463	Backsplash: Solid Surface	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_02_AftVanityBackSplash_L3507H4960_0044.jpg	6.210.31A	In Floorplan	In Floorplan	assets/images/palettes/SolidSurface.png	Essentials	62	999
143	2025-07-23 18:27:01.706425	2025-07-23 18:27:01.706425	Backsplash: Granite/Marble/Quartz	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_02_AftVanityBackSplash_L3507H4960_0043.jpg	6.210.31	1.1	Upgrade ($)	assets/images/palettes/Stone.png	AvantGarde	62	999
144	2025-07-23 18:27:01.710512	2025-07-23 18:27:01.710512	Right-Hand Closet Door: Wood Veneer/Paint	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_02_AftToiletCloset_L3507H4960_0041.jpg	6.212.1R0	In Package	In Package	assets/images/palettes/Wood.png	Essentials	64	999
145	2025-07-23 18:27:01.711771	2025-07-23 18:27:01.711771	Right-Hand Closet Door: Leather Padding	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_02_AftToiletCloset_L3507H4960_0042.jpg	6.212.1R1	4,0	Upgrade ($)	assets/images/palettes/Ultraleather.png	AvantGarde	64	999
146	2025-07-23 18:27:01.715502	2025-07-23 18:27:01.715502	Right-Hand Countertop: Solid Surface	https://api.dassaultfalcon.com/lacollection-smtp/photos/parts/LQ_CamTECH_02_AftToiletTOP_L3507H4960_0037.jpg	6.210.30a	In Package	In Package	assets/images/palettes/SolidSurface.png	Essentials	65	999
147	2025-07-23 18:27:01.717666	2025-07-23 18:27:01.717666	Right-Hand Countertop: Granite/Marble/Quartz	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_02_AftToiletTOP_L3507H4960_0036.jpg	6.210.30	4.0	Upgrade ($)	assets/images/palettes/Stone.png	AvantGarde	65	999
148	2025-07-23 18:27:01.723546	2025-07-23 18:27:01.723546	Forward Main Cabin Bulkhead Finishing: Wood Veneer/Paint (Each, per side)	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_03_CabinGallDivider_L3507H4960_0043.jpg	6.300.10	In Package	In Package	assets/images/palettes/Wood.png	Essentials	66	999
149	2025-07-23 18:27:01.725638	2025-07-23 18:27:01.725638	Forward Main Cabin Bulkhead Finishing: Upholstery (Each, per side)	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_03_CabinGallDivider_L3507H4960_0042.jpg	6.300.11	-2.2	Upgrade ($)	assets/images/palettes/Ultraleather.png	AvantGarde	66	999
150	2025-07-23 18:27:01.72843	2025-07-23 18:27:01.72843	Main Cabin Divider Finishing: Wood Veneer/Paint (Each, per side)	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_04_CabinMIDDivider_L3507H4960_0050.jpg	6.300.20	In Package	In Package	assets/images/palettes/Wood.png	Essentials	67	999
151	2025-07-23 18:27:01.729828	2025-07-23 18:27:01.729828	Main Cabin Divider Finishing: Upholstery (Each, per side)	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_04_CabinMIDDivider_L3507H4960_0051.jpg	6.300.21	-2.2	Upgrade ($)	assets/images/palettes/Ultraleather.png	AvantGarde	67	999
152	2025-07-23 18:27:01.73115	2025-07-23 18:27:01.73115	Main Cabin Divider Finishing: Upholstery/Leather with Wood Veneer/Paint Framed Mirror (Each, per side)	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_04_CabinMIDDivider_L3507H4960_0048.jpg	6.300.22	0.7	Upgrade ($)		AvantGarde	67	999
153	2025-07-23 18:27:01.732317	2025-07-23 18:27:01.732317	Main Cabin Divider Finishing: Quilting with Leather/Upholstery Insert and Piping (Each, per side)	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_04_CabinMIDDivider_L3507H4960_0049.jpg	6.300.23	2.6	Upgrade ($)	assets/images/palettes/Upholstery.png	AvantGarde	67	999
154	2025-07-23 18:27:01.734515	2025-07-23 18:27:01.734515	Aft Main Cabin Bulkhead Finishing: Wood Veneer/ Paint (Each, per side)	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_01_BedAftDivider_L3507H4960_0033.jpg	6.300.30	In Package	In Package	assets/images/palettes/Wood.png	Essentials	68	999
155	2025-07-23 18:27:01.735633	2025-07-23 18:27:01.735633	Aft Main Cabin Bulkhead Finishing: Upholstery (Each, per side)	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_01_BedAftDivider_L3507H4960_0032.jpg	6.300.31	-2.2	Upgrade ($)	assets/images/palettes/Ultraleather.png	AvantGarde	68	999
156	2025-07-23 18:27:01.736708	2025-07-23 18:27:01.736708	Aft Main Cabin Bulkhead Finishing: Upholstery/Leather with Insert and Recess (Each, per side)	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_01_BedAftDivider_L3507H4960_0031.jpg	6.300.32	-0.9	Upgrade ($)	assets/images/palettes/Ultraleather.png	AvantGarde	68	999
157	2025-07-23 18:27:01.739931	2025-07-23 18:27:01.739931	Sink : Glaskote	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_05_AFtLavatSink_L3507H4960.jpg	6.210.12B	In Package	In Package	assets/images/palettes/Glaskote.png	Essentials	69	999
158	2025-07-23 18:27:01.743138	2025-07-23 18:27:01.743138	kkk	https://api.dassaultfalcon.com/lacollection-smtp/photos/parts/LQ_CamTECH_02_AftToiletFloor_L3507H4960_0039.jpg					Essentials	71	999
159	2025-07-23 18:27:01.744162	2025-07-23 18:27:01.744162	kkk	https://api.dassaultfalcon.com/lacollection-smtp/photos/parts/LQ_CamTECH_02_AftToiletFloor_L3507H4960_0039.jpg					Essentials	71	999
160	2025-07-23 18:27:01.746232	2025-07-23 18:27:01.746232	Left-Hand  Closet Door: Wood Veneer/ Paint	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_02_AftToiletCloset_L3507H4960_0041.jpg	6.212.1L0	In Package	In Package	assets/images/palettes/Wood.png	Essentials	72	999
161	2025-07-23 18:27:01.747298	2025-07-23 18:27:01.747298	Left-Hand Closet Door: Leather Padding	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_02_AftToiletCloset_L3507H4960_0042.jpg	6.212.1L1	4,0	Upgrade ($)	assets/images/palettes/Ultraleather.png	AvantGarde	72	999
162	2025-07-23 18:27:01.748938	2025-07-23 18:27:01.748938	Carpet	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_05_AFtLavatFloor_L3507H4960_0053.jpg	6.500.0A	In Package	In Package	assets/images/palettes/Carpet.png	Essentials	73	999
163	2025-07-23 18:27:01.749829	2025-07-23 18:27:01.749829	Vinyl	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_05_AFtLavatFloor_L3507H4960_0054.jpg	6.500.2A	8.8	Upgrade ($)	assets/images/palettes/Vinyl.png	Essentials	73	999
164	2025-07-23 18:27:01.750699	2025-07-23 18:27:01.750699	FlooringGranite/Marble/Quartz Note: Included in shower configuration"	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_05_AFtLavatFloor_L3507H4960_0052.jpg	6.500.3A	24,9	Upgrade ($)	assets/images/palettes/Stone.png	AvantGarde	73	999
165	2025-07-23 18:27:01.751498	2025-07-23 18:27:01.751498	Flooring: Hard Wood 	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_05_AFtLavatFloorWood_L3507H4960.jpg	6.500.4A	7	Upgrade ($)	assets/images/palettes/Wood.png	AvantGarde	73	999
\.


--
-- Data for Name: otp; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.otp (id, "createdAt", "updatedAt", code, expiry) FROM stdin;
\.


--
-- Data for Name: parts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.parts (id, "createdAt", "updatedAt", title, "areaId", "order") FROM stdin;
1	2025-07-23 18:25:23.054737	2025-07-23 18:25:23.054737	Sink	1	999
2	2025-07-23 18:25:23.061928	2025-07-23 18:25:23.061928	Countertop	1	999
3	2025-07-23 18:25:23.065914	2025-07-23 18:25:23.065914	Flooring	1	999
4	2025-07-23 18:25:23.072513	2025-07-23 18:25:23.072513	Sink	2	999
5	2025-07-23 18:25:23.075051	2025-07-23 18:25:23.075051	Countertop	2	999
6	2025-07-23 18:25:23.078097	2025-07-23 18:25:23.078097	Console table	3	999
7	2025-07-23 18:25:23.080767	2025-07-23 18:25:23.080767	Sideledge	3	999
8	2025-07-23 18:25:23.084546	2025-07-23 18:25:23.084546	Dining Table	4	999
9	2025-07-23 18:25:23.087174	2025-07-23 18:25:23.087174	Credenza	4	999
10	2025-07-23 18:25:23.091839	2025-07-23 18:25:23.091839	Bulkheads	4	999
11	2025-07-23 18:25:23.095504	2025-07-23 18:25:23.095504	Divan Cabinet	5	999
12	2025-07-23 18:25:23.096991	2025-07-23 18:25:23.096991	Bulkheads	5	999
13	2025-07-23 18:25:23.100542	2025-07-23 18:25:23.100542	Sink	6	999
14	2025-07-23 18:25:23.102458	2025-07-23 18:25:23.102458	Countertop	6	999
15	2025-07-23 18:25:23.104868	2025-07-23 18:25:23.104868	Flooring	6	999
16	2025-07-23 18:25:23.110527	2025-07-23 18:25:23.110527	Bulkheads	6	999
17	2025-07-23 18:25:52.182808	2025-07-23 18:25:52.182808	Sink	7	999
18	2025-07-23 18:25:52.188718	2025-07-23 18:25:52.188718	Countertop	7	999
19	2025-07-23 18:25:52.191237	2025-07-23 18:25:52.191237	Flooring	7	999
20	2025-07-23 18:25:52.196679	2025-07-23 18:25:52.196679	Console Table	8	999
21	2025-07-23 18:25:52.202114	2025-07-23 18:25:52.202114	Sideledge	8	999
22	2025-07-23 18:25:52.210492	2025-07-23 18:25:52.210492	Dining Table	9	999
23	2025-07-23 18:25:52.215785	2025-07-23 18:25:52.215785	Credenza	9	999
24	2025-07-23 18:25:52.223028	2025-07-23 18:25:52.223028	Bulkheads	9	999
25	2025-07-23 18:25:52.236599	2025-07-23 18:25:52.236599	Divan Cabinet	10	999
26	2025-07-23 18:25:52.241979	2025-07-23 18:25:52.241979	Sink	11	999
27	2025-07-23 18:25:52.244961	2025-07-23 18:25:52.244961	Countertop	11	999
28	2025-07-23 18:25:52.251395	2025-07-23 18:25:52.251395	Flooring	11	999
29	2025-07-23 18:25:52.26037	2025-07-23 18:25:52.26037	Bulkheads	11	999
30	2025-07-23 18:26:44.223031	2025-07-23 18:26:44.223031	Sink	12	999
31	2025-07-23 18:26:44.228687	2025-07-23 18:26:44.228687	Countertop	12	999
32	2025-07-23 18:26:44.232893	2025-07-23 18:26:44.232893	Upper drawer	12	999
33	2025-07-23 18:26:44.236677	2025-07-23 18:26:44.236677	Threshold	12	999
34	2025-07-23 18:26:44.239032	2025-07-23 18:26:44.239032	Flooring	12	999
35	2025-07-23 18:26:44.242557	2025-07-23 18:26:44.242557	Console Table	13	999
36	2025-07-23 18:26:44.243962	2025-07-23 18:26:44.243962	Dining table	13	999
37	2025-07-23 18:26:44.245393	2025-07-23 18:26:44.245393	Sideledge	13	999
38	2025-07-23 18:26:44.248323	2025-07-23 18:26:44.248323	Bulkheads	13	999
39	2025-07-23 18:26:44.252754	2025-07-23 18:26:44.252754	Sink	14	999
40	2025-07-23 18:26:44.254434	2025-07-23 18:26:44.254434	Countertop	14	999
41	2025-07-23 18:26:44.259037	2025-07-23 18:26:44.259037	Flooring	14	999
42	2025-07-23 18:26:44.263984	2025-07-23 18:26:44.263984	Bulkheads	14	999
43	2025-07-23 18:27:01.613731	2025-07-23 18:27:01.613731	FORWARD CLOSET	15	999
44	2025-07-23 18:27:01.620744	2025-07-23 18:27:01.620744		15	999
45	2025-07-23 18:27:01.62377	2025-07-23 18:27:01.62377	 CREW REST	16	999
46	2025-07-23 18:27:01.631807	2025-07-23 18:27:01.631807	Bulkhead	17	999
47	2025-07-23 18:27:01.633658	2025-07-23 18:27:01.633658	Sink	17	999
48	2025-07-23 18:27:01.635518	2025-07-23 18:27:01.635518	Backsplash	17	999
49	2025-07-23 18:27:01.640318	2025-07-23 18:27:01.640318	Bulkhead	18	999
50	2025-07-23 18:27:01.642072	2025-07-23 18:27:01.642072	Sink	18	999
51	2025-07-23 18:27:01.644852	2025-07-23 18:27:01.644852	Countertop	18	999
52	2025-07-23 18:27:01.647615	2025-07-23 18:27:01.647615	Flooring	18	999
53	2025-07-23 18:27:01.65412	2025-07-23 18:27:01.65412	Console table	19	999
54	2025-07-23 18:27:01.655991	2025-07-23 18:27:01.655991	Sideledge	19	999
55	2025-07-23 18:27:01.664308	2025-07-23 18:27:01.664308	Dining Table	20	999
56	2025-07-23 18:27:01.66635	2025-07-23 18:27:01.66635	Credenza	20	999
57	2025-07-23 18:27:01.671214	2025-07-23 18:27:01.671214	Divan	21	999
58	2025-07-23 18:27:01.683406	2025-07-23 18:27:01.683406	Bed Header	22	999
59	2025-07-23 18:27:01.68842	2025-07-23 18:27:01.68842	Credenza	22	999
60	2025-07-23 18:27:01.69827	2025-07-23 18:27:01.69827	 	23	999
61	2025-07-23 18:27:01.700707	2025-07-23 18:27:01.700707	Sink	24	999
62	2025-07-23 18:27:01.703412	2025-07-23 18:27:01.703412	Vanity Backsplash	24	999
63	2025-07-23 18:27:01.708057	2025-07-23 18:27:01.708057		24	999
64	2025-07-23 18:27:01.709332	2025-07-23 18:27:01.709332	Closet Door	24	999
65	2025-07-23 18:27:01.71358	2025-07-23 18:27:01.71358	Right-Hand Countertop  	24	999
66	2025-07-23 18:27:01.721385	2025-07-23 18:27:01.721385	Forward Bulkhead	25	999
67	2025-07-23 18:27:01.727191	2025-07-23 18:27:01.727191	Main Cabin Divider	25	999
68	2025-07-23 18:27:01.733449	2025-07-23 18:27:01.733449	AFT Bulkhead	25	999
69	2025-07-23 18:27:01.738901	2025-07-23 18:27:01.738901	Sink	26	999
70	2025-07-23 18:27:01.740908	2025-07-23 18:27:01.740908		26	999
71	2025-07-23 18:27:01.741857	2025-07-23 18:27:01.741857		26	999
72	2025-07-23 18:27:01.745157	2025-07-23 18:27:01.745157	Closet Door	26	999
73	2025-07-23 18:27:01.748135	2025-07-23 18:27:01.748135	Flooring	26	999
\.


--
-- Data for Name: permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.permissions (id, "createdAt", "updatedAt", action, subject, fields, conditions, inverted, reason, "roleId") FROM stdin;
1	2025-07-23 18:34:23.221671	2025-07-23 18:34:23.221671	manage	all	\N	\N	\N	\N	1
2	2025-07-23 21:23:45.209147	2025-07-23 21:23:45.209147	read	all	\N	\N	\N	\N	3
\.


--
-- Data for Name: planes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.planes (id, "createdAt", "updatedAt", name, "order") FROM stdin;
1	2025-07-23 18:25:23.047298	2025-07-23 18:25:23.047298	8X	999
2	2025-07-23 18:25:52.169099	2025-07-23 18:25:52.169099	6X	999
3	2025-07-23 18:26:44.2153	2025-07-23 18:26:44.2153	2000LXS	999
4	2025-07-23 18:27:01.601069	2025-07-23 18:27:01.601069	10X	999
\.


--
-- Data for Name: preferences; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.preferences (id, "createdAt", "updatedAt", "salesEmails", "accountId") FROM stdin;
2	2025-07-23 21:10:44.881	2025-07-23 21:10:44.881	\N	1
3	2025-07-23 21:43:10.603856	2025-07-23 21:43:10.603856		5
4	2025-07-23 21:43:10.660928	2025-07-23 21:43:10.660928		6
5	2025-07-23 21:43:10.720862	2025-07-23 21:43:10.720862		7
6	2025-07-23 21:43:10.774255	2025-07-23 21:43:10.774255		8
7	2025-07-23 21:43:10.837028	2025-07-23 21:43:10.837028		9
8	2025-07-23 21:43:10.896537	2025-07-23 21:43:10.896537		10
9	2025-07-23 21:43:10.953792	2025-07-23 21:43:10.953792	Carlos.Brana@dassault-aviation.com	11
10	2025-07-23 21:43:11.00986	2025-07-23 21:43:11.00986		12
11	2025-07-23 21:43:11.062988	2025-07-23 21:43:11.062988		13
12	2025-07-23 21:43:11.11826	2025-07-23 21:43:11.11826		14
13	2025-07-23 21:43:11.17305	2025-07-23 21:43:11.17305		15
14	2025-07-23 21:43:11.224514	2025-07-23 21:43:11.224514		16
15	2025-07-23 21:43:11.277703	2025-07-23 21:43:11.277703		17
16	2025-07-23 21:43:11.333634	2025-07-23 21:43:11.333634		18
17	2025-07-23 21:43:11.388763	2025-07-23 21:43:11.388763	Bertrand.Becker@dassault-aviation.com	19
18	2025-07-23 21:43:11.442075	2025-07-23 21:43:11.442075	Nicolas.Aubert@dassault-aviation.com	20
19	2025-07-23 21:43:11.494492	2025-07-23 21:43:11.494492	Jean-Michel.Fraisse@dassault-aviation.com	21
20	2025-07-23 21:43:11.546411	2025-07-23 21:43:11.546411		22
21	2025-07-23 21:43:11.597866	2025-07-23 21:43:11.597866		23
22	2025-07-23 21:43:11.649761	2025-07-23 21:43:11.649761		24
23	2025-07-23 21:43:11.701064	2025-07-23 21:43:11.701064		25
24	2025-07-23 21:43:11.751529	2025-07-23 21:43:11.751529		26
25	2025-07-23 21:43:11.803977	2025-07-23 21:43:11.803977		27
26	2025-07-23 21:43:11.855918	2025-07-23 21:43:11.855918	laetitia.ferelloc@dassault-aviation.com	28
27	2025-07-23 21:43:11.91131	2025-07-23 21:43:11.91131		29
28	2025-07-23 21:43:11.96987	2025-07-23 21:43:11.96987		30
29	2025-07-23 21:43:12.024634	2025-07-23 21:43:12.024634		31
30	2025-07-23 21:43:12.077053	2025-07-23 21:43:12.077053		32
31	2025-07-23 21:43:12.128954	2025-07-23 21:43:12.128954		33
32	2025-07-23 21:43:12.182079	2025-07-23 21:43:12.182079		34
33	2025-07-23 21:43:12.234741	2025-07-23 21:43:12.234741		35
34	2025-07-23 21:43:12.286683	2025-07-23 21:43:12.286683		36
35	2025-07-23 21:43:12.337755	2025-07-23 21:43:12.337755	Igor.Fain@dassault-aviation.com	37
36	2025-07-23 21:43:12.391423	2025-07-23 21:43:12.391423		38
37	2025-07-23 21:43:12.443657	2025-07-23 21:43:12.443657		39
38	2025-07-23 21:43:12.494785	2025-07-23 21:43:12.494785		40
39	2025-07-23 21:43:12.546515	2025-07-23 21:43:12.546515		41
40	2025-07-23 21:43:12.599226	2025-07-23 21:43:12.599226		42
41	2025-07-23 21:43:12.652105	2025-07-23 21:43:12.652105		43
42	2025-07-23 21:43:12.703581	2025-07-23 21:43:12.703581		44
43	2025-07-23 21:43:12.756566	2025-07-23 21:43:12.756566		45
44	2025-07-23 21:43:12.807478	2025-07-23 21:43:12.807478		46
45	2025-07-23 21:43:12.857606	2025-07-23 21:43:12.857606		47
46	2025-07-23 21:43:12.914532	2025-07-23 21:43:12.914532		48
47	2025-07-23 21:43:12.966143	2025-07-23 21:43:12.966143		49
48	2025-07-23 21:43:13.016604	2025-07-23 21:43:13.016604		50
49	2025-07-23 21:43:13.068903	2025-07-23 21:43:13.068903		51
50	2025-07-23 21:43:13.120826	2025-07-23 21:43:13.120826		52
51	2025-07-23 21:43:13.172807	2025-07-23 21:43:13.172807		53
52	2025-07-23 21:43:13.225913	2025-07-23 21:43:13.225913		54
53	2025-07-23 21:43:13.276581	2025-07-23 21:43:13.276581		55
54	2025-07-23 21:43:13.329425	2025-07-23 21:43:13.329425		56
55	2025-07-23 21:43:13.382069	2025-07-23 21:43:13.382069		57
56	2025-07-23 21:43:13.436914	2025-07-23 21:43:13.436914		58
57	2025-07-23 21:43:13.489746	2025-07-23 21:43:13.489746		59
58	2025-07-23 21:43:13.540939	2025-07-23 21:43:13.540939		60
59	2025-07-23 21:43:13.593945	2025-07-23 21:43:13.593945		61
60	2025-07-23 21:43:13.646418	2025-07-23 21:43:13.646418		62
61	2025-07-23 21:43:13.698747	2025-07-23 21:43:13.698747		63
62	2025-07-23 21:43:13.749611	2025-07-23 21:43:13.749611		64
63	2025-07-23 21:43:13.801523	2025-07-23 21:43:13.801523	adrian.jimenez@dassault-aviation.com	65
64	2025-07-23 21:43:13.854013	2025-07-23 21:43:13.854013		66
65	2025-07-23 21:43:13.905077	2025-07-23 21:43:13.905077		67
\.


--
-- Data for Name: preferences_bookmarks_options; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.preferences_bookmarks_options ("preferencesId", "optionsId") FROM stdin;
2	46
59	42
\.


--
-- Data for Name: preferences_planes_planes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.preferences_planes_planes ("preferencesId", "planesId") FROM stdin;
2	1
2	2
2	3
2	4
\.


--
-- Data for Name: profiles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.profiles (id, "createdAt", "updatedAt", firstname, lastname, bio, gender, "phoneNumber", address, "photoUrl", "dateOfBirth") FROM stdin;
1	2025-07-23 18:29:29.940318	2025-07-23 18:29:29.940318	Coralie	BORDENAVE	\N	\N	\N	\N	\N	\N
3	2025-07-23 21:34:27.797294	2025-07-23 21:34:27.797294	Dev	APPLE	\N	\N	\N	\N	\N	\N
5	2025-07-23 21:43:10.543828	2025-07-23 21:43:10.543828	Dev	APPLE	\N	\N	\N	\N	\N	\N
6	2025-07-23 21:43:10.60779	2025-07-23 21:43:10.60779	Stephane	ARDOUIN	\N	\N	\N	\N	\N	\N
7	2025-07-23 21:43:10.664334	2025-07-23 21:43:10.664334	Falilou	GAYE	\N	\N	\N	\N	\N	\N
8	2025-07-23 21:43:10.724393	2025-07-23 21:43:10.724393	Remi	BACHELET	\N	\N	\N	\N	\N	\N
9	2025-07-23 21:43:10.777114	2025-07-23 21:43:10.777114	Aurore	NOUVELLON	\N	\N	\N	\N	\N	\N
10	2025-07-23 21:43:10.840889	2025-07-23 21:43:10.840889	Eloi	DUFOUR	\N	\N	\N	\N	\N	\N
11	2025-07-23 21:43:10.899621	2025-07-23 21:43:10.899621	Carlos	BRANA	\N	\N	\N	\N	\N	\N
12	2025-07-23 21:43:10.9573	2025-07-23 21:43:10.9573	Clement	BROZI	\N	\N	\N	\N	\N	\N
13	2025-07-23 21:43:11.012378	2025-07-23 21:43:11.012378	Jean-charles	FEDINI	\N	\N	\N	\N	\N	\N
14	2025-07-23 21:43:11.066015	2025-07-23 21:43:11.066015	Donna	DIKEN	\N	\N	\N	\N	\N	\N
15	2025-07-23 21:43:11.121544	2025-07-23 21:43:11.121544	Melanie	CANO	\N	\N	\N	\N	\N	\N
16	2025-07-23 21:43:11.176055	2025-07-23 21:43:11.176055	Karla	PALENCIA	\N	\N	\N	\N	\N	\N
17	2025-07-23 21:43:11.227443	2025-07-23 21:43:11.227443	Jennifer	HARPER	\N	\N	\N	\N	\N	\N
18	2025-07-23 21:43:11.280911	2025-07-23 21:43:11.280911	Lucie	WEBER	\N	\N	\N	\N	\N	\N
19	2025-07-23 21:43:11.337026	2025-07-23 21:43:11.337026	Bertrand	BECKER	\N	\N	\N	\N	\N	\N
20	2025-07-23 21:43:11.391896	2025-07-23 21:43:11.391896	Nicolas	AUBERT	\N	\N	\N	\N	\N	\N
21	2025-07-23 21:43:11.445047	2025-07-23 21:43:11.445047	Jean-michel	FRAISSE	\N	\N	\N	\N	\N	\N
22	2025-07-23 21:43:11.49813	2025-07-23 21:43:11.49813	Gilles	APOLLIS	\N	\N	\N	\N	\N	\N
23	2025-07-23 21:43:11.549684	2025-07-23 21:43:11.549684	Beatrice	ASHE	\N	\N	\N	\N	\N	\N
24	2025-07-23 21:43:11.600668	2025-07-23 21:43:11.600668	David	BAILEY	\N	\N	\N	\N	\N	\N
25	2025-07-23 21:43:11.653475	2025-07-23 21:43:11.653475	Thomas	CARLING	\N	\N	\N	\N	\N	\N
26	2025-07-23 21:43:11.704232	2025-07-23 21:43:11.704232	Nick	CHEN	\N	\N	\N	\N	\N	\N
27	2025-07-23 21:43:11.754836	2025-07-23 21:43:11.754836	Renaud	CLOATRE	\N	\N	\N	\N	\N	\N
28	2025-07-23 21:43:11.806888	2025-07-23 21:43:11.806888	Laetitia	FERELLOC	\N	\N	\N	\N	\N	\N
29	2025-07-23 21:43:11.858813	2025-07-23 21:43:11.858813	Gustavo	TOLEDO	\N	\N	\N	\N	\N	\N
30	2025-07-23 21:43:11.914422	2025-07-23 21:43:11.914422	Pierre	DELESTRADE	\N	\N	\N	\N	\N	\N
31	2025-07-23 21:43:11.972916	2025-07-23 21:43:11.972916	Jerome	DESMAZURES	\N	\N	\N	\N	\N	\N
32	2025-07-23 21:43:12.0274	2025-07-23 21:43:12.0274	Yvon	DESVIGNES	\N	\N	\N	\N	\N	\N
33	2025-07-23 21:43:12.080399	2025-07-23 21:43:12.080399	John	DE-TURRIS	\N	\N	\N	\N	\N	\N
34	2025-07-23 21:43:12.132187	2025-07-23 21:43:12.132187	Anne	DEVILLIERS	\N	\N	\N	\N	\N	\N
35	2025-07-23 21:43:12.184921	2025-07-23 21:43:12.184921	Jake	DEVRIES	\N	\N	\N	\N	\N	\N
36	2025-07-23 21:43:12.238277	2025-07-23 21:43:12.238277	Emilien	ETIENNE	\N	\N	\N	\N	\N	\N
37	2025-07-23 21:43:12.290251	2025-07-23 21:43:12.290251	Igor	FAIN	\N	\N	\N	\N	\N	\N
38	2025-07-23 21:43:12.341211	2025-07-23 21:43:12.341211	Paul	FLORECK	\N	\N	\N	\N	\N	\N
39	2025-07-23 21:43:12.394627	2025-07-23 21:43:12.394627	Robert	FRIEDLANDER	\N	\N	\N	\N	\N	\N
40	2025-07-23 21:43:12.44704	2025-07-23 21:43:12.44704	Jean-marie	GAUTHEROT	\N	\N	\N	\N	\N	\N
41	2025-07-23 21:43:12.497944	2025-07-23 21:43:12.497944	Gilles	GAUTIER	\N	\N	\N	\N	\N	\N
42	2025-07-23 21:43:12.549564	2025-07-23 21:43:12.549564	Renaud	LEMIRE	\N	\N	\N	\N	\N	\N
43	2025-07-23 21:43:12.602312	2025-07-23 21:43:12.602312	Mark	GREENWOOD	\N	\N	\N	\N	\N	\N
44	2025-07-23 21:43:12.6552	2025-07-23 21:43:12.6552	Aadil	GOULAMALY	\N	\N	\N	\N	\N	\N
45	2025-07-23 21:43:12.707058	2025-07-23 21:43:12.707058	Thomas	HETIER	\N	\N	\N	\N	\N	\N
46	2025-07-23 21:43:12.759356	2025-07-23 21:43:12.759356	Jean-michel	JACOB	\N	\N	\N	\N	\N	\N
47	2025-07-23 21:43:12.809971	2025-07-23 21:43:12.809971	Frederic	LE BASSER	\N	\N	\N	\N	\N	\N
48	2025-07-23 21:43:12.860464	2025-07-23 21:43:12.860464	Denis	LECULEE	\N	\N	\N	\N	\N	\N
49	2025-07-23 21:43:12.917483	2025-07-23 21:43:12.917483	Nicolas	MARTIN	\N	\N	\N	\N	\N	\N
50	2025-07-23 21:43:12.968902	2025-07-23 21:43:12.968902	Nicolas	MONCALIS	\N	\N	\N	\N	\N	\N
51	2025-07-23 21:43:13.019766	2025-07-23 21:43:13.019766	Rodrigo	PESOA	\N	\N	\N	\N	\N	\N
52	2025-07-23 21:43:13.072817	2025-07-23 21:43:13.072817	Xavier	PONS	\N	\N	\N	\N	\N	\N
53	2025-07-23 21:43:13.123466	2025-07-23 21:43:13.123466	Didier	RAYNARD	\N	\N	\N	\N	\N	\N
54	2025-07-23 21:43:13.175984	2025-07-23 21:43:13.175984	Rhett	REAVIS	\N	\N	\N	\N	\N	\N
55	2025-07-23 21:43:13.228811	2025-07-23 21:43:13.228811	Thomas	ROHAUT	\N	\N	\N	\N	\N	\N
56	2025-07-23 21:43:13.27941	2025-07-23 21:43:13.27941	Emmanuel	SENARD	\N	\N	\N	\N	\N	\N
57	2025-07-23 21:43:13.332047	2025-07-23 21:43:13.332047	Florent	VENTURINI	\N	\N	\N	\N	\N	\N
58	2025-07-23 21:43:13.38488	2025-07-23 21:43:13.38488	Isabelle	VITTET	\N	\N	\N	\N	\N	\N
59	2025-07-23 21:43:13.441024	2025-07-23 21:43:13.441024	Chad	WININGS	\N	\N	\N	\N	\N	\N
60	2025-07-23 21:43:13.493266	2025-07-23 21:43:13.493266	James	TAYLOR	\N	\N	\N	\N	\N	\N
61	2025-07-23 21:43:13.543968	2025-07-23 21:43:13.543968	Vincent	HUBERT	\N	\N	\N	\N	\N	\N
62	2025-07-23 21:43:13.598121	2025-07-23 21:43:13.598121	Axel	COCAT	\N	\N	\N	\N	\N	\N
63	2025-07-23 21:43:13.649455	2025-07-23 21:43:13.649455	Frederique	HOUSSARD	\N	\N	\N	\N	\N	\N
64	2025-07-23 21:43:13.702307	2025-07-23 21:43:13.702307	Marianne	DUPIN	\N	\N	\N	\N	\N	\N
65	2025-07-23 21:43:13.7527	2025-07-23 21:43:13.7527	Adrian	JIMENEZ	\N	\N	\N	\N	\N	\N
66	2025-07-23 21:43:13.804541	2025-07-23 21:43:13.804541	Simon	ETCHECOPAR	\N	\N	\N	\N	\N	\N
67	2025-07-23 21:43:13.857247	2025-07-23 21:43:13.857247	Veronique	LIMITO	\N	\N	\N	\N	\N	\N
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.roles (id, "createdAt", "updatedAt", name, description) FROM stdin;
1	2025-07-23 18:34:23.221671	2025-07-23 18:34:23.221671	admin	\N
3	2025-07-23 21:23:45.209147	2025-07-23 21:23:45.209147	user	\N
\.


--
-- Name: accounts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.accounts_id_seq', 67, true);


--
-- Name: areas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.areas_id_seq', 30, true);


--
-- Name: options_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.options_id_seq', 165, true);


--
-- Name: otp_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.otp_id_seq', 1, false);


--
-- Name: parts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.parts_id_seq', 73, true);


--
-- Name: permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.permissions_id_seq', 2, true);


--
-- Name: planes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.planes_id_seq', 4, true);


--
-- Name: preferences_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.preferences_id_seq', 65, true);


--
-- Name: profiles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.profiles_id_seq', 67, true);


--
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.roles_id_seq', 3, true);


--
-- Name: preferences PK_17f8855e4145192bbabd91a51be; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.preferences
    ADD CONSTRAINT "PK_17f8855e4145192bbabd91a51be" PRIMARY KEY (id);


--
-- Name: otp PK_32556d9d7b22031d7d0e1fd6723; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.otp
    ADD CONSTRAINT "PK_32556d9d7b22031d7d0e1fd6723" PRIMARY KEY (id);


--
-- Name: areas PK_5110493f6342f34c978c084d0d6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.areas
    ADD CONSTRAINT "PK_5110493f6342f34c978c084d0d6" PRIMARY KEY (id);


--
-- Name: preferences_planes_planes PK_51864983a1cbc0c843bf3a8a291; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.preferences_planes_planes
    ADD CONSTRAINT "PK_51864983a1cbc0c843bf3a8a291" PRIMARY KEY ("preferencesId", "planesId");


--
-- Name: accounts PK_5a7a02c20412299d198e097a8fe; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts
    ADD CONSTRAINT "PK_5a7a02c20412299d198e097a8fe" PRIMARY KEY (id);


--
-- Name: preferences_bookmarks_options PK_71d6e6613f9bbc09e383b1c1f26; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.preferences_bookmarks_options
    ADD CONSTRAINT "PK_71d6e6613f9bbc09e383b1c1f26" PRIMARY KEY ("preferencesId", "optionsId");


--
-- Name: profiles PK_8e520eb4da7dc01d0e190447c8e; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profiles
    ADD CONSTRAINT "PK_8e520eb4da7dc01d0e190447c8e" PRIMARY KEY (id);


--
-- Name: planes PK_91be19f449ba03767fe51acdebc; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.planes
    ADD CONSTRAINT "PK_91be19f449ba03767fe51acdebc" PRIMARY KEY (id);


--
-- Name: permissions PK_920331560282b8bd21bb02290df; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT "PK_920331560282b8bd21bb02290df" PRIMARY KEY (id);


--
-- Name: roles PK_c1433d71a4838793a49dcad46ab; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT "PK_c1433d71a4838793a49dcad46ab" PRIMARY KEY (id);


--
-- Name: options PK_d232045bdb5c14d932fba18d957; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.options
    ADD CONSTRAINT "PK_d232045bdb5c14d932fba18d957" PRIMARY KEY (id);


--
-- Name: parts PK_daa5595bb8933f49ac00c9ebc79; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.parts
    ADD CONSTRAINT "PK_daa5595bb8933f49ac00c9ebc79" PRIMARY KEY (id);


--
-- Name: accounts REL_33814c603c3b523e5423ad957d; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts
    ADD CONSTRAINT "REL_33814c603c3b523e5423ad957d" UNIQUE ("profileId");


--
-- Name: accounts REL_39bc78e10dd303f410badc7066; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts
    ADD CONSTRAINT "REL_39bc78e10dd303f410badc7066" UNIQUE ("otpId");


--
-- Name: preferences REL_6bda295d56f85e5706ddc1bbed; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.preferences
    ADD CONSTRAINT "REL_6bda295d56f85e5706ddc1bbed" UNIQUE ("accountId");


--
-- Name: accounts UQ_477e3187cedfb5a3ac121e899c9; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts
    ADD CONSTRAINT "UQ_477e3187cedfb5a3ac121e899c9" UNIQUE (username);


--
-- Name: planes UQ_54b974aae2878402a07cdc8326e; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.planes
    ADD CONSTRAINT "UQ_54b974aae2878402a07cdc8326e" UNIQUE (name);


--
-- Name: roles UQ_648e3f5447f725579d7d4ffdfb7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT "UQ_648e3f5447f725579d7d4ffdfb7" UNIQUE (name);


--
-- Name: accounts UQ_ee66de6cdc53993296d1ceb8aa0; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts
    ADD CONSTRAINT "UQ_ee66de6cdc53993296d1ceb8aa0" UNIQUE (email);


--
-- Name: IDX_450a18db9d1093764d58e41ee3; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_450a18db9d1093764d58e41ee3" ON public.preferences_planes_planes USING btree ("planesId");


--
-- Name: IDX_9f9e84ef1d96da8b031f53b868; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_9f9e84ef1d96da8b031f53b868" ON public.preferences_planes_planes USING btree ("preferencesId");


--
-- Name: IDX_bb54efdaae31741f6dc37c9dd4; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_bb54efdaae31741f6dc37c9dd4" ON public.preferences_bookmarks_options USING btree ("preferencesId");


--
-- Name: IDX_d7676e432868a34fd898c850d0; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_d7676e432868a34fd898c850d0" ON public.preferences_bookmarks_options USING btree ("optionsId");


--
-- Name: areas FK_19aadff6e51e3905cca800cad3e; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.areas
    ADD CONSTRAINT "FK_19aadff6e51e3905cca800cad3e" FOREIGN KEY ("planeId") REFERENCES public.planes(id);


--
-- Name: accounts FK_33814c603c3b523e5423ad957d4; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts
    ADD CONSTRAINT "FK_33814c603c3b523e5423ad957d4" FOREIGN KEY ("profileId") REFERENCES public.profiles(id) ON DELETE CASCADE;


--
-- Name: permissions FK_36d7b8e1a331102ec9161e879ce; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT "FK_36d7b8e1a331102ec9161e879ce" FOREIGN KEY ("roleId") REFERENCES public.roles(id);


--
-- Name: accounts FK_39bc78e10dd303f410badc70668; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts
    ADD CONSTRAINT "FK_39bc78e10dd303f410badc70668" FOREIGN KEY ("otpId") REFERENCES public.otp(id);


--
-- Name: preferences_planes_planes FK_450a18db9d1093764d58e41ee3c; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.preferences_planes_planes
    ADD CONSTRAINT "FK_450a18db9d1093764d58e41ee3c" FOREIGN KEY ("planesId") REFERENCES public.planes(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: preferences FK_6bda295d56f85e5706ddc1bbede; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.preferences
    ADD CONSTRAINT "FK_6bda295d56f85e5706ddc1bbede" FOREIGN KEY ("accountId") REFERENCES public.accounts(id);


--
-- Name: preferences_planes_planes FK_9f9e84ef1d96da8b031f53b8684; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.preferences_planes_planes
    ADD CONSTRAINT "FK_9f9e84ef1d96da8b031f53b8684" FOREIGN KEY ("preferencesId") REFERENCES public.preferences(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: preferences_bookmarks_options FK_bb54efdaae31741f6dc37c9dd45; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.preferences_bookmarks_options
    ADD CONSTRAINT "FK_bb54efdaae31741f6dc37c9dd45" FOREIGN KEY ("preferencesId") REFERENCES public.preferences(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: options FK_bdb9fcd643e9a2f050ba2de14c5; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.options
    ADD CONSTRAINT "FK_bdb9fcd643e9a2f050ba2de14c5" FOREIGN KEY ("partId") REFERENCES public.parts(id);


--
-- Name: parts FK_c0ac2a3b4cc358ed3fedef59b66; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.parts
    ADD CONSTRAINT "FK_c0ac2a3b4cc358ed3fedef59b66" FOREIGN KEY ("areaId") REFERENCES public.areas(id);


--
-- Name: preferences_bookmarks_options FK_d7676e432868a34fd898c850d0e; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.preferences_bookmarks_options
    ADD CONSTRAINT "FK_d7676e432868a34fd898c850d0e" FOREIGN KEY ("optionsId") REFERENCES public.options(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: accounts FK_fb8505547017736dcb551014c17; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts
    ADD CONSTRAINT "FK_fb8505547017736dcb551014c17" FOREIGN KEY ("roleId") REFERENCES public.roles(id);


--
-- PostgreSQL database dump complete
--

\unrestrict JqhzQUT3lq1n28EFCz7OFbvgVL0YPwqd11g4vErXlgYmUsCMoEiEF4Jln7OfKoq

