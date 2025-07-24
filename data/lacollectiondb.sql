--
-- PostgreSQL database dump
--

-- Dumped from database version 17.5 (Debian 17.5-1.pgdg120+1)
-- Dumped by pg_dump version 17.5 (Ubuntu 17.5-1.pgdg22.04+1)

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
    email character varying NOT NULL,
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
    "planeId" integer
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
    "partId" integer
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
    "areaId" integer
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
    name character varying NOT NULL
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

COPY public.accounts (id, "createdAt", "updatedAt", email, password, "loginAttempts", "accountState", "emailVerificationToken", "resetPasswordToken", "stripeCustomerId", "roleId", "profileId", "otpId") FROM stdin;
1	2025-07-21 20:35:03.612022	2025-07-21 20:44:39.946824	caroline.bordenave@dassault-aviation.com	$2b$10$Coy5p34/ISMGM5pSVCiQ4OiWbssh1EfsCl7gpe/rsStVm0V/Dalju	0	VERIFIED	\N	\N	\N	1	2	\N
\.


--
-- Data for Name: areas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.areas (id, "createdAt", "updatedAt", title, image, "planeId") FROM stdin;
1	2025-07-21 20:31:34.887816	2025-07-21 20:31:34.887816	Entryway	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_08_CHAPITRE_2024-12-05.jpg	1
2	2025-07-21 20:31:34.912331	2025-07-21 20:31:34.912331	Cabin	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_04_CHAPITRE_2024-12-05.jpg	1
3	2025-07-21 20:31:34.923563	2025-07-21 20:31:34.923563	Aft Lavatory	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_02_CHAPITRE_2024-12-05.jpg	1
4	2025-07-21 20:31:46.125353	2025-07-21 20:31:46.125353	entryway	assets/images/areas/F6X_SNxxx_DN_Sch01_HQ_View_EntryWay_2023-01-05_Coralie.jpg	2
5	2025-07-21 20:31:46.145966	2025-07-21 20:31:46.145966	forward lounge	assets/images/areas/HQ_View_CabinClub_L4960H3507_CORALIE.jpg	2
6	2025-07-21 20:31:46.153981	2025-07-21 20:31:46.153981	middle lounge	assets/images/areas/F6X_SNxxx_DN_Sch01_HQ_View_CabinFWD_2023-01-05_Coralie.jpg	2
7	2025-07-21 20:31:46.169773	2025-07-21 20:31:46.169773	aft lounge	assets/images/areas/F6X_SNxxx_DN_Sch01_HQ_View_DivanAFTView_2023-01-05_Coralie.jpg	2
8	2025-07-21 20:31:46.17525	2025-07-21 20:31:46.17525	aft lavatory	assets/images/areas/F6X_SNxxx_DN_Sch01_HQ_View_AftLavatory_2023-01-05_CORALIE.jpg	2
9	2025-07-21 20:31:57.662767	2025-07-21 20:31:57.662767	Forward Closet Finishing	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/HQ_CamChap_01_EntryWay_L4960H3507.jpg	3
10	2025-07-21 20:31:57.672503	2025-07-21 20:31:57.672503	Crew Rest Finishing	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/LQ_CamChap_01_CrewRest_L4960H3507.jpg	3
11	2025-07-21 20:31:57.679536	2025-07-21 20:31:57.679536	Forward Lavatory Finishing	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/HQ_CamChap_01_EntryWayFWDLav_L4960H3507.jpg	3
12	2025-07-21 20:31:57.686532	2025-07-21 20:31:57.686532	Galley Finishing	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/HQ_CamChap_01_EntryWay_L4960H3507.jpg	3
13	2025-07-21 20:31:57.696334	2025-07-21 20:31:57.696334	Club Lounge	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/HQ_CamChap_03_Lounge01ClubView_L4960H3507-01.jpg	3
14	2025-07-21 20:31:57.702702	2025-07-21 20:31:57.702702	Dining	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/HQ_CamChap_04_Lounge02Dining_L4960H3507.jpg	3
15	2025-07-21 20:31:57.712682	2025-07-21 20:31:57.712682	Meridian & Divan	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/HQ_CamChap_05_Lounge03Divan_L4960H3507co.jpg	3
16	2025-07-21 20:31:57.726619	2025-07-21 20:31:57.726619	Bedroom	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/HQ_CamCHAP_08_BedView_L4960H3507co.jpg	3
17	2025-07-21 20:31:57.735717	2025-07-21 20:31:57.735717	Falcon Privacy Suite Finishing	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/LQ_CamChap_06_Lounge04FPS02_L4960H3507co.jpg	3
18	2025-07-21 20:31:57.737779	2025-07-21 20:31:57.737779	Shower	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/LQ_CamCHAP_09_AftLavat_L4960H3507co.jpg	3
19	2025-07-21 20:31:57.748033	2025-07-21 20:31:57.748033	Bulkheads	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/LQ_CamCHAP_05b_ViewLH-Lounge1_LH-Club_L4960H3507.jpg	3
20	2025-07-21 20:31:57.758894	2025-07-21 20:31:57.758894	Classic Bathroom	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/HQ_CamChap_07_AftVanity01_L4960H3507.jpg	3
21	2025-07-21 20:31:57.770819	2025-07-21 20:31:57.770819	ENTRYWAY	https://api.dassaultfalcon.com/lacollection-smtp/photos/areas/HQ_CamChap_01_EntryWay_L4960H3507.jpg	3
22	2025-07-21 20:31:57.771513	2025-07-21 20:31:57.771513	MAIN CABIN	https://api.dassaultfalcon.com/lacollection-smtp/photos/areas/LQ_CamChap_02_CabinView_L4960H3507.jpg	3
23	2025-07-21 20:31:57.772227	2025-07-21 20:31:57.772227	AFT LAVATORY 	https://api.dassaultfalcon.com/lacollection-smtp/photos/areas/LQ_CamCHAP_09_AftLavat_L4960H3507.jpg	3
24	2025-07-21 20:31:57.77291	2025-07-21 20:31:57.77291	MAIN CABIN BULKHEAD 	https://api.dassaultfalcon.com/lacollection-smtp/photos/areas/LQ_CamCHAP_05b_ViewLH-Lounge1_LH-Club_L4960H3507.jpg	3
25	2025-07-21 20:32:52.059804	2025-07-21 20:32:52.059804	Forward lavatory	assets/images/areas/HQ_Chapter1_FwdLav_L4960H3507.jpg	6
26	2025-07-21 20:32:52.071387	2025-07-21 20:32:52.071387	Galley bar	assets/images/areas/HQ_Chapter1_EntryWay_L4960H3507.jpg	6
27	2025-07-21 20:32:52.086452	2025-07-21 20:32:52.086452	Forward lounge	assets/images/areas/HQ_Chapter2_MainCabin_L4960H3507.jpg	6
28	2025-07-21 20:32:52.095671	2025-07-21 20:32:52.095671	Middle lounge	assets/images/areas/HQ_Chapter2-B_MiddleLounge_L4960H3507.jpg	6
29	2025-07-21 20:32:52.109699	2025-07-21 20:32:52.109699	Aft lounge	assets/images/areas/HQ_Chapter2-C_AftLounge_L4960H3507.jpg	6
30	2025-07-21 20:32:52.117403	2025-07-21 20:32:52.117403	Aft lavatory	assets/images/areas/HQ_Chapter3_AftLavatory_L3507H4960.jpg	6
\.


--
-- Data for Name: options; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.options (id, "createdAt", "updatedAt", name, image, serial, weight, price, palette, type, "partId") FROM stdin;
1	2025-07-21 20:31:34.894231	2025-07-21 20:31:34.894231	Stainless Steel	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_13_TECH_2024-12-05.jpg	6.210.1	In Package	In Package		Essentials	1
2	2025-07-21 20:31:34.896302	2025-07-21 20:31:34.896302	Glaskote	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_13_TECH_2024-12-05.jpg	6.210.12	0	7800	assets/images/palettes/Glaskote.png	Essentials	1
3	2025-07-21 20:31:34.899175	2025-07-21 20:31:34.899175	Solid Surface	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_09_TECH_2024-12-05.jpg	6.210.2a	0	In Package	assets/images/palettes/SolidSurface.png	Essentials	2
4	2025-07-21 20:31:34.900185	2025-07-21 20:31:34.900185	Stone	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_12_TECH_2024-12-05.jpg	6.210.2	Standard	39200	assets/images/palettes/Stone.png	AvantGarde	2
5	2025-07-21 20:31:34.902797	2025-07-21 20:31:34.902797	Metal plated	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_12_TECH_2024-12-05.jpg	6.210.9a	0	In Package	assets/images/palettes/Stone.png	Essentials	3
6	2025-07-21 20:31:34.904222	2025-07-21 20:31:34.904222	Wood veneer	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_12_TECH_2024-12-05.jpg	6.210.9	Standard	No charge	assets/images/palettes/Wood.png	Essentials	3
7	2025-07-21 20:31:34.906223	2025-07-21 20:31:34.906223	Stainless steel	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_25_TECH_2024-12-05.jpg	6.500.10	In Package	In Package		Essentials	4
8	2025-07-21 20:31:34.907679	2025-07-21 20:31:34.907679	Glasskote	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_25_CHAPITRE_2024-12-05.jpg	6.500.1b	0.1	8700	assets/images/palettes/Glaskote.png	Essentials	4
9	2025-07-21 20:31:34.910539	2025-07-21 20:31:34.910539	Carpet	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_10_TECH_2024-12-05.jpg	6.500.0b	In Package	In Package	Carpet.png	Essentials	5
10	2025-07-21 20:31:34.911559	2025-07-21 20:31:34.911559	Vinyl	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_10_TECH_2024-12-05.jpg	6.500.2	10.6	10500	assets/images/palettes/Vinyl.png	Essentials	5
11	2025-07-21 20:31:34.913799	2025-07-21 20:31:34.913799	Wood veneer	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_05_CHAPITRE_2024-12-05.jpg	6.200.20	In Package	In Package	assets/images/palettes/Wood.png	Essentials	6
12	2025-07-21 20:31:34.915556	2025-07-21 20:31:34.915556	Wood vener	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_06_CHAPITRE_2024-12-05.jpg	6.200.30	In Package	In Package	assets/images/palettes/Wood.png	Essentials	7
13	2025-07-21 20:31:34.917105	2025-07-21 20:31:34.917105	Two (2), 1/8-Inch Metal Trim Strips and Vertical Join Seam below Tables	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_16_TECH_2024-12-05.jpg	6.300.5	In Package	In Package		Essentials	8
14	2025-07-21 20:31:34.917835	2025-07-21 20:31:34.917835	One (1), 1/8-Inch Metal Trim Strip and Vertical Join Seam below Tables	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_16_TECH_2024-12-05.jpg	6.300.5d	0.5	No charge		Essentials	8
15	2025-07-21 20:31:34.918581	2025-07-21 20:31:34.918581	Upholstery	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_19_TECH_2024-12-05.jpg	6.300.41	In Package	In Package		Essentials	8
16	2025-07-21 20:31:34.920206	2025-07-21 20:31:34.920206	Wood veneer	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_11_TECH_2024-12-05.jpg	6.300.7	In Package	In Package	assets/images/palettes/Wood.png	Essentials	9
17	2025-07-21 20:31:34.920893	2025-07-21 20:31:34.920893	One (1), 1/8-Inch Metal Trim Strip and Vertical Join Seam below Tables	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_14B_TECH_2024-12-05.jpg	6.400.1	0	In Package		Essentials	9
18	2025-07-21 20:31:34.921864	2025-07-21 20:31:34.921864	Wood Veneer with Door in Mirror	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_14_TECH_2024-12-05.jpg	6.400.1b	0	No charge		Essentials	9
19	2025-07-21 20:31:34.922774	2025-07-21 20:31:34.922774	Wood Veneer with Leather/Ultraleather insert	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_14_TECH_2024-12-05.jpg	6.400.1g	0.1	10100		AvantGarde	9
20	2025-07-21 20:31:34.925645	2025-07-21 20:31:34.925645	Glaskote	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_24_TECH_2024-12-05.jpg	6.210.12b	In Package	In Package	assets/images/palettes/Glaskote.png	Essentials	10
21	2025-07-21 20:31:34.928059	2025-07-21 20:31:34.928059	Solid Surface	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_21_TECH_2024-12-05.jpg	6.210.3a	In Package	In Package	assets/images/palettes/SolidSurface.png	Essentials	11
22	2025-07-21 20:31:34.928887	2025-07-21 20:31:34.928887	Stone	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_22_TECH_2024-12-05.jpg	6.210.3	1.6	21400	assets/images/palettes/Stone.png	AvantGarde	11
23	2025-07-21 20:31:34.931231	2025-07-21 20:31:34.931231	Carpet	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_23_TECH_2024-12-05.jpg	6.500.0a	In Package	In Package	assets/images/palettes/Carpet.png	Essentials	12
24	2025-07-21 20:31:34.932353	2025-07-21 20:31:34.932353	Vinyl	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_23_TECH_2024-12-05.jpg	6.500.2a	7.9	8000	assets/images/palettes/Vinyl.png	Essentials	12
25	2025-07-21 20:31:34.934163	2025-07-21 20:31:34.934163	Soft good	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_21_TECH_2024-12-05.jpg	6.400.2	In Package	In Package	assets/images/palettes/Wood.png	Essentials	13
26	2025-07-21 20:31:34.934883	2025-07-21 20:31:34.934883	Soft good	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_20_TECH_2024-12-05_V2.jpg	6.410.2	In Package	In Package	assets/images/palettes/Ultraleather.png	Essentials	13
27	2025-07-21 20:31:46.130574	2025-07-21 20:31:46.130574	Stainless steel	assets/images/options/HQ_01-Entryway_Sink_L3507H4960_1003_CORALIE.jpg	6.210.1	In Package	In Package	\N	Essentials	14
28	2025-07-21 20:31:46.132531	2025-07-21 20:31:46.132531	Glaskote	assets/images/options/HQ_01-Entryway_Sink_L3507H4960_1004_CORALIE.jpg	6.210.12	0	7600	assets/images/palettes/Glaskote.png	Essentials	14
29	2025-07-21 20:31:46.135531	2025-07-21 20:31:46.135531	Solid surface	assets/images/options/HQ_01-Entryway_CounterTop_L3507H4960_1006_CORALIE.jpg	6.210.2a	In Package	In Package	assets/images/palettes/SolidSurface.png	Essentials	15
30	2025-07-21 20:31:46.137094	2025-07-21 20:31:46.137094	Stone	assets/images/options/HQ_01-Entryway_CounterTop_L3507H4960_1005_CORALIE.jpg	6.210.2	11	44000	assets/images/palettes/Stone.png	AvantGarde	15
31	2025-07-21 20:31:46.140329	2025-07-21 20:31:46.140329	Carpet	assets/images/options/HQ_01-Entryway_Flooring_L3507H4960_1007_CORALIE.jpg	6.500.0b	In Package	In Package	assets/images/palettes/Carpet.png	Essentials	16
32	2025-07-21 20:31:46.141726	2025-07-21 20:31:46.141726	Vinyl	assets/images/options/HQ_01-Entryway_Flooring_L3507H4960_1009_CORALIE.jpg	6.500.2	4.3	10500	assets/images/palettes/Vinyl.png	Essentials	16
33	2025-07-21 20:31:46.143205	2025-07-21 20:31:46.143205	Wood Veneer	assets/images/options/HQ_01-Entryway_Flooring_L3507H4960_1010_CORALIE.jpg	6.500.4b	22.3	106000	assets/images/palettes/Wood.png	AvantGarde	16
34	2025-07-21 20:31:46.144906	2025-07-21 20:31:46.144906	Stone	assets/images/options/HQ_01-Entryway_Flooring_L3507H4960_1008_CORALIE.jpg	6.500.3b	36.5	115100	assets/images/palettes/Stone.png	AvantGarde	16
35	2025-07-21 20:31:46.147887	2025-07-21 20:31:46.147887	Wood Edge	assets/images/options/HQ_02-Cabin_ConsoleT_L3507H4960_1001_CORALIE.jpg	6.200.21	In Package	In Package	assets/images/palettes/Wood.png	Essentials	17
36	2025-07-21 20:31:46.148659	2025-07-21 20:31:46.148659	Painted Edge	assets/images/options/HQ_02-Cabin_ConsoleT_L3507H4960_1002_CORALIE.jpg	6.200.21a	1.1	30000	assets/images/palettes/Paint.png	AvantGarde	17
37	2025-07-21 20:31:46.150096	2025-07-21 20:31:46.150096	Wood Edge	assets/images/options/HQ_02-Cabin_SideLedge_L3507H4960_1018_CORALIE.jpg	6.300.40a	In Package	In Package	assets/images/palettes/Wood.png	Essentials	18
38	2025-07-21 20:31:46.151223	2025-07-21 20:31:46.151223	Upholstery	assets/images/options/HQ_02-Cabin_SideLedge_L3507H4960_1018__TEXTILE_CORALIE.jpg	6.300.41	In Package	In Package	assets/images/palettes/Upholstery.png	Essentials	18
39	2025-07-21 20:31:46.152414	2025-07-21 20:31:46.152414	Painted Edge	assets/images/options/HQ_02-Cabin_SideLedge_L3507H4960_1019_CORALIE.jpg	6.300.40	0	35900	assets/images/palettes/Paint.png	AvantGarde	18
40	2025-07-21 20:31:46.153235	2025-07-21 20:31:46.153235	Quilting	assets/images/options/HQ_02-Cabin_SideLedge_L3507H4960_1020_CORALIE.jpg	6.300.42	0	17600	assets/images/palettes/QuiltedLeather.png	AvantGarde	18
41	2025-07-21 20:31:46.155692	2025-07-21 20:31:46.155692	Wood Edge	assets/images/options/HQ_02-Cabin_DiningT_L3507H4960_1001.jpg	6.200.31	In Package	In Package	assets/images/palettes/Wood.png	Essentials	19
42	2025-07-21 20:31:46.156527	2025-07-21 20:31:46.156527	Painted Edge	assets/images/options/HQ_02-Cabin_DiningT_L3507H4960_1002.jpg	6.200.31a	1.1	11700	assets/images/palettes/Paint.png	AvantGarde	19
43	2025-07-21 20:31:46.157932	2025-07-21 20:31:46.157932	Wood Door	assets/images/options/HQ_02-Cabin_Credenza_L3507H4960_1017.jpg	6.300.30	In Package	In Package	assets/images/palettes/Wood.png	Essentials	20
44	2025-07-21 20:31:46.158663	2025-07-21 20:31:46.158663	Painted Door	assets/images/options/HQ_02-Cabin_Credenza_L3507H4960_1016.jpg	6.300.32	1.1	51200	assets/images/palettes/Paint.png	Essentials	20
45	2025-07-21 20:31:46.159602	2025-07-21 20:31:46.159602	Leather Door	assets/images/options/HQ_02-Cabin_Credenza_L3507H4960_1015.jpg	6.300.31	0	35000	assets/images/palettes/QuiltedLeather.png	AvantGarde	20
46	2025-07-21 20:31:46.163091	2025-07-21 20:31:46.163091	Wood	assets/images/options/HQ_02-Cabin_AFTMidCabDividerFWD_L3507H4960_1023.jpg	6.300.8	In Package	In Package	assets/images/palettes/Wood.png	Essentials	21
47	2025-07-21 20:31:46.164482	2025-07-21 20:31:46.164482	Mirror Insert	assets/images/options/HQ_02-Cabin_AFTMidCabDividerFWD_L3507H4960_1022.jpg	6.300.8h	3.1	11900		Essentials	21
48	2025-07-21 20:31:46.165785	2025-07-21 20:31:46.165785	Wood	assets/images/options/HQ_02-Cabin_AFTMidCabDividerAFT_L3507H4960-01.jpg	6.300.9	In Package	In Package	assets/images/palettes/Wood.png	Essentials	21
49	2025-07-21 20:31:46.167076	2025-07-21 20:31:46.167076	Mirror Insert	assets/images/options/HQ_02-Cabin_AFTMidCabDividerAFT_L3507H4960-02.jpg	6.300.9h	3.1	11900		Essentials	21
50	2025-07-21 20:31:46.168436	2025-07-21 20:31:46.168436	Upholstery Insert	assets/images/options/HQ_02-Cabin_AFTMidCabDividerFWD_L3507H4960_1021.jpg	6.300.8g	0	9800	assets/images/palettes/Upholstery.png	AvantGarde	21
51	2025-07-21 20:31:46.17242	2025-07-21 20:31:46.17242	Wood Door	assets/images/options/HQ_03-Divan_StorageCab_L3507H4960_1002.jpg	6.300.30R	In Package	In Package	assets/images/palettes/Wood.png	Essentials	22
52	2025-07-21 20:31:46.173971	2025-07-21 20:31:46.173971	Painted Door	assets/images/options/HQ_03-Divan_StorageCab_L3507H4960_1003.jpg	6.300.32R	1.1	25700	assets/images/palettes/Paint.png	Essentials	22
53	2025-07-21 20:31:46.178122	2025-07-21 20:31:46.178122	Glaskote	assets/images/options/HQ_04-Lavatory_Sink_L3507H4960_1000_CORALIE.jpg	6.210.12b	In Package	In Package	assets/images/palettes/Glaskote.png	Essentials	23
54	2025-07-21 20:31:46.181524	2025-07-21 20:31:46.181524	Solid Surface	assets/images/options/HQ_04-Lavatory_CounterTop02_2023-01-19_CORALIE.jpg	6.210.3a	In Package	In Package	assets/images/palettes/SolidSurface.png	Essentials	24
55	2025-07-21 20:31:46.183102	2025-07-21 20:31:46.183102	Stone	assets/images/options/HQ_04-Lavatory_CounterTop01_2023-01-19_CORALIE.jpg	6.210.3	8.8	20800	assets/images/palettes/Stone.png	AvantGarde	24
56	2025-07-21 20:31:46.186328	2025-07-21 20:31:46.186328	Carpet	assets/images/options/HQ_04-Lavatory_Flooring_L3507H4960_1014_CORALIE.jpg	6.500.0a	In Package	In Package	assets/images/palettes/Carpet.png	Essentials	25
57	2025-07-21 20:31:46.187956	2025-07-21 20:31:46.187956	Vinyl	assets/images/options/HQ_04-Lavatory_Flooring_L3507H4960_1013_CORALIE.jpg	6.500.2a	4.3	8000	assets/images/palettes/Vinyl.png	Essentials	25
58	2025-07-21 20:31:46.189499	2025-07-21 20:31:46.189499	Wood Veneer	assets/images/options/HQ_04-Lavatory_Flooring_L3507H4960_1011_CORALIE.jpg	6.500.4a	7.7	90600	assets/images/palettes/Wood.png	AvantGarde	25
59	2025-07-21 20:31:46.191365	2025-07-21 20:31:46.191365	Stone	assets/images/options/HQ_04-Lavatory_Flooring_L3507H4960_1012_CORALIE.jpg	6.500.3a	24.3	99800	assets/images/palettes/Stone.png	AvantGarde	25
60	2025-07-21 20:31:46.194878	2025-07-21 20:31:46.194878	Wood	assets/images/options/HQ_04-Lavatory_BulkheadFWD_L3507H4960_1007.jpg	6.400.2	In Package	In Package	assets/images/palettes/Wood.png	Essentials	26
61	2025-07-21 20:31:46.196268	2025-07-21 20:31:46.196268	Ultraleather	assets/images/options/HQ_04-Lavatory_BulkheadFWD_L3507H4960_1008.jpg	6.400.2a	-0.4	No charge	assets/images/palettes/Ultraleather.png	Essentials	26
62	2025-07-21 20:31:46.197382	2025-07-21 20:31:46.197382	Wood	assets/images/options/HQ_04-Lavatory_BulkheadAFT_L3507H4960_1007.jpg	6.410.2	In Package	In Package	assets/images/palettes/Wood.png	Essentials	26
63	2025-07-21 20:31:46.198748	2025-07-21 20:31:46.198748	Ultraleather	assets/images/options/HQ_04-Lavatory_BulkheadAFT_L3507H4960_1008.jpg	6.410.2a	-0.7	No charge	assets/images/palettes/Ultraleather.png	Essentials	26
64	2025-07-21 20:31:57.666434	2025-07-21 20:31:57.666434	Forward Entryway Closet Finishing: Wood Veneer /Paint with Wood Veneer/ Paint Door	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_01_EntryWCloset_L3507H4960_0036.jpg	6.240.10	In Package	In Package		Essentials	27
65	2025-07-21 20:31:57.668168	2025-07-21 20:31:57.668168	Forward Entryway Closet Finishing: Aft Side, Wood Veneer/ Paint	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_01_EntryWEntry_L3507H4960_0038.jpg	6.240.20	In Package	In Package		Essentials	27
66	2025-07-21 20:31:57.66972	2025-07-21 20:31:57.66972	Forward Entryway Closet Finishing: Wood Veneer /Paint with Mirror Door	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_01_EntryWCloset_L3507H4960_0035.jpg	6.240.11	1.4	Upgrade ($)		AvantGarde	27
67	2025-07-21 20:31:57.671085	2025-07-21 20:31:57.671085	Forward Entryway Closet Finishing: Aft Side, Wall Covering		6.240.21	-2.2	Upgrade ($)	assets/images/palettes/DecoFilm.png	AvantGarde	27
68	2025-07-21 20:31:57.674574	2025-07-21 20:31:57.674574	Crew Rest Forward Bulkhead Finishing: Forward Side, Wood Veneer / Paint	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_01_EntryWEntry_L3507H4960_0038.jpg	6.230.10	In Package	In Package		Essentials	28
69	2025-07-21 20:31:57.675545	2025-07-21 20:31:57.675545	Crew Rest Sliding Panel Finishing: Aft Face, Quilting	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_02_CrewRPanel_L3507H4960_0041.jpg	6.230.20	In Package	In Package		Essentials	28
70	2025-07-21 20:31:57.676779	2025-07-21 20:31:57.676779	Crew Rest Forward Bulkhead Finishing: Forward Side, Wall Covering	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_01_EntryWEntry_L3507H4960_0037.jpg	6.230.11	-2,2	Upgrade ($)	assets/images/palettes/DecoFilm.png	AvantGarde	28
71	2025-07-21 20:31:57.677724	2025-07-21 20:31:57.677724	Crew Rest Sliding Panel Finishing: Aft Face, Upholstery/Leather with Recess	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_02_CrewRPanel_L3507H4960_0040.jpg	6.230.21	-0,9	Upgrade ($)	assets/images/palettes/Ultraleather.png	AvantGarde	28
72	2025-07-21 20:31:57.678478	2025-07-21 20:31:57.678478	Crew Rest Sliding Panel Finishing: Aft Face, Upholstery/Leather	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_02_CrewRPanel_L3507H4960_0040BIS.jpg	6.230.22	Upgrade (Lbs)	Upgrade ($)	assets/images/palettes/Ultraleather.png	AvantGarde	28
73	2025-07-21 20:31:57.681716	2025-07-21 20:31:57.681716	Forward Lavatory Aft Bulkhead Finishing:  Forward Face, Wood Veneer/ Paint	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamChap_01_EntryWay_L4960H3507BIS.jpg	6.220.10	In Package	In Package	assets/images/palettes/Wood.png	Essentials	29
74	2025-07-21 20:31:57.683369	2025-07-21 20:31:57.683369	Sink : Glaskote	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_01_FWDLavat_L3507H4960_0031.jpg	6.210.12A	In Package	In Package	assets/images/palettes/Glaskote.png	Essentials	30
75	2025-07-21 20:31:57.685039	2025-07-21 20:31:57.685039	Forward Lavatory Backsplash Finishing: Solid Surface	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_01_FWDLavat_L3507H4960_0031.jpg	6.210.5	In Package	In Package	assets/images/palettes/SolidSurface.png	Essentials	31
135	2025-07-21 20:32:52.079197	2025-07-21 20:32:52.079197	Solid Surface	assets/images/options/HQ_01-Entryway_CounterTop_L3507H4960_1015.jpg	6.210.2a	In Package	In Package	assets/images/palettes/SolidSurface.png	Essentials	60
76	2025-07-21 20:31:57.685789	2025-07-21 20:31:57.685789	Forward Lavatory Backsplash Finishing: Granite/Marble/Quartz	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_01_FWDLavat_L3507H4960_0030.jpg	6.210.5a	2.2	Upgrade ($)	assets/images/palettes/Stone.png	AvantGarde	31
77	2025-07-21 20:31:57.688457	2025-07-21 20:31:57.688457	Sink : Glaskote	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_01_GalleyCountSink_L3507H4960.jpg	6.210.12	In Package	In Package	assets/images/palettes/Glaskote.png	Essentials	33
78	2025-07-21 20:31:57.689793	2025-07-21 20:31:57.689793	Galley Countertop Finishing: Solid Surface	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_01_GalleyCountTop_L3507H4960_0030.jpg	6.210.2A	In Package	In Package	assets/images/palettes/SolidSurface.png	Essentials	34
79	2025-07-21 20:31:57.690497	2025-07-21 20:31:57.690497	Galley Countertop: Granite/Marble/Quartz	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_01_GalleyCountTop_L3507H4960_0031.jpg	6.210.2	4,0	Upgrade ($)	assets/images/palettes/Stone.png	AvantGarde	34
80	2025-07-21 20:31:57.691946	2025-07-21 20:31:57.691946	Carpet	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_01_EntryWFloor_L3507H4960_0034.jpg	6.500.0B	In Package	In Package	assets/images/palettes/Carpet.png	Essentials	35
81	2025-07-21 20:31:57.69261	2025-07-21 20:31:57.69261	Vinyl	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_01_EntryWFloor_L3507H4960_0033.jpg	6.500.2	21.1	Upgrade ($)	assets/images/palettes/Vinyl.png	Essentials	35
82	2025-07-21 20:31:57.693292	2025-07-21 20:31:57.693292	threshold plate: Polished Aluminium	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_03_CabinThreslholdP_L3507H4960_0045.jpg	6.500.10	In Package	In Package	assets/images/palettes/Metal.png	Essentials	35
83	2025-07-21 20:31:57.693925	2025-07-21 20:31:57.693925	Flooring: Granite/Marble/Quartz	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_01_EntryWFloor_L3507H4960_0032.jpg	6.500.3B	59,8	Upgrade ($)	assets/images/palettes/Stone.png	AvantGarde	35
84	2025-07-21 20:31:57.694597	2025-07-21 20:31:57.694597	Flooring: Hard Wood 	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_01_EntryWFloorWood_L3507H4960_WOOD.jpg	6.500.4B	22	Upgrade ($)	assets/images/palettes/Wood.png	AvantGarde	35
85	2025-07-21 20:31:57.695479	2025-07-21 20:31:57.695479	Threshold plate: Glaskote	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_03_CabinThreslholdP_L3507H4960_0044.jpg	6.500.1B	0	Upgrade ($)	assets/images/palettes/Glaskote.png	AvantGarde	35
86	2025-07-21 20:31:57.697894	2025-07-21 20:31:57.697894	Console Table Finishing: Wood Veneer/ Paint with Wood Veneer/ Paint Edge	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_02_ClubConsoleTable_L3507H4960.jpg	6.200.20A	In Package	In Package	assets/images/palettes/Wood.png	Essentials	36
87	2025-07-21 20:31:57.699456	2025-07-21 20:31:57.699456	Service Ledge Finishing: Upholstery/Leather w/ Seams	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_02_ClubSideWallFront_L3507H4960.jpg	6.300.40A	In Package	In Package	assets/images/palettes/Ultraleather.png	Essentials	37
88	2025-07-21 20:31:57.700182	2025-07-21 20:31:57.700182	Top Surface: Wood Veneer/ Paint	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_02_ClubSideWallTop_L3507H4960.jpg	6.300.41A	In Package	In Package	assets/images/palettes/Wood.png	Essentials	37
89	2025-07-21 20:31:57.701054	2025-07-21 20:31:57.701054	Sideledge Open Storage Interior: Upholstery/Leather	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_02_ClubSideWallInsert_L3507H4960.jpg	6.300.43A	In Package	In Package	assets/images/palettes/Ultraleather.png	Essentials	37
90	2025-07-21 20:31:57.705757	2025-07-21 20:31:57.705757	Wood Veneer/ Paint with Wood Veneer/ Paint Edge	https://api.dassaultfalcon.com/lacollection-smtp/photos/parts/HQ_CamChap_04_Lounge02Diningtable_L4960H3507.jpg	6.200.30A	In Package	In Package	assets/images/palettes/Wood.png	Essentials	38
91	2025-07-21 20:31:57.70856	2025-07-21 20:31:57.70856	Facade: Upholstery/Leather with Top Stitch	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_02_MidCabFacade_L3507H4960.jpg	6.300.30a	In Package	In Package	assets/images/palettes/Ultraleather.png	Essentials	39
92	2025-07-21 20:31:57.709975	2025-07-21 20:31:57.709975	Top: Wood Veneer/Paint	https://api.dassaultfalcon.com/lacollection-smtp/photos/parts/LQ_CamTECH_01_BedCredenza_L3507H4960_0045.jpg	6.300.31a	In Package	In Package	assets/images/palettes/Wood.png	Essentials	39
93	2025-07-21 20:31:57.711321	2025-07-21 20:31:57.711321	Top: Granite/Marble/Quartz	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_01_BedCredenza_L3507H4960_0046.jpg	6.300.31b	15.4	Upgrade ($)	assets/images/palettes/Stone.png	AvantGarde	39
94	2025-07-21 20:31:57.716469	2025-07-21 20:31:57.716469	Divan Lower Facade: Upholstery/Leather	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_04_DivanLowerFacade_L3507H4960.jpg	6.260.10	In Package	In Package	assets/images/palettes/Ultraleather.png	Essentials	40
95	2025-07-21 20:31:57.71879	2025-07-21 20:31:57.71879	Divan Headrest: Upholstery/Leather	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_04_DivanHeadrest_L3507H4960.jpg	6.260.20	In Package	In Package	assets/images/palettes/Ultraleather.png	Essentials	40
96	2025-07-21 20:31:57.720737	2025-07-21 20:31:57.720737	Divan Cushion: Upholstery/Leather	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_04_DivanCushion_L3507H4960.jpg	6.260.30	In Package	In Package	assets/images/palettes/Upholstery.png	Essentials	40
97	2025-07-21 20:31:57.722493	2025-07-21 20:31:57.722493	Divan Backrest: Upholstery/Leather	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_04_DivanBackrest_L3507H4960.jpg	6.260.40	In Package	In Package	assets/images/palettes/Upholstery.png	Essentials	40
98	2025-07-21 20:31:57.724087	2025-07-21 20:31:57.724087	Divan Armrest: Upholstery/Leather	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_04_DivanArmrest_L3507H4960.jpg	6.260.50	In Package	In Package	assets/images/palettes/Upholstery.png	Essentials	40
99	2025-07-21 20:31:57.725399	2025-07-21 20:31:57.725399	Divan Side Storage Top Surface: Wood Veneer/Paint	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_04_DivanSideStorage_L3507H4960.jpg	6.260.60	In Package	In Package	assets/images/palettes/Paint.png	Essentials	40
100	2025-07-21 20:31:57.729217	2025-07-21 20:31:57.729217	Bed Header Exterior: Quilting	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_01_BedBedHeader_L3507H4960_0034.jpg	6.270.10B	In Package	In Package	assets/images/palettes/QuiltedLeather.png	Essentials	41
101	2025-07-21 20:31:57.730588	2025-07-21 20:31:57.730588	Bed Header Exterior: Upholstery	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_01_BedBedHeader_L3507H4960_0035.jpg	6.270.11b	-0.7	Upgrade ($)	assets/images/palettes/Upholstery.png	AvantGarde	41
102	2025-07-21 20:31:57.732823	2025-07-21 20:31:57.732823	Facade: Upholstery/Leather w/ Top Stitc	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_02_MidCabFacade_L3507H4960.jpg	6.300.30A	In Package	In Package		Essentials	42
103	2025-07-21 20:31:57.733827	2025-07-21 20:31:57.733827	Top: Wood Veneer/ Paint	https://api.dassaultfalcon.com/lacollection-smtp/photos/parts/LQ_CamTECH_01_BedCredenza_L3507H4960_0045.jpg	6.300.31A	In Package	In Package	assets/images/palettes/Wood.png	Essentials	42
104	2025-07-21 20:31:57.734778	2025-07-21 20:31:57.734778	Multi-Purpose Storage Cabinet Top: Granite/Marble/Quartz	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_01_BedCredenza_L3507H4960_0046.jpg	6.300.31B	15.4	Upgrade ($)	assets/images/palettes/Stone.png	AvantGarde	42
136	2025-07-21 20:32:52.080301	2025-07-21 20:32:52.080301	Stone	assets/images/options/HQ_01-Entryway_CounterTop_L3507H4960_1016.jpg	6.210.2	5	44000	assets/images/palettes/Stone.png	AvantGarde	60
105	2025-07-21 20:31:57.739252	2025-07-21 20:31:57.739252	Sink : Glaskote	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_02_AftVanityBackSplash_L3507H4960_0043.jpg	6.210.12B	In Package	In Package	assets/images/palettes/Glaskote.png	Essentials	44
106	2025-07-21 20:31:57.740682	2025-07-21 20:31:57.740682	Backsplash: Solid Surface	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_02_AftVanityBackSplash_L3507H4960_0044.jpg	6.210.31A	In Floorplan	In Floorplan	assets/images/palettes/SolidSurface.png	Essentials	45
107	2025-07-21 20:31:57.741497	2025-07-21 20:31:57.741497	Backsplash: Granite/Marble/Quartz	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_02_AftVanityBackSplash_L3507H4960_0043.jpg	6.210.31	1.1	Upgrade ($)	assets/images/palettes/Stone.png	AvantGarde	45
108	2025-07-21 20:31:57.743923	2025-07-21 20:31:57.743923	Right-Hand Closet Door: Wood Veneer/Paint	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_02_AftToiletCloset_L3507H4960_0041.jpg	6.212.1R0	In Package	In Package	assets/images/palettes/Wood.png	Essentials	47
109	2025-07-21 20:31:57.744704	2025-07-21 20:31:57.744704	Right-Hand Closet Door: Leather Padding	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_02_AftToiletCloset_L3507H4960_0042.jpg	6.212.1R1	4,0	Upgrade ($)	assets/images/palettes/Ultraleather.png	AvantGarde	47
110	2025-07-21 20:31:57.7464	2025-07-21 20:31:57.7464	Right-Hand Countertop: Solid Surface	https://api.dassaultfalcon.com/lacollection-smtp/photos/parts/LQ_CamTECH_02_AftToiletTOP_L3507H4960_0037.jpg	6.210.30a	In Package	In Package	assets/images/palettes/SolidSurface.png	Essentials	48
111	2025-07-21 20:31:57.747218	2025-07-21 20:31:57.747218	Right-Hand Countertop: Granite/Marble/Quartz	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_02_AftToiletTOP_L3507H4960_0036.jpg	6.210.30	4.0	Upgrade ($)	assets/images/palettes/Stone.png	AvantGarde	48
112	2025-07-21 20:31:57.749685	2025-07-21 20:31:57.749685	Forward Main Cabin Bulkhead Finishing: Wood Veneer/Paint (Each, per side)	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_03_CabinGallDivider_L3507H4960_0043.jpg	6.300.10	In Package	In Package	assets/images/palettes/Wood.png	Essentials	49
113	2025-07-21 20:31:57.750857	2025-07-21 20:31:57.750857	Forward Main Cabin Bulkhead Finishing: Upholstery (Each, per side)	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_03_CabinGallDivider_L3507H4960_0042.jpg	6.300.11	-2.2	Upgrade ($)	assets/images/palettes/Ultraleather.png	AvantGarde	49
114	2025-07-21 20:31:57.752507	2025-07-21 20:31:57.752507	Main Cabin Divider Finishing: Wood Veneer/Paint (Each, per side)	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_04_CabinMIDDivider_L3507H4960_0050.jpg	6.300.20	In Package	In Package	assets/images/palettes/Wood.png	Essentials	50
115	2025-07-21 20:31:57.753282	2025-07-21 20:31:57.753282	Main Cabin Divider Finishing: Upholstery (Each, per side)	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_04_CabinMIDDivider_L3507H4960_0051.jpg	6.300.21	-2.2	Upgrade ($)	assets/images/palettes/Ultraleather.png	AvantGarde	50
116	2025-07-21 20:31:57.754008	2025-07-21 20:31:57.754008	Main Cabin Divider Finishing: Upholstery/Leather with Wood Veneer/Paint Framed Mirror (Each, per side)	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_04_CabinMIDDivider_L3507H4960_0048.jpg	6.300.22	0.7	Upgrade ($)		AvantGarde	50
117	2025-07-21 20:31:57.754771	2025-07-21 20:31:57.754771	Main Cabin Divider Finishing: Quilting with Leather/Upholstery Insert and Piping (Each, per side)	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_04_CabinMIDDivider_L3507H4960_0049.jpg	6.300.23	2.6	Upgrade ($)	assets/images/palettes/Upholstery.png	AvantGarde	50
118	2025-07-21 20:31:57.756255	2025-07-21 20:31:57.756255	Aft Main Cabin Bulkhead Finishing: Wood Veneer/ Paint (Each, per side)	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_01_BedAftDivider_L3507H4960_0033.jpg	6.300.30	In Package	In Package	assets/images/palettes/Wood.png	Essentials	51
119	2025-07-21 20:31:57.757287	2025-07-21 20:31:57.757287	Aft Main Cabin Bulkhead Finishing: Upholstery (Each, per side)	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_01_BedAftDivider_L3507H4960_0032.jpg	6.300.31	-2.2	Upgrade ($)	assets/images/palettes/Ultraleather.png	AvantGarde	51
120	2025-07-21 20:31:57.758053	2025-07-21 20:31:57.758053	Aft Main Cabin Bulkhead Finishing: Upholstery/Leather with Insert and Recess (Each, per side)	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_01_BedAftDivider_L3507H4960_0031.jpg	6.300.32	-0.9	Upgrade ($)	assets/images/palettes/Ultraleather.png	AvantGarde	51
121	2025-07-21 20:31:57.760527	2025-07-21 20:31:57.760527	Sink : Glaskote	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_05_AFtLavatSink_L3507H4960.jpg	6.210.12B	In Package	In Package	assets/images/palettes/Glaskote.png	Essentials	52
122	2025-07-21 20:31:57.762858	2025-07-21 20:31:57.762858	kkk	https://api.dassaultfalcon.com/lacollection-smtp/photos/parts/LQ_CamTECH_02_AftToiletFloor_L3507H4960_0039.jpg					Essentials	54
123	2025-07-21 20:31:57.763973	2025-07-21 20:31:57.763973	kkk	https://api.dassaultfalcon.com/lacollection-smtp/photos/parts/LQ_CamTECH_02_AftToiletFloor_L3507H4960_0039.jpg					Essentials	54
124	2025-07-21 20:31:57.765496	2025-07-21 20:31:57.765496	Left-Hand  Closet Door: Wood Veneer/ Paint	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_02_AftToiletCloset_L3507H4960_0041.jpg	6.212.1L0	In Package	In Package	assets/images/palettes/Wood.png	Essentials	55
125	2025-07-21 20:31:57.766236	2025-07-21 20:31:57.766236	Left-Hand Closet Door: Leather Padding	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_02_AftToiletCloset_L3507H4960_0042.jpg	6.212.1L1	4,0	Upgrade ($)	assets/images/palettes/Ultraleather.png	AvantGarde	55
126	2025-07-21 20:31:57.767621	2025-07-21 20:31:57.767621	Carpet	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_05_AFtLavatFloor_L3507H4960_0053.jpg	6.500.0A	In Package	In Package	assets/images/palettes/Carpet.png	Essentials	56
127	2025-07-21 20:31:57.768354	2025-07-21 20:31:57.768354	Vinyl	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_05_AFtLavatFloor_L3507H4960_0054.jpg	6.500.2A	8.8	Upgrade ($)	assets/images/palettes/Vinyl.png	Essentials	56
128	2025-07-21 20:31:57.769077	2025-07-21 20:31:57.769077	FlooringGranite/Marble/Quartz Note: Included in shower configuration"	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_05_AFtLavatFloor_L3507H4960_0052.jpg	6.500.3A	24,9	Upgrade ($)	assets/images/palettes/Stone.png	AvantGarde	56
129	2025-07-21 20:31:57.770021	2025-07-21 20:31:57.770021	Flooring: Hard Wood 	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_05_AFtLavatFloorWood_L3507H4960.jpg	6.500.4A	7	Upgrade ($)	assets/images/palettes/Wood.png	AvantGarde	56
130	2025-07-21 20:32:52.063965	2025-07-21 20:32:52.063965	Glaskote	assets/images/options/HQ_01-Entryway_FWDLavSink_L3507H4960_1010.jpg	6.210.12a	In Package	In Package	assets/images/palettes/Glaskote.png	Essentials	57
131	2025-07-21 20:32:52.068237	2025-07-21 20:32:52.068237	Solid Surface	assets/images/options/HQ_01-Entryway_FWDLavConterTop_L3507H4960_1015.jpg	6.210.3b	In Package	In Package	assets/images/palettes/SolidSurface.png	Essentials	58
132	2025-07-21 20:32:52.069976	2025-07-21 20:32:52.069976	Stone	assets/images/options/HQ_01-Entryway_FWDLavConterTop_L3507H4960_1016.jpg	6.210.5	1.5	18300	assets/images/palettes/Stone.png	AvantGarde	58
133	2025-07-21 20:32:52.074294	2025-07-21 20:32:52.074294	Stainless Steel	assets/images/options/HQ_01-Entryway_Sink_L3507H4960_1011.jpg	6.210.1	In Package	In Package	\N	Essentials	59
134	2025-07-21 20:32:52.076	2025-07-21 20:32:52.076	Glaskote	assets/images/options/HQ_01-Entryway_Sink_L3507H4960_1010.jpg	6.210.12	0	7600	assets/images/palettes/Glaskote.png	Essentials	59
137	2025-07-21 20:32:52.081931	2025-07-21 20:32:52.081931	Carpet	assets/images/options/HQ_01-Entryway_Flooring_L3507H4960_1021.jpg	6.500.0b	In Package	In Package	assets/images/palettes/Carpet.png	Essentials	61
138	2025-07-21 20:32:52.083122	2025-07-21 20:32:52.083122	Vinyl	assets/images/options/HQ_01-Entryway_Flooring_L3507H4960_1022.jpg	6.500.2	7.4	10500	assets/images/palettes/Vinyl.png	Essentials	61
139	2025-07-21 20:32:52.084149	2025-07-21 20:32:52.084149	Wood Veneer	assets/images/options/HQ_01-Entryway_Flooring_L3507H4960_1023.jpg	6.500.4b	35.8	106500	assets/images/palettes/Wood.png	AvantGarde	61
140	2025-07-21 20:32:52.085634	2025-07-21 20:32:52.085634	Stone	assets/images/options/HQ_01-Entryway_Flooring_L3507H4960_1020.jpg	6.500.3b	58.6	115100	assets/images/palettes/Stone.png	AvantGarde	61
141	2025-07-21 20:32:52.087878	2025-07-21 20:32:52.087878	Wood Edge	assets/images/options/HQ_02-Cabin_ConsoleT_L3507H4960_1101.jpg	6.200.21	In Package	In Package	assets/images/palettes/Wood.png	Essentials	62
142	2025-07-21 20:32:52.088692	2025-07-21 20:32:52.088692	Painted Edge	assets/images/options/HQ_02-Cabin_ConsoleT_L3507H4960_1100.jpg	6.200.21a	0.5	30000	assets/images/palettes/Paint.png	AvantGarde	62
143	2025-07-21 20:32:52.090382	2025-07-21 20:32:52.090382	Wood Edge	assets/images/options/HQ_02-Cabin_SideLedge_L3507H4960_1102.jpg	6.300.40a	In Package	In Package	assets/images/palettes/Wood.png	Essentials	63
144	2025-07-21 20:32:52.091326	2025-07-21 20:32:52.091326	Upholstery	assets/images/options/HQ_02-Cabin_SideLedge_L3507H4960.jpg	6.300.41	In Package	In Package	assets/images/palettes/Upholstery.png	Essentials	63
145	2025-07-21 20:32:52.092422	2025-07-21 20:32:52.092422	Painted Edge	assets/images/options/HQ_02-Cabin_SideLedge_L3507H4960_1103.jpg	6.300.40	0.5	35900	assets/images/palettes/Paint.png	AvantGarde	63
146	2025-07-21 20:32:52.094233	2025-07-21 20:32:52.094233	Quilting	assets/images/options/HQ_02-Cabin_SideLedge_L3507H4960_1105.jpg	6.300.42	0	17600	assets/images/palettes/QuiltedLeather.png	AvantGarde	63
147	2025-07-21 20:32:52.09795	2025-07-21 20:32:52.09795	Wood Edge	assets/images/options/HQ_02-Cabin_DiningT_L3507H4960_1101.jpg	6.300.31	In Package	In Package	assets/images/palettes/Wood.png	Essentials	64
148	2025-07-21 20:32:52.099331	2025-07-21 20:32:52.099331	Painted Edge	assets/images/options/HQ_02-Cabin_DiningT_L3507H4960_1100.jpg	6.300.31a	0.5	11700	assets/images/palettes/Paint.png	AvantGarde	64
149	2025-07-21 20:32:52.101866	2025-07-21 20:32:52.101866	Wood Door	assets/images/options/HQ_02-Cabin_Credenza_L3507H4960_1111.jpg	6.300.30	In Package	In Package	assets/images/palettes/Wood.png	Essentials	65
150	2025-07-21 20:32:52.103077	2025-07-21 20:32:52.103077	Leather Door	assets/images/options/HQ_02-Cabin_Credenza_L3507H4960_1110.jpg	6.300.31	0.3	35000	assets/images/palettes/Ultraleather.png	AvantGarde	65
151	2025-07-21 20:32:52.105818	2025-07-21 20:32:52.105818	Wood	assets/images/options/HQ_02-Cabin_AFTMidCabDividerFWD_L3507H4960.jpg	6.300.8	In Package	In Package	assets/images/palettes/Wood.png	Essentials	66
152	2025-07-21 20:32:52.107619	2025-07-21 20:32:52.107619	Upholstery Insert	assets/images/options/HQ_02-Cabin_AFTMidCabDividerFWD-LH_L3507H4960.jpg	6.300.8g	0	9800	assets/images/palettes/Upholstery.png	AvantGarde	66
153	2025-07-21 20:32:52.112338	2025-07-21 20:32:52.112338	Wood Door	assets/images/options/HQ_03-Divan_StorageCab_L3507H4960.jpg	6.300.30R	In Package	In Package	assets/images/palettes/Wood.png	Essentials	67
154	2025-07-21 20:32:52.114769	2025-07-21 20:32:52.114769	Wood	assets/images/options/HQ_03-Divan_AFTLavBulkhead_L3507H4960_1111.jpg	6.400.1	In Package	In Package	assets/images/palettes/Wood.png	Essentials	68
155	2025-07-21 20:32:52.116146	2025-07-21 20:32:52.116146	Door Mirror	assets/images/options/HQ_03-Divan_AFTLavBulkhead_L3507H4960_1112.jpg	6.400.1B	6	No charge	\N	Essentials	68
156	2025-07-21 20:32:52.119402	2025-07-21 20:32:52.119402	Glaskote	assets/images/options/HQ_04-Lavatory_Sink_L3507H4960_1010.jpg	6.210.12b	In Package	In Package	assets/images/palettes/Glaskote.png	Essentials	69
157	2025-07-21 20:32:52.120858	2025-07-21 20:32:52.120858	Solid Surface	assets/images/options/HQ_04-Lavatory_CounterTop_L3507H4960_1015.jpg	6.210.3a	In Package	In Package	assets/images/palettes/SolidSurface.png	Essentials	70
158	2025-07-21 20:32:52.121637	2025-07-21 20:32:52.121637	Stone	assets/images/options/HQ_04-Lavatory_CounterTop_L3507H4960_1016.jpg	6.210.3	3	20800	assets/images/palettes/Stone.png	AvantGarde	70
159	2025-07-21 20:32:52.123471	2025-07-21 20:32:52.123471	Carpet	assets/images/options/HQ_04-Lavatory_Flooring_L3507H4960_1021.jpg	6.500.0a	In Package	In Package	assets/images/palettes/Carpet.png	Essentials	71
160	2025-07-21 20:32:52.124412	2025-07-21 20:32:52.124412	Vinyl	assets/images/options/HQ_04-Lavatory_Flooring_L3507H4960_1022.jpg	6.500.2a	5.4	8000	assets/images/palettes/Vinyl.png	Essentials	71
161	2025-07-21 20:32:52.125377	2025-07-21 20:32:52.125377	Wood Veneer	assets/images/options/HQ_04-Lavatory_Flooring_L3507H4960_1023.jpg	6.500.4a	9.4	91100	assets/images/palettes/Wood.png	AvantGarde	71
162	2025-07-21 20:32:52.126211	2025-07-21 20:32:52.126211	Stone	assets/images/options/HQ_04-Lavatory_Flooring_L3507H4960_1020.jpg	6.500.3a	29.5	99800	assets/images/palettes/Stone.png	AvantGarde	71
163	2025-07-21 20:32:52.127655	2025-07-21 20:32:52.127655	Mirror	assets/images/options/HQ_04-Lavatory_BulkheadFWD_L3507H4960_1112.jpg	6.400.2	In Package	In Package		Essentials	72
164	2025-07-21 20:32:52.128419	2025-07-21 20:32:52.128419	Ultraleather	assets/images/options/HQ_04-Lavatory_BulkheadFWD_L3507H4960_11121.jpg	6.400.2a	-0.2	No charge	assets/images/palettes/Ultraleather.png	Essentials	72
165	2025-07-21 20:32:52.129228	2025-07-21 20:32:52.129228	Wood	assets/images/options/HQ_04-Lavatory_BulkheadAFT_L3507H4960_1113.jpg	6.410.2	In Package	In Package	assets/images/palettes/Wood.png	Essentials	72
166	2025-07-21 20:32:52.1303	2025-07-21 20:32:52.1303	Ultraleather	assets/images/options/HQ_04-Lavatory_BulkheadAFT_L3507H4960_1114.jpg	6.410.2a	-0.3	No Charge	assets/images/palettes/Ultraleather.png	Essentials	72
\.


--
-- Data for Name: otp; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.otp (id, "createdAt", "updatedAt", code, expiry) FROM stdin;
\.


--
-- Data for Name: parts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.parts (id, "createdAt", "updatedAt", title, "areaId") FROM stdin;
1	2025-07-21 20:31:34.891647	2025-07-21 20:31:34.891647	Sink	1
2	2025-07-21 20:31:34.897792	2025-07-21 20:31:34.897792	Countertop	1
3	2025-07-21 20:31:34.901297	2025-07-21 20:31:34.901297	Upper drawer	1
4	2025-07-21 20:31:34.905319	2025-07-21 20:31:34.905319	Threshold	1
5	2025-07-21 20:31:34.909195	2025-07-21 20:31:34.909195	Flooring	1
6	2025-07-21 20:31:34.913043	2025-07-21 20:31:34.913043	Console Table	2
7	2025-07-21 20:31:34.914522	2025-07-21 20:31:34.914522	Dining table	2
8	2025-07-21 20:31:34.916372	2025-07-21 20:31:34.916372	Sideledge	2
9	2025-07-21 20:31:34.919499	2025-07-21 20:31:34.919499	Bulkheads	2
10	2025-07-21 20:31:34.924759	2025-07-21 20:31:34.924759	Sink	3
11	2025-07-21 20:31:34.927077	2025-07-21 20:31:34.927077	Countertop	3
12	2025-07-21 20:31:34.930182	2025-07-21 20:31:34.930182	Flooring	3
13	2025-07-21 20:31:34.933343	2025-07-21 20:31:34.933343	Bulkheads	3
14	2025-07-21 20:31:46.128266	2025-07-21 20:31:46.128266	Sink	4
15	2025-07-21 20:31:46.133995	2025-07-21 20:31:46.133995	Countertop	4
16	2025-07-21 20:31:46.139015	2025-07-21 20:31:46.139015	Flooring	4
17	2025-07-21 20:31:46.147081	2025-07-21 20:31:46.147081	Console Table	5
18	2025-07-21 20:31:46.149397	2025-07-21 20:31:46.149397	Sideledge	5
19	2025-07-21 20:31:46.154914	2025-07-21 20:31:46.154914	Dining Table	6
20	2025-07-21 20:31:46.157265	2025-07-21 20:31:46.157265	Credenza	6
21	2025-07-21 20:31:46.161398	2025-07-21 20:31:46.161398	Bulkheads	6
22	2025-07-21 20:31:46.171153	2025-07-21 20:31:46.171153	Divan Cabinet	7
23	2025-07-21 20:31:46.176654	2025-07-21 20:31:46.176654	Sink	8
24	2025-07-21 20:31:46.179934	2025-07-21 20:31:46.179934	Countertop	8
25	2025-07-21 20:31:46.18476	2025-07-21 20:31:46.18476	Flooring	8
26	2025-07-21 20:31:46.193363	2025-07-21 20:31:46.193363	Bulkheads	8
27	2025-07-21 20:31:57.664663	2025-07-21 20:31:57.664663	FORWARD CLOSET	9
28	2025-07-21 20:31:57.67356	2025-07-21 20:31:57.67356	 CREW REST	10
29	2025-07-21 20:31:57.680716	2025-07-21 20:31:57.680716	Bulkhead	11
30	2025-07-21 20:31:57.682599	2025-07-21 20:31:57.682599	Sink	11
31	2025-07-21 20:31:57.684334	2025-07-21 20:31:57.684334	Backsplash	11
32	2025-07-21 20:31:57.687175	2025-07-21 20:31:57.687175	Bulkhead	12
33	2025-07-21 20:31:57.687829	2025-07-21 20:31:57.687829	Sink	12
34	2025-07-21 20:31:57.689112	2025-07-21 20:31:57.689112	Countertop	12
35	2025-07-21 20:31:57.691219	2025-07-21 20:31:57.691219	Flooring	12
36	2025-07-21 20:31:57.697146	2025-07-21 20:31:57.697146	Console table	13
37	2025-07-21 20:31:57.698744	2025-07-21 20:31:57.698744	Sideledge	13
38	2025-07-21 20:31:57.704252	2025-07-21 20:31:57.704252	Dining Table	14
39	2025-07-21 20:31:57.707228	2025-07-21 20:31:57.707228	Credenza	14
40	2025-07-21 20:31:57.714753	2025-07-21 20:31:57.714753	Divan	15
41	2025-07-21 20:31:57.727953	2025-07-21 20:31:57.727953	Bed Header	16
42	2025-07-21 20:31:57.731751	2025-07-21 20:31:57.731751	Credenza	16
43	2025-07-21 20:31:57.736809	2025-07-21 20:31:57.736809	 	17
44	2025-07-21 20:31:57.738532	2025-07-21 20:31:57.738532	Sink	18
45	2025-07-21 20:31:57.739995	2025-07-21 20:31:57.739995	Vanity Backsplash	18
46	2025-07-21 20:31:57.742305	2025-07-21 20:31:57.742305		18
47	2025-07-21 20:31:57.742996	2025-07-21 20:31:57.742996	Closet Door	18
48	2025-07-21 20:31:57.745579	2025-07-21 20:31:57.745579	Right-Hand Countertop  	18
49	2025-07-21 20:31:57.748852	2025-07-21 20:31:57.748852	Forward Bulkhead	19
50	2025-07-21 20:31:57.751626	2025-07-21 20:31:57.751626	Main Cabin Divider	19
51	2025-07-21 20:31:57.755552	2025-07-21 20:31:57.755552	AFT Bulkhead	19
52	2025-07-21 20:31:57.759774	2025-07-21 20:31:57.759774	Sink	20
53	2025-07-21 20:31:57.761345	2025-07-21 20:31:57.761345		20
54	2025-07-21 20:31:57.762074	2025-07-21 20:31:57.762074		20
55	2025-07-21 20:31:57.764797	2025-07-21 20:31:57.764797	Closet Door	20
56	2025-07-21 20:31:57.766954	2025-07-21 20:31:57.766954	Flooring	20
57	2025-07-21 20:32:52.062143	2025-07-21 20:32:52.062143	Sink	25
58	2025-07-21 20:32:52.066022	2025-07-21 20:32:52.066022	Countertop	25
59	2025-07-21 20:32:52.072723	2025-07-21 20:32:52.072723	Sink	26
60	2025-07-21 20:32:52.077957	2025-07-21 20:32:52.077957	Countertop	26
61	2025-07-21 20:32:52.081127	2025-07-21 20:32:52.081127	flooring	26
62	2025-07-21 20:32:52.087171	2025-07-21 20:32:52.087171	Console table	27
63	2025-07-21 20:32:52.089531	2025-07-21 20:32:52.089531	Sideledge	27
64	2025-07-21 20:32:52.09696	2025-07-21 20:32:52.09696	Dining Table	28
65	2025-07-21 20:32:52.100672	2025-07-21 20:32:52.100672	Credenza	28
66	2025-07-21 20:32:52.104638	2025-07-21 20:32:52.104638	Bulkheads	28
67	2025-07-21 20:32:52.111136	2025-07-21 20:32:52.111136	Divan Cabinet	29
68	2025-07-21 20:32:52.113655	2025-07-21 20:32:52.113655	Bulkheads	29
69	2025-07-21 20:32:52.118459	2025-07-21 20:32:52.118459	Sink	30
70	2025-07-21 20:32:52.120156	2025-07-21 20:32:52.120156	Countertop	30
71	2025-07-21 20:32:52.122407	2025-07-21 20:32:52.122407	Flooring	30
72	2025-07-21 20:32:52.126923	2025-07-21 20:32:52.126923	Bulkheads	30
\.


--
-- Data for Name: permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.permissions (id, "createdAt", "updatedAt", action, subject, fields, conditions, inverted, reason, "roleId") FROM stdin;
1	2025-07-21 20:37:54.236074	2025-07-21 20:37:54.236074	manage	all	\N	\N	\N	\N	1
\.


--
-- Data for Name: planes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.planes (id, "createdAt", "updatedAt", name) FROM stdin;
1	2025-07-21 20:31:34.87942	2025-07-21 20:31:34.87942	2000LXS
2	2025-07-21 20:31:46.122893	2025-07-21 20:31:46.122893	6X
3	2025-07-21 20:31:57.651704	2025-07-21 20:31:57.651704	10X
6	2025-07-21 20:32:52.049884	2025-07-21 20:32:52.049884	8X
\.


--
-- Data for Name: preferences; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.preferences (id, "createdAt", "updatedAt", "salesEmails", "accountId") FROM stdin;
1	2025-07-21 20:35:03.702575	2025-07-21 20:35:03.702575	sales@mail.com	1
\.


--
-- Data for Name: preferences_bookmarks_options; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.preferences_bookmarks_options ("preferencesId", "optionsId") FROM stdin;
1	130
1	131
1	1
1	3
1	10
1	35
1	15
1	45
1	44
1	46
1	51
1	155
1	20
1	21
1	24
1	61
\.


--
-- Data for Name: preferences_planes_planes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.preferences_planes_planes ("preferencesId", "planesId") FROM stdin;
1	6
1	2
1	3
1	1
\.


--
-- Data for Name: profiles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.profiles (id, "createdAt", "updatedAt", firstname, lastname, bio, gender, "phoneNumber", address, "photoUrl", "dateOfBirth") FROM stdin;
2	2025-07-21 20:35:03.612022	2025-07-21 20:35:03.612022	Caroline	BORDENAVE	\N	\N	\N	\N	\N	\N
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.roles (id, "createdAt", "updatedAt", name, description) FROM stdin;
1	2025-07-21 20:37:54.236074	2025-07-21 20:37:54.236074	admin	\N
\.


--
-- Name: accounts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.accounts_id_seq', 1, true);


--
-- Name: areas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.areas_id_seq', 30, true);


--
-- Name: options_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.options_id_seq', 166, true);


--
-- Name: otp_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.otp_id_seq', 1, false);


--
-- Name: parts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.parts_id_seq', 72, true);


--
-- Name: permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.permissions_id_seq', 1, true);


--
-- Name: planes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.planes_id_seq', 6, true);


--
-- Name: preferences_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.preferences_id_seq', 1, true);


--
-- Name: profiles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.profiles_id_seq', 2, true);


--
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.roles_id_seq', 1, true);


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
    ADD CONSTRAINT "FK_33814c603c3b523e5423ad957d4" FOREIGN KEY ("profileId") REFERENCES public.profiles(id);


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

--
-- PostgreSQL database dump
--

-- Dumped from database version 17.5 (Debian 17.5-1.pgdg120+1)
-- Dumped by pg_dump version 17.5 (Ubuntu 17.5-1.pgdg22.04+1)

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
    "planeId" integer
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
    "partId" integer
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
    "areaId" integer
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
    name character varying NOT NULL
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
1	2025-07-23 18:29:29.940318	2025-07-23 19:20:53.167505	coralie.bordenave@dassault-aviation.com	CBORD	$2b$10$8EFkX6Q8KLMz16BxU6vCrO5Z178twvHQD9xc84qWC1ZWkRWD6klem	0	VERIFIED	\N	\N	\N	1	1	\N
\.


--
-- Data for Name: areas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.areas (id, "createdAt", "updatedAt", title, image, "planeId") FROM stdin;
1	2025-07-23 18:25:23.052662	2025-07-23 18:25:23.052662	Galley bar 	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/HQ_Chapter1_EntryWay_L4960H35078bd.jpg	1
2	2025-07-23 18:25:23.071413	2025-07-23 18:25:23.071413	Forward lavatory	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/HQ_Chapter1_FwdLav_L4960H3507bd.jpg	1
3	2025-07-23 18:25:23.077378	2025-07-23 18:25:23.077378	Forward lounge	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/HQ_Chapter2_MainCabin_L4960H3507BD.jpg	1
4	2025-07-23 18:25:23.083829	2025-07-23 18:25:23.083829	Middle lounge	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/HQ_Chapter2-B_MiddleLounge_L4960H3507BD.jpg	1
5	2025-07-23 18:25:23.094383	2025-07-23 18:25:23.094383	Aft lounge	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/HQ_Chapter2-C_AftLounge_L4960H3507BD.jpg	1
6	2025-07-23 18:25:23.099577	2025-07-23 18:25:23.099577	Aft lavatory	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/HQ_Chapter3_AftLavatory_L3507H4960BD.jpg	1
7	2025-07-23 18:25:52.179285	2025-07-23 18:25:52.179285	entryway	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/F6X_SNxxx_DN_Sch01_HQ_View_EntryWay2_2023-01-05.jpg	2
8	2025-07-23 18:25:52.195634	2025-07-23 18:25:52.195634	forward lounge	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/HQ_View_CabinClub_L4960H3507_Night.jpg	2
9	2025-07-23 18:25:52.209111	2025-07-23 18:25:52.209111	middle lounge	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/HQ_View_CabinFWD_L4960H3507.jpg	2
10	2025-07-23 18:25:52.235282	2025-07-23 18:25:52.235282	aft lounge	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/F6X_SNxxx_DN_Sch01_HQ_View_DivanAFTView_2023-01-05_Coralie.jpg	2
11	2025-07-23 18:25:52.240695	2025-07-23 18:25:52.240695	aft lavatory	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/F6X_SNxxx_DN_Sch01_HQ_View_AftLavatory_2023-01-05_CORALIE.jpg	2
12	2025-07-23 18:26:44.221116	2025-07-23 18:26:44.221116	Entryway	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_08_CHAPITRE_2024-12-05.jpg	3
13	2025-07-23 18:26:44.241745	2025-07-23 18:26:44.241745	Cabin	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_04_CHAPITRE_2024-12-05.jpg	3
14	2025-07-23 18:26:44.252007	2025-07-23 18:26:44.252007	Aft Lavatory	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_02_CHAPITRE_2024-12-05.jpg	3
15	2025-07-23 18:27:01.611656	2025-07-23 18:27:01.611656	Forward Closet Finishing	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/HQ_CamChap_01_EntryWay_L4960H3507.jpg	4
16	2025-07-23 18:27:01.622279	2025-07-23 18:27:01.622279	Crew Rest Finishing	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/LQ_CamChap_01_CrewRest_L4960H3507.jpg	4
17	2025-07-23 18:27:01.630617	2025-07-23 18:27:01.630617	Forward Lavatory Finishing	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/HQ_CamChap_01_EntryWayFWDLav_L4960H3507.jpg	4
18	2025-07-23 18:27:01.638418	2025-07-23 18:27:01.638418	Galley Finishing	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/HQ_CamChap_01_EntryWay_L4960H3507.jpg	4
19	2025-07-23 18:27:01.653334	2025-07-23 18:27:01.653334	Club Lounge	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/HQ_CamChap_03_Lounge01ClubView_L4960H3507-01.jpg	4
20	2025-07-23 18:27:01.662999	2025-07-23 18:27:01.662999	Dining	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/HQ_CamChap_04_Lounge02Dining_L4960H3507.jpg	4
21	2025-07-23 18:27:01.670184	2025-07-23 18:27:01.670184	Meridian & Divan	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/HQ_CamChap_05_Lounge03Divan_L4960H3507co.jpg	4
22	2025-07-23 18:27:01.681427	2025-07-23 18:27:01.681427	Bedroom	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/HQ_CamCHAP_08_BedView_L4960H3507co.jpg	4
23	2025-07-23 18:27:01.696651	2025-07-23 18:27:01.696651	Falcon Privacy Suite Finishing	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/LQ_CamChap_06_Lounge04FPS02_L4960H3507co.jpg	4
24	2025-07-23 18:27:01.699488	2025-07-23 18:27:01.699488	Shower	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/LQ_CamCHAP_09_AftLavat_L4960H3507co.jpg	4
25	2025-07-23 18:27:01.719638	2025-07-23 18:27:01.719638	Bulkheads	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/LQ_CamCHAP_05b_ViewLH-Lounge1_LH-Club_L4960H3507.jpg	4
26	2025-07-23 18:27:01.737734	2025-07-23 18:27:01.737734	Classic Bathroom	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/HQ_CamChap_07_AftVanity01_L4960H3507.jpg	4
27	2025-07-23 18:27:01.752238	2025-07-23 18:27:01.752238	ENTRYWAY	https://api.dassaultfalcon.com/lacollection-smtp/photos/areas/HQ_CamChap_01_EntryWay_L4960H3507.jpg	4
28	2025-07-23 18:27:01.753025	2025-07-23 18:27:01.753025	MAIN CABIN	https://api.dassaultfalcon.com/lacollection-smtp/photos/areas/LQ_CamChap_02_CabinView_L4960H3507.jpg	4
29	2025-07-23 18:27:01.753807	2025-07-23 18:27:01.753807	AFT LAVATORY 	https://api.dassaultfalcon.com/lacollection-smtp/photos/areas/LQ_CamCHAP_09_AftLavat_L4960H3507.jpg	4
30	2025-07-23 18:27:01.754545	2025-07-23 18:27:01.754545	MAIN CABIN BULKHEAD 	https://api.dassaultfalcon.com/lacollection-smtp/photos/areas/LQ_CamCHAP_05b_ViewLH-Lounge1_LH-Club_L4960H3507.jpg	4
\.


--
-- Data for Name: options; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.options (id, "createdAt", "updatedAt", name, image, serial, weight, price, palette, type, "partId") FROM stdin;
1	2025-07-23 18:25:23.057039	2025-07-23 18:25:23.057039	Stainless Steel	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_01-Entryway_Sink_L3507H4960_1011.jpg	6.210.1	In Package	In Package		Essentials	1
2	2025-07-23 18:25:23.059877	2025-07-23 18:25:23.059877	Glaskote	https://api.dassaultfalcon.com/lacollection-smtp/photos/parts/HQ_01-Entryway_Sink_L3507H4960_1010.jpg	6.210.12	0	7800	assets/images/palettes/Glaskote.png	Essentials	1
3	2025-07-23 18:25:23.063113	2025-07-23 18:25:23.063113	Solid Surface	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_01-Entryway_CounterTop_L3507H4960_1015.jpg	6.210.2a	In Package	In Package	assets/images/palettes/SolidSurface.png	Essentials	2
4	2025-07-23 18:25:23.06459	2025-07-23 18:25:23.06459	Stone	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_01-Entryway_CounterTop_L3507H4960_1016.jpg	6.210.2	5	45300	assets/images/palettes/Stone.png	AvantGarde	2
5	2025-07-23 18:25:23.067618	2025-07-23 18:25:23.067618	Carpet	https://api.dassaultfalcon.com/lacollection-smtp/photos/parts/HQ_01-Entryway_Flooring_L3507H4960_1021.jpg	6.500.0B	In Package	In Package	assets/images/palettes/Carpet.png	Essentials	3
6	2025-07-23 18:25:23.068775	2025-07-23 18:25:23.068775	Vinyl	https://api.dassaultfalcon.com/lacollection-smtp/photos/parts/HQ_01-Entryway_Flooring_L3507H4960_1022BD.jpg	6.500.2	22,4	$10,500	assets/images/palettes/Vinyl.png	Essentials	3
7	2025-07-23 18:25:23.069627	2025-07-23 18:25:23.069627	Stone	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_01-Entryway_Flooring_L3507H4960_1020BD.jpg	6.500.3B	32,3	$115,100	assets/images/palettes/Stone.png	AvantGarde	3
8	2025-07-23 18:25:23.070571	2025-07-23 18:25:23.070571	Wood Veneer	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_01-Entryway_Flooring_L3507H4960_1023BD.jpg	6.500.4B	10,9	$106,500	assets/images/palettes/Wood.png	AvantGarde	3
9	2025-07-23 18:25:23.073883	2025-07-23 18:25:23.073883	Glaskote	https://api.dassaultfalcon.com/lacollection-smtp/photos/parts/HQ_01-Entryway_FWDLavSink_L3507H4960_1010.jpg	6.210.12a	In Package	In Package	assets/images/palettes/Glaskote.png	Essentials	4
10	2025-07-23 18:25:23.075841	2025-07-23 18:25:23.075841	Solid Surface1	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_01-Entryway_FWDLavConterTop_L3507H4960_1015.jpg	6.210.3b	In Package	In Package	assets/images/palettes/SolidSurface.png	Essentials	5
11	2025-07-23 18:25:23.076613	2025-07-23 18:25:23.076613	Stone	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_01-Entryway_FWDLavConterTop_L3507H4960_1016BD.jpg	6.210.5 	1.5	18800	assets/images/palettes/Stone.png	AvantGarde	5
12	2025-07-23 18:25:23.078909	2025-07-23 18:25:23.078909	Wood Edge	assets/images/options/HQ_02-Cabin_ConsoleT_L3507H4960_1101.jpg	6.200.21	In Package	In Package	assets/images/palettes/Wood.png	Essentials	6
13	2025-07-23 18:25:23.079657	2025-07-23 18:25:23.079657	Painted Edge	assets/images/options/HQ_02-Cabin_ConsoleT_L3507H4960_1100.jpg	6.200.21a	0	30000	assets/images/palettes/Paint.png	AvantGarde	6
14	2025-07-23 18:25:23.081515	2025-07-23 18:25:23.081515	Wood Edge	assets/images/options/HQ_02-Cabin_SideLedge_L3507H4960_1102.jpg	6.300.40a	In Package	In Package	assets/images/palettes/Wood.png	Essentials	7
15	2025-07-23 18:25:23.082363	2025-07-23 18:25:23.082363	Upholstery	assets/images/options/HQ_02-Cabin_SideLedge_L3507H4960.jpg	6.300.41	In Package	In Package	assets/images/palettes/Upholstery.png	Essentials	7
16	2025-07-23 18:25:23.083127	2025-07-23 18:25:23.083127	Painted Edge	assets/images/options/HQ_02-Cabin_SideLedge_L3507H4960_1103.jpg	6.300.40	0	37000	assets/images/palettes/Paint.png	AvantGarde	7
17	2025-07-23 18:25:23.085246	2025-07-23 18:25:23.085246	Wood Edge	assets/images/options/HQ_02-Cabin_DiningT_L3507H4960_1101.jpg	6.300.31	In Package	In Package	assets/images/palettes/Wood.png	Essentials	8
18	2025-07-23 18:25:23.085954	2025-07-23 18:25:23.085954	Painted Edge	assets/images/options/HQ_02-Cabin_DiningT_L3507H4960_1100.jpg	6.300.31a	0	15000	assets/images/palettes/Paint.png	AvantGarde	8
19	2025-07-23 18:25:23.088254	2025-07-23 18:25:23.088254	Wood Door	assets/images/options/HQ_02-Cabin_Credenza_L3507H4960_1111.jpg	6.300.30	In Package	In Package	assets/images/palettes/Wood.png	Essentials	9
20	2025-07-23 18:25:23.089424	2025-07-23 18:25:23.089424	Leather Door	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_02-Cabin_Credenza_L3507H4960_1111221.jpg	6.300.31	0	No Charge	assets/images/palettes/Ultraleather.png	AvantGarde	9
21	2025-07-23 18:25:23.09081	2025-07-23 18:25:23.09081	Painted Door	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_02-Cabin_Credenza_L3507H4960_1109.jpg	6.300.32	0	10000	assets/images/palettes/Paint.png	AvantGarde	9
22	2025-07-23 18:25:23.092833	2025-07-23 18:25:23.092833	Wood	assets/images/options/HQ_02-Cabin_AFTMidCabDividerFWD_L3507H4960.jpg	6.300.8	In Package	In Package	assets/images/palettes/Wood.png	Essentials	10
23	2025-07-23 18:25:23.093652	2025-07-23 18:25:23.093652	Upholstery Insert	assets/images/options/HQ_02-Cabin_AFTMidCabDividerFWD-LH_L3507H4960.jpg	6.300.8g	0	10100	assets/images/palettes/Upholstery.png	AvantGarde	10
24	2025-07-23 18:25:23.096209	2025-07-23 18:25:23.096209	Wood Door	assets/images/options/HQ_03-Divan_StorageCab_L3507H4960.jpg	6.300.30R	In Package	In Package	assets/images/palettes/Wood.png	Essentials	11
25	2025-07-23 18:25:23.097758	2025-07-23 18:25:23.097758	Wood	assets/images/options/HQ_03-Divan_AFTLavBulkhead_L3507H4960_1111.jpg	6.400.1	In Package	In Package	assets/images/palettes/Wood.png	Essentials	12
26	2025-07-23 18:25:23.098616	2025-07-23 18:25:23.098616	Door Mirror	assets/images/options/HQ_03-Divan_AFTLavBulkhead_L3507H4960_1112.jpg	6.400.1B	6	No charge	\N	Essentials	12
27	2025-07-23 18:25:23.101484	2025-07-23 18:25:23.101484	Glaskote	assets/images/options/HQ_04-Lavatory_Sink_L3507H4960_1010.jpg	6.210.12b	In Package	In Package	assets/images/palettes/Glaskote.png	Essentials	13
28	2025-07-23 18:25:23.103215	2025-07-23 18:25:23.103215	Solid Surface	assets/images/options/HQ_04-Lavatory_CounterTop_L3507H4960_1015.jpg	6.210.3a	In Package	In Package	assets/images/palettes/SolidSurface.png	Essentials	14
29	2025-07-23 18:25:23.104065	2025-07-23 18:25:23.104065	Stone	assets/images/options/HQ_04-Lavatory_CounterTop_L3507H4960_1016.jpg	6.210.3	0,3	21400	assets/images/palettes/Stone.png	AvantGarde	14
30	2025-07-23 18:25:23.105781	2025-07-23 18:25:23.105781	Carpet	assets/images/options/HQ_04-Lavatory_Flooring_L3507H4960_1021.jpg	6.500.0a	In Package	In Package	assets/images/palettes/Carpet.png	Essentials	15
31	2025-07-23 18:25:23.106987	2025-07-23 18:25:23.106987	Vinyl	assets/images/options/HQ_04-Lavatory_Flooring_L3507H4960_1022.jpg	6.500.2a	8,8	8000	assets/images/palettes/Vinyl.png	Essentials	15
32	2025-07-23 18:25:23.108272	2025-07-23 18:25:23.108272	Wood Veneer	assets/images/options/HQ_04-Lavatory_Flooring_L3507H4960_1023.jpg	6.500.4a	3,5	91100	assets/images/palettes/Wood.png	AvantGarde	15
33	2025-07-23 18:25:23.109302	2025-07-23 18:25:23.109302	Stone	assets/images/options/HQ_04-Lavatory_Flooring_L3507H4960_1020.jpg	6.500.3a	13,9	99800	assets/images/palettes/Stone.png	AvantGarde	15
34	2025-07-23 18:25:23.111526	2025-07-23 18:25:23.111526	Mirror	assets/images/options/HQ_04-Lavatory_BulkheadFWD_L3507H4960_1112.jpg	6.400.2	In Package	In Package		Essentials	16
35	2025-07-23 18:25:23.112693	2025-07-23 18:25:23.112693	Ultraleather	assets/images/options/HQ_04-Lavatory_BulkheadFWD_L3507H4960_11121.jpg	6.400.2a	-0.2	No charge	assets/images/palettes/Ultraleather.png	Essentials	16
36	2025-07-23 18:25:23.113746	2025-07-23 18:25:23.113746	Wood	assets/images/options/HQ_04-Lavatory_BulkheadAFT_L3507H4960_1113.jpg	6.410.2	In Package	In Package	assets/images/palettes/Wood.png	Essentials	16
37	2025-07-23 18:25:23.114922	2025-07-23 18:25:23.114922	Ultraleather	assets/images/options/HQ_04-Lavatory_BulkheadAFT_L3507H4960_1114.jpg	6.410.2a	-0,1	No Charge	assets/images/palettes/Ultraleather.png	Essentials	16
38	2025-07-23 18:25:52.185455	2025-07-23 18:25:52.185455	Stainless steel	assets/images/options/HQ_01-Entryway_Sink_L3507H4960_1003_CORALIE.jpg	6.210.1	In Package	In Package	\N	Essentials	17
39	2025-07-23 18:25:52.187208	2025-07-23 18:25:52.187208	Glaskote	assets/images/options/HQ_01-Entryway_Sink_L3507H4960_1004_CORALIE.jpg	6.210.12	0	7800	assets/images/palettes/Glaskote.png	Essentials	17
40	2025-07-23 18:25:52.189623	2025-07-23 18:25:52.189623	Solid surface	assets/images/options/HQ_01-Entryway_CounterTop_L3507H4960_1006_CORALIE.jpg	6.210.2a	In Package	In Package	assets/images/palettes/SolidSurface.png	Essentials	18
41	2025-07-23 18:25:52.19047	2025-07-23 18:25:52.19047	Stone	assets/images/options/HQ_01-Entryway_CounterTop_L3507H4960_1005_CORALIE.jpg	6.210.2	-1,5	45300	assets/images/palettes/Stone.png	AvantGarde	18
42	2025-07-23 18:25:52.192309	2025-07-23 18:25:52.192309	Carpet	assets/images/options/HQ_01-Entryway_Flooring_L3507H4960_1007_CORALIE.jpg	6.500.0b	In Package	In Package	assets/images/palettes/Carpet.png	Essentials	19
43	2025-07-23 18:25:52.193095	2025-07-23 18:25:52.193095	Vinyl	assets/images/options/HQ_01-Entryway_Flooring_L3507H4960_1009_CORALIE.jpg	6.500.2	13,3	10500	assets/images/palettes/Vinyl.png	Essentials	19
44	2025-07-23 18:25:52.193861	2025-07-23 18:25:52.193861	Wood Veneer	assets/images/options/HQ_01-Entryway_Flooring_L3507H4960_1010_CORALIE.jpg	6.500.4b	7.4	106000	assets/images/palettes/Wood.png	AvantGarde	19
45	2025-07-23 18:25:52.194648	2025-07-23 18:25:52.194648	Stone	assets/images/options/HQ_01-Entryway_Flooring_L3507H4960_1008_CORALIE.jpg	6.500.3b	24.8	115100	assets/images/palettes/Stone.png	AvantGarde	19
46	2025-07-23 18:25:52.1985	2025-07-23 18:25:52.1985	Wood Edge	assets/images/options/HQ_02-Cabin_ConsoleT_L3507H4960_1001_CORALIE.jpg	6.200.21	In Package	In Package	assets/images/palettes/Wood.png	Essentials	20
47	2025-07-23 18:25:52.200458	2025-07-23 18:25:52.200458	Painted Edge	assets/images/options/HQ_02-Cabin_ConsoleT_L3507H4960_1002_CORALIE.jpg	6.200.21a	0	30000	assets/images/palettes/Paint.png	AvantGarde	20
48	2025-07-23 18:25:52.203598	2025-07-23 18:25:52.203598	Wood Edge	assets/images/options/HQ_02-Cabin_SideLedge_L3507H4960_1018_CORALIE.jpg	6.300.40a	In Package	In Package	assets/images/palettes/Wood.png	Essentials	21
49	2025-07-23 18:25:52.205184	2025-07-23 18:25:52.205184	Upholstery	assets/images/options/HQ_02-Cabin_SideLedge_L3507H4960_1018__TEXTILE_CORALIE.jpg	6.300.41	In Package	In Package	assets/images/palettes/Upholstery.png	Essentials	21
50	2025-07-23 18:25:52.206986	2025-07-23 18:25:52.206986	Painted Edge	assets/images/options/HQ_02-Cabin_SideLedge_L3507H4960_1019_CORALIE.jpg	6.300.40	0	37000	assets/images/palettes/Paint.png	AvantGarde	21
51	2025-07-23 18:25:52.212106	2025-07-23 18:25:52.212106	Wood Edge	assets/images/options/HQ_02-Cabin_DiningT_L3507H4960_1001.jpg	6.200.31	In Package	In Package	assets/images/palettes/Wood.png	Essentials	22
52	2025-07-23 18:25:52.213862	2025-07-23 18:25:52.213862	Painted Edge	assets/images/options/HQ_02-Cabin_DiningT_L3507H4960_1002.jpg	6.200.31a	0	15000	assets/images/palettes/Paint.png	AvantGarde	22
53	2025-07-23 18:25:52.217657	2025-07-23 18:25:52.217657	Wood Door	assets/images/options/HQ_02-Cabin_Credenza_L3507H4960_1017.jpg	6.300.30	In Package	In Package	assets/images/palettes/Wood.png	Essentials	23
54	2025-07-23 18:25:52.219138	2025-07-23 18:25:52.219138	Painted Door	assets/images/options/HQ_02-Cabin_Credenza_L3507H4960_1016.jpg	6.300.32	0	10000	assets/images/palettes/Paint.png	Essentials	23
55	2025-07-23 18:25:52.221095	2025-07-23 18:25:52.221095	Leather Door	assets/images/options/HQ_02-Cabin_Credenza_L3507H4960_1015.jpg	6.300.31	0	No Charge	assets/images/palettes/QuiltedLeather.png	AvantGarde	23
56	2025-07-23 18:25:52.225	2025-07-23 18:25:52.225	Wood	assets/images/options/HQ_02-Cabin_AFTMidCabDividerFWD_L3507H4960_1023.jpg	6.300.8	In Package	In Package	assets/images/palettes/Wood.png	Essentials	24
57	2025-07-23 18:25:52.226832	2025-07-23 18:25:52.226832	Mirror Insert	assets/images/options/HQ_02-Cabin_AFTMidCabDividerFWD_L3507H4960_1022.jpg	6.300.8h	1	11900		Essentials	24
58	2025-07-23 18:25:52.22842	2025-07-23 18:25:52.22842	Wood	assets/images/options/HQ_02-Cabin_AFTMidCabDividerAFT_L3507H4960-01.jpg	6.300.9	In Package	In Package	assets/images/palettes/Wood.png	Essentials	24
59	2025-07-23 18:25:52.230536	2025-07-23 18:25:52.230536	Mirror Insert	assets/images/options/HQ_02-Cabin_AFTMidCabDividerAFT_L3507H4960-02.jpg	6.300.9h	1	12300		Essentials	24
60	2025-07-23 18:25:52.233378	2025-07-23 18:25:52.233378	Upholstery Insert	assets/images/options/HQ_02-Cabin_AFTMidCabDividerFWD_L3507H4960_1021.jpg	6.300.8g	0	10100	assets/images/palettes/Upholstery.png	AvantGarde	24
61	2025-07-23 18:25:52.238024	2025-07-23 18:25:52.238024	Wood Door	assets/images/options/HQ_03-Divan_StorageCab_L3507H4960_1002.jpg	6.300.30R	In Package	In Package	assets/images/palettes/Wood.png	Essentials	25
62	2025-07-23 18:25:52.239436	2025-07-23 18:25:52.239436	Painted Door	assets/images/options/HQ_03-Divan_StorageCab_L3507H4960_1003.jpg	6.300.32R	0	10000	assets/images/palettes/Paint.png	Essentials	25
63	2025-07-23 18:25:52.243	2025-07-23 18:25:52.243	Glaskote	assets/images/options/HQ_04-Lavatory_Sink_L3507H4960_1000_CORALIE.jpg	6.210.12b	In Package	In Package	assets/images/palettes/Glaskote.png	Essentials	26
64	2025-07-23 18:25:52.247439	2025-07-23 18:25:52.247439	Solid Surface	assets/images/options/HQ_04-Lavatory_CounterTop02_2023-01-19_CORALIE.jpg	6.210.3a	In Package	In Package	assets/images/palettes/SolidSurface.png	Essentials	27
65	2025-07-23 18:25:52.249083	2025-07-23 18:25:52.249083	Stone	assets/images/options/HQ_04-Lavatory_CounterTop01_2023-01-19_CORALIE.jpg	6.210.3	2.5	21400	assets/images/palettes/Stone.png	AvantGarde	27
66	2025-07-23 18:25:52.253396	2025-07-23 18:25:52.253396	Carpet	assets/images/options/HQ_04-Lavatory_Flooring_L3507H4960_1014_CORALIE.jpg	6.500.0a	In Package	In Package	assets/images/palettes/Carpet.png	Essentials	28
67	2025-07-23 18:25:52.254955	2025-07-23 18:25:52.254955	Vinyl	assets/images/options/HQ_04-Lavatory_Flooring_L3507H4960_1013_CORALIE.jpg	6.500.2a	3.2	8000	assets/images/palettes/Vinyl.png	Essentials	28
68	2025-07-23 18:25:52.256451	2025-07-23 18:25:52.256451	Wood Veneer	assets/images/options/HQ_04-Lavatory_Flooring_L3507H4960_1011_CORALIE.jpg	6.500.4a	0.8	90600	assets/images/palettes/Wood.png	AvantGarde	28
69	2025-07-23 18:25:52.258545	2025-07-23 18:25:52.258545	Stone	assets/images/options/HQ_04-Lavatory_Flooring_L3507H4960_1012_CORALIE.jpg	6.500.3a	9.6	99800	assets/images/palettes/Stone.png	AvantGarde	28
70	2025-07-23 18:25:52.261632	2025-07-23 18:25:52.261632	Wood	assets/images/options/HQ_04-Lavatory_BulkheadFWD_L3507H4960_1007.jpg	6.400.2	In Package	In Package	assets/images/palettes/Wood.png	Essentials	29
71	2025-07-23 18:25:52.263216	2025-07-23 18:25:52.263216	Ultraleather	assets/images/options/HQ_04-Lavatory_BulkheadFWD_L3507H4960_1008.jpg	6.400.2a	-0.8	No charge	assets/images/palettes/Ultraleather.png	Essentials	29
72	2025-07-23 18:25:52.26531	2025-07-23 18:25:52.26531	Wood	assets/images/options/HQ_04-Lavatory_BulkheadAFT_L3507H4960_1007.jpg	6.410.2	In Package	In Package	assets/images/palettes/Wood.png	Essentials	29
73	2025-07-23 18:25:52.266677	2025-07-23 18:25:52.266677	Ultraleather	assets/images/options/HQ_04-Lavatory_BulkheadAFT_L3507H4960_1008.jpg	6.410.2a	-0.2	No charge	assets/images/palettes/Ultraleather.png	Essentials	29
74	2025-07-23 18:26:44.22482	2025-07-23 18:26:44.22482	Stainless Steel	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_13_TECH_2024-12-05.jpg	6.210.1	In Package	In Package		Essentials	30
75	2025-07-23 18:26:44.227308	2025-07-23 18:26:44.227308	Glaskote	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/F2L_SNxxx_DN_Scheme01_HQ_13_TECH_2024-12-05.jpg	6.210.12	0	7800	assets/images/palettes/Glaskote.png	Essentials	30
76	2025-07-23 18:26:44.229653	2025-07-23 18:26:44.229653	Solid Surface	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/F2L_SNxxx_DN_Scheme01_LQ_09_TECH_2024-12-05A.jpg	6.210.2a	0	In Package	assets/images/palettes/SolidSurface.png	Essentials	31
77	2025-07-23 18:26:44.23097	2025-07-23 18:26:44.23097	Stone	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/F2L_SNxxx_DN_Scheme01_LQ_09_TECH_2024-12-05.jpg	6.210.2	Standard	39200	assets/images/palettes/Stone.png	AvantGarde	31
78	2025-07-23 18:26:44.234656	2025-07-23 18:26:44.234656	Metal plated	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_12_TECH_2024-12-05.jpg	6.210.9a	0	In Package	assets/images/palettes/Stone.png	Essentials	32
79	2025-07-23 18:26:44.235782	2025-07-23 18:26:44.235782	Wood veneer	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_12_TECH_2024-12-05.jpg	6.210.9	Standard	No charge	assets/images/palettes/Wood.png	Essentials	32
80	2025-07-23 18:26:44.237507	2025-07-23 18:26:44.237507	Stainless steel	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_25_TECH_2024-12-05.jpg	6.500.10	In Package	In Package		Essentials	33
81	2025-07-23 18:26:44.238261	2025-07-23 18:26:44.238261	Glasskote	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_25_CHAPITRE_2024-12-05.jpg	6.500.1b	0.1	8700	assets/images/palettes/Glaskote.png	Essentials	33
82	2025-07-23 18:26:44.239856	2025-07-23 18:26:44.239856	Carpet	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_10_TECH_2024-12-05.jpg	6.500.0b	In Package	In Package	Carpet.png	Essentials	34
83	2025-07-23 18:26:44.24079	2025-07-23 18:26:44.24079	Vinyl	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_10_TECH_2024-12-05.jpg	6.500.2	10.6	10500	assets/images/palettes/Vinyl.png	Essentials	34
84	2025-07-23 18:26:44.243253	2025-07-23 18:26:44.243253	Wood veneer	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_05_CHAPITRE_2024-12-05.jpg	6.200.20	In Package	In Package	assets/images/palettes/Wood.png	Essentials	35
85	2025-07-23 18:26:44.244686	2025-07-23 18:26:44.244686	Wood vener	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_06_CHAPITRE_2024-12-05.jpg	6.200.30	In Package	In Package	assets/images/palettes/Wood.png	Essentials	36
86	2025-07-23 18:26:44.246031	2025-07-23 18:26:44.246031	Two (2), 1/8-Inch Metal Trim Strips and Vertical Join Seam below Tables	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_16_TECH_2024-12-05.jpg	6.300.5	In Package	In Package		Essentials	37
87	2025-07-23 18:26:44.24673	2025-07-23 18:26:44.24673	One (1), 1/8-Inch Metal Trim Strip and Vertical Join Seam below Tables	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_16_TECH_2024-12-05.jpg	6.300.5d	0.5	No charge		Essentials	37
88	2025-07-23 18:26:44.247466	2025-07-23 18:26:44.247466	Upholstery	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_19_TECH_2024-12-05.jpg	6.300.41	In Package	In Package		Essentials	37
89	2025-07-23 18:26:44.249033	2025-07-23 18:26:44.249033	Wood veneer	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_11_TECH_2024-12-05.jpg	6.300.7	In Package	In Package	assets/images/palettes/Wood.png	Essentials	38
90	2025-07-23 18:26:44.249747	2025-07-23 18:26:44.249747	One (1), 1/8-Inch Metal Trim Strip and Vertical Join Seam below Tables	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_14B_TECH_2024-12-05.jpg	6.400.1	0	In Package		Essentials	38
91	2025-07-23 18:26:44.250512	2025-07-23 18:26:44.250512	Wood Veneer with Door in Mirror	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_14_TECH_2024-12-05.jpg	6.400.1b	0	No charge		Essentials	38
92	2025-07-23 18:26:44.251264	2025-07-23 18:26:44.251264	Wood Veneer with Leather/Ultraleather insert	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_14_TECH_2024-12-05.jpg	6.400.1g	0.1	10100		AvantGarde	38
93	2025-07-23 18:26:44.253446	2025-07-23 18:26:44.253446	Glaskote	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_24_TECH_2024-12-05.jpg	6.210.12b	In Package	In Package	assets/images/palettes/Glaskote.png	Essentials	39
94	2025-07-23 18:26:44.255917	2025-07-23 18:26:44.255917	Solid Surface	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_21_TECH_2024-12-05.jpg	6.210.3a	In Package	In Package	assets/images/palettes/SolidSurface.png	Essentials	40
95	2025-07-23 18:26:44.257188	2025-07-23 18:26:44.257188	Stone	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_22_TECH_2024-12-05.jpg	6.210.3	1.6	21400	assets/images/palettes/Stone.png	AvantGarde	40
96	2025-07-23 18:26:44.260668	2025-07-23 18:26:44.260668	Carpet	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_23_TECH_2024-12-05.jpg	6.500.0a	In Package	In Package	assets/images/palettes/Carpet.png	Essentials	41
97	2025-07-23 18:26:44.262466	2025-07-23 18:26:44.262466	Vinyl	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_23_TECH_2024-12-05.jpg	6.500.2a	7.9	8000	assets/images/palettes/Vinyl.png	Essentials	41
98	2025-07-23 18:26:44.265403	2025-07-23 18:26:44.265403	Soft good	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_21_TECH_2024-12-05.jpg	6.400.2	In Package	In Package	assets/images/palettes/Wood.png	Essentials	42
99	2025-07-23 18:26:44.266964	2025-07-23 18:26:44.266964	Soft good	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_20_TECH_2024-12-05_V2.jpg	6.410.2	In Package	In Package	assets/images/palettes/Ultraleather.png	Essentials	42
100	2025-07-23 18:27:01.615088	2025-07-23 18:27:01.615088	Forward Entryway Closet Finishing: Wood Veneer /Paint with Wood Veneer/ Paint Door	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_01_EntryWCloset_L3507H4960_0036.jpg	6.240.10	In Package	In Package		Essentials	43
101	2025-07-23 18:27:01.616615	2025-07-23 18:27:01.616615	Forward Entryway Closet Finishing: Aft Side, Wood Veneer/ Paint	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_01_EntryWEntry_L3507H4960_0038.jpg	6.240.20	In Package	In Package		Essentials	43
102	2025-07-23 18:27:01.618127	2025-07-23 18:27:01.618127	Forward Entryway Closet Finishing: Wood Veneer /Paint with Mirror Door	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_01_EntryWCloset_L3507H4960_0035.jpg	6.240.11	1.4	Upgrade ($)		AvantGarde	43
103	2025-07-23 18:27:01.619459	2025-07-23 18:27:01.619459	Forward Entryway Closet Finishing: Aft Side, Wall Covering		6.240.21	-2.2	Upgrade ($)	assets/images/palettes/DecoFilm.png	AvantGarde	43
104	2025-07-23 18:27:01.624948	2025-07-23 18:27:01.624948	Crew Rest Forward Bulkhead Finishing: Forward Side, Wood Veneer / Paint	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_01_EntryWEntry_L3507H4960_0038.jpg	6.230.10	In Package	In Package		Essentials	45
105	2025-07-23 18:27:01.625969	2025-07-23 18:27:01.625969	Crew Rest Sliding Panel Finishing: Aft Face, Quilting	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_02_CrewRPanel_L3507H4960_0041.jpg	6.230.20	In Package	In Package		Essentials	45
106	2025-07-23 18:27:01.627325	2025-07-23 18:27:01.627325	Crew Rest Forward Bulkhead Finishing: Forward Side, Wall Covering	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_01_EntryWEntry_L3507H4960_0037.jpg	6.230.11	-2,2	Upgrade ($)	assets/images/palettes/DecoFilm.png	AvantGarde	45
107	2025-07-23 18:27:01.628455	2025-07-23 18:27:01.628455	Crew Rest Sliding Panel Finishing: Aft Face, Upholstery/Leather with Recess	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_02_CrewRPanel_L3507H4960_0040.jpg	6.230.21	-0,9	Upgrade ($)	assets/images/palettes/Ultraleather.png	AvantGarde	45
108	2025-07-23 18:27:01.629521	2025-07-23 18:27:01.629521	Crew Rest Sliding Panel Finishing: Aft Face, Upholstery/Leather	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_02_CrewRPanel_L3507H4960_0040BIS.jpg	6.230.22	Upgrade (Lbs)	Upgrade ($)	assets/images/palettes/Ultraleather.png	AvantGarde	45
109	2025-07-23 18:27:01.632773	2025-07-23 18:27:01.632773	Forward Lavatory Aft Bulkhead Finishing:  Forward Face, Wood Veneer/ Paint	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamChap_01_EntryWay_L4960H3507BIS.jpg	6.220.10	In Package	In Package	assets/images/palettes/Wood.png	Essentials	46
110	2025-07-23 18:27:01.634455	2025-07-23 18:27:01.634455	Sink : Glaskote	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_01_FWDLavat_L3507H4960_0031.jpg	6.210.12A	In Package	In Package	assets/images/palettes/Glaskote.png	Essentials	47
111	2025-07-23 18:27:01.636286	2025-07-23 18:27:01.636286	Forward Lavatory Backsplash Finishing: Solid Surface	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_01_FWDLavat_L3507H4960_0031.jpg	6.210.5	In Package	In Package	assets/images/palettes/SolidSurface.png	Essentials	48
112	2025-07-23 18:27:01.637245	2025-07-23 18:27:01.637245	Forward Lavatory Backsplash Finishing: Granite/Marble/Quartz	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_01_FWDLavat_L3507H4960_0030.jpg	6.210.5a	2.2	Upgrade ($)	assets/images/palettes/Stone.png	AvantGarde	48
113	2025-07-23 18:27:01.643806	2025-07-23 18:27:01.643806	Sink : Glaskote	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_01_GalleyCountSink_L3507H4960.jpg	6.210.12	In Package	In Package	assets/images/palettes/Glaskote.png	Essentials	50
114	2025-07-23 18:27:01.645913	2025-07-23 18:27:01.645913	Solid Surface	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_01_GalleyCountTop_L3507H4960_0030.jpg	6.210.2A	In Package	In Package	assets/images/palettes/SolidSurface.png	Essentials	51
115	2025-07-23 18:27:01.646834	2025-07-23 18:27:01.646834	Granite/Marble/Quartz	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_01_GalleyCountTop_L3507H4960_0031.jpg	6.210.2	4,0	Upgrade ($)	assets/images/palettes/Stone.png	AvantGarde	51
116	2025-07-23 18:27:01.648301	2025-07-23 18:27:01.648301	Carpet	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_01_EntryWFloor_L3507H4960_0034.jpg	6.500.0B	In Package	In Package	assets/images/palettes/Carpet.png	Essentials	52
117	2025-07-23 18:27:01.649137	2025-07-23 18:27:01.649137	Vinyl	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_01_EntryWFloor_L3507H4960_0033.jpg	6.500.2	21.1	Upgrade ($)	assets/images/palettes/Vinyl.png	Essentials	52
118	2025-07-23 18:27:01.649905	2025-07-23 18:27:01.649905	threshold plate: Polished Aluminium	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_03_CabinThreslholdP_L3507H4960_0045.jpg	6.500.10	In Package	In Package	assets/images/palettes/Metal.png	Essentials	52
119	2025-07-23 18:27:01.650733	2025-07-23 18:27:01.650733	Flooring: Granite/Marble/Quartz	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_01_EntryWFloor_L3507H4960_0032.jpg	6.500.3B	59,8	Upgrade ($)	assets/images/palettes/Stone.png	AvantGarde	52
120	2025-07-23 18:27:01.651549	2025-07-23 18:27:01.651549	Flooring: Hard Wood 	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_01_EntryWFloorWood_L3507H4960_WOOD.jpg	6.500.4B	22	Upgrade ($)	assets/images/palettes/Wood.png	AvantGarde	52
121	2025-07-23 18:27:01.652551	2025-07-23 18:27:01.652551	Threshold plate: Glaskote	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_03_CabinThreslholdP_L3507H4960_0044.jpg	6.500.1B	0	Upgrade ($)	assets/images/palettes/Glaskote.png	AvantGarde	52
122	2025-07-23 18:27:01.655042	2025-07-23 18:27:01.655042	Console Table Finishing: Wood Veneer/ Paint with Wood Veneer/ Paint Edge	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_02_ClubConsoleTable_L3507H4960.jpg	6.200.20A	In Package	In Package	assets/images/palettes/Wood.png	Essentials	53
123	2025-07-23 18:27:01.657612	2025-07-23 18:27:01.657612	Service Ledge Finishing: Upholstery/Leather w/ Seams	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_02_ClubSideWallFront_L3507H4960.jpg	6.300.40A	In Package	In Package	assets/images/palettes/Ultraleather.png	Essentials	54
124	2025-07-23 18:27:01.659778	2025-07-23 18:27:01.659778	Top Surface: Wood Veneer/ Paint	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_02_ClubSideWallTop_L3507H4960.jpg	6.300.41A	In Package	In Package	assets/images/palettes/Wood.png	Essentials	54
125	2025-07-23 18:27:01.661385	2025-07-23 18:27:01.661385	Sideledge Open Storage Interior: Upholstery/Leather	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_02_ClubSideWallInsert_L3507H4960.jpg	6.300.43A	In Package	In Package	assets/images/palettes/Ultraleather.png	Essentials	54
126	2025-07-23 18:27:01.665477	2025-07-23 18:27:01.665477	Wood Veneer/ Paint with Wood Veneer/ Paint Edge	https://api.dassaultfalcon.com/lacollection-smtp/photos/parts/HQ_CamChap_04_Lounge02Diningtable_L4960H3507.jpg	6.200.30A	In Package	In Package	assets/images/palettes/Wood.png	Essentials	55
127	2025-07-23 18:27:01.667198	2025-07-23 18:27:01.667198	Facade: Upholstery/Leather with Top Stitch	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_02_MidCabFacade_L3507H4960.jpg	6.300.30a	In Package	In Package	assets/images/palettes/Ultraleather.png	Essentials	56
128	2025-07-23 18:27:01.668617	2025-07-23 18:27:01.668617	Top: Wood Veneer/Paint	https://api.dassaultfalcon.com/lacollection-smtp/photos/parts/LQ_CamTECH_01_BedCredenza_L3507H4960_0045.jpg	6.300.31a	In Package	In Package	assets/images/palettes/Wood.png	Essentials	56
129	2025-07-23 18:27:01.669469	2025-07-23 18:27:01.669469	Top: Granite/Marble/Quartz	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_01_BedCredenza_L3507H4960_0046.jpg	6.300.31b	15.4	Upgrade ($)	assets/images/palettes/Stone.png	AvantGarde	56
130	2025-07-23 18:27:01.672025	2025-07-23 18:27:01.672025	Divan Lower Facade: Upholstery/Leather	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_04_DivanLowerFacade_L3507H4960.jpg	6.260.10	In Package	In Package	assets/images/palettes/Ultraleather.png	Essentials	57
131	2025-07-23 18:27:01.673805	2025-07-23 18:27:01.673805	Divan Headrest: Upholstery/Leather	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_04_DivanHeadrest_L3507H4960.jpg	6.260.20	In Package	In Package	assets/images/palettes/Ultraleather.png	Essentials	57
132	2025-07-23 18:27:01.675474	2025-07-23 18:27:01.675474	Divan Cushion: Upholstery/Leather	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_04_DivanCushion_L3507H4960.jpg	6.260.30	In Package	In Package	assets/images/palettes/Upholstery.png	Essentials	57
133	2025-07-23 18:27:01.677054	2025-07-23 18:27:01.677054	Divan Backrest: Upholstery/Leather	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_04_DivanBackrest_L3507H4960.jpg	6.260.40	In Package	In Package	assets/images/palettes/Upholstery.png	Essentials	57
134	2025-07-23 18:27:01.678414	2025-07-23 18:27:01.678414	Divan Armrest: Upholstery/Leather	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_04_DivanArmrest_L3507H4960.jpg	6.260.50	In Package	In Package	assets/images/palettes/Upholstery.png	Essentials	57
135	2025-07-23 18:27:01.680004	2025-07-23 18:27:01.680004	Divan Side Storage Top Surface: Wood Veneer/Paint	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_04_DivanSideStorage_L3507H4960.jpg	6.260.60	In Package	In Package	assets/images/palettes/Paint.png	Essentials	57
136	2025-07-23 18:27:01.685102	2025-07-23 18:27:01.685102	Bed Header Exterior: Quilting	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_01_BedBedHeader_L3507H4960_0034.jpg	6.270.10B	In Package	In Package	assets/images/palettes/QuiltedLeather.png	Essentials	58
137	2025-07-23 18:27:01.686751	2025-07-23 18:27:01.686751	Bed Header Exterior: Upholstery	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_01_BedBedHeader_L3507H4960_0035.jpg	6.270.11b	-0.7	Upgrade ($)	assets/images/palettes/Upholstery.png	AvantGarde	58
138	2025-07-23 18:27:01.690659	2025-07-23 18:27:01.690659	Facade: Upholstery/Leather w/ Top Stitc	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_02_MidCabFacade_L3507H4960.jpg	6.300.30A	In Package	In Package		Essentials	59
139	2025-07-23 18:27:01.692938	2025-07-23 18:27:01.692938	Top: Wood Veneer/ Paint	https://api.dassaultfalcon.com/lacollection-smtp/photos/parts/LQ_CamTECH_01_BedCredenza_L3507H4960_0045.jpg	6.300.31A	In Package	In Package	assets/images/palettes/Wood.png	Essentials	59
140	2025-07-23 18:27:01.694918	2025-07-23 18:27:01.694918	Multi-Purpose Storage Cabinet Top: Granite/Marble/Quartz	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_01_BedCredenza_L3507H4960_0046.jpg	6.300.31B	15.4	Upgrade ($)	assets/images/palettes/Stone.png	AvantGarde	59
141	2025-07-23 18:27:01.702178	2025-07-23 18:27:01.702178	Sink : Glaskote	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_02_AftVanityBackSplash_L3507H4960_0043.jpg	6.210.12B	In Package	In Package	assets/images/palettes/Glaskote.png	Essentials	61
142	2025-07-23 18:27:01.70463	2025-07-23 18:27:01.70463	Backsplash: Solid Surface	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_02_AftVanityBackSplash_L3507H4960_0044.jpg	6.210.31A	In Floorplan	In Floorplan	assets/images/palettes/SolidSurface.png	Essentials	62
143	2025-07-23 18:27:01.706425	2025-07-23 18:27:01.706425	Backsplash: Granite/Marble/Quartz	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_02_AftVanityBackSplash_L3507H4960_0043.jpg	6.210.31	1.1	Upgrade ($)	assets/images/palettes/Stone.png	AvantGarde	62
144	2025-07-23 18:27:01.710512	2025-07-23 18:27:01.710512	Right-Hand Closet Door: Wood Veneer/Paint	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_02_AftToiletCloset_L3507H4960_0041.jpg	6.212.1R0	In Package	In Package	assets/images/palettes/Wood.png	Essentials	64
145	2025-07-23 18:27:01.711771	2025-07-23 18:27:01.711771	Right-Hand Closet Door: Leather Padding	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_02_AftToiletCloset_L3507H4960_0042.jpg	6.212.1R1	4,0	Upgrade ($)	assets/images/palettes/Ultraleather.png	AvantGarde	64
146	2025-07-23 18:27:01.715502	2025-07-23 18:27:01.715502	Right-Hand Countertop: Solid Surface	https://api.dassaultfalcon.com/lacollection-smtp/photos/parts/LQ_CamTECH_02_AftToiletTOP_L3507H4960_0037.jpg	6.210.30a	In Package	In Package	assets/images/palettes/SolidSurface.png	Essentials	65
147	2025-07-23 18:27:01.717666	2025-07-23 18:27:01.717666	Right-Hand Countertop: Granite/Marble/Quartz	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_02_AftToiletTOP_L3507H4960_0036.jpg	6.210.30	4.0	Upgrade ($)	assets/images/palettes/Stone.png	AvantGarde	65
148	2025-07-23 18:27:01.723546	2025-07-23 18:27:01.723546	Forward Main Cabin Bulkhead Finishing: Wood Veneer/Paint (Each, per side)	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_03_CabinGallDivider_L3507H4960_0043.jpg	6.300.10	In Package	In Package	assets/images/palettes/Wood.png	Essentials	66
149	2025-07-23 18:27:01.725638	2025-07-23 18:27:01.725638	Forward Main Cabin Bulkhead Finishing: Upholstery (Each, per side)	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_03_CabinGallDivider_L3507H4960_0042.jpg	6.300.11	-2.2	Upgrade ($)	assets/images/palettes/Ultraleather.png	AvantGarde	66
150	2025-07-23 18:27:01.72843	2025-07-23 18:27:01.72843	Main Cabin Divider Finishing: Wood Veneer/Paint (Each, per side)	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_04_CabinMIDDivider_L3507H4960_0050.jpg	6.300.20	In Package	In Package	assets/images/palettes/Wood.png	Essentials	67
151	2025-07-23 18:27:01.729828	2025-07-23 18:27:01.729828	Main Cabin Divider Finishing: Upholstery (Each, per side)	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_04_CabinMIDDivider_L3507H4960_0051.jpg	6.300.21	-2.2	Upgrade ($)	assets/images/palettes/Ultraleather.png	AvantGarde	67
152	2025-07-23 18:27:01.73115	2025-07-23 18:27:01.73115	Main Cabin Divider Finishing: Upholstery/Leather with Wood Veneer/Paint Framed Mirror (Each, per side)	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_04_CabinMIDDivider_L3507H4960_0048.jpg	6.300.22	0.7	Upgrade ($)		AvantGarde	67
153	2025-07-23 18:27:01.732317	2025-07-23 18:27:01.732317	Main Cabin Divider Finishing: Quilting with Leather/Upholstery Insert and Piping (Each, per side)	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_04_CabinMIDDivider_L3507H4960_0049.jpg	6.300.23	2.6	Upgrade ($)	assets/images/palettes/Upholstery.png	AvantGarde	67
154	2025-07-23 18:27:01.734515	2025-07-23 18:27:01.734515	Aft Main Cabin Bulkhead Finishing: Wood Veneer/ Paint (Each, per side)	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_01_BedAftDivider_L3507H4960_0033.jpg	6.300.30	In Package	In Package	assets/images/palettes/Wood.png	Essentials	68
155	2025-07-23 18:27:01.735633	2025-07-23 18:27:01.735633	Aft Main Cabin Bulkhead Finishing: Upholstery (Each, per side)	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_01_BedAftDivider_L3507H4960_0032.jpg	6.300.31	-2.2	Upgrade ($)	assets/images/palettes/Ultraleather.png	AvantGarde	68
156	2025-07-23 18:27:01.736708	2025-07-23 18:27:01.736708	Aft Main Cabin Bulkhead Finishing: Upholstery/Leather with Insert and Recess (Each, per side)	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_01_BedAftDivider_L3507H4960_0031.jpg	6.300.32	-0.9	Upgrade ($)	assets/images/palettes/Ultraleather.png	AvantGarde	68
157	2025-07-23 18:27:01.739931	2025-07-23 18:27:01.739931	Sink : Glaskote	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_05_AFtLavatSink_L3507H4960.jpg	6.210.12B	In Package	In Package	assets/images/palettes/Glaskote.png	Essentials	69
158	2025-07-23 18:27:01.743138	2025-07-23 18:27:01.743138	kkk	https://api.dassaultfalcon.com/lacollection-smtp/photos/parts/LQ_CamTECH_02_AftToiletFloor_L3507H4960_0039.jpg					Essentials	71
159	2025-07-23 18:27:01.744162	2025-07-23 18:27:01.744162	kkk	https://api.dassaultfalcon.com/lacollection-smtp/photos/parts/LQ_CamTECH_02_AftToiletFloor_L3507H4960_0039.jpg					Essentials	71
160	2025-07-23 18:27:01.746232	2025-07-23 18:27:01.746232	Left-Hand  Closet Door: Wood Veneer/ Paint	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_02_AftToiletCloset_L3507H4960_0041.jpg	6.212.1L0	In Package	In Package	assets/images/palettes/Wood.png	Essentials	72
161	2025-07-23 18:27:01.747298	2025-07-23 18:27:01.747298	Left-Hand Closet Door: Leather Padding	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_02_AftToiletCloset_L3507H4960_0042.jpg	6.212.1L1	4,0	Upgrade ($)	assets/images/palettes/Ultraleather.png	AvantGarde	72
162	2025-07-23 18:27:01.748938	2025-07-23 18:27:01.748938	Carpet	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_05_AFtLavatFloor_L3507H4960_0053.jpg	6.500.0A	In Package	In Package	assets/images/palettes/Carpet.png	Essentials	73
163	2025-07-23 18:27:01.749829	2025-07-23 18:27:01.749829	Vinyl	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_05_AFtLavatFloor_L3507H4960_0054.jpg	6.500.2A	8.8	Upgrade ($)	assets/images/palettes/Vinyl.png	Essentials	73
164	2025-07-23 18:27:01.750699	2025-07-23 18:27:01.750699	FlooringGranite/Marble/Quartz Note: Included in shower configuration"	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_05_AFtLavatFloor_L3507H4960_0052.jpg	6.500.3A	24,9	Upgrade ($)	assets/images/palettes/Stone.png	AvantGarde	73
165	2025-07-23 18:27:01.751498	2025-07-23 18:27:01.751498	Flooring: Hard Wood 	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_05_AFtLavatFloorWood_L3507H4960.jpg	6.500.4A	7	Upgrade ($)	assets/images/palettes/Wood.png	AvantGarde	73
\.


--
-- Data for Name: otp; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.otp (id, "createdAt", "updatedAt", code, expiry) FROM stdin;
\.


--
-- Data for Name: parts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.parts (id, "createdAt", "updatedAt", title, "areaId") FROM stdin;
1	2025-07-23 18:25:23.054737	2025-07-23 18:25:23.054737	Sink	1
2	2025-07-23 18:25:23.061928	2025-07-23 18:25:23.061928	Countertop	1
3	2025-07-23 18:25:23.065914	2025-07-23 18:25:23.065914	Flooring	1
4	2025-07-23 18:25:23.072513	2025-07-23 18:25:23.072513	Sink	2
5	2025-07-23 18:25:23.075051	2025-07-23 18:25:23.075051	Countertop	2
6	2025-07-23 18:25:23.078097	2025-07-23 18:25:23.078097	Console table	3
7	2025-07-23 18:25:23.080767	2025-07-23 18:25:23.080767	Sideledge	3
8	2025-07-23 18:25:23.084546	2025-07-23 18:25:23.084546	Dining Table	4
9	2025-07-23 18:25:23.087174	2025-07-23 18:25:23.087174	Credenza	4
10	2025-07-23 18:25:23.091839	2025-07-23 18:25:23.091839	Bulkheads	4
11	2025-07-23 18:25:23.095504	2025-07-23 18:25:23.095504	Divan Cabinet	5
12	2025-07-23 18:25:23.096991	2025-07-23 18:25:23.096991	Bulkheads	5
13	2025-07-23 18:25:23.100542	2025-07-23 18:25:23.100542	Sink	6
14	2025-07-23 18:25:23.102458	2025-07-23 18:25:23.102458	Countertop	6
15	2025-07-23 18:25:23.104868	2025-07-23 18:25:23.104868	Flooring	6
16	2025-07-23 18:25:23.110527	2025-07-23 18:25:23.110527	Bulkheads	6
17	2025-07-23 18:25:52.182808	2025-07-23 18:25:52.182808	Sink	7
18	2025-07-23 18:25:52.188718	2025-07-23 18:25:52.188718	Countertop	7
19	2025-07-23 18:25:52.191237	2025-07-23 18:25:52.191237	Flooring	7
20	2025-07-23 18:25:52.196679	2025-07-23 18:25:52.196679	Console Table	8
21	2025-07-23 18:25:52.202114	2025-07-23 18:25:52.202114	Sideledge	8
22	2025-07-23 18:25:52.210492	2025-07-23 18:25:52.210492	Dining Table	9
23	2025-07-23 18:25:52.215785	2025-07-23 18:25:52.215785	Credenza	9
24	2025-07-23 18:25:52.223028	2025-07-23 18:25:52.223028	Bulkheads	9
25	2025-07-23 18:25:52.236599	2025-07-23 18:25:52.236599	Divan Cabinet	10
26	2025-07-23 18:25:52.241979	2025-07-23 18:25:52.241979	Sink	11
27	2025-07-23 18:25:52.244961	2025-07-23 18:25:52.244961	Countertop	11
28	2025-07-23 18:25:52.251395	2025-07-23 18:25:52.251395	Flooring	11
29	2025-07-23 18:25:52.26037	2025-07-23 18:25:52.26037	Bulkheads	11
30	2025-07-23 18:26:44.223031	2025-07-23 18:26:44.223031	Sink	12
31	2025-07-23 18:26:44.228687	2025-07-23 18:26:44.228687	Countertop	12
32	2025-07-23 18:26:44.232893	2025-07-23 18:26:44.232893	Upper drawer	12
33	2025-07-23 18:26:44.236677	2025-07-23 18:26:44.236677	Threshold	12
34	2025-07-23 18:26:44.239032	2025-07-23 18:26:44.239032	Flooring	12
35	2025-07-23 18:26:44.242557	2025-07-23 18:26:44.242557	Console Table	13
36	2025-07-23 18:26:44.243962	2025-07-23 18:26:44.243962	Dining table	13
37	2025-07-23 18:26:44.245393	2025-07-23 18:26:44.245393	Sideledge	13
38	2025-07-23 18:26:44.248323	2025-07-23 18:26:44.248323	Bulkheads	13
39	2025-07-23 18:26:44.252754	2025-07-23 18:26:44.252754	Sink	14
40	2025-07-23 18:26:44.254434	2025-07-23 18:26:44.254434	Countertop	14
41	2025-07-23 18:26:44.259037	2025-07-23 18:26:44.259037	Flooring	14
42	2025-07-23 18:26:44.263984	2025-07-23 18:26:44.263984	Bulkheads	14
43	2025-07-23 18:27:01.613731	2025-07-23 18:27:01.613731	FORWARD CLOSET	15
44	2025-07-23 18:27:01.620744	2025-07-23 18:27:01.620744		15
45	2025-07-23 18:27:01.62377	2025-07-23 18:27:01.62377	 CREW REST	16
46	2025-07-23 18:27:01.631807	2025-07-23 18:27:01.631807	Bulkhead	17
47	2025-07-23 18:27:01.633658	2025-07-23 18:27:01.633658	Sink	17
48	2025-07-23 18:27:01.635518	2025-07-23 18:27:01.635518	Backsplash	17
49	2025-07-23 18:27:01.640318	2025-07-23 18:27:01.640318	Bulkhead	18
50	2025-07-23 18:27:01.642072	2025-07-23 18:27:01.642072	Sink	18
51	2025-07-23 18:27:01.644852	2025-07-23 18:27:01.644852	Countertop	18
52	2025-07-23 18:27:01.647615	2025-07-23 18:27:01.647615	Flooring	18
53	2025-07-23 18:27:01.65412	2025-07-23 18:27:01.65412	Console table	19
54	2025-07-23 18:27:01.655991	2025-07-23 18:27:01.655991	Sideledge	19
55	2025-07-23 18:27:01.664308	2025-07-23 18:27:01.664308	Dining Table	20
56	2025-07-23 18:27:01.66635	2025-07-23 18:27:01.66635	Credenza	20
57	2025-07-23 18:27:01.671214	2025-07-23 18:27:01.671214	Divan	21
58	2025-07-23 18:27:01.683406	2025-07-23 18:27:01.683406	Bed Header	22
59	2025-07-23 18:27:01.68842	2025-07-23 18:27:01.68842	Credenza	22
60	2025-07-23 18:27:01.69827	2025-07-23 18:27:01.69827	 	23
61	2025-07-23 18:27:01.700707	2025-07-23 18:27:01.700707	Sink	24
62	2025-07-23 18:27:01.703412	2025-07-23 18:27:01.703412	Vanity Backsplash	24
63	2025-07-23 18:27:01.708057	2025-07-23 18:27:01.708057		24
64	2025-07-23 18:27:01.709332	2025-07-23 18:27:01.709332	Closet Door	24
65	2025-07-23 18:27:01.71358	2025-07-23 18:27:01.71358	Right-Hand Countertop  	24
66	2025-07-23 18:27:01.721385	2025-07-23 18:27:01.721385	Forward Bulkhead	25
67	2025-07-23 18:27:01.727191	2025-07-23 18:27:01.727191	Main Cabin Divider	25
68	2025-07-23 18:27:01.733449	2025-07-23 18:27:01.733449	AFT Bulkhead	25
69	2025-07-23 18:27:01.738901	2025-07-23 18:27:01.738901	Sink	26
70	2025-07-23 18:27:01.740908	2025-07-23 18:27:01.740908		26
71	2025-07-23 18:27:01.741857	2025-07-23 18:27:01.741857		26
72	2025-07-23 18:27:01.745157	2025-07-23 18:27:01.745157	Closet Door	26
73	2025-07-23 18:27:01.748135	2025-07-23 18:27:01.748135	Flooring	26
\.


--
-- Data for Name: permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.permissions (id, "createdAt", "updatedAt", action, subject, fields, conditions, inverted, reason, "roleId") FROM stdin;
1	2025-07-23 18:34:23.221671	2025-07-23 18:34:23.221671	manage	all	\N	\N	\N	\N	1
\.


--
-- Data for Name: planes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.planes (id, "createdAt", "updatedAt", name) FROM stdin;
1	2025-07-23 18:25:23.047298	2025-07-23 18:25:23.047298	8X
2	2025-07-23 18:25:52.169099	2025-07-23 18:25:52.169099	6X
3	2025-07-23 18:26:44.2153	2025-07-23 18:26:44.2153	2000LXS
4	2025-07-23 18:27:01.601069	2025-07-23 18:27:01.601069	10X
\.


--
-- Data for Name: preferences; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.preferences (id, "createdAt", "updatedAt", "salesEmails", "accountId") FROM stdin;
\.


--
-- Data for Name: preferences_bookmarks_options; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.preferences_bookmarks_options ("preferencesId", "optionsId") FROM stdin;
\.


--
-- Data for Name: preferences_planes_planes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.preferences_planes_planes ("preferencesId", "planesId") FROM stdin;
\.


--
-- Data for Name: profiles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.profiles (id, "createdAt", "updatedAt", firstname, lastname, bio, gender, "phoneNumber", address, "photoUrl", "dateOfBirth") FROM stdin;
1	2025-07-23 18:29:29.940318	2025-07-23 18:29:29.940318	Coralie	BORDENAVE	\N	\N	\N	\N	\N	\N
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.roles (id, "createdAt", "updatedAt", name, description) FROM stdin;
1	2025-07-23 18:34:23.221671	2025-07-23 18:34:23.221671	admin	\N
\.


--
-- Name: accounts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.accounts_id_seq', 1, true);


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

SELECT pg_catalog.setval('public.permissions_id_seq', 1, true);


--
-- Name: planes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.planes_id_seq', 4, true);


--
-- Name: preferences_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.preferences_id_seq', 1, false);


--
-- Name: profiles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.profiles_id_seq', 1, true);


--
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.roles_id_seq', 1, true);


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

--
-- PostgreSQL database dump
--

-- Dumped from database version 15.13 (Debian 15.13-1.pgdg120+1)
-- Dumped by pg_dump version 17.5 (Ubuntu 17.5-1.pgdg22.04+1)

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
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 15.13 (Debian 15.13-1.pgdg120+1)
-- Dumped by pg_dump version 17.5 (Ubuntu 17.5-1.pgdg22.04+1)

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
    "planeId" integer
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
    "partId" integer
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
    "areaId" integer
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
    name character varying NOT NULL
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
3	2025-07-24 12:25:37.601769	2025-07-24 12:25:37.601769	\N	DAPPLE01	$2b$10$WxCn6x3nMVkqlDdVsQosgu6tl1TkgamcuVViqHb5YxmLCckA6VJau	0	VERIFIED	\N	\N	\N	1	3	\N
4	2025-07-24 12:25:37.676	2025-07-24 12:25:37.676	\N	SARDOU01	$2b$10$YYLkZeWJFwnT4vSHRipEpu/LDCZsKKtqMd3Z5KYfoOLkwZ/0chc0K	0	VERIFIED	\N	\N	\N	1	4	\N
5	2025-07-24 12:25:37.73508	2025-07-24 12:25:37.73508	\N	FGAYE01	$2b$10$rEu9Jx/RZs0E/U/VSJ8CKeGtgW/fjw2USnL4.eBoX6rK8i.IvJYui	0	VERIFIED	\N	\N	\N	1	5	\N
6	2025-07-24 12:25:37.808784	2025-07-24 12:25:37.808784	\N	RBACHE01	$2b$10$CfaMz9pz5v2Vk4noWxI5bOerFWUt2QnrmEpj1Sz4.WVBX12PS.UBy	0	VERIFIED	\N	\N	\N	1	6	\N
7	2025-07-24 12:25:37.872688	2025-07-24 12:25:37.872688	\N	ANOUVE01	$2b$10$HRbDIjUu/smCBhiBHYkkUOaj/shoO.bjb2kcfiZQFIsINLaZxGBTy	0	VERIFIED	\N	\N	\N	1	7	\N
8	2025-07-24 12:25:37.950202	2025-07-24 12:25:37.950202	\N	EDUFOU02	$2b$10$upVlvKTd4cOIO0h.QPamoeJXx.FE5FQ0CKQVVLCVqKk45cR4Q3mlG	0	VERIFIED	\N	\N	\N	1	8	\N
9	2025-07-24 12:25:38.019576	2025-07-24 12:25:38.019576	\N	CBRANA01	$2b$10$CGLZHHM8goq9akY8HUqqS.FhWvWA8ZUBEN4TAaF3wJsoZSvYYgvei	0	VERIFIED	\N	\N	\N	1	9	\N
10	2025-07-24 12:25:38.079166	2025-07-24 12:25:38.079166	\N	CBROZI01	$2b$10$hXmP8/IoOiz2iQXs4yaK5e5vf47YiWRxB1eA71gjpitdrJMT3eYxW	0	VERIFIED	\N	\N	\N	1	10	\N
11	2025-07-24 12:25:38.14609	2025-07-24 12:25:38.14609	\N	JFEDIN01	$2b$10$J8YaHsjbXfk919MzPr2Jg.qWl/2PCkYwpw1onZhFZB9lzlXF5Tp5W	0	VERIFIED	\N	\N	\N	1	11	\N
12	2025-07-24 12:25:38.218694	2025-07-24 12:25:38.218694	\N	DDIKEN01	$2b$10$nBwQ5hDHx9brtYmrNIU2ouji.Voc5mpUy1T1Cl0a1hzxYe0GqWlHG	0	VERIFIED	\N	\N	\N	1	12	\N
13	2025-07-24 12:25:38.286307	2025-07-24 12:25:38.286307	\N	MCANO01	$2b$10$B98QjjrBUaP.5BIkld.4B.eIm2w5bHlqfy/xlwGkC/pBY0GpLCIIG	0	VERIFIED	\N	\N	\N	1	13	\N
14	2025-07-24 12:25:38.349032	2025-07-24 12:25:38.349032	\N	KPALEN01	$2b$10$Wl6Zp2.cxQDLkFwLGN/s1.DUyk2MPMGBNTh4GYQbDtPZrq/sXw.Xu	0	VERIFIED	\N	\N	\N	1	14	\N
15	2025-07-24 12:25:38.411415	2025-07-24 12:25:38.411415	\N	JHARPE02	$2b$10$JyNATM5XOV7268AK5VGdZON.77VXd5z/VBFiO1gPICbMPXsf8ivs.	0	VERIFIED	\N	\N	\N	1	15	\N
16	2025-07-24 12:25:38.473051	2025-07-24 12:25:38.473051	\N	LWEBER01	$2b$10$h5a0/DcVwzgAOhwDzFXLYuL9D4gcUAWBt4wmAywkoD.vSz8wo3D86	0	VERIFIED	\N	\N	\N	1	16	\N
17	2025-07-24 12:25:38.538312	2025-07-24 12:25:38.538312	\N	BBECKE04	$2b$10$PRTEMIgyeheZtUOvHl.M0uzRyPBOp4N9Rj0.6eRQsBBO0z5iR5LwO	0	VERIFIED	\N	\N	\N	1	17	\N
18	2025-07-24 12:25:38.597497	2025-07-24 12:25:38.597497	\N	NAUBER01	$2b$10$Gx8UK7g0DzIlum1Wq8hZz.4AHn1j/nCYYqXdy/WZM3cTCyXaoKfXS	0	VERIFIED	\N	\N	\N	1	18	\N
19	2025-07-24 12:25:38.655358	2025-07-24 12:25:38.655358	\N	JFRAIS01	$2b$10$5TJIBPn0XYkFjK94PyvNdeLakaSqS2CfduR7xKqsgObif3wQarlIe	0	VERIFIED	\N	\N	\N	1	19	\N
20	2025-07-24 12:25:38.714022	2025-07-24 12:25:38.714022	\N	GAPOLL01	$2b$10$Iw5mBsPJIN1NZlU1NseTHOrroBYuhjlkK7k8DFgMxFtGgAHK17T3y	0	VERIFIED	\N	\N	\N	1	20	\N
21	2025-07-24 12:25:38.783723	2025-07-24 12:25:38.783723	\N	BASHE01	$2b$10$qMjNIftyTQUj2bsaEJepcuyrJxJZbEIZZ3naLO86EyqRQMYzsinT6	0	VERIFIED	\N	\N	\N	1	21	\N
22	2025-07-24 12:25:38.857672	2025-07-24 12:25:38.857672	\N	DBAILE03	$2b$10$4IJ8ibZSrXl5qnn05V3TquKiBIyLXV142zUB.H.P6QVGf5E.lWlS.	0	VERIFIED	\N	\N	\N	1	22	\N
23	2025-07-24 12:25:38.931255	2025-07-24 12:25:38.931255	\N	TCARLI01	$2b$10$aG4C3WIs.obWYCf0WpY0hexbYK25KWqi2jRCHMlD6B7ivCRpMuoZm	0	VERIFIED	\N	\N	\N	1	23	\N
24	2025-07-24 12:25:39.001741	2025-07-24 12:25:39.001741	\N	NCHEN01	$2b$10$yJwzA0ydniVJ8oMIxdUqOeBto1awmq476UaUqNgV6yoNwVwl3xx92	0	VERIFIED	\N	\N	\N	1	24	\N
25	2025-07-24 12:25:39.065252	2025-07-24 12:25:39.065252	\N	RCLOAT01	$2b$10$rHEbRZ7P8tMiztWqJtWgzuYBrWtHNyLds1ObXCN.93Woq3EgVRrEO	0	VERIFIED	\N	\N	\N	1	25	\N
26	2025-07-24 12:25:39.12571	2025-07-24 12:25:39.12571	\N	LFEREL01	$2b$10$2Z7j1aa8d503pNUTgIp80umr6jp8qL12EvZhrDGrXkafVCP6OlTvi	0	VERIFIED	\N	\N	\N	1	26	\N
27	2025-07-24 12:25:39.18129	2025-07-24 12:25:39.18129	\N	GTOLED01	$2b$10$tn4ugVhNpHJsJWnLpPnrBeKO/12ee58k1pliemyIoYCfSfDMC1Ch.	0	VERIFIED	\N	\N	\N	1	27	\N
28	2025-07-24 12:25:39.241408	2025-07-24 12:25:39.241408	\N	PDELES01	$2b$10$7pHYaTg9Mqo68xcwRUszP.sOcvhF7WUbgn/vzDa2PpjYQ/mxN8yYC	0	VERIFIED	\N	\N	\N	1	28	\N
29	2025-07-24 12:25:39.297165	2025-07-24 12:25:39.297165	\N	JDESMA01	$2b$10$d1fWjXgXaRcpJg7sg0D5wuhpxwlu2frO2AnCF3MNi79r.S111OQoW	0	VERIFIED	\N	\N	\N	1	29	\N
30	2025-07-24 12:25:39.354521	2025-07-24 12:25:39.354521	\N	YDESVI01	$2b$10$69.fjMz3HmdyNxvfk0.7G.gXMepSpVI/GUnVpPr0k19twDemd4cOW	0	VERIFIED	\N	\N	\N	1	30	\N
31	2025-07-24 12:25:39.42027	2025-07-24 12:25:39.42027	\N	JDETUR01	$2b$10$JjZBKvVkHUxn/8UoukhRn.pQI3sKUPfAdr4toAJ6UCKu6JkPQkvQu	0	VERIFIED	\N	\N	\N	1	31	\N
32	2025-07-24 12:25:39.487953	2025-07-24 12:25:39.487953	\N	ALISSO01	$2b$10$uVYXOCD1r4pQRMT7q20jIOWT0nrkJo9ntNIO0sZ9IBFLX0pLTgt6q	0	VERIFIED	\N	\N	\N	1	32	\N
33	2025-07-24 12:25:39.557199	2025-07-24 12:25:39.557199	\N	JDEVRI01	$2b$10$W.DBmjLkwoGwCip8QkDxo.i0EzacddyWKx6x3zH1o1nI/dWXBRpHi	0	VERIFIED	\N	\N	\N	1	33	\N
34	2025-07-24 12:25:39.629081	2025-07-24 12:25:39.629081	\N	EETIEN01	$2b$10$x2NV1MmXEwZ9yTCG8OBQ8OzxPdFrmkZ9wwxJwy9YKwEPruzexjWHC	0	VERIFIED	\N	\N	\N	1	34	\N
35	2025-07-24 12:25:39.693085	2025-07-24 12:25:39.693085	\N	IFAIN01	$2b$10$TQ.J8raRZsE8vwjmj7LUVeKo/gxkL1e9P8Ns1gNmBeJaSI3VOHxGa	0	VERIFIED	\N	\N	\N	1	35	\N
36	2025-07-24 12:25:39.751444	2025-07-24 12:25:39.751444	\N	PFLORE01	$2b$10$H3k1qFO2n93EefNoCIfr8ORVF7mIZKVdQ3Kr54l8tw6XAYCDYEOaW	0	VERIFIED	\N	\N	\N	1	36	\N
37	2025-07-24 12:25:39.81638	2025-07-24 12:25:39.81638	\N	RFRIED01	$2b$10$wQP0tU7fD13Wk3CNmu/pve5iCuXrAM10ZZloU1KbREEfhifFyg2P.	0	VERIFIED	\N	\N	\N	1	37	\N
38	2025-07-24 12:25:39.879752	2025-07-24 12:25:39.879752	\N	JGAUTH01	$2b$10$NcDMYyisH0R/dzseW6NSMOidEQLoiwrJ2WfhV8J60rX6sI/28XQei	0	VERIFIED	\N	\N	\N	1	38	\N
39	2025-07-24 12:25:39.943319	2025-07-24 12:25:39.943319	\N	GGAUTI01	$2b$10$9x22lZpI4rg9zlawmymf7OAs9fktQpp1mpPlydrLmviQoVWrDZ6Ey	0	VERIFIED	\N	\N	\N	1	39	\N
40	2025-07-24 12:25:40.009986	2025-07-24 12:25:40.009986	\N	RLEMIR01	$2b$10$wpJYagNLt1DxhZUz4JeG.ewv0p9kR9z8eNURNmZR5Zm6tAIAIdxpy	0	VERIFIED	\N	\N	\N	1	40	\N
41	2025-07-24 12:25:40.070576	2025-07-24 12:25:40.070576	\N	MGREEN01	$2b$10$eMTtEa8io36sD/V9Q6av2OPfVVbV6ATV7rOMffLXtJ.POKEszqkxS	0	VERIFIED	\N	\N	\N	1	41	\N
42	2025-07-24 12:25:40.137816	2025-07-24 12:25:40.137816	\N	AGOULA01	$2b$10$f5P6r4RbSNGxDrJXV6rRaujnw..O2ktNdx.WO5Ij7wPrGBGqS2RbC	0	VERIFIED	\N	\N	\N	1	42	\N
43	2025-07-24 12:25:40.20722	2025-07-24 12:25:40.20722	\N	THETIE01	$2b$10$OnN2SGD1nDh5W0/hM6WCtOHQkqfomYgbabxTxPeUtev/C69QetU4q	0	VERIFIED	\N	\N	\N	1	43	\N
44	2025-07-24 12:25:40.282115	2025-07-24 12:25:40.282115	\N	JJACOB01	$2b$10$SNlEZ/js/LJAxyRgHFSPCerhJYfGTsZP2RALSUCCX9uy1HyGV1a7y	0	VERIFIED	\N	\N	\N	1	44	\N
45	2025-07-24 12:25:40.349395	2025-07-24 12:25:40.349395	\N	FLEBAS01	$2b$10$QCImW3E1dXQdwj7qG8decejvQayEzNHJ9xLHFt3wj3LippLxUbtkO	0	VERIFIED	\N	\N	\N	1	45	\N
46	2025-07-24 12:25:40.424373	2025-07-24 12:25:40.424373	\N	DLECUL02	$2b$10$/ak7vzEqG1vjB8qp7JHAi.OzK9XgOUrSnixhuP/GuOSdK9/RUX1iW	0	VERIFIED	\N	\N	\N	1	46	\N
47	2025-07-24 12:25:40.49759	2025-07-24 12:25:40.49759	\N	NMARTI01	$2b$10$qIqRLpmAkhMvH0bV7Xo4iebvslxve/pNT4P2WeCiNEW/iV/PM7J1q	0	VERIFIED	\N	\N	\N	1	47	\N
48	2025-07-24 12:25:40.562594	2025-07-24 12:25:40.562594	\N	NMONCA01	$2b$10$SbGGnPcJR70oouV0ImqjLuUczkt.6FZILor2md3nT39oHTSMucjgi	0	VERIFIED	\N	\N	\N	1	48	\N
49	2025-07-24 12:25:40.629322	2025-07-24 12:25:40.629322	\N	RPESOA01	$2b$10$IPgP4UNFEwcEvtknL4rkZe0e2ofA.Pzo6fw9GHIt/smYzF9UpGjhC	0	VERIFIED	\N	\N	\N	1	49	\N
50	2025-07-24 12:25:40.702812	2025-07-24 12:25:40.702812	\N	XPONS01	$2b$10$Innpox4x3/Y7L6l6QCpQA.e6xFO45napVJqYzQbxHhAAAHfvOmx6e	0	VERIFIED	\N	\N	\N	1	50	\N
51	2025-07-24 12:25:40.77777	2025-07-24 12:25:40.77777	\N	DRAYNA01	$2b$10$w0x1k22Pdl3ILrakdwtWBuQGkf1/p8qEm.2uUWWOZuhYweK5./F7a	0	VERIFIED	\N	\N	\N	1	51	\N
52	2025-07-24 12:25:40.85302	2025-07-24 12:25:40.85302	\N	RREAVI01	$2b$10$F8M.juAmong4f5HQICN82.S7fl6m4ELLSYTIBP5CCnkDf8V6CjgMq	0	VERIFIED	\N	\N	\N	1	52	\N
53	2025-07-24 12:25:40.928462	2025-07-24 12:25:40.928462	\N	TROHAU01	$2b$10$4HBX3432KUdF5Pk/CxZggeniiTcBYDeSLYRUasYEfcpynq/6JyjS.	0	VERIFIED	\N	\N	\N	1	53	\N
54	2025-07-24 12:25:41.005248	2025-07-24 12:25:41.005248	\N	ESENAR01	$2b$10$LQTqusz6Vx7i5Yy0TlMDEOsnlrkFDeFL5SwDGjrU0OKd3t2w3HCt6	0	VERIFIED	\N	\N	\N	1	54	\N
55	2025-07-24 12:25:41.076617	2025-07-24 12:25:41.076617	\N	FVENTU01	$2b$10$aiKC7a2xjUNkjgeFwjEWR.jaH/RVRUiKws/vUyMjbcRjpC14.lXi2	0	VERIFIED	\N	\N	\N	1	55	\N
56	2025-07-24 12:25:41.152117	2025-07-24 12:25:41.152117	\N	IVITTE01	$2b$10$n1LfscVV6y6hbGin5oePyOmK7pi3.3tC400y12QqoHlskyXUWWvd.	0	VERIFIED	\N	\N	\N	1	56	\N
57	2025-07-24 12:25:41.227528	2025-07-24 12:25:41.227528	\N	CWININ01	$2b$10$Xy/xWGmEYLbkWfMJwYTLyOsNVUTfZfGUqsw5PoKL8haC3U9EHv0mS	0	VERIFIED	\N	\N	\N	1	57	\N
58	2025-07-24 12:25:41.28471	2025-07-24 12:25:41.28471	\N	JTAYLO06	$2b$10$rvq1E0QBVTkZwHtzXoJWLumCw0o5DE7DcNeh33Vlxi5VhX6QLlibS	0	VERIFIED	\N	\N	\N	1	58	\N
59	2025-07-24 12:25:41.338536	2025-07-24 12:25:41.338536	\N	VHUBER01	$2b$10$2I/g45R4ghmVr/vz5ouNruehzTjy6nnM882s6j9zdVJkEJZprun52	0	VERIFIED	\N	\N	\N	1	59	\N
60	2025-07-24 12:25:41.393345	2025-07-24 12:25:41.393345	\N	ACOCAT01	$2b$10$NZXSWcrFnd.HicU9ScAikeLbxiI2TYcqp49QxbYBZMp5JHw6UEw9e	0	VERIFIED	\N	\N	\N	1	60	\N
61	2025-07-24 12:25:41.457356	2025-07-24 12:25:41.457356	\N	FHOUSS01	$2b$10$Hbk45TYFASlDSAfz5ADEsO0Jnm0uLhMOlChS87A3LUg2r2dBwc1eq	0	VERIFIED	\N	\N	\N	1	61	\N
65	2025-07-24 12:25:41.6619	2025-07-24 12:25:41.6619	\N	VLIMIT01	$2b$10$bWMzPfye8iUd4CwePUqZg.LUEYNnqq.PnSwPRaxDw/iLW3rDy7R3i	0	VERIFIED	\N	\N	\N	1	65	\N
62	2025-07-24 12:25:41.515334	2025-07-24 12:25:41.515334	\N	MDUPIN01	$2b$10$2UNnOa/MimwbTEQfxaW2Beuo9xuhdAvqpNDurAoq.xa4kuEiKJ7XW	0	VERIFIED	\N	\N	\N	1	62	\N
63	2025-07-24 12:25:41.562245	2025-07-24 12:25:41.562245	\N	AJIMEN02	$2b$10$1daGcfDZnpG6pCTPg4s4ae9p2iw9LQpJP4fv2cKw2k8EVMLJTUbSm	0	VERIFIED	\N	\N	\N	1	63	\N
64	2025-07-24 12:25:41.610338	2025-07-24 12:25:41.610338	\N	SETCHE01	$2b$10$vcqNGEYGLF4uRdQNtxCKZuAIDG65WmCssfdctwbkF/6W/hzUcx2Rm	0	VERIFIED	\N	\N	\N	1	64	\N
66	2025-07-24 12:45:30.194666	2025-07-24 12:45:30.194666	coralie.bordenave@dassault-aviation.com	CBORD	$2b$10$4XPNnMMrLPFxd4k8tdKg4urfjw2OfWiy.zuaygqfEPJ1DseUZ9lOW	0	VERIFIED	\N	\N	\N	1	66	\N
\.


--
-- Data for Name: areas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.areas (id, "createdAt", "updatedAt", title, image, "planeId") FROM stdin;
1	2025-07-24 09:34:45.796001	2025-07-24 09:34:45.796001	Entryway	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_08_CHAPITRE_2024-12-05.jpg	1
2	2025-07-24 09:34:45.829801	2025-07-24 09:34:45.829801	Cabin	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_04_CHAPITRE_2024-12-05.jpg	1
3	2025-07-24 09:34:45.848395	2025-07-24 09:34:45.848395	Aft Lavatory	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_02_CHAPITRE_2024-12-05.jpg	1
4	2025-07-24 09:35:09.516505	2025-07-24 09:35:09.516505	Forward Closet Finishing	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/HQ_CamChap_01_EntryWay_L4960H3507.jpg	2
5	2025-07-24 09:35:09.529634	2025-07-24 09:35:09.529634	Crew Rest Finishing	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/LQ_CamChap_01_CrewRest_L4960H3507.jpg	2
6	2025-07-24 09:35:09.539958	2025-07-24 09:35:09.539958	Forward Lavatory Finishing	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/HQ_CamChap_01_EntryWayFWDLav_L4960H3507.jpg	2
7	2025-07-24 09:35:09.550896	2025-07-24 09:35:09.550896	Galley Finishing	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/HQ_CamChap_01_EntryWay_L4960H3507.jpg	2
8	2025-07-24 09:35:09.566418	2025-07-24 09:35:09.566418	Club Lounge	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/HQ_CamChap_03_Lounge01ClubView_L4960H3507-01.jpg	2
9	2025-07-24 09:35:09.575052	2025-07-24 09:35:09.575052	Dining	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/HQ_CamChap_04_Lounge02Dining_L4960H3507.jpg	2
10	2025-07-24 09:35:09.58458	2025-07-24 09:35:09.58458	Meridian & Divan	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/HQ_CamChap_05_Lounge03Divan_L4960H3507co.jpg	2
11	2025-07-24 09:35:09.599422	2025-07-24 09:35:09.599422	Bedroom	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/HQ_CamCHAP_08_BedView_L4960H3507co.jpg	2
12	2025-07-24 09:35:09.611081	2025-07-24 09:35:09.611081	Falcon Privacy Suite Finishing	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/LQ_CamChap_06_Lounge04FPS02_L4960H3507co.jpg	2
13	2025-07-24 09:35:09.612966	2025-07-24 09:35:09.612966	Shower	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/LQ_CamCHAP_09_AftLavat_L4960H3507co.jpg	2
14	2025-07-24 09:35:09.630959	2025-07-24 09:35:09.630959	Bulkheads	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/LQ_CamCHAP_05b_ViewLH-Lounge1_LH-Club_L4960H3507.jpg	2
15	2025-07-24 09:35:09.647992	2025-07-24 09:35:09.647992	Classic Bathroom	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/HQ_CamChap_07_AftVanity01_L4960H3507.jpg	2
16	2025-07-24 09:35:09.665389	2025-07-24 09:35:09.665389	ENTRYWAY	https://api.dassaultfalcon.com/lacollection-smtp/photos/areas/HQ_CamChap_01_EntryWay_L4960H3507.jpg	2
17	2025-07-24 09:35:09.666386	2025-07-24 09:35:09.666386	MAIN CABIN	https://api.dassaultfalcon.com/lacollection-smtp/photos/areas/LQ_CamChap_02_CabinView_L4960H3507.jpg	2
18	2025-07-24 09:35:09.667375	2025-07-24 09:35:09.667375	AFT LAVATORY 	https://api.dassaultfalcon.com/lacollection-smtp/photos/areas/LQ_CamCHAP_09_AftLavat_L4960H3507.jpg	2
19	2025-07-24 09:35:09.668265	2025-07-24 09:35:09.668265	MAIN CABIN BULKHEAD 	https://api.dassaultfalcon.com/lacollection-smtp/photos/areas/LQ_CamCHAP_05b_ViewLH-Lounge1_LH-Club_L4960H3507.jpg	2
20	2025-07-24 09:35:25.806383	2025-07-24 09:35:25.806383	Galley bar 	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/HQ_Chapter1_EntryWay_L4960H35078bd.jpg	3
21	2025-07-24 09:35:25.827505	2025-07-24 09:35:25.827505	Forward lavatory	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/HQ_Chapter1_FwdLav_L4960H3507bd.jpg	3
22	2025-07-24 09:35:25.835114	2025-07-24 09:35:25.835114	Forward lounge	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/HQ_Chapter2_MainCabin_L4960H3507BD.jpg	3
23	2025-07-24 09:35:25.846268	2025-07-24 09:35:25.846268	Middle lounge	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/HQ_Chapter2-B_MiddleLounge_L4960H3507BD.jpg	3
24	2025-07-24 09:35:25.858793	2025-07-24 09:35:25.858793	Aft lounge	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/HQ_Chapter2-C_AftLounge_L4960H3507BD.jpg	3
25	2025-07-24 09:35:25.866939	2025-07-24 09:35:25.866939	Aft lavatory	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/HQ_Chapter3_AftLavatory_L3507H4960BD.jpg	3
26	2025-07-24 09:35:37.365093	2025-07-24 09:35:37.365093	entryway	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/F6X_SNxxx_DN_Sch01_HQ_View_EntryWay2_2023-01-05.jpg	4
27	2025-07-24 09:35:37.388219	2025-07-24 09:35:37.388219	forward lounge	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/HQ_View_CabinClub_L4960H3507_Night.jpg	4
28	2025-07-24 09:35:37.39962	2025-07-24 09:35:37.39962	middle lounge	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/HQ_View_CabinFWD_L4960H3507.jpg	4
29	2025-07-24 09:35:37.419301	2025-07-24 09:35:37.419301	aft lounge	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/F6X_SNxxx_DN_Sch01_HQ_View_DivanAFTView_2023-01-05_Coralie.jpg	4
30	2025-07-24 09:35:37.425154	2025-07-24 09:35:37.425154	aft lavatory	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/F6X_SNxxx_DN_Sch01_HQ_View_AftLavatory_2023-01-05_CORALIE.jpg	4
\.


--
-- Data for Name: options; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.options (id, "createdAt", "updatedAt", name, image, serial, weight, price, palette, type, "partId") FROM stdin;
1	2025-07-24 09:34:45.801322	2025-07-24 09:34:45.801322	Stainless Steel	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_13_TECH_2024-12-05.jpg	6.210.1	In Package	In Package		Essentials	1
2	2025-07-24 09:34:45.803845	2025-07-24 09:34:45.803845	Glaskote	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/F2L_SNxxx_DN_Scheme01_HQ_13_TECH_2024-12-05.jpg	6.210.12	0	7800	assets/images/palettes/Glaskote.png	Essentials	1
3	2025-07-24 09:34:45.807732	2025-07-24 09:34:45.807732	Solid Surface	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/F2L_SNxxx_DN_Scheme01_LQ_09_TECH_2024-12-05A.jpg	6.210.2a	0	In Package	assets/images/palettes/SolidSurface.png	Essentials	2
4	2025-07-24 09:34:45.809533	2025-07-24 09:34:45.809533	Stone	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/F2L_SNxxx_DN_Scheme01_LQ_09_TECH_2024-12-05.jpg	6.210.2	Standard	39200	assets/images/palettes/Stone.png	AvantGarde	2
5	2025-07-24 09:34:45.817593	2025-07-24 09:34:45.817593	Metal plated	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_12_TECH_2024-12-05.jpg	6.210.9a	0	In Package	assets/images/palettes/Stone.png	Essentials	3
6	2025-07-24 09:34:45.820013	2025-07-24 09:34:45.820013	Wood veneer	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_12_TECH_2024-12-05.jpg	6.210.9	Standard	No charge	assets/images/palettes/Wood.png	Essentials	3
7	2025-07-24 09:34:45.822857	2025-07-24 09:34:45.822857	Stainless steel	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_25_TECH_2024-12-05.jpg	6.500.10	In Package	In Package		Essentials	4
8	2025-07-24 09:34:45.824147	2025-07-24 09:34:45.824147	Glasskote	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_25_CHAPITRE_2024-12-05.jpg	6.500.1b	0.1	8700	assets/images/palettes/Glaskote.png	Essentials	4
9	2025-07-24 09:34:45.826992	2025-07-24 09:34:45.826992	Carpet	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_10_TECH_2024-12-05.jpg	6.500.0b	In Package	In Package	Carpet.png	Essentials	5
10	2025-07-24 09:34:45.828386	2025-07-24 09:34:45.828386	Vinyl	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_10_TECH_2024-12-05.jpg	6.500.2	10.6	10500	assets/images/palettes/Vinyl.png	Essentials	5
11	2025-07-24 09:34:45.832869	2025-07-24 09:34:45.832869	Wood veneer	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_05_CHAPITRE_2024-12-05.jpg	6.200.20	In Package	In Package	assets/images/palettes/Wood.png	Essentials	6
12	2025-07-24 09:34:45.835242	2025-07-24 09:34:45.835242	Wood vener	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_06_CHAPITRE_2024-12-05.jpg	6.200.30	In Package	In Package	assets/images/palettes/Wood.png	Essentials	7
13	2025-07-24 09:34:45.838108	2025-07-24 09:34:45.838108	Two (2), 1/8-Inch Metal Trim Strips and Vertical Join Seam below Tables	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_16_TECH_2024-12-05.jpg	6.300.5	In Package	In Package		Essentials	8
14	2025-07-24 09:34:45.839511	2025-07-24 09:34:45.839511	One (1), 1/8-Inch Metal Trim Strip and Vertical Join Seam below Tables	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_16_TECH_2024-12-05.jpg	6.300.5d	0.5	No charge		Essentials	8
15	2025-07-24 09:34:45.840847	2025-07-24 09:34:45.840847	Upholstery	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_19_TECH_2024-12-05.jpg	6.300.41	In Package	In Package		Essentials	8
16	2025-07-24 09:34:45.843697	2025-07-24 09:34:45.843697	Wood veneer	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_11_TECH_2024-12-05.jpg	6.300.7	In Package	In Package	assets/images/palettes/Wood.png	Essentials	9
17	2025-07-24 09:34:45.845255	2025-07-24 09:34:45.845255	One (1), 1/8-Inch Metal Trim Strip and Vertical Join Seam below Tables	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_14B_TECH_2024-12-05.jpg	6.400.1	0	In Package		Essentials	9
18	2025-07-24 09:34:45.846178	2025-07-24 09:34:45.846178	Wood Veneer with Door in Mirror	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_14_TECH_2024-12-05.jpg	6.400.1b	0	No charge		Essentials	9
19	2025-07-24 09:34:45.847265	2025-07-24 09:34:45.847265	Wood Veneer with Leather/Ultraleather insert	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_14_TECH_2024-12-05.jpg	6.400.1g	0.1	10100		AvantGarde	9
20	2025-07-24 09:34:45.852064	2025-07-24 09:34:45.852064	Glaskote	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_24_TECH_2024-12-05.jpg	6.210.12b	In Package	In Package	assets/images/palettes/Glaskote.png	Essentials	10
21	2025-07-24 09:34:45.854337	2025-07-24 09:34:45.854337	Solid Surface	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_21_TECH_2024-12-05.jpg	6.210.3a	In Package	In Package	assets/images/palettes/SolidSurface.png	Essentials	11
22	2025-07-24 09:34:45.855069	2025-07-24 09:34:45.855069	Stone	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_22_TECH_2024-12-05.jpg	6.210.3	1.6	21400	assets/images/palettes/Stone.png	AvantGarde	11
23	2025-07-24 09:34:45.856457	2025-07-24 09:34:45.856457	Carpet	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_23_TECH_2024-12-05.jpg	6.500.0a	In Package	In Package	assets/images/palettes/Carpet.png	Essentials	12
24	2025-07-24 09:34:45.857167	2025-07-24 09:34:45.857167	Vinyl	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_23_TECH_2024-12-05.jpg	6.500.2a	7.9	8000	assets/images/palettes/Vinyl.png	Essentials	12
25	2025-07-24 09:34:45.859294	2025-07-24 09:34:45.859294	Soft good	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_21_TECH_2024-12-05.jpg	6.400.2	In Package	In Package	assets/images/palettes/Wood.png	Essentials	13
26	2025-07-24 09:34:45.860606	2025-07-24 09:34:45.860606	Soft good	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_20_TECH_2024-12-05_V2.jpg	6.410.2	In Package	In Package	assets/images/palettes/Ultraleather.png	Essentials	13
27	2025-07-24 09:35:09.521262	2025-07-24 09:35:09.521262	Forward Entryway Closet Finishing: Wood Veneer /Paint with Wood Veneer/ Paint Door	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_01_EntryWCloset_L3507H4960_0036.jpg	6.240.10	In Package	In Package		Essentials	14
28	2025-07-24 09:35:09.523367	2025-07-24 09:35:09.523367	Forward Entryway Closet Finishing: Aft Side, Wood Veneer/ Paint	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_01_EntryWEntry_L3507H4960_0038.jpg	6.240.20	In Package	In Package		Essentials	14
29	2025-07-24 09:35:09.52523	2025-07-24 09:35:09.52523	Forward Entryway Closet Finishing: Wood Veneer /Paint with Mirror Door	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_01_EntryWCloset_L3507H4960_0035.jpg	6.240.11	1.4	Upgrade ($)		AvantGarde	14
30	2025-07-24 09:35:09.526752	2025-07-24 09:35:09.526752	Forward Entryway Closet Finishing: Aft Side, Wall Covering		6.240.21	-2.2	Upgrade ($)	assets/images/palettes/DecoFilm.png	AvantGarde	14
31	2025-07-24 09:35:09.532351	2025-07-24 09:35:09.532351	Crew Rest Forward Bulkhead Finishing: Forward Side, Wood Veneer / Paint	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_01_EntryWEntry_L3507H4960_0038.jpg	6.230.10	In Package	In Package		Essentials	16
32	2025-07-24 09:35:09.533796	2025-07-24 09:35:09.533796	Crew Rest Sliding Panel Finishing: Aft Face, Quilting	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_02_CrewRPanel_L3507H4960_0041.jpg	6.230.20	In Package	In Package		Essentials	16
33	2025-07-24 09:35:09.5354	2025-07-24 09:35:09.5354	Crew Rest Forward Bulkhead Finishing: Forward Side, Wall Covering	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_01_EntryWEntry_L3507H4960_0037.jpg	6.230.11	-2,2	Upgrade ($)	assets/images/palettes/DecoFilm.png	AvantGarde	16
34	2025-07-24 09:35:09.536683	2025-07-24 09:35:09.536683	Crew Rest Sliding Panel Finishing: Aft Face, Upholstery/Leather with Recess	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_02_CrewRPanel_L3507H4960_0040.jpg	6.230.21	-0,9	Upgrade ($)	assets/images/palettes/Ultraleather.png	AvantGarde	16
35	2025-07-24 09:35:09.538096	2025-07-24 09:35:09.538096	Crew Rest Sliding Panel Finishing: Aft Face, Upholstery/Leather	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_02_CrewRPanel_L3507H4960_0040BIS.jpg	6.230.22	Upgrade (Lbs)	Upgrade ($)	assets/images/palettes/Ultraleather.png	AvantGarde	16
66	2025-07-24 09:35:09.607879	2025-07-24 09:35:09.607879	Top: Wood Veneer/ Paint	https://api.dassaultfalcon.com/lacollection-smtp/photos/parts/LQ_CamTECH_01_BedCredenza_L3507H4960_0045.jpg	6.300.31A	In Package	In Package	assets/images/palettes/Wood.png	Essentials	30
36	2025-07-24 09:35:09.542475	2025-07-24 09:35:09.542475	Forward Lavatory Aft Bulkhead Finishing:  Forward Face, Wood Veneer/ Paint	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamChap_01_EntryWay_L4960H3507BIS.jpg	6.220.10	In Package	In Package	assets/images/palettes/Wood.png	Essentials	17
37	2025-07-24 09:35:09.545416	2025-07-24 09:35:09.545416	Sink : Glaskote	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_01_FWDLavat_L3507H4960_0031.jpg	6.210.12A	In Package	In Package	assets/images/palettes/Glaskote.png	Essentials	18
38	2025-07-24 09:35:09.548321	2025-07-24 09:35:09.548321	Forward Lavatory Backsplash Finishing: Solid Surface	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_01_FWDLavat_L3507H4960_0031.jpg	6.210.5	In Package	In Package	assets/images/palettes/SolidSurface.png	Essentials	19
39	2025-07-24 09:35:09.549631	2025-07-24 09:35:09.549631	Forward Lavatory Backsplash Finishing: Granite/Marble/Quartz	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_01_FWDLavat_L3507H4960_0030.jpg	6.210.5a	2.2	Upgrade ($)	assets/images/palettes/Stone.png	AvantGarde	19
40	2025-07-24 09:35:09.555048	2025-07-24 09:35:09.555048	Sink : Glaskote	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_01_GalleyCountSink_L3507H4960.jpg	6.210.12	In Package	In Package	assets/images/palettes/Glaskote.png	Essentials	21
41	2025-07-24 09:35:09.557588	2025-07-24 09:35:09.557588	Solid Surface	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_01_GalleyCountTop_L3507H4960_0030.jpg	6.210.2A	In Package	In Package	assets/images/palettes/SolidSurface.png	Essentials	22
42	2025-07-24 09:35:09.558695	2025-07-24 09:35:09.558695	Granite/Marble/Quartz	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_01_GalleyCountTop_L3507H4960_0031.jpg	6.210.2	4,0	Upgrade ($)	assets/images/palettes/Stone.png	AvantGarde	22
43	2025-07-24 09:35:09.560849	2025-07-24 09:35:09.560849	Carpet	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_01_EntryWFloor_L3507H4960_0034.jpg	6.500.0B	In Package	In Package	assets/images/palettes/Carpet.png	Essentials	23
44	2025-07-24 09:35:09.561949	2025-07-24 09:35:09.561949	Vinyl	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_01_EntryWFloor_L3507H4960_0033.jpg	6.500.2	21.1	Upgrade ($)	assets/images/palettes/Vinyl.png	Essentials	23
45	2025-07-24 09:35:09.562869	2025-07-24 09:35:09.562869	threshold plate: Polished Aluminium	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_03_CabinThreslholdP_L3507H4960_0045.jpg	6.500.10	In Package	In Package	assets/images/palettes/Metal.png	Essentials	23
46	2025-07-24 09:35:09.563772	2025-07-24 09:35:09.563772	Flooring: Granite/Marble/Quartz	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_01_EntryWFloor_L3507H4960_0032.jpg	6.500.3B	59,8	Upgrade ($)	assets/images/palettes/Stone.png	AvantGarde	23
47	2025-07-24 09:35:09.564541	2025-07-24 09:35:09.564541	Flooring: Hard Wood 	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_01_EntryWFloorWood_L3507H4960_WOOD.jpg	6.500.4B	22	Upgrade ($)	assets/images/palettes/Wood.png	AvantGarde	23
48	2025-07-24 09:35:09.565637	2025-07-24 09:35:09.565637	Threshold plate: Glaskote	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_03_CabinThreslholdP_L3507H4960_0044.jpg	6.500.1B	0	Upgrade ($)	assets/images/palettes/Glaskote.png	AvantGarde	23
49	2025-07-24 09:35:09.567962	2025-07-24 09:35:09.567962	Console Table Finishing: Wood Veneer/ Paint with Wood Veneer/ Paint Edge	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_02_ClubConsoleTable_L3507H4960.jpg	6.200.20A	In Package	In Package	assets/images/palettes/Wood.png	Essentials	24
50	2025-07-24 09:35:09.570646	2025-07-24 09:35:09.570646	Service Ledge Finishing: Upholstery/Leather w/ Seams	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_02_ClubSideWallFront_L3507H4960.jpg	6.300.40A	In Package	In Package	assets/images/palettes/Ultraleather.png	Essentials	25
51	2025-07-24 09:35:09.572119	2025-07-24 09:35:09.572119	Top Surface: Wood Veneer/ Paint	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_02_ClubSideWallTop_L3507H4960.jpg	6.300.41A	In Package	In Package	assets/images/palettes/Wood.png	Essentials	25
52	2025-07-24 09:35:09.573389	2025-07-24 09:35:09.573389	Sideledge Open Storage Interior: Upholstery/Leather	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_02_ClubSideWallInsert_L3507H4960.jpg	6.300.43A	In Package	In Package	assets/images/palettes/Ultraleather.png	Essentials	25
53	2025-07-24 09:35:09.578003	2025-07-24 09:35:09.578003	Wood Veneer/ Paint with Wood Veneer/ Paint Edge	https://api.dassaultfalcon.com/lacollection-smtp/photos/parts/HQ_CamChap_04_Lounge02Diningtable_L4960H3507.jpg	6.200.30A	In Package	In Package	assets/images/palettes/Wood.png	Essentials	26
54	2025-07-24 09:35:09.580791	2025-07-24 09:35:09.580791	Facade: Upholstery/Leather with Top Stitch	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_02_MidCabFacade_L3507H4960.jpg	6.300.30a	In Package	In Package	assets/images/palettes/Ultraleather.png	Essentials	27
55	2025-07-24 09:35:09.582011	2025-07-24 09:35:09.582011	Top: Wood Veneer/Paint	https://api.dassaultfalcon.com/lacollection-smtp/photos/parts/LQ_CamTECH_01_BedCredenza_L3507H4960_0045.jpg	6.300.31a	In Package	In Package	assets/images/palettes/Wood.png	Essentials	27
56	2025-07-24 09:35:09.583229	2025-07-24 09:35:09.583229	Top: Granite/Marble/Quartz	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_01_BedCredenza_L3507H4960_0046.jpg	6.300.31b	15.4	Upgrade ($)	assets/images/palettes/Stone.png	AvantGarde	27
57	2025-07-24 09:35:09.587695	2025-07-24 09:35:09.587695	Divan Lower Facade: Upholstery/Leather	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_04_DivanLowerFacade_L3507H4960.jpg	6.260.10	In Package	In Package	assets/images/palettes/Ultraleather.png	Essentials	28
58	2025-07-24 09:35:09.589407	2025-07-24 09:35:09.589407	Divan Headrest: Upholstery/Leather	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_04_DivanHeadrest_L3507H4960.jpg	6.260.20	In Package	In Package	assets/images/palettes/Ultraleather.png	Essentials	28
59	2025-07-24 09:35:09.591173	2025-07-24 09:35:09.591173	Divan Cushion: Upholstery/Leather	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_04_DivanCushion_L3507H4960.jpg	6.260.30	In Package	In Package	assets/images/palettes/Upholstery.png	Essentials	28
60	2025-07-24 09:35:09.594071	2025-07-24 09:35:09.594071	Divan Backrest: Upholstery/Leather	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_04_DivanBackrest_L3507H4960.jpg	6.260.40	In Package	In Package	assets/images/palettes/Upholstery.png	Essentials	28
61	2025-07-24 09:35:09.595975	2025-07-24 09:35:09.595975	Divan Armrest: Upholstery/Leather	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_04_DivanArmrest_L3507H4960.jpg	6.260.50	In Package	In Package	assets/images/palettes/Upholstery.png	Essentials	28
62	2025-07-24 09:35:09.597732	2025-07-24 09:35:09.597732	Divan Side Storage Top Surface: Wood Veneer/Paint	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_04_DivanSideStorage_L3507H4960.jpg	6.260.60	In Package	In Package	assets/images/palettes/Paint.png	Essentials	28
63	2025-07-24 09:35:09.601362	2025-07-24 09:35:09.601362	Bed Header Exterior: Quilting	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_01_BedBedHeader_L3507H4960_0034.jpg	6.270.10B	In Package	In Package	assets/images/palettes/QuiltedLeather.png	Essentials	29
64	2025-07-24 09:35:09.602686	2025-07-24 09:35:09.602686	Bed Header Exterior: Upholstery	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_01_BedBedHeader_L3507H4960_0035.jpg	6.270.11b	-0.7	Upgrade ($)	assets/images/palettes/Upholstery.png	AvantGarde	29
65	2025-07-24 09:35:09.606346	2025-07-24 09:35:09.606346	Facade: Upholstery/Leather w/ Top Stitc	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_02_MidCabFacade_L3507H4960.jpg	6.300.30A	In Package	In Package		Essentials	30
67	2025-07-24 09:35:09.609738	2025-07-24 09:35:09.609738	Multi-Purpose Storage Cabinet Top: Granite/Marble/Quartz	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_01_BedCredenza_L3507H4960_0046.jpg	6.300.31B	15.4	Upgrade ($)	assets/images/palettes/Stone.png	AvantGarde	30
68	2025-07-24 09:35:09.614929	2025-07-24 09:35:09.614929	Sink : Glaskote	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_02_AftVanityBackSplash_L3507H4960_0043.jpg	6.210.12B	In Package	In Package	assets/images/palettes/Glaskote.png	Essentials	32
69	2025-07-24 09:35:09.619016	2025-07-24 09:35:09.619016	Backsplash: Solid Surface	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_02_AftVanityBackSplash_L3507H4960_0044.jpg	6.210.31A	In Floorplan	In Floorplan	assets/images/palettes/SolidSurface.png	Essentials	33
70	2025-07-24 09:35:09.621053	2025-07-24 09:35:09.621053	Backsplash: Granite/Marble/Quartz	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_02_AftVanityBackSplash_L3507H4960_0043.jpg	6.210.31	1.1	Upgrade ($)	assets/images/palettes/Stone.png	AvantGarde	33
71	2025-07-24 09:35:09.62549	2025-07-24 09:35:09.62549	Right-Hand Closet Door: Wood Veneer/Paint	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_02_AftToiletCloset_L3507H4960_0041.jpg	6.212.1R0	In Package	In Package	assets/images/palettes/Wood.png	Essentials	35
72	2025-07-24 09:35:09.626592	2025-07-24 09:35:09.626592	Right-Hand Closet Door: Leather Padding	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_02_AftToiletCloset_L3507H4960_0042.jpg	6.212.1R1	4,0	Upgrade ($)	assets/images/palettes/Ultraleather.png	AvantGarde	35
73	2025-07-24 09:35:09.628881	2025-07-24 09:35:09.628881	Right-Hand Countertop: Solid Surface	https://api.dassaultfalcon.com/lacollection-smtp/photos/parts/LQ_CamTECH_02_AftToiletTOP_L3507H4960_0037.jpg	6.210.30a	In Package	In Package	assets/images/palettes/SolidSurface.png	Essentials	36
74	2025-07-24 09:35:09.63005	2025-07-24 09:35:09.63005	Right-Hand Countertop: Granite/Marble/Quartz	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_02_AftToiletTOP_L3507H4960_0036.jpg	6.210.30	4.0	Upgrade ($)	assets/images/palettes/Stone.png	AvantGarde	36
75	2025-07-24 09:35:09.633096	2025-07-24 09:35:09.633096	Forward Main Cabin Bulkhead Finishing: Wood Veneer/Paint (Each, per side)	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_03_CabinGallDivider_L3507H4960_0043.jpg	6.300.10	In Package	In Package	assets/images/palettes/Wood.png	Essentials	37
76	2025-07-24 09:35:09.635352	2025-07-24 09:35:09.635352	Forward Main Cabin Bulkhead Finishing: Upholstery (Each, per side)	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_03_CabinGallDivider_L3507H4960_0042.jpg	6.300.11	-2.2	Upgrade ($)	assets/images/palettes/Ultraleather.png	AvantGarde	37
77	2025-07-24 09:35:09.637624	2025-07-24 09:35:09.637624	Main Cabin Divider Finishing: Wood Veneer/Paint (Each, per side)	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_04_CabinMIDDivider_L3507H4960_0050.jpg	6.300.20	In Package	In Package	assets/images/palettes/Wood.png	Essentials	38
78	2025-07-24 09:35:09.639036	2025-07-24 09:35:09.639036	Main Cabin Divider Finishing: Upholstery (Each, per side)	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_04_CabinMIDDivider_L3507H4960_0051.jpg	6.300.21	-2.2	Upgrade ($)	assets/images/palettes/Ultraleather.png	AvantGarde	38
79	2025-07-24 09:35:09.640755	2025-07-24 09:35:09.640755	Main Cabin Divider Finishing: Upholstery/Leather with Wood Veneer/Paint Framed Mirror (Each, per side)	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_04_CabinMIDDivider_L3507H4960_0048.jpg	6.300.22	0.7	Upgrade ($)		AvantGarde	38
80	2025-07-24 09:35:09.642387	2025-07-24 09:35:09.642387	Main Cabin Divider Finishing: Quilting with Leather/Upholstery Insert and Piping (Each, per side)	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_04_CabinMIDDivider_L3507H4960_0049.jpg	6.300.23	2.6	Upgrade ($)	assets/images/palettes/Upholstery.png	AvantGarde	38
81	2025-07-24 09:35:09.645374	2025-07-24 09:35:09.645374	Aft Main Cabin Bulkhead Finishing: Wood Veneer/ Paint (Each, per side)	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_01_BedAftDivider_L3507H4960_0033.jpg	6.300.30	In Package	In Package	assets/images/palettes/Wood.png	Essentials	39
82	2025-07-24 09:35:09.64634	2025-07-24 09:35:09.64634	Aft Main Cabin Bulkhead Finishing: Upholstery (Each, per side)	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_01_BedAftDivider_L3507H4960_0032.jpg	6.300.31	-2.2	Upgrade ($)	assets/images/palettes/Ultraleather.png	AvantGarde	39
83	2025-07-24 09:35:09.647169	2025-07-24 09:35:09.647169	Aft Main Cabin Bulkhead Finishing: Upholstery/Leather with Insert and Recess (Each, per side)	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_01_BedAftDivider_L3507H4960_0031.jpg	6.300.32	-0.9	Upgrade ($)	assets/images/palettes/Ultraleather.png	AvantGarde	39
84	2025-07-24 09:35:09.649962	2025-07-24 09:35:09.649962	Sink : Glaskote	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_05_AFtLavatSink_L3507H4960.jpg	6.210.12B	In Package	In Package	assets/images/palettes/Glaskote.png	Essentials	40
85	2025-07-24 09:35:09.654816	2025-07-24 09:35:09.654816	kkk	https://api.dassaultfalcon.com/lacollection-smtp/photos/parts/LQ_CamTECH_02_AftToiletFloor_L3507H4960_0039.jpg					Essentials	42
86	2025-07-24 09:35:09.655914	2025-07-24 09:35:09.655914	kkk	https://api.dassaultfalcon.com/lacollection-smtp/photos/parts/LQ_CamTECH_02_AftToiletFloor_L3507H4960_0039.jpg					Essentials	42
87	2025-07-24 09:35:09.658115	2025-07-24 09:35:09.658115	Left-Hand  Closet Door: Wood Veneer/ Paint	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_02_AftToiletCloset_L3507H4960_0041.jpg	6.212.1L0	In Package	In Package	assets/images/palettes/Wood.png	Essentials	43
88	2025-07-24 09:35:09.659132	2025-07-24 09:35:09.659132	Left-Hand Closet Door: Leather Padding	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_02_AftToiletCloset_L3507H4960_0042.jpg	6.212.1L1	4,0	Upgrade ($)	assets/images/palettes/Ultraleather.png	AvantGarde	43
89	2025-07-24 09:35:09.660949	2025-07-24 09:35:09.660949	Carpet	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_05_AFtLavatFloor_L3507H4960_0053.jpg	6.500.0A	In Package	In Package	assets/images/palettes/Carpet.png	Essentials	44
90	2025-07-24 09:35:09.661687	2025-07-24 09:35:09.661687	Vinyl	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_05_AFtLavatFloor_L3507H4960_0054.jpg	6.500.2A	8.8	Upgrade ($)	assets/images/palettes/Vinyl.png	Essentials	44
91	2025-07-24 09:35:09.662978	2025-07-24 09:35:09.662978	FlooringGranite/Marble/Quartz Note: Included in shower configuration"	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_05_AFtLavatFloor_L3507H4960_0052.jpg	6.500.3A	24,9	Upgrade ($)	assets/images/palettes/Stone.png	AvantGarde	44
92	2025-07-24 09:35:09.664148	2025-07-24 09:35:09.664148	Flooring: Hard Wood 	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_05_AFtLavatFloorWood_L3507H4960.jpg	6.500.4A	7	Upgrade ($)	assets/images/palettes/Wood.png	AvantGarde	44
93	2025-07-24 09:35:25.81062	2025-07-24 09:35:25.81062	Stainless Steel	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_01-Entryway_Sink_L3507H4960_1011.jpg	6.210.1	In Package	In Package		Essentials	45
94	2025-07-24 09:35:25.81327	2025-07-24 09:35:25.81327	Glaskote	https://api.dassaultfalcon.com/lacollection-smtp/photos/parts/HQ_01-Entryway_Sink_L3507H4960_1010.jpg	6.210.12	0	7800	assets/images/palettes/Glaskote.png	Essentials	45
95	2025-07-24 09:35:25.816559	2025-07-24 09:35:25.816559	Solid Surface	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_01-Entryway_CounterTop_L3507H4960_1015.jpg	6.210.2a	In Package	In Package	assets/images/palettes/SolidSurface.png	Essentials	46
96	2025-07-24 09:35:25.818547	2025-07-24 09:35:25.818547	Stone	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_01-Entryway_CounterTop_L3507H4960_1016.jpg	6.210.2	5	45300	assets/images/palettes/Stone.png	AvantGarde	46
97	2025-07-24 09:35:25.821539	2025-07-24 09:35:25.821539	Carpet	https://api.dassaultfalcon.com/lacollection-smtp/photos/parts/HQ_01-Entryway_Flooring_L3507H4960_1021.jpg	6.500.0B	In Package	In Package	assets/images/palettes/Carpet.png	Essentials	47
98	2025-07-24 09:35:25.822925	2025-07-24 09:35:25.822925	Vinyl	https://api.dassaultfalcon.com/lacollection-smtp/photos/parts/HQ_01-Entryway_Flooring_L3507H4960_1022BD.jpg	6.500.2	22,4	$10,500	assets/images/palettes/Vinyl.png	Essentials	47
99	2025-07-24 09:35:25.824699	2025-07-24 09:35:25.824699	Stone	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_01-Entryway_Flooring_L3507H4960_1020BD.jpg	6.500.3B	32,3	$115,100	assets/images/palettes/Stone.png	AvantGarde	47
100	2025-07-24 09:35:25.826128	2025-07-24 09:35:25.826128	Wood Veneer	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_01-Entryway_Flooring_L3507H4960_1023BD.jpg	6.500.4B	10,9	$106,500	assets/images/palettes/Wood.png	AvantGarde	47
101	2025-07-24 09:35:25.830039	2025-07-24 09:35:25.830039	Glaskote	https://api.dassaultfalcon.com/lacollection-smtp/photos/parts/HQ_01-Entryway_FWDLavSink_L3507H4960_1010.jpg	6.210.12a	In Package	In Package	assets/images/palettes/Glaskote.png	Essentials	48
102	2025-07-24 09:35:25.83202	2025-07-24 09:35:25.83202	Solid Surface1	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_01-Entryway_FWDLavConterTop_L3507H4960_1015.jpg	6.210.3b	In Package	In Package	assets/images/palettes/SolidSurface.png	Essentials	49
103	2025-07-24 09:35:25.833389	2025-07-24 09:35:25.833389	Stone	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_01-Entryway_FWDLavConterTop_L3507H4960_1016BD.jpg	6.210.5 	1.5	18800	assets/images/palettes/Stone.png	AvantGarde	49
104	2025-07-24 09:35:25.837857	2025-07-24 09:35:25.837857	Wood Edge	assets/images/options/HQ_02-Cabin_ConsoleT_L3507H4960_1101.jpg	6.200.21	In Package	In Package	assets/images/palettes/Wood.png	Essentials	50
105	2025-07-24 09:35:25.838959	2025-07-24 09:35:25.838959	Painted Edge	assets/images/options/HQ_02-Cabin_ConsoleT_L3507H4960_1100.jpg	6.200.21a	0	30000	assets/images/palettes/Paint.png	AvantGarde	50
106	2025-07-24 09:35:25.841579	2025-07-24 09:35:25.841579	Wood Edge	assets/images/options/HQ_02-Cabin_SideLedge_L3507H4960_1102.jpg	6.300.40a	In Package	In Package	assets/images/palettes/Wood.png	Essentials	51
107	2025-07-24 09:35:25.842883	2025-07-24 09:35:25.842883	Upholstery	assets/images/options/HQ_02-Cabin_SideLedge_L3507H4960.jpg	6.300.41	In Package	In Package	assets/images/palettes/Upholstery.png	Essentials	51
108	2025-07-24 09:35:25.844562	2025-07-24 09:35:25.844562	Painted Edge	assets/images/options/HQ_02-Cabin_SideLedge_L3507H4960_1103.jpg	6.300.40	0	37000	assets/images/palettes/Paint.png	AvantGarde	51
109	2025-07-24 09:35:25.848845	2025-07-24 09:35:25.848845	Wood Edge	assets/images/options/HQ_02-Cabin_DiningT_L3507H4960_1101.jpg	6.300.31	In Package	In Package	assets/images/palettes/Wood.png	Essentials	52
110	2025-07-24 09:35:25.850531	2025-07-24 09:35:25.850531	Painted Edge	assets/images/options/HQ_02-Cabin_DiningT_L3507H4960_1100.jpg	6.300.31a	0	15000	assets/images/palettes/Paint.png	AvantGarde	52
111	2025-07-24 09:35:25.853399	2025-07-24 09:35:25.853399	Wood Door	assets/images/options/HQ_02-Cabin_Credenza_L3507H4960_1111.jpg	6.300.30	In Package	In Package	assets/images/palettes/Wood.png	Essentials	53
112	2025-07-24 09:35:25.854562	2025-07-24 09:35:25.854562	Leather Door	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_02-Cabin_Credenza_L3507H4960_1111221.jpg	6.300.31	0	No Charge	assets/images/palettes/Ultraleather.png	AvantGarde	53
113	2025-07-24 09:35:25.855439	2025-07-24 09:35:25.855439	Painted Door	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_02-Cabin_Credenza_L3507H4960_1109.jpg	6.300.32	0	10000	assets/images/palettes/Paint.png	AvantGarde	53
114	2025-07-24 09:35:25.857269	2025-07-24 09:35:25.857269	Wood	assets/images/options/HQ_02-Cabin_AFTMidCabDividerFWD_L3507H4960.jpg	6.300.8	In Package	In Package	assets/images/palettes/Wood.png	Essentials	54
115	2025-07-24 09:35:25.857975	2025-07-24 09:35:25.857975	Upholstery Insert	assets/images/options/HQ_02-Cabin_AFTMidCabDividerFWD-LH_L3507H4960.jpg	6.300.8g	0	10100	assets/images/palettes/Upholstery.png	AvantGarde	54
116	2025-07-24 09:35:25.861391	2025-07-24 09:35:25.861391	Wood Door	assets/images/options/HQ_03-Divan_StorageCab_L3507H4960.jpg	6.300.30R	In Package	In Package	assets/images/palettes/Wood.png	Essentials	55
117	2025-07-24 09:35:25.86394	2025-07-24 09:35:25.86394	Wood	assets/images/options/HQ_03-Divan_AFTLavBulkhead_L3507H4960_1111.jpg	6.400.1	In Package	In Package	assets/images/palettes/Wood.png	Essentials	56
118	2025-07-24 09:35:25.865379	2025-07-24 09:35:25.865379	Door Mirror	assets/images/options/HQ_03-Divan_AFTLavBulkhead_L3507H4960_1112.jpg	6.400.1B	6	No charge	\N	Essentials	56
119	2025-07-24 09:35:25.869959	2025-07-24 09:35:25.869959	Glaskote	assets/images/options/HQ_04-Lavatory_Sink_L3507H4960_1010.jpg	6.210.12b	In Package	In Package	assets/images/palettes/Glaskote.png	Essentials	57
120	2025-07-24 09:35:25.872426	2025-07-24 09:35:25.872426	Solid Surface	assets/images/options/HQ_04-Lavatory_CounterTop_L3507H4960_1015.jpg	6.210.3a	In Package	In Package	assets/images/palettes/SolidSurface.png	Essentials	58
121	2025-07-24 09:35:25.873425	2025-07-24 09:35:25.873425	Stone	assets/images/options/HQ_04-Lavatory_CounterTop_L3507H4960_1016.jpg	6.210.3	0,3	21400	assets/images/palettes/Stone.png	AvantGarde	58
122	2025-07-24 09:35:25.875245	2025-07-24 09:35:25.875245	Carpet	assets/images/options/HQ_04-Lavatory_Flooring_L3507H4960_1021.jpg	6.500.0a	In Package	In Package	assets/images/palettes/Carpet.png	Essentials	59
123	2025-07-24 09:35:25.876409	2025-07-24 09:35:25.876409	Vinyl	assets/images/options/HQ_04-Lavatory_Flooring_L3507H4960_1022.jpg	6.500.2a	8,8	8000	assets/images/palettes/Vinyl.png	Essentials	59
124	2025-07-24 09:35:25.877965	2025-07-24 09:35:25.877965	Wood Veneer	assets/images/options/HQ_04-Lavatory_Flooring_L3507H4960_1023.jpg	6.500.4a	3,5	91100	assets/images/palettes/Wood.png	AvantGarde	59
125	2025-07-24 09:35:25.879279	2025-07-24 09:35:25.879279	Stone	assets/images/options/HQ_04-Lavatory_Flooring_L3507H4960_1020.jpg	6.500.3a	13,9	99800	assets/images/palettes/Stone.png	AvantGarde	59
126	2025-07-24 09:35:25.881224	2025-07-24 09:35:25.881224	Mirror	assets/images/options/HQ_04-Lavatory_BulkheadFWD_L3507H4960_1112.jpg	6.400.2	In Package	In Package		Essentials	60
127	2025-07-24 09:35:25.882935	2025-07-24 09:35:25.882935	Ultraleather	assets/images/options/HQ_04-Lavatory_BulkheadFWD_L3507H4960_11121.jpg	6.400.2a	-0.2	No charge	assets/images/palettes/Ultraleather.png	Essentials	60
128	2025-07-24 09:35:25.885277	2025-07-24 09:35:25.885277	Wood	assets/images/options/HQ_04-Lavatory_BulkheadAFT_L3507H4960_1113.jpg	6.410.2	In Package	In Package	assets/images/palettes/Wood.png	Essentials	60
129	2025-07-24 09:35:25.886889	2025-07-24 09:35:25.886889	Ultraleather	assets/images/options/HQ_04-Lavatory_BulkheadAFT_L3507H4960_1114.jpg	6.410.2a	-0,1	No Charge	assets/images/palettes/Ultraleather.png	Essentials	60
130	2025-07-24 09:35:37.369714	2025-07-24 09:35:37.369714	Stainless steel	assets/images/options/HQ_01-Entryway_Sink_L3507H4960_1003_CORALIE.jpg	6.210.1	In Package	In Package	\N	Essentials	61
131	2025-07-24 09:35:37.371996	2025-07-24 09:35:37.371996	Glaskote	assets/images/options/HQ_01-Entryway_Sink_L3507H4960_1004_CORALIE.jpg	6.210.12	0	7800	assets/images/palettes/Glaskote.png	Essentials	61
132	2025-07-24 09:35:37.374622	2025-07-24 09:35:37.374622	Solid surface	assets/images/options/HQ_01-Entryway_CounterTop_L3507H4960_1006_CORALIE.jpg	6.210.2a	In Package	In Package	assets/images/palettes/SolidSurface.png	Essentials	62
133	2025-07-24 09:35:37.377526	2025-07-24 09:35:37.377526	Stone	assets/images/options/HQ_01-Entryway_CounterTop_L3507H4960_1005_CORALIE.jpg	6.210.2	-1,5	45300	assets/images/palettes/Stone.png	AvantGarde	62
134	2025-07-24 09:35:37.381	2025-07-24 09:35:37.381	Carpet	assets/images/options/HQ_01-Entryway_Flooring_L3507H4960_1007_CORALIE.jpg	6.500.0b	In Package	In Package	assets/images/palettes/Carpet.png	Essentials	63
135	2025-07-24 09:35:37.383186	2025-07-24 09:35:37.383186	Vinyl	assets/images/options/HQ_01-Entryway_Flooring_L3507H4960_1009_CORALIE.jpg	6.500.2	13,3	10500	assets/images/palettes/Vinyl.png	Essentials	63
136	2025-07-24 09:35:37.385139	2025-07-24 09:35:37.385139	Wood Veneer	assets/images/options/HQ_01-Entryway_Flooring_L3507H4960_1010_CORALIE.jpg	6.500.4b	7.4	106000	assets/images/palettes/Wood.png	AvantGarde	63
137	2025-07-24 09:35:37.386658	2025-07-24 09:35:37.386658	Stone	assets/images/options/HQ_01-Entryway_Flooring_L3507H4960_1008_CORALIE.jpg	6.500.3b	24.8	115100	assets/images/palettes/Stone.png	AvantGarde	63
138	2025-07-24 09:35:37.390898	2025-07-24 09:35:37.390898	Wood Edge	assets/images/options/HQ_02-Cabin_ConsoleT_L3507H4960_1001_CORALIE.jpg	6.200.21	In Package	In Package	assets/images/palettes/Wood.png	Essentials	64
139	2025-07-24 09:35:37.392366	2025-07-24 09:35:37.392366	Painted Edge	assets/images/options/HQ_02-Cabin_ConsoleT_L3507H4960_1002_CORALIE.jpg	6.200.21a	0	30000	assets/images/palettes/Paint.png	AvantGarde	64
140	2025-07-24 09:35:37.395402	2025-07-24 09:35:37.395402	Wood Edge	assets/images/options/HQ_02-Cabin_SideLedge_L3507H4960_1018_CORALIE.jpg	6.300.40a	In Package	In Package	assets/images/palettes/Wood.png	Essentials	65
141	2025-07-24 09:35:37.396773	2025-07-24 09:35:37.396773	Upholstery	assets/images/options/HQ_02-Cabin_SideLedge_L3507H4960_1018__TEXTILE_CORALIE.jpg	6.300.41	In Package	In Package	assets/images/palettes/Upholstery.png	Essentials	65
142	2025-07-24 09:35:37.398155	2025-07-24 09:35:37.398155	Painted Edge	assets/images/options/HQ_02-Cabin_SideLedge_L3507H4960_1019_CORALIE.jpg	6.300.40	0	37000	assets/images/palettes/Paint.png	AvantGarde	65
143	2025-07-24 09:35:37.402216	2025-07-24 09:35:37.402216	Wood Edge	assets/images/options/HQ_02-Cabin_DiningT_L3507H4960_1001.jpg	6.200.31	In Package	In Package	assets/images/palettes/Wood.png	Essentials	66
144	2025-07-24 09:35:37.403422	2025-07-24 09:35:37.403422	Painted Edge	assets/images/options/HQ_02-Cabin_DiningT_L3507H4960_1002.jpg	6.200.31a	0	15000	assets/images/palettes/Paint.png	AvantGarde	66
145	2025-07-24 09:35:37.405949	2025-07-24 09:35:37.405949	Wood Door	assets/images/options/HQ_02-Cabin_Credenza_L3507H4960_1017.jpg	6.300.30	In Package	In Package	assets/images/palettes/Wood.png	Essentials	67
146	2025-07-24 09:35:37.407205	2025-07-24 09:35:37.407205	Painted Door	assets/images/options/HQ_02-Cabin_Credenza_L3507H4960_1016.jpg	6.300.32	0	10000	assets/images/palettes/Paint.png	Essentials	67
147	2025-07-24 09:35:37.408465	2025-07-24 09:35:37.408465	Leather Door	assets/images/options/HQ_02-Cabin_Credenza_L3507H4960_1015.jpg	6.300.31	0	No Charge	assets/images/palettes/QuiltedLeather.png	AvantGarde	67
148	2025-07-24 09:35:37.412256	2025-07-24 09:35:37.412256	Wood	assets/images/options/HQ_02-Cabin_AFTMidCabDividerFWD_L3507H4960_1023.jpg	6.300.8	In Package	In Package	assets/images/palettes/Wood.png	Essentials	68
149	2025-07-24 09:35:37.41364	2025-07-24 09:35:37.41364	Mirror Insert	assets/images/options/HQ_02-Cabin_AFTMidCabDividerFWD_L3507H4960_1022.jpg	6.300.8h	1	11900		Essentials	68
150	2025-07-24 09:35:37.414892	2025-07-24 09:35:37.414892	Wood	assets/images/options/HQ_02-Cabin_AFTMidCabDividerAFT_L3507H4960-01.jpg	6.300.9	In Package	In Package	assets/images/palettes/Wood.png	Essentials	68
151	2025-07-24 09:35:37.416358	2025-07-24 09:35:37.416358	Mirror Insert	assets/images/options/HQ_02-Cabin_AFTMidCabDividerAFT_L3507H4960-02.jpg	6.300.9h	1	12300		Essentials	68
152	2025-07-24 09:35:37.41777	2025-07-24 09:35:37.41777	Upholstery Insert	assets/images/options/HQ_02-Cabin_AFTMidCabDividerFWD_L3507H4960_1021.jpg	6.300.8g	0	10100	assets/images/palettes/Upholstery.png	AvantGarde	68
153	2025-07-24 09:35:37.421914	2025-07-24 09:35:37.421914	Wood Door	assets/images/options/HQ_03-Divan_StorageCab_L3507H4960_1002.jpg	6.300.30R	In Package	In Package	assets/images/palettes/Wood.png	Essentials	69
154	2025-07-24 09:35:37.42299	2025-07-24 09:35:37.42299	Painted Door	assets/images/options/HQ_03-Divan_StorageCab_L3507H4960_1003.jpg	6.300.32R	0	10000	assets/images/palettes/Paint.png	Essentials	69
155	2025-07-24 09:35:37.428784	2025-07-24 09:35:37.428784	Glaskote	assets/images/options/HQ_04-Lavatory_Sink_L3507H4960_1000_CORALIE.jpg	6.210.12b	In Package	In Package	assets/images/palettes/Glaskote.png	Essentials	70
156	2025-07-24 09:35:37.43159	2025-07-24 09:35:37.43159	Solid Surface	assets/images/options/HQ_04-Lavatory_CounterTop02_2023-01-19_CORALIE.jpg	6.210.3a	In Package	In Package	assets/images/palettes/SolidSurface.png	Essentials	71
157	2025-07-24 09:35:37.433265	2025-07-24 09:35:37.433265	Stone	assets/images/options/HQ_04-Lavatory_CounterTop01_2023-01-19_CORALIE.jpg	6.210.3	2.5	21400	assets/images/palettes/Stone.png	AvantGarde	71
158	2025-07-24 09:35:37.436054	2025-07-24 09:35:37.436054	Carpet	assets/images/options/HQ_04-Lavatory_Flooring_L3507H4960_1014_CORALIE.jpg	6.500.0a	In Package	In Package	assets/images/palettes/Carpet.png	Essentials	72
159	2025-07-24 09:35:37.43749	2025-07-24 09:35:37.43749	Vinyl	assets/images/options/HQ_04-Lavatory_Flooring_L3507H4960_1013_CORALIE.jpg	6.500.2a	3.2	8000	assets/images/palettes/Vinyl.png	Essentials	72
160	2025-07-24 09:35:37.438636	2025-07-24 09:35:37.438636	Wood Veneer	assets/images/options/HQ_04-Lavatory_Flooring_L3507H4960_1011_CORALIE.jpg	6.500.4a	0.8	90600	assets/images/palettes/Wood.png	AvantGarde	72
161	2025-07-24 09:35:37.439886	2025-07-24 09:35:37.439886	Stone	assets/images/options/HQ_04-Lavatory_Flooring_L3507H4960_1012_CORALIE.jpg	6.500.3a	9.6	99800	assets/images/palettes/Stone.png	AvantGarde	72
162	2025-07-24 09:35:37.442697	2025-07-24 09:35:37.442697	Wood	assets/images/options/HQ_04-Lavatory_BulkheadFWD_L3507H4960_1007.jpg	6.400.2	In Package	In Package	assets/images/palettes/Wood.png	Essentials	73
163	2025-07-24 09:35:37.44439	2025-07-24 09:35:37.44439	Ultraleather	assets/images/options/HQ_04-Lavatory_BulkheadFWD_L3507H4960_1008.jpg	6.400.2a	-0.8	No charge	assets/images/palettes/Ultraleather.png	Essentials	73
164	2025-07-24 09:35:37.44593	2025-07-24 09:35:37.44593	Wood	assets/images/options/HQ_04-Lavatory_BulkheadAFT_L3507H4960_1007.jpg	6.410.2	In Package	In Package	assets/images/palettes/Wood.png	Essentials	73
165	2025-07-24 09:35:37.447209	2025-07-24 09:35:37.447209	Ultraleather	assets/images/options/HQ_04-Lavatory_BulkheadAFT_L3507H4960_1008.jpg	6.410.2a	-0.2	No charge	assets/images/palettes/Ultraleather.png	Essentials	73
\.


--
-- Data for Name: otp; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.otp (id, "createdAt", "updatedAt", code, expiry) FROM stdin;
\.


--
-- Data for Name: parts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.parts (id, "createdAt", "updatedAt", title, "areaId") FROM stdin;
1	2025-07-24 09:34:45.798513	2025-07-24 09:34:45.798513	Sink	1
2	2025-07-24 09:34:45.806218	2025-07-24 09:34:45.806218	Countertop	1
3	2025-07-24 09:34:45.813405	2025-07-24 09:34:45.813405	Upper drawer	1
4	2025-07-24 09:34:45.821496	2025-07-24 09:34:45.821496	Threshold	1
5	2025-07-24 09:34:45.825611	2025-07-24 09:34:45.825611	Flooring	1
6	2025-07-24 09:34:45.831208	2025-07-24 09:34:45.831208	Console Table	2
7	2025-07-24 09:34:45.834308	2025-07-24 09:34:45.834308	Dining table	2
8	2025-07-24 09:34:45.836599	2025-07-24 09:34:45.836599	Sideledge	2
9	2025-07-24 09:34:45.84222	2025-07-24 09:34:45.84222	Bulkheads	2
10	2025-07-24 09:34:45.850469	2025-07-24 09:34:45.850469	Sink	3
11	2025-07-24 09:34:45.853483	2025-07-24 09:34:45.853483	Countertop	3
12	2025-07-24 09:34:45.855788	2025-07-24 09:34:45.855788	Flooring	3
13	2025-07-24 09:34:45.857879	2025-07-24 09:34:45.857879	Bulkheads	3
14	2025-07-24 09:35:09.519257	2025-07-24 09:35:09.519257	FORWARD CLOSET	4
15	2025-07-24 09:35:09.528202	2025-07-24 09:35:09.528202		4
16	2025-07-24 09:35:09.531007	2025-07-24 09:35:09.531007	 CREW REST	5
17	2025-07-24 09:35:09.541249	2025-07-24 09:35:09.541249	Bulkhead	6
18	2025-07-24 09:35:09.544035	2025-07-24 09:35:09.544035	Sink	6
19	2025-07-24 09:35:09.547043	2025-07-24 09:35:09.547043	Backsplash	6
20	2025-07-24 09:35:09.552125	2025-07-24 09:35:09.552125	Bulkhead	7
21	2025-07-24 09:35:09.553277	2025-07-24 09:35:09.553277	Sink	7
22	2025-07-24 09:35:09.556707	2025-07-24 09:35:09.556707	Countertop	7
23	2025-07-24 09:35:09.559832	2025-07-24 09:35:09.559832	Flooring	7
24	2025-07-24 09:35:09.56719	2025-07-24 09:35:09.56719	Console table	8
25	2025-07-24 09:35:09.569149	2025-07-24 09:35:09.569149	Sideledge	8
26	2025-07-24 09:35:09.576589	2025-07-24 09:35:09.576589	Dining Table	9
27	2025-07-24 09:35:09.579606	2025-07-24 09:35:09.579606	Credenza	9
28	2025-07-24 09:35:09.586226	2025-07-24 09:35:09.586226	Divan	10
29	2025-07-24 09:35:09.600549	2025-07-24 09:35:09.600549	Bed Header	11
30	2025-07-24 09:35:09.604616	2025-07-24 09:35:09.604616	Credenza	11
31	2025-07-24 09:35:09.61222	2025-07-24 09:35:09.61222	 	12
32	2025-07-24 09:35:09.613709	2025-07-24 09:35:09.613709	Sink	13
33	2025-07-24 09:35:09.616915	2025-07-24 09:35:09.616915	Vanity Backsplash	13
34	2025-07-24 09:35:09.623078	2025-07-24 09:35:09.623078		13
35	2025-07-24 09:35:09.624097	2025-07-24 09:35:09.624097	Closet Door	13
36	2025-07-24 09:35:09.627797	2025-07-24 09:35:09.627797	Right-Hand Countertop  	13
37	2025-07-24 09:35:09.631741	2025-07-24 09:35:09.631741	Forward Bulkhead	14
38	2025-07-24 09:35:09.636627	2025-07-24 09:35:09.636627	Main Cabin Divider	14
39	2025-07-24 09:35:09.644397	2025-07-24 09:35:09.644397	AFT Bulkhead	14
40	2025-07-24 09:35:09.648822	2025-07-24 09:35:09.648822	Sink	15
41	2025-07-24 09:35:09.650884	2025-07-24 09:35:09.650884		15
42	2025-07-24 09:35:09.652988	2025-07-24 09:35:09.652988		15
43	2025-07-24 09:35:09.657164	2025-07-24 09:35:09.657164	Closet Door	15
44	2025-07-24 09:35:09.660118	2025-07-24 09:35:09.660118	Flooring	15
45	2025-07-24 09:35:25.808484	2025-07-24 09:35:25.808484	Sink	20
46	2025-07-24 09:35:25.81477	2025-07-24 09:35:25.81477	Countertop	20
47	2025-07-24 09:35:25.820326	2025-07-24 09:35:25.820326	Flooring	20
48	2025-07-24 09:35:25.828839	2025-07-24 09:35:25.828839	Sink	21
49	2025-07-24 09:35:25.830975	2025-07-24 09:35:25.830975	Countertop	21
50	2025-07-24 09:35:25.836645	2025-07-24 09:35:25.836645	Console table	22
51	2025-07-24 09:35:25.840387	2025-07-24 09:35:25.840387	Sideledge	22
52	2025-07-24 09:35:25.847463	2025-07-24 09:35:25.847463	Dining Table	23
53	2025-07-24 09:35:25.852149	2025-07-24 09:35:25.852149	Credenza	23
54	2025-07-24 09:35:25.856202	2025-07-24 09:35:25.856202	Bulkheads	23
55	2025-07-24 09:35:25.860227	2025-07-24 09:35:25.860227	Divan Cabinet	24
56	2025-07-24 09:35:25.862622	2025-07-24 09:35:25.862622	Bulkheads	24
57	2025-07-24 09:35:25.868408	2025-07-24 09:35:25.868408	Sink	25
58	2025-07-24 09:35:25.871239	2025-07-24 09:35:25.871239	Countertop	25
59	2025-07-24 09:35:25.874338	2025-07-24 09:35:25.874338	Flooring	25
60	2025-07-24 09:35:25.880387	2025-07-24 09:35:25.880387	Bulkheads	25
61	2025-07-24 09:35:37.367534	2025-07-24 09:35:37.367534	Sink	26
62	2025-07-24 09:35:37.373324	2025-07-24 09:35:37.373324	Countertop	26
63	2025-07-24 09:35:37.379595	2025-07-24 09:35:37.379595	Flooring	26
64	2025-07-24 09:35:37.390009	2025-07-24 09:35:37.390009	Console Table	27
65	2025-07-24 09:35:37.393935	2025-07-24 09:35:37.393935	Sideledge	27
66	2025-07-24 09:35:37.401041	2025-07-24 09:35:37.401041	Dining Table	28
67	2025-07-24 09:35:37.404565	2025-07-24 09:35:37.404565	Credenza	28
68	2025-07-24 09:35:37.410472	2025-07-24 09:35:37.410472	Bulkheads	28
69	2025-07-24 09:35:37.420756	2025-07-24 09:35:37.420756	Divan Cabinet	29
70	2025-07-24 09:35:37.427122	2025-07-24 09:35:37.427122	Sink	30
71	2025-07-24 09:35:37.43023	2025-07-24 09:35:37.43023	Countertop	30
72	2025-07-24 09:35:37.434731	2025-07-24 09:35:37.434731	Flooring	30
73	2025-07-24 09:35:37.441234	2025-07-24 09:35:37.441234	Bulkheads	30
\.


--
-- Data for Name: permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.permissions (id, "createdAt", "updatedAt", action, subject, fields, conditions, inverted, reason, "roleId") FROM stdin;
1	2025-07-24 12:22:19.389855	2025-07-24 12:22:19.389855	manage	all	\N	\N	\N	\N	1
2	2025-07-24 12:22:49.937548	2025-07-24 12:22:49.937548	read	all	\N	\N	\N	\N	2
\.


--
-- Data for Name: planes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.planes (id, "createdAt", "updatedAt", name) FROM stdin;
1	2025-07-24 09:34:45.787842	2025-07-24 09:34:45.787842	2000LXS
2	2025-07-24 09:35:09.505266	2025-07-24 09:35:09.505266	10X
3	2025-07-24 09:35:25.796082	2025-07-24 09:35:25.796082	8X
4	2025-07-24 09:35:37.353568	2025-07-24 09:35:37.353568	6X
\.


--
-- Data for Name: preferences; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.preferences (id, "createdAt", "updatedAt", "salesEmails", "accountId") FROM stdin;
1	2025-07-24 12:25:37.672471	2025-07-24 12:25:37.672471		3
2	2025-07-24 12:25:37.733302	2025-07-24 12:25:37.733302		4
3	2025-07-24 12:25:37.804798	2025-07-24 12:25:37.804798		5
4	2025-07-24 12:25:37.870119	2025-07-24 12:25:37.870119		6
5	2025-07-24 12:25:37.946392	2025-07-24 12:25:37.946392		7
6	2025-07-24 12:25:38.016704	2025-07-24 12:25:38.016704		8
7	2025-07-24 12:25:38.077219	2025-07-24 12:25:38.077219	Carlos.Brana@dassault-aviation.com	9
8	2025-07-24 12:25:38.142533	2025-07-24 12:25:38.142533		10
9	2025-07-24 12:25:38.215283	2025-07-24 12:25:38.215283		11
10	2025-07-24 12:25:38.282918	2025-07-24 12:25:38.282918		12
11	2025-07-24 12:25:38.346273	2025-07-24 12:25:38.346273		13
12	2025-07-24 12:25:38.407978	2025-07-24 12:25:38.407978		14
13	2025-07-24 12:25:38.470501	2025-07-24 12:25:38.470501		15
14	2025-07-24 12:25:38.535905	2025-07-24 12:25:38.535905		16
15	2025-07-24 12:25:38.595088	2025-07-24 12:25:38.595088	Bertrand.Becker@dassault-aviation.com	17
16	2025-07-24 12:25:38.65321	2025-07-24 12:25:38.65321	Nicolas.Aubert@dassault-aviation.com	18
17	2025-07-24 12:25:38.711942	2025-07-24 12:25:38.711942	Jean-Michel.Fraisse@dassault-aviation.com	19
18	2025-07-24 12:25:38.780596	2025-07-24 12:25:38.780596		20
19	2025-07-24 12:25:38.854361	2025-07-24 12:25:38.854361		21
20	2025-07-24 12:25:38.928558	2025-07-24 12:25:38.928558		22
21	2025-07-24 12:25:38.998882	2025-07-24 12:25:38.998882		23
22	2025-07-24 12:25:39.062111	2025-07-24 12:25:39.062111		24
23	2025-07-24 12:25:39.122447	2025-07-24 12:25:39.122447		25
24	2025-07-24 12:25:39.179589	2025-07-24 12:25:39.179589	laetitia.ferelloc@dassault-aviation.com	26
25	2025-07-24 12:25:39.238639	2025-07-24 12:25:39.238639		27
26	2025-07-24 12:25:39.295585	2025-07-24 12:25:39.295585		28
27	2025-07-24 12:25:39.352084	2025-07-24 12:25:39.352084		29
28	2025-07-24 12:25:39.417987	2025-07-24 12:25:39.417987		30
29	2025-07-24 12:25:39.48435	2025-07-24 12:25:39.48435		31
30	2025-07-24 12:25:39.554119	2025-07-24 12:25:39.554119		32
31	2025-07-24 12:25:39.62569	2025-07-24 12:25:39.62569		33
32	2025-07-24 12:25:39.690238	2025-07-24 12:25:39.690238		34
33	2025-07-24 12:25:39.749728	2025-07-24 12:25:39.749728	Igor.Fain@dassault-aviation.com	35
34	2025-07-24 12:25:39.813365	2025-07-24 12:25:39.813365		36
35	2025-07-24 12:25:39.87695	2025-07-24 12:25:39.87695		37
36	2025-07-24 12:25:39.939979	2025-07-24 12:25:39.939979		38
37	2025-07-24 12:25:40.007127	2025-07-24 12:25:40.007127		39
38	2025-07-24 12:25:40.067849	2025-07-24 12:25:40.067849		40
39	2025-07-24 12:25:40.134974	2025-07-24 12:25:40.134974		41
40	2025-07-24 12:25:40.203516	2025-07-24 12:25:40.203516		42
41	2025-07-24 12:25:40.279122	2025-07-24 12:25:40.279122		43
42	2025-07-24 12:25:40.346445	2025-07-24 12:25:40.346445		44
43	2025-07-24 12:25:40.421357	2025-07-24 12:25:40.421357		45
44	2025-07-24 12:25:40.494491	2025-07-24 12:25:40.494491		46
45	2025-07-24 12:25:40.559572	2025-07-24 12:25:40.559572		47
46	2025-07-24 12:25:40.626402	2025-07-24 12:25:40.626402		48
47	2025-07-24 12:25:40.700164	2025-07-24 12:25:40.700164		49
48	2025-07-24 12:25:40.77334	2025-07-24 12:25:40.77334		50
49	2025-07-24 12:25:40.850226	2025-07-24 12:25:40.850226		51
50	2025-07-24 12:25:40.924992	2025-07-24 12:25:40.924992		52
51	2025-07-24 12:25:41.002536	2025-07-24 12:25:41.002536		53
52	2025-07-24 12:25:41.072525	2025-07-24 12:25:41.072525		54
53	2025-07-24 12:25:41.148824	2025-07-24 12:25:41.148824		55
54	2025-07-24 12:25:41.223765	2025-07-24 12:25:41.223765		56
55	2025-07-24 12:25:41.283041	2025-07-24 12:25:41.283041		57
56	2025-07-24 12:25:41.336726	2025-07-24 12:25:41.336726		58
57	2025-07-24 12:25:41.390238	2025-07-24 12:25:41.390238		59
58	2025-07-24 12:25:41.452362	2025-07-24 12:25:41.452362		60
59	2025-07-24 12:25:41.512365	2025-07-24 12:25:41.512365		61
60	2025-07-24 12:25:41.560529	2025-07-24 12:25:41.560529		62
61	2025-07-24 12:25:41.608482	2025-07-24 12:25:41.608482	adrian.jimenez@dassault-aviation.com	63
62	2025-07-24 12:25:41.659561	2025-07-24 12:25:41.659561		64
63	2025-07-24 12:25:41.713795	2025-07-24 12:25:41.713795		65
\.


--
-- Data for Name: preferences_bookmarks_options; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.preferences_bookmarks_options ("preferencesId", "optionsId") FROM stdin;
57	9
\.


--
-- Data for Name: preferences_planes_planes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.preferences_planes_planes ("preferencesId", "planesId") FROM stdin;
1	4
1	3
2	4
3	3
3	4
3	1
4	1
4	4
4	3
5	2
5	1
5	4
5	3
6	1
6	4
6	3
8	4
8	3
9	4
9	3
10	4
10	3
11	4
11	3
12	4
12	3
13	4
13	3
14	4
14	3
18	4
18	3
19	4
19	3
20	4
20	3
21	4
21	3
22	4
22	3
23	4
23	3
25	4
25	3
26	4
26	3
27	4
27	3
28	4
28	3
29	3
29	4
30	3
30	4
31	4
31	3
32	4
32	3
34	4
34	3
35	4
35	3
36	3
36	4
37	4
37	3
38	4
38	3
39	4
39	3
40	3
40	4
41	3
41	4
42	4
42	3
43	3
43	4
44	4
44	3
45	4
45	3
46	4
46	3
47	4
47	3
48	4
48	3
49	4
49	3
50	4
50	3
51	4
51	3
52	4
52	3
53	4
53	3
54	4
54	3
55	4
55	3
58	4
58	3
58	1
59	2
59	1
59	4
59	3
62	4
62	3
62	1
63	4
63	3
63	1
\.


--
-- Data for Name: profiles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.profiles (id, "createdAt", "updatedAt", firstname, lastname, bio, gender, "phoneNumber", address, "photoUrl", "dateOfBirth") FROM stdin;
3	2025-07-24 12:25:37.601769	2025-07-24 12:25:37.601769	Dev	APPLE	\N	\N	\N	\N	\N	\N
4	2025-07-24 12:25:37.676	2025-07-24 12:25:37.676	Stephane	ARDOUIN	\N	\N	\N	\N	\N	\N
5	2025-07-24 12:25:37.73508	2025-07-24 12:25:37.73508	Falilou	GAYE	\N	\N	\N	\N	\N	\N
6	2025-07-24 12:25:37.808784	2025-07-24 12:25:37.808784	Remi	BACHELET	\N	\N	\N	\N	\N	\N
7	2025-07-24 12:25:37.872688	2025-07-24 12:25:37.872688	Aurore	NOUVELLON	\N	\N	\N	\N	\N	\N
8	2025-07-24 12:25:37.950202	2025-07-24 12:25:37.950202	Eloi	DUFOUR	\N	\N	\N	\N	\N	\N
9	2025-07-24 12:25:38.019576	2025-07-24 12:25:38.019576	Carlos	BRANA	\N	\N	\N	\N	\N	\N
10	2025-07-24 12:25:38.079166	2025-07-24 12:25:38.079166	Clement	BROZI	\N	\N	\N	\N	\N	\N
11	2025-07-24 12:25:38.14609	2025-07-24 12:25:38.14609	Jean-charles	FEDINI	\N	\N	\N	\N	\N	\N
12	2025-07-24 12:25:38.218694	2025-07-24 12:25:38.218694	Donna	DIKEN	\N	\N	\N	\N	\N	\N
13	2025-07-24 12:25:38.286307	2025-07-24 12:25:38.286307	Melanie	CANO	\N	\N	\N	\N	\N	\N
14	2025-07-24 12:25:38.349032	2025-07-24 12:25:38.349032	Karla	PALENCIA	\N	\N	\N	\N	\N	\N
15	2025-07-24 12:25:38.411415	2025-07-24 12:25:38.411415	Jennifer	HARPER	\N	\N	\N	\N	\N	\N
16	2025-07-24 12:25:38.473051	2025-07-24 12:25:38.473051	Lucie	WEBER	\N	\N	\N	\N	\N	\N
17	2025-07-24 12:25:38.538312	2025-07-24 12:25:38.538312	Bertrand	BECKER	\N	\N	\N	\N	\N	\N
18	2025-07-24 12:25:38.597497	2025-07-24 12:25:38.597497	Nicolas	AUBERT	\N	\N	\N	\N	\N	\N
19	2025-07-24 12:25:38.655358	2025-07-24 12:25:38.655358	Jean-michel	FRAISSE	\N	\N	\N	\N	\N	\N
20	2025-07-24 12:25:38.714022	2025-07-24 12:25:38.714022	Gilles	APOLLIS	\N	\N	\N	\N	\N	\N
21	2025-07-24 12:25:38.783723	2025-07-24 12:25:38.783723	Beatrice	ASHE	\N	\N	\N	\N	\N	\N
22	2025-07-24 12:25:38.857672	2025-07-24 12:25:38.857672	David	BAILEY	\N	\N	\N	\N	\N	\N
23	2025-07-24 12:25:38.931255	2025-07-24 12:25:38.931255	Thomas	CARLING	\N	\N	\N	\N	\N	\N
24	2025-07-24 12:25:39.001741	2025-07-24 12:25:39.001741	Nick	CHEN	\N	\N	\N	\N	\N	\N
25	2025-07-24 12:25:39.065252	2025-07-24 12:25:39.065252	Renaud	CLOATRE	\N	\N	\N	\N	\N	\N
26	2025-07-24 12:25:39.12571	2025-07-24 12:25:39.12571	Laetitia	FERELLOC	\N	\N	\N	\N	\N	\N
27	2025-07-24 12:25:39.18129	2025-07-24 12:25:39.18129	Gustavo	TOLEDO	\N	\N	\N	\N	\N	\N
28	2025-07-24 12:25:39.241408	2025-07-24 12:25:39.241408	Pierre	DELESTRADE	\N	\N	\N	\N	\N	\N
29	2025-07-24 12:25:39.297165	2025-07-24 12:25:39.297165	Jerome	DESMAZURES	\N	\N	\N	\N	\N	\N
30	2025-07-24 12:25:39.354521	2025-07-24 12:25:39.354521	Yvon	DESVIGNES	\N	\N	\N	\N	\N	\N
31	2025-07-24 12:25:39.42027	2025-07-24 12:25:39.42027	John	DE-TURRIS	\N	\N	\N	\N	\N	\N
32	2025-07-24 12:25:39.487953	2025-07-24 12:25:39.487953	Anne	DEVILLIERS	\N	\N	\N	\N	\N	\N
33	2025-07-24 12:25:39.557199	2025-07-24 12:25:39.557199	Jake	DEVRIES	\N	\N	\N	\N	\N	\N
34	2025-07-24 12:25:39.629081	2025-07-24 12:25:39.629081	Emilien	ETIENNE	\N	\N	\N	\N	\N	\N
35	2025-07-24 12:25:39.693085	2025-07-24 12:25:39.693085	Igor	FAIN	\N	\N	\N	\N	\N	\N
36	2025-07-24 12:25:39.751444	2025-07-24 12:25:39.751444	Paul	FLORECK	\N	\N	\N	\N	\N	\N
37	2025-07-24 12:25:39.81638	2025-07-24 12:25:39.81638	Robert	FRIEDLANDER	\N	\N	\N	\N	\N	\N
38	2025-07-24 12:25:39.879752	2025-07-24 12:25:39.879752	Jean-marie	GAUTHEROT	\N	\N	\N	\N	\N	\N
39	2025-07-24 12:25:39.943319	2025-07-24 12:25:39.943319	Gilles	GAUTIER	\N	\N	\N	\N	\N	\N
40	2025-07-24 12:25:40.009986	2025-07-24 12:25:40.009986	Renaud	LEMIRE	\N	\N	\N	\N	\N	\N
41	2025-07-24 12:25:40.070576	2025-07-24 12:25:40.070576	Mark	GREENWOOD	\N	\N	\N	\N	\N	\N
42	2025-07-24 12:25:40.137816	2025-07-24 12:25:40.137816	Aadil	GOULAMALY	\N	\N	\N	\N	\N	\N
43	2025-07-24 12:25:40.20722	2025-07-24 12:25:40.20722	Thomas	HETIER	\N	\N	\N	\N	\N	\N
44	2025-07-24 12:25:40.282115	2025-07-24 12:25:40.282115	Jean-michel	JACOB	\N	\N	\N	\N	\N	\N
45	2025-07-24 12:25:40.349395	2025-07-24 12:25:40.349395	Frederic	LE BASSER	\N	\N	\N	\N	\N	\N
46	2025-07-24 12:25:40.424373	2025-07-24 12:25:40.424373	Denis	LECULEE	\N	\N	\N	\N	\N	\N
47	2025-07-24 12:25:40.49759	2025-07-24 12:25:40.49759	Nicolas	MARTIN	\N	\N	\N	\N	\N	\N
48	2025-07-24 12:25:40.562594	2025-07-24 12:25:40.562594	Nicolas	MONCALIS	\N	\N	\N	\N	\N	\N
49	2025-07-24 12:25:40.629322	2025-07-24 12:25:40.629322	Rodrigo	PESOA	\N	\N	\N	\N	\N	\N
50	2025-07-24 12:25:40.702812	2025-07-24 12:25:40.702812	Xavier	PONS	\N	\N	\N	\N	\N	\N
51	2025-07-24 12:25:40.77777	2025-07-24 12:25:40.77777	Didier	RAYNARD	\N	\N	\N	\N	\N	\N
52	2025-07-24 12:25:40.85302	2025-07-24 12:25:40.85302	Rhett	REAVIS	\N	\N	\N	\N	\N	\N
53	2025-07-24 12:25:40.928462	2025-07-24 12:25:40.928462	Thomas	ROHAUT	\N	\N	\N	\N	\N	\N
54	2025-07-24 12:25:41.005248	2025-07-24 12:25:41.005248	Emmanuel	SENARD	\N	\N	\N	\N	\N	\N
55	2025-07-24 12:25:41.076617	2025-07-24 12:25:41.076617	Florent	VENTURINI	\N	\N	\N	\N	\N	\N
56	2025-07-24 12:25:41.152117	2025-07-24 12:25:41.152117	Isabelle	VITTET	\N	\N	\N	\N	\N	\N
57	2025-07-24 12:25:41.227528	2025-07-24 12:25:41.227528	Chad	WININGS	\N	\N	\N	\N	\N	\N
58	2025-07-24 12:25:41.28471	2025-07-24 12:25:41.28471	James	TAYLOR	\N	\N	\N	\N	\N	\N
59	2025-07-24 12:25:41.338536	2025-07-24 12:25:41.338536	Vincent	HUBERT	\N	\N	\N	\N	\N	\N
60	2025-07-24 12:25:41.393345	2025-07-24 12:25:41.393345	Axel	COCAT	\N	\N	\N	\N	\N	\N
61	2025-07-24 12:25:41.457356	2025-07-24 12:25:41.457356	Frederique	HOUSSARD	\N	\N	\N	\N	\N	\N
62	2025-07-24 12:25:41.515334	2025-07-24 12:25:41.515334	Marianne	DUPIN	\N	\N	\N	\N	\N	\N
63	2025-07-24 12:25:41.562245	2025-07-24 12:25:41.562245	Adrian	JIMENEZ	\N	\N	\N	\N	\N	\N
64	2025-07-24 12:25:41.610338	2025-07-24 12:25:41.610338	Simon	ETCHECOPAR	\N	\N	\N	\N	\N	\N
65	2025-07-24 12:25:41.6619	2025-07-24 12:25:41.6619	Veronique	LIMITO	\N	\N	\N	\N	\N	\N
66	2025-07-24 12:45:30.194666	2025-07-24 12:45:30.194666	Coralie	BORDENAVE	\N	\N	\N	\N	\N	\N
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.roles (id, "createdAt", "updatedAt", name, description) FROM stdin;
1	2025-07-24 12:22:19.389855	2025-07-24 12:22:19.389855	admin	\N
2	2025-07-24 12:22:49.937548	2025-07-24 12:22:49.937548	user	\N
\.


--
-- Name: accounts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.accounts_id_seq', 66, true);


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

SELECT pg_catalog.setval('public.preferences_id_seq', 63, true);


--
-- Name: profiles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.profiles_id_seq', 66, true);


--
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.roles_id_seq', 2, true);


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

--
-- PostgreSQL database dump
--

-- Dumped from database version 15.13 (Debian 15.13-1.pgdg120+1)
-- Dumped by pg_dump version 17.5 (Ubuntu 17.5-1.pgdg22.04+1)

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
    "planeId" integer
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
    "partId" integer
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
    "areaId" integer
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
    name character varying NOT NULL
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
3	2025-07-24 12:25:37.601769	2025-07-24 12:25:37.601769	\N	DAPPLE01	$2b$10$WxCn6x3nMVkqlDdVsQosgu6tl1TkgamcuVViqHb5YxmLCckA6VJau	0	VERIFIED	\N	\N	\N	1	3	\N
4	2025-07-24 12:25:37.676	2025-07-24 12:25:37.676	\N	SARDOU01	$2b$10$YYLkZeWJFwnT4vSHRipEpu/LDCZsKKtqMd3Z5KYfoOLkwZ/0chc0K	0	VERIFIED	\N	\N	\N	1	4	\N
5	2025-07-24 12:25:37.73508	2025-07-24 12:25:37.73508	\N	FGAYE01	$2b$10$rEu9Jx/RZs0E/U/VSJ8CKeGtgW/fjw2USnL4.eBoX6rK8i.IvJYui	0	VERIFIED	\N	\N	\N	1	5	\N
6	2025-07-24 12:25:37.808784	2025-07-24 12:25:37.808784	\N	RBACHE01	$2b$10$CfaMz9pz5v2Vk4noWxI5bOerFWUt2QnrmEpj1Sz4.WVBX12PS.UBy	0	VERIFIED	\N	\N	\N	1	6	\N
7	2025-07-24 12:25:37.872688	2025-07-24 12:25:37.872688	\N	ANOUVE01	$2b$10$HRbDIjUu/smCBhiBHYkkUOaj/shoO.bjb2kcfiZQFIsINLaZxGBTy	0	VERIFIED	\N	\N	\N	1	7	\N
8	2025-07-24 12:25:37.950202	2025-07-24 12:25:37.950202	\N	EDUFOU02	$2b$10$upVlvKTd4cOIO0h.QPamoeJXx.FE5FQ0CKQVVLCVqKk45cR4Q3mlG	0	VERIFIED	\N	\N	\N	1	8	\N
9	2025-07-24 12:25:38.019576	2025-07-24 12:25:38.019576	\N	CBRANA01	$2b$10$CGLZHHM8goq9akY8HUqqS.FhWvWA8ZUBEN4TAaF3wJsoZSvYYgvei	0	VERIFIED	\N	\N	\N	1	9	\N
10	2025-07-24 12:25:38.079166	2025-07-24 12:25:38.079166	\N	CBROZI01	$2b$10$hXmP8/IoOiz2iQXs4yaK5e5vf47YiWRxB1eA71gjpitdrJMT3eYxW	0	VERIFIED	\N	\N	\N	1	10	\N
11	2025-07-24 12:25:38.14609	2025-07-24 12:25:38.14609	\N	JFEDIN01	$2b$10$J8YaHsjbXfk919MzPr2Jg.qWl/2PCkYwpw1onZhFZB9lzlXF5Tp5W	0	VERIFIED	\N	\N	\N	1	11	\N
12	2025-07-24 12:25:38.218694	2025-07-24 12:25:38.218694	\N	DDIKEN01	$2b$10$nBwQ5hDHx9brtYmrNIU2ouji.Voc5mpUy1T1Cl0a1hzxYe0GqWlHG	0	VERIFIED	\N	\N	\N	1	12	\N
13	2025-07-24 12:25:38.286307	2025-07-24 12:25:38.286307	\N	MCANO01	$2b$10$B98QjjrBUaP.5BIkld.4B.eIm2w5bHlqfy/xlwGkC/pBY0GpLCIIG	0	VERIFIED	\N	\N	\N	1	13	\N
14	2025-07-24 12:25:38.349032	2025-07-24 12:25:38.349032	\N	KPALEN01	$2b$10$Wl6Zp2.cxQDLkFwLGN/s1.DUyk2MPMGBNTh4GYQbDtPZrq/sXw.Xu	0	VERIFIED	\N	\N	\N	1	14	\N
15	2025-07-24 12:25:38.411415	2025-07-24 12:25:38.411415	\N	JHARPE02	$2b$10$JyNATM5XOV7268AK5VGdZON.77VXd5z/VBFiO1gPICbMPXsf8ivs.	0	VERIFIED	\N	\N	\N	1	15	\N
16	2025-07-24 12:25:38.473051	2025-07-24 12:25:38.473051	\N	LWEBER01	$2b$10$h5a0/DcVwzgAOhwDzFXLYuL9D4gcUAWBt4wmAywkoD.vSz8wo3D86	0	VERIFIED	\N	\N	\N	1	16	\N
17	2025-07-24 12:25:38.538312	2025-07-24 12:25:38.538312	\N	BBECKE04	$2b$10$PRTEMIgyeheZtUOvHl.M0uzRyPBOp4N9Rj0.6eRQsBBO0z5iR5LwO	0	VERIFIED	\N	\N	\N	1	17	\N
18	2025-07-24 12:25:38.597497	2025-07-24 12:25:38.597497	\N	NAUBER01	$2b$10$Gx8UK7g0DzIlum1Wq8hZz.4AHn1j/nCYYqXdy/WZM3cTCyXaoKfXS	0	VERIFIED	\N	\N	\N	1	18	\N
19	2025-07-24 12:25:38.655358	2025-07-24 12:25:38.655358	\N	JFRAIS01	$2b$10$5TJIBPn0XYkFjK94PyvNdeLakaSqS2CfduR7xKqsgObif3wQarlIe	0	VERIFIED	\N	\N	\N	1	19	\N
20	2025-07-24 12:25:38.714022	2025-07-24 12:25:38.714022	\N	GAPOLL01	$2b$10$Iw5mBsPJIN1NZlU1NseTHOrroBYuhjlkK7k8DFgMxFtGgAHK17T3y	0	VERIFIED	\N	\N	\N	1	20	\N
21	2025-07-24 12:25:38.783723	2025-07-24 12:25:38.783723	\N	BASHE01	$2b$10$qMjNIftyTQUj2bsaEJepcuyrJxJZbEIZZ3naLO86EyqRQMYzsinT6	0	VERIFIED	\N	\N	\N	1	21	\N
22	2025-07-24 12:25:38.857672	2025-07-24 12:25:38.857672	\N	DBAILE03	$2b$10$4IJ8ibZSrXl5qnn05V3TquKiBIyLXV142zUB.H.P6QVGf5E.lWlS.	0	VERIFIED	\N	\N	\N	1	22	\N
23	2025-07-24 12:25:38.931255	2025-07-24 12:25:38.931255	\N	TCARLI01	$2b$10$aG4C3WIs.obWYCf0WpY0hexbYK25KWqi2jRCHMlD6B7ivCRpMuoZm	0	VERIFIED	\N	\N	\N	1	23	\N
24	2025-07-24 12:25:39.001741	2025-07-24 12:25:39.001741	\N	NCHEN01	$2b$10$yJwzA0ydniVJ8oMIxdUqOeBto1awmq476UaUqNgV6yoNwVwl3xx92	0	VERIFIED	\N	\N	\N	1	24	\N
25	2025-07-24 12:25:39.065252	2025-07-24 12:25:39.065252	\N	RCLOAT01	$2b$10$rHEbRZ7P8tMiztWqJtWgzuYBrWtHNyLds1ObXCN.93Woq3EgVRrEO	0	VERIFIED	\N	\N	\N	1	25	\N
26	2025-07-24 12:25:39.12571	2025-07-24 12:25:39.12571	\N	LFEREL01	$2b$10$2Z7j1aa8d503pNUTgIp80umr6jp8qL12EvZhrDGrXkafVCP6OlTvi	0	VERIFIED	\N	\N	\N	1	26	\N
27	2025-07-24 12:25:39.18129	2025-07-24 12:25:39.18129	\N	GTOLED01	$2b$10$tn4ugVhNpHJsJWnLpPnrBeKO/12ee58k1pliemyIoYCfSfDMC1Ch.	0	VERIFIED	\N	\N	\N	1	27	\N
28	2025-07-24 12:25:39.241408	2025-07-24 12:25:39.241408	\N	PDELES01	$2b$10$7pHYaTg9Mqo68xcwRUszP.sOcvhF7WUbgn/vzDa2PpjYQ/mxN8yYC	0	VERIFIED	\N	\N	\N	1	28	\N
29	2025-07-24 12:25:39.297165	2025-07-24 12:25:39.297165	\N	JDESMA01	$2b$10$d1fWjXgXaRcpJg7sg0D5wuhpxwlu2frO2AnCF3MNi79r.S111OQoW	0	VERIFIED	\N	\N	\N	1	29	\N
30	2025-07-24 12:25:39.354521	2025-07-24 12:25:39.354521	\N	YDESVI01	$2b$10$69.fjMz3HmdyNxvfk0.7G.gXMepSpVI/GUnVpPr0k19twDemd4cOW	0	VERIFIED	\N	\N	\N	1	30	\N
31	2025-07-24 12:25:39.42027	2025-07-24 12:25:39.42027	\N	JDETUR01	$2b$10$JjZBKvVkHUxn/8UoukhRn.pQI3sKUPfAdr4toAJ6UCKu6JkPQkvQu	0	VERIFIED	\N	\N	\N	1	31	\N
32	2025-07-24 12:25:39.487953	2025-07-24 12:25:39.487953	\N	ALISSO01	$2b$10$uVYXOCD1r4pQRMT7q20jIOWT0nrkJo9ntNIO0sZ9IBFLX0pLTgt6q	0	VERIFIED	\N	\N	\N	1	32	\N
33	2025-07-24 12:25:39.557199	2025-07-24 12:25:39.557199	\N	JDEVRI01	$2b$10$W.DBmjLkwoGwCip8QkDxo.i0EzacddyWKx6x3zH1o1nI/dWXBRpHi	0	VERIFIED	\N	\N	\N	1	33	\N
34	2025-07-24 12:25:39.629081	2025-07-24 12:25:39.629081	\N	EETIEN01	$2b$10$x2NV1MmXEwZ9yTCG8OBQ8OzxPdFrmkZ9wwxJwy9YKwEPruzexjWHC	0	VERIFIED	\N	\N	\N	1	34	\N
35	2025-07-24 12:25:39.693085	2025-07-24 12:25:39.693085	\N	IFAIN01	$2b$10$TQ.J8raRZsE8vwjmj7LUVeKo/gxkL1e9P8Ns1gNmBeJaSI3VOHxGa	0	VERIFIED	\N	\N	\N	1	35	\N
36	2025-07-24 12:25:39.751444	2025-07-24 12:25:39.751444	\N	PFLORE01	$2b$10$H3k1qFO2n93EefNoCIfr8ORVF7mIZKVdQ3Kr54l8tw6XAYCDYEOaW	0	VERIFIED	\N	\N	\N	1	36	\N
37	2025-07-24 12:25:39.81638	2025-07-24 12:25:39.81638	\N	RFRIED01	$2b$10$wQP0tU7fD13Wk3CNmu/pve5iCuXrAM10ZZloU1KbREEfhifFyg2P.	0	VERIFIED	\N	\N	\N	1	37	\N
38	2025-07-24 12:25:39.879752	2025-07-24 12:25:39.879752	\N	JGAUTH01	$2b$10$NcDMYyisH0R/dzseW6NSMOidEQLoiwrJ2WfhV8J60rX6sI/28XQei	0	VERIFIED	\N	\N	\N	1	38	\N
39	2025-07-24 12:25:39.943319	2025-07-24 12:25:39.943319	\N	GGAUTI01	$2b$10$9x22lZpI4rg9zlawmymf7OAs9fktQpp1mpPlydrLmviQoVWrDZ6Ey	0	VERIFIED	\N	\N	\N	1	39	\N
40	2025-07-24 12:25:40.009986	2025-07-24 12:25:40.009986	\N	RLEMIR01	$2b$10$wpJYagNLt1DxhZUz4JeG.ewv0p9kR9z8eNURNmZR5Zm6tAIAIdxpy	0	VERIFIED	\N	\N	\N	1	40	\N
41	2025-07-24 12:25:40.070576	2025-07-24 12:25:40.070576	\N	MGREEN01	$2b$10$eMTtEa8io36sD/V9Q6av2OPfVVbV6ATV7rOMffLXtJ.POKEszqkxS	0	VERIFIED	\N	\N	\N	1	41	\N
42	2025-07-24 12:25:40.137816	2025-07-24 12:25:40.137816	\N	AGOULA01	$2b$10$f5P6r4RbSNGxDrJXV6rRaujnw..O2ktNdx.WO5Ij7wPrGBGqS2RbC	0	VERIFIED	\N	\N	\N	1	42	\N
43	2025-07-24 12:25:40.20722	2025-07-24 12:25:40.20722	\N	THETIE01	$2b$10$OnN2SGD1nDh5W0/hM6WCtOHQkqfomYgbabxTxPeUtev/C69QetU4q	0	VERIFIED	\N	\N	\N	1	43	\N
44	2025-07-24 12:25:40.282115	2025-07-24 12:25:40.282115	\N	JJACOB01	$2b$10$SNlEZ/js/LJAxyRgHFSPCerhJYfGTsZP2RALSUCCX9uy1HyGV1a7y	0	VERIFIED	\N	\N	\N	1	44	\N
45	2025-07-24 12:25:40.349395	2025-07-24 12:25:40.349395	\N	FLEBAS01	$2b$10$QCImW3E1dXQdwj7qG8decejvQayEzNHJ9xLHFt3wj3LippLxUbtkO	0	VERIFIED	\N	\N	\N	1	45	\N
46	2025-07-24 12:25:40.424373	2025-07-24 12:25:40.424373	\N	DLECUL02	$2b$10$/ak7vzEqG1vjB8qp7JHAi.OzK9XgOUrSnixhuP/GuOSdK9/RUX1iW	0	VERIFIED	\N	\N	\N	1	46	\N
47	2025-07-24 12:25:40.49759	2025-07-24 12:25:40.49759	\N	NMARTI01	$2b$10$qIqRLpmAkhMvH0bV7Xo4iebvslxve/pNT4P2WeCiNEW/iV/PM7J1q	0	VERIFIED	\N	\N	\N	1	47	\N
48	2025-07-24 12:25:40.562594	2025-07-24 12:25:40.562594	\N	NMONCA01	$2b$10$SbGGnPcJR70oouV0ImqjLuUczkt.6FZILor2md3nT39oHTSMucjgi	0	VERIFIED	\N	\N	\N	1	48	\N
49	2025-07-24 12:25:40.629322	2025-07-24 12:25:40.629322	\N	RPESOA01	$2b$10$IPgP4UNFEwcEvtknL4rkZe0e2ofA.Pzo6fw9GHIt/smYzF9UpGjhC	0	VERIFIED	\N	\N	\N	1	49	\N
50	2025-07-24 12:25:40.702812	2025-07-24 12:25:40.702812	\N	XPONS01	$2b$10$Innpox4x3/Y7L6l6QCpQA.e6xFO45napVJqYzQbxHhAAAHfvOmx6e	0	VERIFIED	\N	\N	\N	1	50	\N
51	2025-07-24 12:25:40.77777	2025-07-24 12:25:40.77777	\N	DRAYNA01	$2b$10$w0x1k22Pdl3ILrakdwtWBuQGkf1/p8qEm.2uUWWOZuhYweK5./F7a	0	VERIFIED	\N	\N	\N	1	51	\N
52	2025-07-24 12:25:40.85302	2025-07-24 12:25:40.85302	\N	RREAVI01	$2b$10$F8M.juAmong4f5HQICN82.S7fl6m4ELLSYTIBP5CCnkDf8V6CjgMq	0	VERIFIED	\N	\N	\N	1	52	\N
53	2025-07-24 12:25:40.928462	2025-07-24 12:25:40.928462	\N	TROHAU01	$2b$10$4HBX3432KUdF5Pk/CxZggeniiTcBYDeSLYRUasYEfcpynq/6JyjS.	0	VERIFIED	\N	\N	\N	1	53	\N
54	2025-07-24 12:25:41.005248	2025-07-24 12:25:41.005248	\N	ESENAR01	$2b$10$LQTqusz6Vx7i5Yy0TlMDEOsnlrkFDeFL5SwDGjrU0OKd3t2w3HCt6	0	VERIFIED	\N	\N	\N	1	54	\N
55	2025-07-24 12:25:41.076617	2025-07-24 12:25:41.076617	\N	FVENTU01	$2b$10$aiKC7a2xjUNkjgeFwjEWR.jaH/RVRUiKws/vUyMjbcRjpC14.lXi2	0	VERIFIED	\N	\N	\N	1	55	\N
56	2025-07-24 12:25:41.152117	2025-07-24 12:25:41.152117	\N	IVITTE01	$2b$10$n1LfscVV6y6hbGin5oePyOmK7pi3.3tC400y12QqoHlskyXUWWvd.	0	VERIFIED	\N	\N	\N	1	56	\N
57	2025-07-24 12:25:41.227528	2025-07-24 12:25:41.227528	\N	CWININ01	$2b$10$Xy/xWGmEYLbkWfMJwYTLyOsNVUTfZfGUqsw5PoKL8haC3U9EHv0mS	0	VERIFIED	\N	\N	\N	1	57	\N
58	2025-07-24 12:25:41.28471	2025-07-24 12:25:41.28471	\N	JTAYLO06	$2b$10$rvq1E0QBVTkZwHtzXoJWLumCw0o5DE7DcNeh33Vlxi5VhX6QLlibS	0	VERIFIED	\N	\N	\N	1	58	\N
59	2025-07-24 12:25:41.338536	2025-07-24 12:25:41.338536	\N	VHUBER01	$2b$10$2I/g45R4ghmVr/vz5ouNruehzTjy6nnM882s6j9zdVJkEJZprun52	0	VERIFIED	\N	\N	\N	1	59	\N
60	2025-07-24 12:25:41.393345	2025-07-24 12:25:41.393345	\N	ACOCAT01	$2b$10$NZXSWcrFnd.HicU9ScAikeLbxiI2TYcqp49QxbYBZMp5JHw6UEw9e	0	VERIFIED	\N	\N	\N	1	60	\N
61	2025-07-24 12:25:41.457356	2025-07-24 12:25:41.457356	\N	FHOUSS01	$2b$10$Hbk45TYFASlDSAfz5ADEsO0Jnm0uLhMOlChS87A3LUg2r2dBwc1eq	0	VERIFIED	\N	\N	\N	1	61	\N
65	2025-07-24 12:25:41.6619	2025-07-24 12:25:41.6619	\N	VLIMIT01	$2b$10$bWMzPfye8iUd4CwePUqZg.LUEYNnqq.PnSwPRaxDw/iLW3rDy7R3i	0	VERIFIED	\N	\N	\N	1	65	\N
62	2025-07-24 12:25:41.515334	2025-07-24 12:25:41.515334	\N	MDUPIN01	$2b$10$2UNnOa/MimwbTEQfxaW2Beuo9xuhdAvqpNDurAoq.xa4kuEiKJ7XW	0	VERIFIED	\N	\N	\N	1	62	\N
63	2025-07-24 12:25:41.562245	2025-07-24 12:25:41.562245	\N	AJIMEN02	$2b$10$1daGcfDZnpG6pCTPg4s4ae9p2iw9LQpJP4fv2cKw2k8EVMLJTUbSm	0	VERIFIED	\N	\N	\N	1	63	\N
64	2025-07-24 12:25:41.610338	2025-07-24 12:25:41.610338	\N	SETCHE01	$2b$10$vcqNGEYGLF4uRdQNtxCKZuAIDG65WmCssfdctwbkF/6W/hzUcx2Rm	0	VERIFIED	\N	\N	\N	1	64	\N
66	2025-07-24 12:45:30.194666	2025-07-24 13:58:17.912523	coralie.bordenave@dassault-aviation.com	CBORD	$2b$10$4XPNnMMrLPFxd4k8tdKg4urfjw2OfWiy.zuaygqfEPJ1DseUZ9lOW	0	VERIFIED	\N	\N	\N	1	66	\N
\.


--
-- Data for Name: areas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.areas (id, "createdAt", "updatedAt", title, image, "planeId") FROM stdin;
1	2025-07-24 09:34:45.796001	2025-07-24 09:34:45.796001	Entryway	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_08_CHAPITRE_2024-12-05.jpg	1
2	2025-07-24 09:34:45.829801	2025-07-24 09:34:45.829801	Cabin	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_04_CHAPITRE_2024-12-05.jpg	1
3	2025-07-24 09:34:45.848395	2025-07-24 09:34:45.848395	Aft Lavatory	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_02_CHAPITRE_2024-12-05.jpg	1
4	2025-07-24 09:35:09.516505	2025-07-24 09:35:09.516505	Forward Closet Finishing	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/HQ_CamChap_01_EntryWay_L4960H3507.jpg	2
5	2025-07-24 09:35:09.529634	2025-07-24 09:35:09.529634	Crew Rest Finishing	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/LQ_CamChap_01_CrewRest_L4960H3507.jpg	2
6	2025-07-24 09:35:09.539958	2025-07-24 09:35:09.539958	Forward Lavatory Finishing	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/HQ_CamChap_01_EntryWayFWDLav_L4960H3507.jpg	2
7	2025-07-24 09:35:09.550896	2025-07-24 09:35:09.550896	Galley Finishing	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/HQ_CamChap_01_EntryWay_L4960H3507.jpg	2
8	2025-07-24 09:35:09.566418	2025-07-24 09:35:09.566418	Club Lounge	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/HQ_CamChap_03_Lounge01ClubView_L4960H3507-01.jpg	2
9	2025-07-24 09:35:09.575052	2025-07-24 09:35:09.575052	Dining	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/HQ_CamChap_04_Lounge02Dining_L4960H3507.jpg	2
10	2025-07-24 09:35:09.58458	2025-07-24 09:35:09.58458	Meridian & Divan	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/HQ_CamChap_05_Lounge03Divan_L4960H3507co.jpg	2
11	2025-07-24 09:35:09.599422	2025-07-24 09:35:09.599422	Bedroom	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/HQ_CamCHAP_08_BedView_L4960H3507co.jpg	2
12	2025-07-24 09:35:09.611081	2025-07-24 09:35:09.611081	Falcon Privacy Suite Finishing	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/LQ_CamChap_06_Lounge04FPS02_L4960H3507co.jpg	2
13	2025-07-24 09:35:09.612966	2025-07-24 09:35:09.612966	Shower	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/LQ_CamCHAP_09_AftLavat_L4960H3507co.jpg	2
14	2025-07-24 09:35:09.630959	2025-07-24 09:35:09.630959	Bulkheads	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/LQ_CamCHAP_05b_ViewLH-Lounge1_LH-Club_L4960H3507.jpg	2
15	2025-07-24 09:35:09.647992	2025-07-24 09:35:09.647992	Classic Bathroom	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/HQ_CamChap_07_AftVanity01_L4960H3507.jpg	2
16	2025-07-24 09:35:09.665389	2025-07-24 09:35:09.665389	ENTRYWAY	https://api.dassaultfalcon.com/lacollection-smtp/photos/areas/HQ_CamChap_01_EntryWay_L4960H3507.jpg	2
17	2025-07-24 09:35:09.666386	2025-07-24 09:35:09.666386	MAIN CABIN	https://api.dassaultfalcon.com/lacollection-smtp/photos/areas/LQ_CamChap_02_CabinView_L4960H3507.jpg	2
18	2025-07-24 09:35:09.667375	2025-07-24 09:35:09.667375	AFT LAVATORY 	https://api.dassaultfalcon.com/lacollection-smtp/photos/areas/LQ_CamCHAP_09_AftLavat_L4960H3507.jpg	2
19	2025-07-24 09:35:09.668265	2025-07-24 09:35:09.668265	MAIN CABIN BULKHEAD 	https://api.dassaultfalcon.com/lacollection-smtp/photos/areas/LQ_CamCHAP_05b_ViewLH-Lounge1_LH-Club_L4960H3507.jpg	2
20	2025-07-24 09:35:25.806383	2025-07-24 09:35:25.806383	Galley bar 	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/HQ_Chapter1_EntryWay_L4960H35078bd.jpg	3
21	2025-07-24 09:35:25.827505	2025-07-24 09:35:25.827505	Forward lavatory	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/HQ_Chapter1_FwdLav_L4960H3507bd.jpg	3
22	2025-07-24 09:35:25.835114	2025-07-24 09:35:25.835114	Forward lounge	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/HQ_Chapter2_MainCabin_L4960H3507BD.jpg	3
23	2025-07-24 09:35:25.846268	2025-07-24 09:35:25.846268	Middle lounge	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/HQ_Chapter2-B_MiddleLounge_L4960H3507BD.jpg	3
24	2025-07-24 09:35:25.858793	2025-07-24 09:35:25.858793	Aft lounge	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/HQ_Chapter2-C_AftLounge_L4960H3507BD.jpg	3
25	2025-07-24 09:35:25.866939	2025-07-24 09:35:25.866939	Aft lavatory	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/HQ_Chapter3_AftLavatory_L3507H4960BD.jpg	3
26	2025-07-24 09:35:37.365093	2025-07-24 09:35:37.365093	entryway	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/F6X_SNxxx_DN_Sch01_HQ_View_EntryWay2_2023-01-05.jpg	4
27	2025-07-24 09:35:37.388219	2025-07-24 09:35:37.388219	forward lounge	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/HQ_View_CabinClub_L4960H3507_Night.jpg	4
28	2025-07-24 09:35:37.39962	2025-07-24 09:35:37.39962	middle lounge	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/HQ_View_CabinFWD_L4960H3507.jpg	4
29	2025-07-24 09:35:37.419301	2025-07-24 09:35:37.419301	aft lounge	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/F6X_SNxxx_DN_Sch01_HQ_View_DivanAFTView_2023-01-05_Coralie.jpg	4
30	2025-07-24 09:35:37.425154	2025-07-24 09:35:37.425154	aft lavatory	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/F6X_SNxxx_DN_Sch01_HQ_View_AftLavatory_2023-01-05_CORALIE.jpg	4
\.


--
-- Data for Name: options; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.options (id, "createdAt", "updatedAt", name, image, serial, weight, price, palette, type, "partId") FROM stdin;
1	2025-07-24 09:34:45.801322	2025-07-24 09:34:45.801322	Stainless Steel	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_13_TECH_2024-12-05.jpg	6.210.1	In Package	In Package		Essentials	1
2	2025-07-24 09:34:45.803845	2025-07-24 09:34:45.803845	Glaskote	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/F2L_SNxxx_DN_Scheme01_HQ_13_TECH_2024-12-05.jpg	6.210.12	0	7800	assets/images/palettes/Glaskote.png	Essentials	1
3	2025-07-24 09:34:45.807732	2025-07-24 09:34:45.807732	Solid Surface	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/F2L_SNxxx_DN_Scheme01_LQ_09_TECH_2024-12-05A.jpg	6.210.2a	0	In Package	assets/images/palettes/SolidSurface.png	Essentials	2
4	2025-07-24 09:34:45.809533	2025-07-24 09:34:45.809533	Stone	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/F2L_SNxxx_DN_Scheme01_LQ_09_TECH_2024-12-05.jpg	6.210.2	Standard	39200	assets/images/palettes/Stone.png	AvantGarde	2
5	2025-07-24 09:34:45.817593	2025-07-24 09:34:45.817593	Metal plated	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_12_TECH_2024-12-05.jpg	6.210.9a	0	In Package	assets/images/palettes/Stone.png	Essentials	3
6	2025-07-24 09:34:45.820013	2025-07-24 09:34:45.820013	Wood veneer	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_12_TECH_2024-12-05.jpg	6.210.9	Standard	No charge	assets/images/palettes/Wood.png	Essentials	3
7	2025-07-24 09:34:45.822857	2025-07-24 09:34:45.822857	Stainless steel	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_25_TECH_2024-12-05.jpg	6.500.10	In Package	In Package		Essentials	4
8	2025-07-24 09:34:45.824147	2025-07-24 09:34:45.824147	Glasskote	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_25_CHAPITRE_2024-12-05.jpg	6.500.1b	0.1	8700	assets/images/palettes/Glaskote.png	Essentials	4
9	2025-07-24 09:34:45.826992	2025-07-24 09:34:45.826992	Carpet	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_10_TECH_2024-12-05.jpg	6.500.0b	In Package	In Package	Carpet.png	Essentials	5
10	2025-07-24 09:34:45.828386	2025-07-24 09:34:45.828386	Vinyl	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_10_TECH_2024-12-05.jpg	6.500.2	10.6	10500	assets/images/palettes/Vinyl.png	Essentials	5
11	2025-07-24 09:34:45.832869	2025-07-24 09:34:45.832869	Wood veneer	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_05_CHAPITRE_2024-12-05.jpg	6.200.20	In Package	In Package	assets/images/palettes/Wood.png	Essentials	6
12	2025-07-24 09:34:45.835242	2025-07-24 09:34:45.835242	Wood vener	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_06_CHAPITRE_2024-12-05.jpg	6.200.30	In Package	In Package	assets/images/palettes/Wood.png	Essentials	7
13	2025-07-24 09:34:45.838108	2025-07-24 09:34:45.838108	Two (2), 1/8-Inch Metal Trim Strips and Vertical Join Seam below Tables	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_16_TECH_2024-12-05.jpg	6.300.5	In Package	In Package		Essentials	8
14	2025-07-24 09:34:45.839511	2025-07-24 09:34:45.839511	One (1), 1/8-Inch Metal Trim Strip and Vertical Join Seam below Tables	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_16_TECH_2024-12-05.jpg	6.300.5d	0.5	No charge		Essentials	8
15	2025-07-24 09:34:45.840847	2025-07-24 09:34:45.840847	Upholstery	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_19_TECH_2024-12-05.jpg	6.300.41	In Package	In Package		Essentials	8
16	2025-07-24 09:34:45.843697	2025-07-24 09:34:45.843697	Wood veneer	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_11_TECH_2024-12-05.jpg	6.300.7	In Package	In Package	assets/images/palettes/Wood.png	Essentials	9
17	2025-07-24 09:34:45.845255	2025-07-24 09:34:45.845255	One (1), 1/8-Inch Metal Trim Strip and Vertical Join Seam below Tables	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_14B_TECH_2024-12-05.jpg	6.400.1	0	In Package		Essentials	9
18	2025-07-24 09:34:45.846178	2025-07-24 09:34:45.846178	Wood Veneer with Door in Mirror	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_14_TECH_2024-12-05.jpg	6.400.1b	0	No charge		Essentials	9
19	2025-07-24 09:34:45.847265	2025-07-24 09:34:45.847265	Wood Veneer with Leather/Ultraleather insert	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_14_TECH_2024-12-05.jpg	6.400.1g	0.1	10100		AvantGarde	9
20	2025-07-24 09:34:45.852064	2025-07-24 09:34:45.852064	Glaskote	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_24_TECH_2024-12-05.jpg	6.210.12b	In Package	In Package	assets/images/palettes/Glaskote.png	Essentials	10
21	2025-07-24 09:34:45.854337	2025-07-24 09:34:45.854337	Solid Surface	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_21_TECH_2024-12-05.jpg	6.210.3a	In Package	In Package	assets/images/palettes/SolidSurface.png	Essentials	11
22	2025-07-24 09:34:45.855069	2025-07-24 09:34:45.855069	Stone	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_22_TECH_2024-12-05.jpg	6.210.3	1.6	21400	assets/images/palettes/Stone.png	AvantGarde	11
23	2025-07-24 09:34:45.856457	2025-07-24 09:34:45.856457	Carpet	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_23_TECH_2024-12-05.jpg	6.500.0a	In Package	In Package	assets/images/palettes/Carpet.png	Essentials	12
24	2025-07-24 09:34:45.857167	2025-07-24 09:34:45.857167	Vinyl	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_23_TECH_2024-12-05.jpg	6.500.2a	7.9	8000	assets/images/palettes/Vinyl.png	Essentials	12
25	2025-07-24 09:34:45.859294	2025-07-24 09:34:45.859294	Soft good	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_21_TECH_2024-12-05.jpg	6.400.2	In Package	In Package	assets/images/palettes/Wood.png	Essentials	13
26	2025-07-24 09:34:45.860606	2025-07-24 09:34:45.860606	Soft good	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_20_TECH_2024-12-05_V2.jpg	6.410.2	In Package	In Package	assets/images/palettes/Ultraleather.png	Essentials	13
27	2025-07-24 09:35:09.521262	2025-07-24 09:35:09.521262	Forward Entryway Closet Finishing: Wood Veneer /Paint with Wood Veneer/ Paint Door	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_01_EntryWCloset_L3507H4960_0036.jpg	6.240.10	In Package	In Package		Essentials	14
28	2025-07-24 09:35:09.523367	2025-07-24 09:35:09.523367	Forward Entryway Closet Finishing: Aft Side, Wood Veneer/ Paint	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_01_EntryWEntry_L3507H4960_0038.jpg	6.240.20	In Package	In Package		Essentials	14
29	2025-07-24 09:35:09.52523	2025-07-24 09:35:09.52523	Forward Entryway Closet Finishing: Wood Veneer /Paint with Mirror Door	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_01_EntryWCloset_L3507H4960_0035.jpg	6.240.11	1.4	Upgrade ($)		AvantGarde	14
30	2025-07-24 09:35:09.526752	2025-07-24 09:35:09.526752	Forward Entryway Closet Finishing: Aft Side, Wall Covering		6.240.21	-2.2	Upgrade ($)	assets/images/palettes/DecoFilm.png	AvantGarde	14
31	2025-07-24 09:35:09.532351	2025-07-24 09:35:09.532351	Crew Rest Forward Bulkhead Finishing: Forward Side, Wood Veneer / Paint	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_01_EntryWEntry_L3507H4960_0038.jpg	6.230.10	In Package	In Package		Essentials	16
32	2025-07-24 09:35:09.533796	2025-07-24 09:35:09.533796	Crew Rest Sliding Panel Finishing: Aft Face, Quilting	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_02_CrewRPanel_L3507H4960_0041.jpg	6.230.20	In Package	In Package		Essentials	16
33	2025-07-24 09:35:09.5354	2025-07-24 09:35:09.5354	Crew Rest Forward Bulkhead Finishing: Forward Side, Wall Covering	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_01_EntryWEntry_L3507H4960_0037.jpg	6.230.11	-2,2	Upgrade ($)	assets/images/palettes/DecoFilm.png	AvantGarde	16
34	2025-07-24 09:35:09.536683	2025-07-24 09:35:09.536683	Crew Rest Sliding Panel Finishing: Aft Face, Upholstery/Leather with Recess	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_02_CrewRPanel_L3507H4960_0040.jpg	6.230.21	-0,9	Upgrade ($)	assets/images/palettes/Ultraleather.png	AvantGarde	16
35	2025-07-24 09:35:09.538096	2025-07-24 09:35:09.538096	Crew Rest Sliding Panel Finishing: Aft Face, Upholstery/Leather	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_02_CrewRPanel_L3507H4960_0040BIS.jpg	6.230.22	Upgrade (Lbs)	Upgrade ($)	assets/images/palettes/Ultraleather.png	AvantGarde	16
66	2025-07-24 09:35:09.607879	2025-07-24 09:35:09.607879	Top: Wood Veneer/ Paint	https://api.dassaultfalcon.com/lacollection-smtp/photos/parts/LQ_CamTECH_01_BedCredenza_L3507H4960_0045.jpg	6.300.31A	In Package	In Package	assets/images/palettes/Wood.png	Essentials	30
36	2025-07-24 09:35:09.542475	2025-07-24 09:35:09.542475	Forward Lavatory Aft Bulkhead Finishing:  Forward Face, Wood Veneer/ Paint	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamChap_01_EntryWay_L4960H3507BIS.jpg	6.220.10	In Package	In Package	assets/images/palettes/Wood.png	Essentials	17
37	2025-07-24 09:35:09.545416	2025-07-24 09:35:09.545416	Sink : Glaskote	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_01_FWDLavat_L3507H4960_0031.jpg	6.210.12A	In Package	In Package	assets/images/palettes/Glaskote.png	Essentials	18
38	2025-07-24 09:35:09.548321	2025-07-24 09:35:09.548321	Forward Lavatory Backsplash Finishing: Solid Surface	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_01_FWDLavat_L3507H4960_0031.jpg	6.210.5	In Package	In Package	assets/images/palettes/SolidSurface.png	Essentials	19
39	2025-07-24 09:35:09.549631	2025-07-24 09:35:09.549631	Forward Lavatory Backsplash Finishing: Granite/Marble/Quartz	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_01_FWDLavat_L3507H4960_0030.jpg	6.210.5a	2.2	Upgrade ($)	assets/images/palettes/Stone.png	AvantGarde	19
40	2025-07-24 09:35:09.555048	2025-07-24 09:35:09.555048	Sink : Glaskote	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_01_GalleyCountSink_L3507H4960.jpg	6.210.12	In Package	In Package	assets/images/palettes/Glaskote.png	Essentials	21
41	2025-07-24 09:35:09.557588	2025-07-24 09:35:09.557588	Solid Surface	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_01_GalleyCountTop_L3507H4960_0030.jpg	6.210.2A	In Package	In Package	assets/images/palettes/SolidSurface.png	Essentials	22
42	2025-07-24 09:35:09.558695	2025-07-24 09:35:09.558695	Granite/Marble/Quartz	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_01_GalleyCountTop_L3507H4960_0031.jpg	6.210.2	4,0	Upgrade ($)	assets/images/palettes/Stone.png	AvantGarde	22
43	2025-07-24 09:35:09.560849	2025-07-24 09:35:09.560849	Carpet	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_01_EntryWFloor_L3507H4960_0034.jpg	6.500.0B	In Package	In Package	assets/images/palettes/Carpet.png	Essentials	23
44	2025-07-24 09:35:09.561949	2025-07-24 09:35:09.561949	Vinyl	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_01_EntryWFloor_L3507H4960_0033.jpg	6.500.2	21.1	Upgrade ($)	assets/images/palettes/Vinyl.png	Essentials	23
45	2025-07-24 09:35:09.562869	2025-07-24 09:35:09.562869	threshold plate: Polished Aluminium	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_03_CabinThreslholdP_L3507H4960_0045.jpg	6.500.10	In Package	In Package	assets/images/palettes/Metal.png	Essentials	23
46	2025-07-24 09:35:09.563772	2025-07-24 09:35:09.563772	Flooring: Granite/Marble/Quartz	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_01_EntryWFloor_L3507H4960_0032.jpg	6.500.3B	59,8	Upgrade ($)	assets/images/palettes/Stone.png	AvantGarde	23
47	2025-07-24 09:35:09.564541	2025-07-24 09:35:09.564541	Flooring: Hard Wood 	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_01_EntryWFloorWood_L3507H4960_WOOD.jpg	6.500.4B	22	Upgrade ($)	assets/images/palettes/Wood.png	AvantGarde	23
48	2025-07-24 09:35:09.565637	2025-07-24 09:35:09.565637	Threshold plate: Glaskote	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_03_CabinThreslholdP_L3507H4960_0044.jpg	6.500.1B	0	Upgrade ($)	assets/images/palettes/Glaskote.png	AvantGarde	23
49	2025-07-24 09:35:09.567962	2025-07-24 09:35:09.567962	Console Table Finishing: Wood Veneer/ Paint with Wood Veneer/ Paint Edge	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_02_ClubConsoleTable_L3507H4960.jpg	6.200.20A	In Package	In Package	assets/images/palettes/Wood.png	Essentials	24
50	2025-07-24 09:35:09.570646	2025-07-24 09:35:09.570646	Service Ledge Finishing: Upholstery/Leather w/ Seams	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_02_ClubSideWallFront_L3507H4960.jpg	6.300.40A	In Package	In Package	assets/images/palettes/Ultraleather.png	Essentials	25
51	2025-07-24 09:35:09.572119	2025-07-24 09:35:09.572119	Top Surface: Wood Veneer/ Paint	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_02_ClubSideWallTop_L3507H4960.jpg	6.300.41A	In Package	In Package	assets/images/palettes/Wood.png	Essentials	25
52	2025-07-24 09:35:09.573389	2025-07-24 09:35:09.573389	Sideledge Open Storage Interior: Upholstery/Leather	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_02_ClubSideWallInsert_L3507H4960.jpg	6.300.43A	In Package	In Package	assets/images/palettes/Ultraleather.png	Essentials	25
53	2025-07-24 09:35:09.578003	2025-07-24 09:35:09.578003	Wood Veneer/ Paint with Wood Veneer/ Paint Edge	https://api.dassaultfalcon.com/lacollection-smtp/photos/parts/HQ_CamChap_04_Lounge02Diningtable_L4960H3507.jpg	6.200.30A	In Package	In Package	assets/images/palettes/Wood.png	Essentials	26
54	2025-07-24 09:35:09.580791	2025-07-24 09:35:09.580791	Facade: Upholstery/Leather with Top Stitch	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_02_MidCabFacade_L3507H4960.jpg	6.300.30a	In Package	In Package	assets/images/palettes/Ultraleather.png	Essentials	27
55	2025-07-24 09:35:09.582011	2025-07-24 09:35:09.582011	Top: Wood Veneer/Paint	https://api.dassaultfalcon.com/lacollection-smtp/photos/parts/LQ_CamTECH_01_BedCredenza_L3507H4960_0045.jpg	6.300.31a	In Package	In Package	assets/images/palettes/Wood.png	Essentials	27
56	2025-07-24 09:35:09.583229	2025-07-24 09:35:09.583229	Top: Granite/Marble/Quartz	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_01_BedCredenza_L3507H4960_0046.jpg	6.300.31b	15.4	Upgrade ($)	assets/images/palettes/Stone.png	AvantGarde	27
57	2025-07-24 09:35:09.587695	2025-07-24 09:35:09.587695	Divan Lower Facade: Upholstery/Leather	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_04_DivanLowerFacade_L3507H4960.jpg	6.260.10	In Package	In Package	assets/images/palettes/Ultraleather.png	Essentials	28
58	2025-07-24 09:35:09.589407	2025-07-24 09:35:09.589407	Divan Headrest: Upholstery/Leather	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_04_DivanHeadrest_L3507H4960.jpg	6.260.20	In Package	In Package	assets/images/palettes/Ultraleather.png	Essentials	28
59	2025-07-24 09:35:09.591173	2025-07-24 09:35:09.591173	Divan Cushion: Upholstery/Leather	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_04_DivanCushion_L3507H4960.jpg	6.260.30	In Package	In Package	assets/images/palettes/Upholstery.png	Essentials	28
60	2025-07-24 09:35:09.594071	2025-07-24 09:35:09.594071	Divan Backrest: Upholstery/Leather	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_04_DivanBackrest_L3507H4960.jpg	6.260.40	In Package	In Package	assets/images/palettes/Upholstery.png	Essentials	28
61	2025-07-24 09:35:09.595975	2025-07-24 09:35:09.595975	Divan Armrest: Upholstery/Leather	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_04_DivanArmrest_L3507H4960.jpg	6.260.50	In Package	In Package	assets/images/palettes/Upholstery.png	Essentials	28
62	2025-07-24 09:35:09.597732	2025-07-24 09:35:09.597732	Divan Side Storage Top Surface: Wood Veneer/Paint	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_04_DivanSideStorage_L3507H4960.jpg	6.260.60	In Package	In Package	assets/images/palettes/Paint.png	Essentials	28
63	2025-07-24 09:35:09.601362	2025-07-24 09:35:09.601362	Bed Header Exterior: Quilting	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_01_BedBedHeader_L3507H4960_0034.jpg	6.270.10B	In Package	In Package	assets/images/palettes/QuiltedLeather.png	Essentials	29
64	2025-07-24 09:35:09.602686	2025-07-24 09:35:09.602686	Bed Header Exterior: Upholstery	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_01_BedBedHeader_L3507H4960_0035.jpg	6.270.11b	-0.7	Upgrade ($)	assets/images/palettes/Upholstery.png	AvantGarde	29
65	2025-07-24 09:35:09.606346	2025-07-24 09:35:09.606346	Facade: Upholstery/Leather w/ Top Stitc	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_02_MidCabFacade_L3507H4960.jpg	6.300.30A	In Package	In Package		Essentials	30
67	2025-07-24 09:35:09.609738	2025-07-24 09:35:09.609738	Multi-Purpose Storage Cabinet Top: Granite/Marble/Quartz	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_01_BedCredenza_L3507H4960_0046.jpg	6.300.31B	15.4	Upgrade ($)	assets/images/palettes/Stone.png	AvantGarde	30
68	2025-07-24 09:35:09.614929	2025-07-24 09:35:09.614929	Sink : Glaskote	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_02_AftVanityBackSplash_L3507H4960_0043.jpg	6.210.12B	In Package	In Package	assets/images/palettes/Glaskote.png	Essentials	32
69	2025-07-24 09:35:09.619016	2025-07-24 09:35:09.619016	Backsplash: Solid Surface	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_02_AftVanityBackSplash_L3507H4960_0044.jpg	6.210.31A	In Floorplan	In Floorplan	assets/images/palettes/SolidSurface.png	Essentials	33
70	2025-07-24 09:35:09.621053	2025-07-24 09:35:09.621053	Backsplash: Granite/Marble/Quartz	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_02_AftVanityBackSplash_L3507H4960_0043.jpg	6.210.31	1.1	Upgrade ($)	assets/images/palettes/Stone.png	AvantGarde	33
71	2025-07-24 09:35:09.62549	2025-07-24 09:35:09.62549	Right-Hand Closet Door: Wood Veneer/Paint	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_02_AftToiletCloset_L3507H4960_0041.jpg	6.212.1R0	In Package	In Package	assets/images/palettes/Wood.png	Essentials	35
72	2025-07-24 09:35:09.626592	2025-07-24 09:35:09.626592	Right-Hand Closet Door: Leather Padding	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_02_AftToiletCloset_L3507H4960_0042.jpg	6.212.1R1	4,0	Upgrade ($)	assets/images/palettes/Ultraleather.png	AvantGarde	35
73	2025-07-24 09:35:09.628881	2025-07-24 09:35:09.628881	Right-Hand Countertop: Solid Surface	https://api.dassaultfalcon.com/lacollection-smtp/photos/parts/LQ_CamTECH_02_AftToiletTOP_L3507H4960_0037.jpg	6.210.30a	In Package	In Package	assets/images/palettes/SolidSurface.png	Essentials	36
74	2025-07-24 09:35:09.63005	2025-07-24 09:35:09.63005	Right-Hand Countertop: Granite/Marble/Quartz	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_02_AftToiletTOP_L3507H4960_0036.jpg	6.210.30	4.0	Upgrade ($)	assets/images/palettes/Stone.png	AvantGarde	36
75	2025-07-24 09:35:09.633096	2025-07-24 09:35:09.633096	Forward Main Cabin Bulkhead Finishing: Wood Veneer/Paint (Each, per side)	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_03_CabinGallDivider_L3507H4960_0043.jpg	6.300.10	In Package	In Package	assets/images/palettes/Wood.png	Essentials	37
76	2025-07-24 09:35:09.635352	2025-07-24 09:35:09.635352	Forward Main Cabin Bulkhead Finishing: Upholstery (Each, per side)	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_03_CabinGallDivider_L3507H4960_0042.jpg	6.300.11	-2.2	Upgrade ($)	assets/images/palettes/Ultraleather.png	AvantGarde	37
77	2025-07-24 09:35:09.637624	2025-07-24 09:35:09.637624	Main Cabin Divider Finishing: Wood Veneer/Paint (Each, per side)	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_04_CabinMIDDivider_L3507H4960_0050.jpg	6.300.20	In Package	In Package	assets/images/palettes/Wood.png	Essentials	38
78	2025-07-24 09:35:09.639036	2025-07-24 09:35:09.639036	Main Cabin Divider Finishing: Upholstery (Each, per side)	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_04_CabinMIDDivider_L3507H4960_0051.jpg	6.300.21	-2.2	Upgrade ($)	assets/images/palettes/Ultraleather.png	AvantGarde	38
79	2025-07-24 09:35:09.640755	2025-07-24 09:35:09.640755	Main Cabin Divider Finishing: Upholstery/Leather with Wood Veneer/Paint Framed Mirror (Each, per side)	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_04_CabinMIDDivider_L3507H4960_0048.jpg	6.300.22	0.7	Upgrade ($)		AvantGarde	38
80	2025-07-24 09:35:09.642387	2025-07-24 09:35:09.642387	Main Cabin Divider Finishing: Quilting with Leather/Upholstery Insert and Piping (Each, per side)	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_04_CabinMIDDivider_L3507H4960_0049.jpg	6.300.23	2.6	Upgrade ($)	assets/images/palettes/Upholstery.png	AvantGarde	38
81	2025-07-24 09:35:09.645374	2025-07-24 09:35:09.645374	Aft Main Cabin Bulkhead Finishing: Wood Veneer/ Paint (Each, per side)	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_01_BedAftDivider_L3507H4960_0033.jpg	6.300.30	In Package	In Package	assets/images/palettes/Wood.png	Essentials	39
82	2025-07-24 09:35:09.64634	2025-07-24 09:35:09.64634	Aft Main Cabin Bulkhead Finishing: Upholstery (Each, per side)	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_01_BedAftDivider_L3507H4960_0032.jpg	6.300.31	-2.2	Upgrade ($)	assets/images/palettes/Ultraleather.png	AvantGarde	39
83	2025-07-24 09:35:09.647169	2025-07-24 09:35:09.647169	Aft Main Cabin Bulkhead Finishing: Upholstery/Leather with Insert and Recess (Each, per side)	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_01_BedAftDivider_L3507H4960_0031.jpg	6.300.32	-0.9	Upgrade ($)	assets/images/palettes/Ultraleather.png	AvantGarde	39
84	2025-07-24 09:35:09.649962	2025-07-24 09:35:09.649962	Sink : Glaskote	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_05_AFtLavatSink_L3507H4960.jpg	6.210.12B	In Package	In Package	assets/images/palettes/Glaskote.png	Essentials	40
85	2025-07-24 09:35:09.654816	2025-07-24 09:35:09.654816	kkk	https://api.dassaultfalcon.com/lacollection-smtp/photos/parts/LQ_CamTECH_02_AftToiletFloor_L3507H4960_0039.jpg					Essentials	42
86	2025-07-24 09:35:09.655914	2025-07-24 09:35:09.655914	kkk	https://api.dassaultfalcon.com/lacollection-smtp/photos/parts/LQ_CamTECH_02_AftToiletFloor_L3507H4960_0039.jpg					Essentials	42
87	2025-07-24 09:35:09.658115	2025-07-24 09:35:09.658115	Left-Hand  Closet Door: Wood Veneer/ Paint	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_02_AftToiletCloset_L3507H4960_0041.jpg	6.212.1L0	In Package	In Package	assets/images/palettes/Wood.png	Essentials	43
88	2025-07-24 09:35:09.659132	2025-07-24 09:35:09.659132	Left-Hand Closet Door: Leather Padding	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_02_AftToiletCloset_L3507H4960_0042.jpg	6.212.1L1	4,0	Upgrade ($)	assets/images/palettes/Ultraleather.png	AvantGarde	43
89	2025-07-24 09:35:09.660949	2025-07-24 09:35:09.660949	Carpet	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_05_AFtLavatFloor_L3507H4960_0053.jpg	6.500.0A	In Package	In Package	assets/images/palettes/Carpet.png	Essentials	44
90	2025-07-24 09:35:09.661687	2025-07-24 09:35:09.661687	Vinyl	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_05_AFtLavatFloor_L3507H4960_0054.jpg	6.500.2A	8.8	Upgrade ($)	assets/images/palettes/Vinyl.png	Essentials	44
91	2025-07-24 09:35:09.662978	2025-07-24 09:35:09.662978	FlooringGranite/Marble/Quartz Note: Included in shower configuration"	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_05_AFtLavatFloor_L3507H4960_0052.jpg	6.500.3A	24,9	Upgrade ($)	assets/images/palettes/Stone.png	AvantGarde	44
92	2025-07-24 09:35:09.664148	2025-07-24 09:35:09.664148	Flooring: Hard Wood 	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_05_AFtLavatFloorWood_L3507H4960.jpg	6.500.4A	7	Upgrade ($)	assets/images/palettes/Wood.png	AvantGarde	44
93	2025-07-24 09:35:25.81062	2025-07-24 09:35:25.81062	Stainless Steel	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_01-Entryway_Sink_L3507H4960_1011.jpg	6.210.1	In Package	In Package		Essentials	45
94	2025-07-24 09:35:25.81327	2025-07-24 09:35:25.81327	Glaskote	https://api.dassaultfalcon.com/lacollection-smtp/photos/parts/HQ_01-Entryway_Sink_L3507H4960_1010.jpg	6.210.12	0	7800	assets/images/palettes/Glaskote.png	Essentials	45
95	2025-07-24 09:35:25.816559	2025-07-24 09:35:25.816559	Solid Surface	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_01-Entryway_CounterTop_L3507H4960_1015.jpg	6.210.2a	In Package	In Package	assets/images/palettes/SolidSurface.png	Essentials	46
96	2025-07-24 09:35:25.818547	2025-07-24 09:35:25.818547	Stone	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_01-Entryway_CounterTop_L3507H4960_1016.jpg	6.210.2	5	45300	assets/images/palettes/Stone.png	AvantGarde	46
97	2025-07-24 09:35:25.821539	2025-07-24 09:35:25.821539	Carpet	https://api.dassaultfalcon.com/lacollection-smtp/photos/parts/HQ_01-Entryway_Flooring_L3507H4960_1021.jpg	6.500.0B	In Package	In Package	assets/images/palettes/Carpet.png	Essentials	47
98	2025-07-24 09:35:25.822925	2025-07-24 09:35:25.822925	Vinyl	https://api.dassaultfalcon.com/lacollection-smtp/photos/parts/HQ_01-Entryway_Flooring_L3507H4960_1022BD.jpg	6.500.2	22,4	$10,500	assets/images/palettes/Vinyl.png	Essentials	47
99	2025-07-24 09:35:25.824699	2025-07-24 09:35:25.824699	Stone	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_01-Entryway_Flooring_L3507H4960_1020BD.jpg	6.500.3B	32,3	$115,100	assets/images/palettes/Stone.png	AvantGarde	47
100	2025-07-24 09:35:25.826128	2025-07-24 09:35:25.826128	Wood Veneer	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_01-Entryway_Flooring_L3507H4960_1023BD.jpg	6.500.4B	10,9	$106,500	assets/images/palettes/Wood.png	AvantGarde	47
101	2025-07-24 09:35:25.830039	2025-07-24 09:35:25.830039	Glaskote	https://api.dassaultfalcon.com/lacollection-smtp/photos/parts/HQ_01-Entryway_FWDLavSink_L3507H4960_1010.jpg	6.210.12a	In Package	In Package	assets/images/palettes/Glaskote.png	Essentials	48
102	2025-07-24 09:35:25.83202	2025-07-24 09:35:25.83202	Solid Surface1	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_01-Entryway_FWDLavConterTop_L3507H4960_1015.jpg	6.210.3b	In Package	In Package	assets/images/palettes/SolidSurface.png	Essentials	49
103	2025-07-24 09:35:25.833389	2025-07-24 09:35:25.833389	Stone	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_01-Entryway_FWDLavConterTop_L3507H4960_1016BD.jpg	6.210.5 	1.5	18800	assets/images/palettes/Stone.png	AvantGarde	49
104	2025-07-24 09:35:25.837857	2025-07-24 09:35:25.837857	Wood Edge	assets/images/options/HQ_02-Cabin_ConsoleT_L3507H4960_1101.jpg	6.200.21	In Package	In Package	assets/images/palettes/Wood.png	Essentials	50
105	2025-07-24 09:35:25.838959	2025-07-24 09:35:25.838959	Painted Edge	assets/images/options/HQ_02-Cabin_ConsoleT_L3507H4960_1100.jpg	6.200.21a	0	30000	assets/images/palettes/Paint.png	AvantGarde	50
106	2025-07-24 09:35:25.841579	2025-07-24 09:35:25.841579	Wood Edge	assets/images/options/HQ_02-Cabin_SideLedge_L3507H4960_1102.jpg	6.300.40a	In Package	In Package	assets/images/palettes/Wood.png	Essentials	51
107	2025-07-24 09:35:25.842883	2025-07-24 09:35:25.842883	Upholstery	assets/images/options/HQ_02-Cabin_SideLedge_L3507H4960.jpg	6.300.41	In Package	In Package	assets/images/palettes/Upholstery.png	Essentials	51
108	2025-07-24 09:35:25.844562	2025-07-24 09:35:25.844562	Painted Edge	assets/images/options/HQ_02-Cabin_SideLedge_L3507H4960_1103.jpg	6.300.40	0	37000	assets/images/palettes/Paint.png	AvantGarde	51
109	2025-07-24 09:35:25.848845	2025-07-24 09:35:25.848845	Wood Edge	assets/images/options/HQ_02-Cabin_DiningT_L3507H4960_1101.jpg	6.300.31	In Package	In Package	assets/images/palettes/Wood.png	Essentials	52
110	2025-07-24 09:35:25.850531	2025-07-24 09:35:25.850531	Painted Edge	assets/images/options/HQ_02-Cabin_DiningT_L3507H4960_1100.jpg	6.300.31a	0	15000	assets/images/palettes/Paint.png	AvantGarde	52
111	2025-07-24 09:35:25.853399	2025-07-24 09:35:25.853399	Wood Door	assets/images/options/HQ_02-Cabin_Credenza_L3507H4960_1111.jpg	6.300.30	In Package	In Package	assets/images/palettes/Wood.png	Essentials	53
112	2025-07-24 09:35:25.854562	2025-07-24 09:35:25.854562	Leather Door	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_02-Cabin_Credenza_L3507H4960_1111221.jpg	6.300.31	0	No Charge	assets/images/palettes/Ultraleather.png	AvantGarde	53
113	2025-07-24 09:35:25.855439	2025-07-24 09:35:25.855439	Painted Door	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_02-Cabin_Credenza_L3507H4960_1109.jpg	6.300.32	0	10000	assets/images/palettes/Paint.png	AvantGarde	53
114	2025-07-24 09:35:25.857269	2025-07-24 09:35:25.857269	Wood	assets/images/options/HQ_02-Cabin_AFTMidCabDividerFWD_L3507H4960.jpg	6.300.8	In Package	In Package	assets/images/palettes/Wood.png	Essentials	54
115	2025-07-24 09:35:25.857975	2025-07-24 09:35:25.857975	Upholstery Insert	assets/images/options/HQ_02-Cabin_AFTMidCabDividerFWD-LH_L3507H4960.jpg	6.300.8g	0	10100	assets/images/palettes/Upholstery.png	AvantGarde	54
116	2025-07-24 09:35:25.861391	2025-07-24 09:35:25.861391	Wood Door	assets/images/options/HQ_03-Divan_StorageCab_L3507H4960.jpg	6.300.30R	In Package	In Package	assets/images/palettes/Wood.png	Essentials	55
117	2025-07-24 09:35:25.86394	2025-07-24 09:35:25.86394	Wood	assets/images/options/HQ_03-Divan_AFTLavBulkhead_L3507H4960_1111.jpg	6.400.1	In Package	In Package	assets/images/palettes/Wood.png	Essentials	56
118	2025-07-24 09:35:25.865379	2025-07-24 09:35:25.865379	Door Mirror	assets/images/options/HQ_03-Divan_AFTLavBulkhead_L3507H4960_1112.jpg	6.400.1B	6	No charge	\N	Essentials	56
119	2025-07-24 09:35:25.869959	2025-07-24 09:35:25.869959	Glaskote	assets/images/options/HQ_04-Lavatory_Sink_L3507H4960_1010.jpg	6.210.12b	In Package	In Package	assets/images/palettes/Glaskote.png	Essentials	57
120	2025-07-24 09:35:25.872426	2025-07-24 09:35:25.872426	Solid Surface	assets/images/options/HQ_04-Lavatory_CounterTop_L3507H4960_1015.jpg	6.210.3a	In Package	In Package	assets/images/palettes/SolidSurface.png	Essentials	58
121	2025-07-24 09:35:25.873425	2025-07-24 09:35:25.873425	Stone	assets/images/options/HQ_04-Lavatory_CounterTop_L3507H4960_1016.jpg	6.210.3	0,3	21400	assets/images/palettes/Stone.png	AvantGarde	58
122	2025-07-24 09:35:25.875245	2025-07-24 09:35:25.875245	Carpet	assets/images/options/HQ_04-Lavatory_Flooring_L3507H4960_1021.jpg	6.500.0a	In Package	In Package	assets/images/palettes/Carpet.png	Essentials	59
123	2025-07-24 09:35:25.876409	2025-07-24 09:35:25.876409	Vinyl	assets/images/options/HQ_04-Lavatory_Flooring_L3507H4960_1022.jpg	6.500.2a	8,8	8000	assets/images/palettes/Vinyl.png	Essentials	59
124	2025-07-24 09:35:25.877965	2025-07-24 09:35:25.877965	Wood Veneer	assets/images/options/HQ_04-Lavatory_Flooring_L3507H4960_1023.jpg	6.500.4a	3,5	91100	assets/images/palettes/Wood.png	AvantGarde	59
125	2025-07-24 09:35:25.879279	2025-07-24 09:35:25.879279	Stone	assets/images/options/HQ_04-Lavatory_Flooring_L3507H4960_1020.jpg	6.500.3a	13,9	99800	assets/images/palettes/Stone.png	AvantGarde	59
126	2025-07-24 09:35:25.881224	2025-07-24 09:35:25.881224	Mirror	assets/images/options/HQ_04-Lavatory_BulkheadFWD_L3507H4960_1112.jpg	6.400.2	In Package	In Package		Essentials	60
127	2025-07-24 09:35:25.882935	2025-07-24 09:35:25.882935	Ultraleather	assets/images/options/HQ_04-Lavatory_BulkheadFWD_L3507H4960_11121.jpg	6.400.2a	-0.2	No charge	assets/images/palettes/Ultraleather.png	Essentials	60
128	2025-07-24 09:35:25.885277	2025-07-24 09:35:25.885277	Wood	assets/images/options/HQ_04-Lavatory_BulkheadAFT_L3507H4960_1113.jpg	6.410.2	In Package	In Package	assets/images/palettes/Wood.png	Essentials	60
129	2025-07-24 09:35:25.886889	2025-07-24 09:35:25.886889	Ultraleather	assets/images/options/HQ_04-Lavatory_BulkheadAFT_L3507H4960_1114.jpg	6.410.2a	-0,1	No Charge	assets/images/palettes/Ultraleather.png	Essentials	60
130	2025-07-24 09:35:37.369714	2025-07-24 09:35:37.369714	Stainless steel	assets/images/options/HQ_01-Entryway_Sink_L3507H4960_1003_CORALIE.jpg	6.210.1	In Package	In Package	\N	Essentials	61
131	2025-07-24 09:35:37.371996	2025-07-24 09:35:37.371996	Glaskote	assets/images/options/HQ_01-Entryway_Sink_L3507H4960_1004_CORALIE.jpg	6.210.12	0	7800	assets/images/palettes/Glaskote.png	Essentials	61
132	2025-07-24 09:35:37.374622	2025-07-24 09:35:37.374622	Solid surface	assets/images/options/HQ_01-Entryway_CounterTop_L3507H4960_1006_CORALIE.jpg	6.210.2a	In Package	In Package	assets/images/palettes/SolidSurface.png	Essentials	62
133	2025-07-24 09:35:37.377526	2025-07-24 09:35:37.377526	Stone	assets/images/options/HQ_01-Entryway_CounterTop_L3507H4960_1005_CORALIE.jpg	6.210.2	-1,5	45300	assets/images/palettes/Stone.png	AvantGarde	62
134	2025-07-24 09:35:37.381	2025-07-24 09:35:37.381	Carpet	assets/images/options/HQ_01-Entryway_Flooring_L3507H4960_1007_CORALIE.jpg	6.500.0b	In Package	In Package	assets/images/palettes/Carpet.png	Essentials	63
135	2025-07-24 09:35:37.383186	2025-07-24 09:35:37.383186	Vinyl	assets/images/options/HQ_01-Entryway_Flooring_L3507H4960_1009_CORALIE.jpg	6.500.2	13,3	10500	assets/images/palettes/Vinyl.png	Essentials	63
136	2025-07-24 09:35:37.385139	2025-07-24 09:35:37.385139	Wood Veneer	assets/images/options/HQ_01-Entryway_Flooring_L3507H4960_1010_CORALIE.jpg	6.500.4b	7.4	106000	assets/images/palettes/Wood.png	AvantGarde	63
137	2025-07-24 09:35:37.386658	2025-07-24 09:35:37.386658	Stone	assets/images/options/HQ_01-Entryway_Flooring_L3507H4960_1008_CORALIE.jpg	6.500.3b	24.8	115100	assets/images/palettes/Stone.png	AvantGarde	63
138	2025-07-24 09:35:37.390898	2025-07-24 09:35:37.390898	Wood Edge	assets/images/options/HQ_02-Cabin_ConsoleT_L3507H4960_1001_CORALIE.jpg	6.200.21	In Package	In Package	assets/images/palettes/Wood.png	Essentials	64
139	2025-07-24 09:35:37.392366	2025-07-24 09:35:37.392366	Painted Edge	assets/images/options/HQ_02-Cabin_ConsoleT_L3507H4960_1002_CORALIE.jpg	6.200.21a	0	30000	assets/images/palettes/Paint.png	AvantGarde	64
140	2025-07-24 09:35:37.395402	2025-07-24 09:35:37.395402	Wood Edge	assets/images/options/HQ_02-Cabin_SideLedge_L3507H4960_1018_CORALIE.jpg	6.300.40a	In Package	In Package	assets/images/palettes/Wood.png	Essentials	65
141	2025-07-24 09:35:37.396773	2025-07-24 09:35:37.396773	Upholstery	assets/images/options/HQ_02-Cabin_SideLedge_L3507H4960_1018__TEXTILE_CORALIE.jpg	6.300.41	In Package	In Package	assets/images/palettes/Upholstery.png	Essentials	65
142	2025-07-24 09:35:37.398155	2025-07-24 09:35:37.398155	Painted Edge	assets/images/options/HQ_02-Cabin_SideLedge_L3507H4960_1019_CORALIE.jpg	6.300.40	0	37000	assets/images/palettes/Paint.png	AvantGarde	65
143	2025-07-24 09:35:37.402216	2025-07-24 09:35:37.402216	Wood Edge	assets/images/options/HQ_02-Cabin_DiningT_L3507H4960_1001.jpg	6.200.31	In Package	In Package	assets/images/palettes/Wood.png	Essentials	66
144	2025-07-24 09:35:37.403422	2025-07-24 09:35:37.403422	Painted Edge	assets/images/options/HQ_02-Cabin_DiningT_L3507H4960_1002.jpg	6.200.31a	0	15000	assets/images/palettes/Paint.png	AvantGarde	66
145	2025-07-24 09:35:37.405949	2025-07-24 09:35:37.405949	Wood Door	assets/images/options/HQ_02-Cabin_Credenza_L3507H4960_1017.jpg	6.300.30	In Package	In Package	assets/images/palettes/Wood.png	Essentials	67
146	2025-07-24 09:35:37.407205	2025-07-24 09:35:37.407205	Painted Door	assets/images/options/HQ_02-Cabin_Credenza_L3507H4960_1016.jpg	6.300.32	0	10000	assets/images/palettes/Paint.png	Essentials	67
147	2025-07-24 09:35:37.408465	2025-07-24 09:35:37.408465	Leather Door	assets/images/options/HQ_02-Cabin_Credenza_L3507H4960_1015.jpg	6.300.31	0	No Charge	assets/images/palettes/QuiltedLeather.png	AvantGarde	67
148	2025-07-24 09:35:37.412256	2025-07-24 09:35:37.412256	Wood	assets/images/options/HQ_02-Cabin_AFTMidCabDividerFWD_L3507H4960_1023.jpg	6.300.8	In Package	In Package	assets/images/palettes/Wood.png	Essentials	68
149	2025-07-24 09:35:37.41364	2025-07-24 09:35:37.41364	Mirror Insert	assets/images/options/HQ_02-Cabin_AFTMidCabDividerFWD_L3507H4960_1022.jpg	6.300.8h	1	11900		Essentials	68
150	2025-07-24 09:35:37.414892	2025-07-24 09:35:37.414892	Wood	assets/images/options/HQ_02-Cabin_AFTMidCabDividerAFT_L3507H4960-01.jpg	6.300.9	In Package	In Package	assets/images/palettes/Wood.png	Essentials	68
151	2025-07-24 09:35:37.416358	2025-07-24 09:35:37.416358	Mirror Insert	assets/images/options/HQ_02-Cabin_AFTMidCabDividerAFT_L3507H4960-02.jpg	6.300.9h	1	12300		Essentials	68
152	2025-07-24 09:35:37.41777	2025-07-24 09:35:37.41777	Upholstery Insert	assets/images/options/HQ_02-Cabin_AFTMidCabDividerFWD_L3507H4960_1021.jpg	6.300.8g	0	10100	assets/images/palettes/Upholstery.png	AvantGarde	68
153	2025-07-24 09:35:37.421914	2025-07-24 09:35:37.421914	Wood Door	assets/images/options/HQ_03-Divan_StorageCab_L3507H4960_1002.jpg	6.300.30R	In Package	In Package	assets/images/palettes/Wood.png	Essentials	69
154	2025-07-24 09:35:37.42299	2025-07-24 09:35:37.42299	Painted Door	assets/images/options/HQ_03-Divan_StorageCab_L3507H4960_1003.jpg	6.300.32R	0	10000	assets/images/palettes/Paint.png	Essentials	69
155	2025-07-24 09:35:37.428784	2025-07-24 09:35:37.428784	Glaskote	assets/images/options/HQ_04-Lavatory_Sink_L3507H4960_1000_CORALIE.jpg	6.210.12b	In Package	In Package	assets/images/palettes/Glaskote.png	Essentials	70
156	2025-07-24 09:35:37.43159	2025-07-24 09:35:37.43159	Solid Surface	assets/images/options/HQ_04-Lavatory_CounterTop02_2023-01-19_CORALIE.jpg	6.210.3a	In Package	In Package	assets/images/palettes/SolidSurface.png	Essentials	71
157	2025-07-24 09:35:37.433265	2025-07-24 09:35:37.433265	Stone	assets/images/options/HQ_04-Lavatory_CounterTop01_2023-01-19_CORALIE.jpg	6.210.3	2.5	21400	assets/images/palettes/Stone.png	AvantGarde	71
158	2025-07-24 09:35:37.436054	2025-07-24 09:35:37.436054	Carpet	assets/images/options/HQ_04-Lavatory_Flooring_L3507H4960_1014_CORALIE.jpg	6.500.0a	In Package	In Package	assets/images/palettes/Carpet.png	Essentials	72
159	2025-07-24 09:35:37.43749	2025-07-24 09:35:37.43749	Vinyl	assets/images/options/HQ_04-Lavatory_Flooring_L3507H4960_1013_CORALIE.jpg	6.500.2a	3.2	8000	assets/images/palettes/Vinyl.png	Essentials	72
160	2025-07-24 09:35:37.438636	2025-07-24 09:35:37.438636	Wood Veneer	assets/images/options/HQ_04-Lavatory_Flooring_L3507H4960_1011_CORALIE.jpg	6.500.4a	0.8	90600	assets/images/palettes/Wood.png	AvantGarde	72
161	2025-07-24 09:35:37.439886	2025-07-24 09:35:37.439886	Stone	assets/images/options/HQ_04-Lavatory_Flooring_L3507H4960_1012_CORALIE.jpg	6.500.3a	9.6	99800	assets/images/palettes/Stone.png	AvantGarde	72
162	2025-07-24 09:35:37.442697	2025-07-24 09:35:37.442697	Wood	assets/images/options/HQ_04-Lavatory_BulkheadFWD_L3507H4960_1007.jpg	6.400.2	In Package	In Package	assets/images/palettes/Wood.png	Essentials	73
163	2025-07-24 09:35:37.44439	2025-07-24 09:35:37.44439	Ultraleather	assets/images/options/HQ_04-Lavatory_BulkheadFWD_L3507H4960_1008.jpg	6.400.2a	-0.8	No charge	assets/images/palettes/Ultraleather.png	Essentials	73
164	2025-07-24 09:35:37.44593	2025-07-24 09:35:37.44593	Wood	assets/images/options/HQ_04-Lavatory_BulkheadAFT_L3507H4960_1007.jpg	6.410.2	In Package	In Package	assets/images/palettes/Wood.png	Essentials	73
165	2025-07-24 09:35:37.447209	2025-07-24 09:35:37.447209	Ultraleather	assets/images/options/HQ_04-Lavatory_BulkheadAFT_L3507H4960_1008.jpg	6.410.2a	-0.2	No charge	assets/images/palettes/Ultraleather.png	Essentials	73
\.


--
-- Data for Name: otp; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.otp (id, "createdAt", "updatedAt", code, expiry) FROM stdin;
\.


--
-- Data for Name: parts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.parts (id, "createdAt", "updatedAt", title, "areaId") FROM stdin;
1	2025-07-24 09:34:45.798513	2025-07-24 09:34:45.798513	Sink	1
2	2025-07-24 09:34:45.806218	2025-07-24 09:34:45.806218	Countertop	1
3	2025-07-24 09:34:45.813405	2025-07-24 09:34:45.813405	Upper drawer	1
4	2025-07-24 09:34:45.821496	2025-07-24 09:34:45.821496	Threshold	1
5	2025-07-24 09:34:45.825611	2025-07-24 09:34:45.825611	Flooring	1
6	2025-07-24 09:34:45.831208	2025-07-24 09:34:45.831208	Console Table	2
7	2025-07-24 09:34:45.834308	2025-07-24 09:34:45.834308	Dining table	2
8	2025-07-24 09:34:45.836599	2025-07-24 09:34:45.836599	Sideledge	2
9	2025-07-24 09:34:45.84222	2025-07-24 09:34:45.84222	Bulkheads	2
10	2025-07-24 09:34:45.850469	2025-07-24 09:34:45.850469	Sink	3
11	2025-07-24 09:34:45.853483	2025-07-24 09:34:45.853483	Countertop	3
12	2025-07-24 09:34:45.855788	2025-07-24 09:34:45.855788	Flooring	3
13	2025-07-24 09:34:45.857879	2025-07-24 09:34:45.857879	Bulkheads	3
14	2025-07-24 09:35:09.519257	2025-07-24 09:35:09.519257	FORWARD CLOSET	4
15	2025-07-24 09:35:09.528202	2025-07-24 09:35:09.528202		4
16	2025-07-24 09:35:09.531007	2025-07-24 09:35:09.531007	 CREW REST	5
17	2025-07-24 09:35:09.541249	2025-07-24 09:35:09.541249	Bulkhead	6
18	2025-07-24 09:35:09.544035	2025-07-24 09:35:09.544035	Sink	6
19	2025-07-24 09:35:09.547043	2025-07-24 09:35:09.547043	Backsplash	6
20	2025-07-24 09:35:09.552125	2025-07-24 09:35:09.552125	Bulkhead	7
21	2025-07-24 09:35:09.553277	2025-07-24 09:35:09.553277	Sink	7
22	2025-07-24 09:35:09.556707	2025-07-24 09:35:09.556707	Countertop	7
23	2025-07-24 09:35:09.559832	2025-07-24 09:35:09.559832	Flooring	7
24	2025-07-24 09:35:09.56719	2025-07-24 09:35:09.56719	Console table	8
25	2025-07-24 09:35:09.569149	2025-07-24 09:35:09.569149	Sideledge	8
26	2025-07-24 09:35:09.576589	2025-07-24 09:35:09.576589	Dining Table	9
27	2025-07-24 09:35:09.579606	2025-07-24 09:35:09.579606	Credenza	9
28	2025-07-24 09:35:09.586226	2025-07-24 09:35:09.586226	Divan	10
29	2025-07-24 09:35:09.600549	2025-07-24 09:35:09.600549	Bed Header	11
30	2025-07-24 09:35:09.604616	2025-07-24 09:35:09.604616	Credenza	11
31	2025-07-24 09:35:09.61222	2025-07-24 09:35:09.61222	 	12
32	2025-07-24 09:35:09.613709	2025-07-24 09:35:09.613709	Sink	13
33	2025-07-24 09:35:09.616915	2025-07-24 09:35:09.616915	Vanity Backsplash	13
34	2025-07-24 09:35:09.623078	2025-07-24 09:35:09.623078		13
35	2025-07-24 09:35:09.624097	2025-07-24 09:35:09.624097	Closet Door	13
36	2025-07-24 09:35:09.627797	2025-07-24 09:35:09.627797	Right-Hand Countertop  	13
37	2025-07-24 09:35:09.631741	2025-07-24 09:35:09.631741	Forward Bulkhead	14
38	2025-07-24 09:35:09.636627	2025-07-24 09:35:09.636627	Main Cabin Divider	14
39	2025-07-24 09:35:09.644397	2025-07-24 09:35:09.644397	AFT Bulkhead	14
40	2025-07-24 09:35:09.648822	2025-07-24 09:35:09.648822	Sink	15
41	2025-07-24 09:35:09.650884	2025-07-24 09:35:09.650884		15
42	2025-07-24 09:35:09.652988	2025-07-24 09:35:09.652988		15
43	2025-07-24 09:35:09.657164	2025-07-24 09:35:09.657164	Closet Door	15
44	2025-07-24 09:35:09.660118	2025-07-24 09:35:09.660118	Flooring	15
45	2025-07-24 09:35:25.808484	2025-07-24 09:35:25.808484	Sink	20
46	2025-07-24 09:35:25.81477	2025-07-24 09:35:25.81477	Countertop	20
47	2025-07-24 09:35:25.820326	2025-07-24 09:35:25.820326	Flooring	20
48	2025-07-24 09:35:25.828839	2025-07-24 09:35:25.828839	Sink	21
49	2025-07-24 09:35:25.830975	2025-07-24 09:35:25.830975	Countertop	21
50	2025-07-24 09:35:25.836645	2025-07-24 09:35:25.836645	Console table	22
51	2025-07-24 09:35:25.840387	2025-07-24 09:35:25.840387	Sideledge	22
52	2025-07-24 09:35:25.847463	2025-07-24 09:35:25.847463	Dining Table	23
53	2025-07-24 09:35:25.852149	2025-07-24 09:35:25.852149	Credenza	23
54	2025-07-24 09:35:25.856202	2025-07-24 09:35:25.856202	Bulkheads	23
55	2025-07-24 09:35:25.860227	2025-07-24 09:35:25.860227	Divan Cabinet	24
56	2025-07-24 09:35:25.862622	2025-07-24 09:35:25.862622	Bulkheads	24
57	2025-07-24 09:35:25.868408	2025-07-24 09:35:25.868408	Sink	25
58	2025-07-24 09:35:25.871239	2025-07-24 09:35:25.871239	Countertop	25
59	2025-07-24 09:35:25.874338	2025-07-24 09:35:25.874338	Flooring	25
60	2025-07-24 09:35:25.880387	2025-07-24 09:35:25.880387	Bulkheads	25
61	2025-07-24 09:35:37.367534	2025-07-24 09:35:37.367534	Sink	26
62	2025-07-24 09:35:37.373324	2025-07-24 09:35:37.373324	Countertop	26
63	2025-07-24 09:35:37.379595	2025-07-24 09:35:37.379595	Flooring	26
64	2025-07-24 09:35:37.390009	2025-07-24 09:35:37.390009	Console Table	27
65	2025-07-24 09:35:37.393935	2025-07-24 09:35:37.393935	Sideledge	27
66	2025-07-24 09:35:37.401041	2025-07-24 09:35:37.401041	Dining Table	28
67	2025-07-24 09:35:37.404565	2025-07-24 09:35:37.404565	Credenza	28
68	2025-07-24 09:35:37.410472	2025-07-24 09:35:37.410472	Bulkheads	28
69	2025-07-24 09:35:37.420756	2025-07-24 09:35:37.420756	Divan Cabinet	29
70	2025-07-24 09:35:37.427122	2025-07-24 09:35:37.427122	Sink	30
71	2025-07-24 09:35:37.43023	2025-07-24 09:35:37.43023	Countertop	30
72	2025-07-24 09:35:37.434731	2025-07-24 09:35:37.434731	Flooring	30
73	2025-07-24 09:35:37.441234	2025-07-24 09:35:37.441234	Bulkheads	30
\.


--
-- Data for Name: permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.permissions (id, "createdAt", "updatedAt", action, subject, fields, conditions, inverted, reason, "roleId") FROM stdin;
1	2025-07-24 12:22:19.389855	2025-07-24 12:22:19.389855	manage	all	\N	\N	\N	\N	1
2	2025-07-24 12:22:49.937548	2025-07-24 12:22:49.937548	read	all	\N	\N	\N	\N	2
\.


--
-- Data for Name: planes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.planes (id, "createdAt", "updatedAt", name) FROM stdin;
1	2025-07-24 09:34:45.787842	2025-07-24 09:34:45.787842	2000LXS
2	2025-07-24 09:35:09.505266	2025-07-24 09:35:09.505266	10X
3	2025-07-24 09:35:25.796082	2025-07-24 09:35:25.796082	8X
4	2025-07-24 09:35:37.353568	2025-07-24 09:35:37.353568	6X
\.


--
-- Data for Name: preferences; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.preferences (id, "createdAt", "updatedAt", "salesEmails", "accountId") FROM stdin;
2	2025-07-24 12:25:37.733302	2025-07-24 12:25:37.733302		4
3	2025-07-24 12:25:37.804798	2025-07-24 12:25:37.804798		5
4	2025-07-24 12:25:37.870119	2025-07-24 12:25:37.870119		6
5	2025-07-24 12:25:37.946392	2025-07-24 12:25:37.946392		7
6	2025-07-24 12:25:38.016704	2025-07-24 12:25:38.016704		8
7	2025-07-24 12:25:38.077219	2025-07-24 12:25:38.077219	Carlos.Brana@dassault-aviation.com	9
8	2025-07-24 12:25:38.142533	2025-07-24 12:25:38.142533		10
9	2025-07-24 12:25:38.215283	2025-07-24 12:25:38.215283		11
10	2025-07-24 12:25:38.282918	2025-07-24 12:25:38.282918		12
11	2025-07-24 12:25:38.346273	2025-07-24 12:25:38.346273		13
12	2025-07-24 12:25:38.407978	2025-07-24 12:25:38.407978		14
13	2025-07-24 12:25:38.470501	2025-07-24 12:25:38.470501		15
14	2025-07-24 12:25:38.535905	2025-07-24 12:25:38.535905		16
15	2025-07-24 12:25:38.595088	2025-07-24 12:25:38.595088	Bertrand.Becker@dassault-aviation.com	17
16	2025-07-24 12:25:38.65321	2025-07-24 12:25:38.65321	Nicolas.Aubert@dassault-aviation.com	18
17	2025-07-24 12:25:38.711942	2025-07-24 12:25:38.711942	Jean-Michel.Fraisse@dassault-aviation.com	19
18	2025-07-24 12:25:38.780596	2025-07-24 12:25:38.780596		20
19	2025-07-24 12:25:38.854361	2025-07-24 12:25:38.854361		21
20	2025-07-24 12:25:38.928558	2025-07-24 12:25:38.928558		22
21	2025-07-24 12:25:38.998882	2025-07-24 12:25:38.998882		23
22	2025-07-24 12:25:39.062111	2025-07-24 12:25:39.062111		24
23	2025-07-24 12:25:39.122447	2025-07-24 12:25:39.122447		25
24	2025-07-24 12:25:39.179589	2025-07-24 12:25:39.179589	laetitia.ferelloc@dassault-aviation.com	26
25	2025-07-24 12:25:39.238639	2025-07-24 12:25:39.238639		27
26	2025-07-24 12:25:39.295585	2025-07-24 12:25:39.295585		28
27	2025-07-24 12:25:39.352084	2025-07-24 12:25:39.352084		29
28	2025-07-24 12:25:39.417987	2025-07-24 12:25:39.417987		30
29	2025-07-24 12:25:39.48435	2025-07-24 12:25:39.48435		31
30	2025-07-24 12:25:39.554119	2025-07-24 12:25:39.554119		32
31	2025-07-24 12:25:39.62569	2025-07-24 12:25:39.62569		33
32	2025-07-24 12:25:39.690238	2025-07-24 12:25:39.690238		34
33	2025-07-24 12:25:39.749728	2025-07-24 12:25:39.749728	Igor.Fain@dassault-aviation.com	35
34	2025-07-24 12:25:39.813365	2025-07-24 12:25:39.813365		36
35	2025-07-24 12:25:39.87695	2025-07-24 12:25:39.87695		37
36	2025-07-24 12:25:39.939979	2025-07-24 12:25:39.939979		38
37	2025-07-24 12:25:40.007127	2025-07-24 12:25:40.007127		39
38	2025-07-24 12:25:40.067849	2025-07-24 12:25:40.067849		40
39	2025-07-24 12:25:40.134974	2025-07-24 12:25:40.134974		41
40	2025-07-24 12:25:40.203516	2025-07-24 12:25:40.203516		42
41	2025-07-24 12:25:40.279122	2025-07-24 12:25:40.279122		43
42	2025-07-24 12:25:40.346445	2025-07-24 12:25:40.346445		44
43	2025-07-24 12:25:40.421357	2025-07-24 12:25:40.421357		45
44	2025-07-24 12:25:40.494491	2025-07-24 12:25:40.494491		46
45	2025-07-24 12:25:40.559572	2025-07-24 12:25:40.559572		47
46	2025-07-24 12:25:40.626402	2025-07-24 12:25:40.626402		48
47	2025-07-24 12:25:40.700164	2025-07-24 12:25:40.700164		49
48	2025-07-24 12:25:40.77334	2025-07-24 12:25:40.77334		50
49	2025-07-24 12:25:40.850226	2025-07-24 12:25:40.850226		51
50	2025-07-24 12:25:40.924992	2025-07-24 12:25:40.924992		52
51	2025-07-24 12:25:41.002536	2025-07-24 12:25:41.002536		53
52	2025-07-24 12:25:41.072525	2025-07-24 12:25:41.072525		54
53	2025-07-24 12:25:41.148824	2025-07-24 12:25:41.148824		55
54	2025-07-24 12:25:41.223765	2025-07-24 12:25:41.223765		56
55	2025-07-24 12:25:41.283041	2025-07-24 12:25:41.283041		57
56	2025-07-24 12:25:41.336726	2025-07-24 12:25:41.336726		58
57	2025-07-24 12:25:41.390238	2025-07-24 12:25:41.390238		59
58	2025-07-24 12:25:41.452362	2025-07-24 12:25:41.452362		60
59	2025-07-24 12:25:41.512365	2025-07-24 12:25:41.512365		61
60	2025-07-24 12:25:41.560529	2025-07-24 12:25:41.560529		62
61	2025-07-24 12:25:41.608482	2025-07-24 12:25:41.608482	adrian.jimenez@dassault-aviation.com	63
62	2025-07-24 12:25:41.659561	2025-07-24 12:25:41.659561		64
63	2025-07-24 12:25:41.713795	2025-07-24 12:25:41.713795		65
1	2025-07-24 12:25:37.672	2025-07-24 12:25:37.672		3
64	2025-07-24 13:38:38.231561	2025-07-24 13:38:38.231561	\N	66
\.


--
-- Data for Name: preferences_bookmarks_options; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.preferences_bookmarks_options ("preferencesId", "optionsId") FROM stdin;
57	9
1	138
\.


--
-- Data for Name: preferences_planes_planes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.preferences_planes_planes ("preferencesId", "planesId") FROM stdin;
1	4
1	3
2	4
3	3
3	4
3	1
4	1
4	4
4	3
5	2
5	1
5	4
5	3
6	1
6	4
6	3
8	4
8	3
9	4
9	3
10	4
10	3
11	4
11	3
12	4
12	3
13	4
13	3
14	4
14	3
18	4
18	3
19	4
19	3
20	4
20	3
21	4
21	3
22	4
22	3
23	4
23	3
25	4
25	3
26	4
26	3
27	4
27	3
28	4
28	3
29	3
29	4
30	3
30	4
31	4
31	3
32	4
32	3
34	4
34	3
35	4
35	3
36	3
36	4
37	4
37	3
38	4
38	3
39	4
39	3
40	3
40	4
41	3
41	4
42	4
42	3
43	3
43	4
44	4
44	3
45	4
45	3
46	4
46	3
47	4
47	3
48	4
48	3
49	4
49	3
50	4
50	3
51	4
51	3
52	4
52	3
53	4
53	3
54	4
54	3
55	4
55	3
58	4
58	3
58	1
59	2
59	1
59	4
59	3
62	4
62	3
62	1
63	4
63	3
63	1
64	1
64	2
64	3
64	4
\.


--
-- Data for Name: profiles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.profiles (id, "createdAt", "updatedAt", firstname, lastname, bio, gender, "phoneNumber", address, "photoUrl", "dateOfBirth") FROM stdin;
3	2025-07-24 12:25:37.601769	2025-07-24 12:25:37.601769	Dev	APPLE	\N	\N	\N	\N	\N	\N
4	2025-07-24 12:25:37.676	2025-07-24 12:25:37.676	Stephane	ARDOUIN	\N	\N	\N	\N	\N	\N
5	2025-07-24 12:25:37.73508	2025-07-24 12:25:37.73508	Falilou	GAYE	\N	\N	\N	\N	\N	\N
6	2025-07-24 12:25:37.808784	2025-07-24 12:25:37.808784	Remi	BACHELET	\N	\N	\N	\N	\N	\N
7	2025-07-24 12:25:37.872688	2025-07-24 12:25:37.872688	Aurore	NOUVELLON	\N	\N	\N	\N	\N	\N
8	2025-07-24 12:25:37.950202	2025-07-24 12:25:37.950202	Eloi	DUFOUR	\N	\N	\N	\N	\N	\N
9	2025-07-24 12:25:38.019576	2025-07-24 12:25:38.019576	Carlos	BRANA	\N	\N	\N	\N	\N	\N
10	2025-07-24 12:25:38.079166	2025-07-24 12:25:38.079166	Clement	BROZI	\N	\N	\N	\N	\N	\N
11	2025-07-24 12:25:38.14609	2025-07-24 12:25:38.14609	Jean-charles	FEDINI	\N	\N	\N	\N	\N	\N
12	2025-07-24 12:25:38.218694	2025-07-24 12:25:38.218694	Donna	DIKEN	\N	\N	\N	\N	\N	\N
13	2025-07-24 12:25:38.286307	2025-07-24 12:25:38.286307	Melanie	CANO	\N	\N	\N	\N	\N	\N
14	2025-07-24 12:25:38.349032	2025-07-24 12:25:38.349032	Karla	PALENCIA	\N	\N	\N	\N	\N	\N
15	2025-07-24 12:25:38.411415	2025-07-24 12:25:38.411415	Jennifer	HARPER	\N	\N	\N	\N	\N	\N
16	2025-07-24 12:25:38.473051	2025-07-24 12:25:38.473051	Lucie	WEBER	\N	\N	\N	\N	\N	\N
17	2025-07-24 12:25:38.538312	2025-07-24 12:25:38.538312	Bertrand	BECKER	\N	\N	\N	\N	\N	\N
18	2025-07-24 12:25:38.597497	2025-07-24 12:25:38.597497	Nicolas	AUBERT	\N	\N	\N	\N	\N	\N
19	2025-07-24 12:25:38.655358	2025-07-24 12:25:38.655358	Jean-michel	FRAISSE	\N	\N	\N	\N	\N	\N
20	2025-07-24 12:25:38.714022	2025-07-24 12:25:38.714022	Gilles	APOLLIS	\N	\N	\N	\N	\N	\N
21	2025-07-24 12:25:38.783723	2025-07-24 12:25:38.783723	Beatrice	ASHE	\N	\N	\N	\N	\N	\N
22	2025-07-24 12:25:38.857672	2025-07-24 12:25:38.857672	David	BAILEY	\N	\N	\N	\N	\N	\N
23	2025-07-24 12:25:38.931255	2025-07-24 12:25:38.931255	Thomas	CARLING	\N	\N	\N	\N	\N	\N
24	2025-07-24 12:25:39.001741	2025-07-24 12:25:39.001741	Nick	CHEN	\N	\N	\N	\N	\N	\N
25	2025-07-24 12:25:39.065252	2025-07-24 12:25:39.065252	Renaud	CLOATRE	\N	\N	\N	\N	\N	\N
26	2025-07-24 12:25:39.12571	2025-07-24 12:25:39.12571	Laetitia	FERELLOC	\N	\N	\N	\N	\N	\N
27	2025-07-24 12:25:39.18129	2025-07-24 12:25:39.18129	Gustavo	TOLEDO	\N	\N	\N	\N	\N	\N
28	2025-07-24 12:25:39.241408	2025-07-24 12:25:39.241408	Pierre	DELESTRADE	\N	\N	\N	\N	\N	\N
29	2025-07-24 12:25:39.297165	2025-07-24 12:25:39.297165	Jerome	DESMAZURES	\N	\N	\N	\N	\N	\N
30	2025-07-24 12:25:39.354521	2025-07-24 12:25:39.354521	Yvon	DESVIGNES	\N	\N	\N	\N	\N	\N
31	2025-07-24 12:25:39.42027	2025-07-24 12:25:39.42027	John	DE-TURRIS	\N	\N	\N	\N	\N	\N
32	2025-07-24 12:25:39.487953	2025-07-24 12:25:39.487953	Anne	DEVILLIERS	\N	\N	\N	\N	\N	\N
33	2025-07-24 12:25:39.557199	2025-07-24 12:25:39.557199	Jake	DEVRIES	\N	\N	\N	\N	\N	\N
34	2025-07-24 12:25:39.629081	2025-07-24 12:25:39.629081	Emilien	ETIENNE	\N	\N	\N	\N	\N	\N
35	2025-07-24 12:25:39.693085	2025-07-24 12:25:39.693085	Igor	FAIN	\N	\N	\N	\N	\N	\N
36	2025-07-24 12:25:39.751444	2025-07-24 12:25:39.751444	Paul	FLORECK	\N	\N	\N	\N	\N	\N
37	2025-07-24 12:25:39.81638	2025-07-24 12:25:39.81638	Robert	FRIEDLANDER	\N	\N	\N	\N	\N	\N
38	2025-07-24 12:25:39.879752	2025-07-24 12:25:39.879752	Jean-marie	GAUTHEROT	\N	\N	\N	\N	\N	\N
39	2025-07-24 12:25:39.943319	2025-07-24 12:25:39.943319	Gilles	GAUTIER	\N	\N	\N	\N	\N	\N
40	2025-07-24 12:25:40.009986	2025-07-24 12:25:40.009986	Renaud	LEMIRE	\N	\N	\N	\N	\N	\N
41	2025-07-24 12:25:40.070576	2025-07-24 12:25:40.070576	Mark	GREENWOOD	\N	\N	\N	\N	\N	\N
42	2025-07-24 12:25:40.137816	2025-07-24 12:25:40.137816	Aadil	GOULAMALY	\N	\N	\N	\N	\N	\N
43	2025-07-24 12:25:40.20722	2025-07-24 12:25:40.20722	Thomas	HETIER	\N	\N	\N	\N	\N	\N
44	2025-07-24 12:25:40.282115	2025-07-24 12:25:40.282115	Jean-michel	JACOB	\N	\N	\N	\N	\N	\N
45	2025-07-24 12:25:40.349395	2025-07-24 12:25:40.349395	Frederic	LE BASSER	\N	\N	\N	\N	\N	\N
46	2025-07-24 12:25:40.424373	2025-07-24 12:25:40.424373	Denis	LECULEE	\N	\N	\N	\N	\N	\N
47	2025-07-24 12:25:40.49759	2025-07-24 12:25:40.49759	Nicolas	MARTIN	\N	\N	\N	\N	\N	\N
48	2025-07-24 12:25:40.562594	2025-07-24 12:25:40.562594	Nicolas	MONCALIS	\N	\N	\N	\N	\N	\N
49	2025-07-24 12:25:40.629322	2025-07-24 12:25:40.629322	Rodrigo	PESOA	\N	\N	\N	\N	\N	\N
50	2025-07-24 12:25:40.702812	2025-07-24 12:25:40.702812	Xavier	PONS	\N	\N	\N	\N	\N	\N
51	2025-07-24 12:25:40.77777	2025-07-24 12:25:40.77777	Didier	RAYNARD	\N	\N	\N	\N	\N	\N
52	2025-07-24 12:25:40.85302	2025-07-24 12:25:40.85302	Rhett	REAVIS	\N	\N	\N	\N	\N	\N
53	2025-07-24 12:25:40.928462	2025-07-24 12:25:40.928462	Thomas	ROHAUT	\N	\N	\N	\N	\N	\N
54	2025-07-24 12:25:41.005248	2025-07-24 12:25:41.005248	Emmanuel	SENARD	\N	\N	\N	\N	\N	\N
55	2025-07-24 12:25:41.076617	2025-07-24 12:25:41.076617	Florent	VENTURINI	\N	\N	\N	\N	\N	\N
56	2025-07-24 12:25:41.152117	2025-07-24 12:25:41.152117	Isabelle	VITTET	\N	\N	\N	\N	\N	\N
57	2025-07-24 12:25:41.227528	2025-07-24 12:25:41.227528	Chad	WININGS	\N	\N	\N	\N	\N	\N
58	2025-07-24 12:25:41.28471	2025-07-24 12:25:41.28471	James	TAYLOR	\N	\N	\N	\N	\N	\N
59	2025-07-24 12:25:41.338536	2025-07-24 12:25:41.338536	Vincent	HUBERT	\N	\N	\N	\N	\N	\N
60	2025-07-24 12:25:41.393345	2025-07-24 12:25:41.393345	Axel	COCAT	\N	\N	\N	\N	\N	\N
61	2025-07-24 12:25:41.457356	2025-07-24 12:25:41.457356	Frederique	HOUSSARD	\N	\N	\N	\N	\N	\N
62	2025-07-24 12:25:41.515334	2025-07-24 12:25:41.515334	Marianne	DUPIN	\N	\N	\N	\N	\N	\N
63	2025-07-24 12:25:41.562245	2025-07-24 12:25:41.562245	Adrian	JIMENEZ	\N	\N	\N	\N	\N	\N
64	2025-07-24 12:25:41.610338	2025-07-24 12:25:41.610338	Simon	ETCHECOPAR	\N	\N	\N	\N	\N	\N
65	2025-07-24 12:25:41.6619	2025-07-24 12:25:41.6619	Veronique	LIMITO	\N	\N	\N	\N	\N	\N
66	2025-07-24 12:45:30.194666	2025-07-24 12:45:30.194666	Coralie	BORDENAVE	\N	\N	\N	\N	\N	\N
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.roles (id, "createdAt", "updatedAt", name, description) FROM stdin;
1	2025-07-24 12:22:19.389855	2025-07-24 12:22:19.389855	admin	\N
2	2025-07-24 12:22:49.937548	2025-07-24 12:22:49.937548	user	\N
\.


--
-- Name: accounts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.accounts_id_seq', 66, true);


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

SELECT pg_catalog.setval('public.preferences_id_seq', 64, true);


--
-- Name: profiles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.profiles_id_seq', 66, true);


--
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.roles_id_seq', 2, true);


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

--
-- PostgreSQL database dump
--

-- Dumped from database version 15.13 (Debian 15.13-1.pgdg120+1)
-- Dumped by pg_dump version 17.5 (Ubuntu 17.5-1.pgdg22.04+1)

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
    "planeId" integer
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
    "partId" integer
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
    "areaId" integer
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
    name character varying NOT NULL
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
3	2025-07-24 12:25:37.601769	2025-07-24 12:25:37.601769	\N	DAPPLE01	$2b$10$WxCn6x3nMVkqlDdVsQosgu6tl1TkgamcuVViqHb5YxmLCckA6VJau	0	VERIFIED	\N	\N	\N	1	3	\N
4	2025-07-24 12:25:37.676	2025-07-24 12:25:37.676	\N	SARDOU01	$2b$10$YYLkZeWJFwnT4vSHRipEpu/LDCZsKKtqMd3Z5KYfoOLkwZ/0chc0K	0	VERIFIED	\N	\N	\N	1	4	\N
5	2025-07-24 12:25:37.73508	2025-07-24 12:25:37.73508	\N	FGAYE01	$2b$10$rEu9Jx/RZs0E/U/VSJ8CKeGtgW/fjw2USnL4.eBoX6rK8i.IvJYui	0	VERIFIED	\N	\N	\N	1	5	\N
6	2025-07-24 12:25:37.808784	2025-07-24 12:25:37.808784	\N	RBACHE01	$2b$10$CfaMz9pz5v2Vk4noWxI5bOerFWUt2QnrmEpj1Sz4.WVBX12PS.UBy	0	VERIFIED	\N	\N	\N	1	6	\N
7	2025-07-24 12:25:37.872688	2025-07-24 12:25:37.872688	\N	ANOUVE01	$2b$10$HRbDIjUu/smCBhiBHYkkUOaj/shoO.bjb2kcfiZQFIsINLaZxGBTy	0	VERIFIED	\N	\N	\N	1	7	\N
8	2025-07-24 12:25:37.950202	2025-07-24 12:25:37.950202	\N	EDUFOU02	$2b$10$upVlvKTd4cOIO0h.QPamoeJXx.FE5FQ0CKQVVLCVqKk45cR4Q3mlG	0	VERIFIED	\N	\N	\N	1	8	\N
9	2025-07-24 12:25:38.019576	2025-07-24 12:25:38.019576	\N	CBRANA01	$2b$10$CGLZHHM8goq9akY8HUqqS.FhWvWA8ZUBEN4TAaF3wJsoZSvYYgvei	0	VERIFIED	\N	\N	\N	1	9	\N
10	2025-07-24 12:25:38.079166	2025-07-24 12:25:38.079166	\N	CBROZI01	$2b$10$hXmP8/IoOiz2iQXs4yaK5e5vf47YiWRxB1eA71gjpitdrJMT3eYxW	0	VERIFIED	\N	\N	\N	1	10	\N
11	2025-07-24 12:25:38.14609	2025-07-24 12:25:38.14609	\N	JFEDIN01	$2b$10$J8YaHsjbXfk919MzPr2Jg.qWl/2PCkYwpw1onZhFZB9lzlXF5Tp5W	0	VERIFIED	\N	\N	\N	1	11	\N
12	2025-07-24 12:25:38.218694	2025-07-24 12:25:38.218694	\N	DDIKEN01	$2b$10$nBwQ5hDHx9brtYmrNIU2ouji.Voc5mpUy1T1Cl0a1hzxYe0GqWlHG	0	VERIFIED	\N	\N	\N	1	12	\N
13	2025-07-24 12:25:38.286307	2025-07-24 12:25:38.286307	\N	MCANO01	$2b$10$B98QjjrBUaP.5BIkld.4B.eIm2w5bHlqfy/xlwGkC/pBY0GpLCIIG	0	VERIFIED	\N	\N	\N	1	13	\N
14	2025-07-24 12:25:38.349032	2025-07-24 12:25:38.349032	\N	KPALEN01	$2b$10$Wl6Zp2.cxQDLkFwLGN/s1.DUyk2MPMGBNTh4GYQbDtPZrq/sXw.Xu	0	VERIFIED	\N	\N	\N	1	14	\N
15	2025-07-24 12:25:38.411415	2025-07-24 12:25:38.411415	\N	JHARPE02	$2b$10$JyNATM5XOV7268AK5VGdZON.77VXd5z/VBFiO1gPICbMPXsf8ivs.	0	VERIFIED	\N	\N	\N	1	15	\N
16	2025-07-24 12:25:38.473051	2025-07-24 12:25:38.473051	\N	LWEBER01	$2b$10$h5a0/DcVwzgAOhwDzFXLYuL9D4gcUAWBt4wmAywkoD.vSz8wo3D86	0	VERIFIED	\N	\N	\N	1	16	\N
17	2025-07-24 12:25:38.538312	2025-07-24 12:25:38.538312	\N	BBECKE04	$2b$10$PRTEMIgyeheZtUOvHl.M0uzRyPBOp4N9Rj0.6eRQsBBO0z5iR5LwO	0	VERIFIED	\N	\N	\N	1	17	\N
18	2025-07-24 12:25:38.597497	2025-07-24 12:25:38.597497	\N	NAUBER01	$2b$10$Gx8UK7g0DzIlum1Wq8hZz.4AHn1j/nCYYqXdy/WZM3cTCyXaoKfXS	0	VERIFIED	\N	\N	\N	1	18	\N
19	2025-07-24 12:25:38.655358	2025-07-24 12:25:38.655358	\N	JFRAIS01	$2b$10$5TJIBPn0XYkFjK94PyvNdeLakaSqS2CfduR7xKqsgObif3wQarlIe	0	VERIFIED	\N	\N	\N	1	19	\N
20	2025-07-24 12:25:38.714022	2025-07-24 12:25:38.714022	\N	GAPOLL01	$2b$10$Iw5mBsPJIN1NZlU1NseTHOrroBYuhjlkK7k8DFgMxFtGgAHK17T3y	0	VERIFIED	\N	\N	\N	1	20	\N
21	2025-07-24 12:25:38.783723	2025-07-24 12:25:38.783723	\N	BASHE01	$2b$10$qMjNIftyTQUj2bsaEJepcuyrJxJZbEIZZ3naLO86EyqRQMYzsinT6	0	VERIFIED	\N	\N	\N	1	21	\N
22	2025-07-24 12:25:38.857672	2025-07-24 12:25:38.857672	\N	DBAILE03	$2b$10$4IJ8ibZSrXl5qnn05V3TquKiBIyLXV142zUB.H.P6QVGf5E.lWlS.	0	VERIFIED	\N	\N	\N	1	22	\N
23	2025-07-24 12:25:38.931255	2025-07-24 12:25:38.931255	\N	TCARLI01	$2b$10$aG4C3WIs.obWYCf0WpY0hexbYK25KWqi2jRCHMlD6B7ivCRpMuoZm	0	VERIFIED	\N	\N	\N	1	23	\N
24	2025-07-24 12:25:39.001741	2025-07-24 12:25:39.001741	\N	NCHEN01	$2b$10$yJwzA0ydniVJ8oMIxdUqOeBto1awmq476UaUqNgV6yoNwVwl3xx92	0	VERIFIED	\N	\N	\N	1	24	\N
25	2025-07-24 12:25:39.065252	2025-07-24 12:25:39.065252	\N	RCLOAT01	$2b$10$rHEbRZ7P8tMiztWqJtWgzuYBrWtHNyLds1ObXCN.93Woq3EgVRrEO	0	VERIFIED	\N	\N	\N	1	25	\N
26	2025-07-24 12:25:39.12571	2025-07-24 12:25:39.12571	\N	LFEREL01	$2b$10$2Z7j1aa8d503pNUTgIp80umr6jp8qL12EvZhrDGrXkafVCP6OlTvi	0	VERIFIED	\N	\N	\N	1	26	\N
27	2025-07-24 12:25:39.18129	2025-07-24 12:25:39.18129	\N	GTOLED01	$2b$10$tn4ugVhNpHJsJWnLpPnrBeKO/12ee58k1pliemyIoYCfSfDMC1Ch.	0	VERIFIED	\N	\N	\N	1	27	\N
28	2025-07-24 12:25:39.241408	2025-07-24 12:25:39.241408	\N	PDELES01	$2b$10$7pHYaTg9Mqo68xcwRUszP.sOcvhF7WUbgn/vzDa2PpjYQ/mxN8yYC	0	VERIFIED	\N	\N	\N	1	28	\N
29	2025-07-24 12:25:39.297165	2025-07-24 12:25:39.297165	\N	JDESMA01	$2b$10$d1fWjXgXaRcpJg7sg0D5wuhpxwlu2frO2AnCF3MNi79r.S111OQoW	0	VERIFIED	\N	\N	\N	1	29	\N
30	2025-07-24 12:25:39.354521	2025-07-24 12:25:39.354521	\N	YDESVI01	$2b$10$69.fjMz3HmdyNxvfk0.7G.gXMepSpVI/GUnVpPr0k19twDemd4cOW	0	VERIFIED	\N	\N	\N	1	30	\N
31	2025-07-24 12:25:39.42027	2025-07-24 12:25:39.42027	\N	JDETUR01	$2b$10$JjZBKvVkHUxn/8UoukhRn.pQI3sKUPfAdr4toAJ6UCKu6JkPQkvQu	0	VERIFIED	\N	\N	\N	1	31	\N
32	2025-07-24 12:25:39.487953	2025-07-24 12:25:39.487953	\N	ALISSO01	$2b$10$uVYXOCD1r4pQRMT7q20jIOWT0nrkJo9ntNIO0sZ9IBFLX0pLTgt6q	0	VERIFIED	\N	\N	\N	1	32	\N
33	2025-07-24 12:25:39.557199	2025-07-24 12:25:39.557199	\N	JDEVRI01	$2b$10$W.DBmjLkwoGwCip8QkDxo.i0EzacddyWKx6x3zH1o1nI/dWXBRpHi	0	VERIFIED	\N	\N	\N	1	33	\N
34	2025-07-24 12:25:39.629081	2025-07-24 12:25:39.629081	\N	EETIEN01	$2b$10$x2NV1MmXEwZ9yTCG8OBQ8OzxPdFrmkZ9wwxJwy9YKwEPruzexjWHC	0	VERIFIED	\N	\N	\N	1	34	\N
35	2025-07-24 12:25:39.693085	2025-07-24 12:25:39.693085	\N	IFAIN01	$2b$10$TQ.J8raRZsE8vwjmj7LUVeKo/gxkL1e9P8Ns1gNmBeJaSI3VOHxGa	0	VERIFIED	\N	\N	\N	1	35	\N
36	2025-07-24 12:25:39.751444	2025-07-24 12:25:39.751444	\N	PFLORE01	$2b$10$H3k1qFO2n93EefNoCIfr8ORVF7mIZKVdQ3Kr54l8tw6XAYCDYEOaW	0	VERIFIED	\N	\N	\N	1	36	\N
37	2025-07-24 12:25:39.81638	2025-07-24 12:25:39.81638	\N	RFRIED01	$2b$10$wQP0tU7fD13Wk3CNmu/pve5iCuXrAM10ZZloU1KbREEfhifFyg2P.	0	VERIFIED	\N	\N	\N	1	37	\N
38	2025-07-24 12:25:39.879752	2025-07-24 12:25:39.879752	\N	JGAUTH01	$2b$10$NcDMYyisH0R/dzseW6NSMOidEQLoiwrJ2WfhV8J60rX6sI/28XQei	0	VERIFIED	\N	\N	\N	1	38	\N
39	2025-07-24 12:25:39.943319	2025-07-24 12:25:39.943319	\N	GGAUTI01	$2b$10$9x22lZpI4rg9zlawmymf7OAs9fktQpp1mpPlydrLmviQoVWrDZ6Ey	0	VERIFIED	\N	\N	\N	1	39	\N
40	2025-07-24 12:25:40.009986	2025-07-24 12:25:40.009986	\N	RLEMIR01	$2b$10$wpJYagNLt1DxhZUz4JeG.ewv0p9kR9z8eNURNmZR5Zm6tAIAIdxpy	0	VERIFIED	\N	\N	\N	1	40	\N
41	2025-07-24 12:25:40.070576	2025-07-24 12:25:40.070576	\N	MGREEN01	$2b$10$eMTtEa8io36sD/V9Q6av2OPfVVbV6ATV7rOMffLXtJ.POKEszqkxS	0	VERIFIED	\N	\N	\N	1	41	\N
42	2025-07-24 12:25:40.137816	2025-07-24 12:25:40.137816	\N	AGOULA01	$2b$10$f5P6r4RbSNGxDrJXV6rRaujnw..O2ktNdx.WO5Ij7wPrGBGqS2RbC	0	VERIFIED	\N	\N	\N	1	42	\N
43	2025-07-24 12:25:40.20722	2025-07-24 12:25:40.20722	\N	THETIE01	$2b$10$OnN2SGD1nDh5W0/hM6WCtOHQkqfomYgbabxTxPeUtev/C69QetU4q	0	VERIFIED	\N	\N	\N	1	43	\N
44	2025-07-24 12:25:40.282115	2025-07-24 12:25:40.282115	\N	JJACOB01	$2b$10$SNlEZ/js/LJAxyRgHFSPCerhJYfGTsZP2RALSUCCX9uy1HyGV1a7y	0	VERIFIED	\N	\N	\N	1	44	\N
45	2025-07-24 12:25:40.349395	2025-07-24 12:25:40.349395	\N	FLEBAS01	$2b$10$QCImW3E1dXQdwj7qG8decejvQayEzNHJ9xLHFt3wj3LippLxUbtkO	0	VERIFIED	\N	\N	\N	1	45	\N
46	2025-07-24 12:25:40.424373	2025-07-24 12:25:40.424373	\N	DLECUL02	$2b$10$/ak7vzEqG1vjB8qp7JHAi.OzK9XgOUrSnixhuP/GuOSdK9/RUX1iW	0	VERIFIED	\N	\N	\N	1	46	\N
47	2025-07-24 12:25:40.49759	2025-07-24 12:25:40.49759	\N	NMARTI01	$2b$10$qIqRLpmAkhMvH0bV7Xo4iebvslxve/pNT4P2WeCiNEW/iV/PM7J1q	0	VERIFIED	\N	\N	\N	1	47	\N
48	2025-07-24 12:25:40.562594	2025-07-24 12:25:40.562594	\N	NMONCA01	$2b$10$SbGGnPcJR70oouV0ImqjLuUczkt.6FZILor2md3nT39oHTSMucjgi	0	VERIFIED	\N	\N	\N	1	48	\N
49	2025-07-24 12:25:40.629322	2025-07-24 12:25:40.629322	\N	RPESOA01	$2b$10$IPgP4UNFEwcEvtknL4rkZe0e2ofA.Pzo6fw9GHIt/smYzF9UpGjhC	0	VERIFIED	\N	\N	\N	1	49	\N
50	2025-07-24 12:25:40.702812	2025-07-24 12:25:40.702812	\N	XPONS01	$2b$10$Innpox4x3/Y7L6l6QCpQA.e6xFO45napVJqYzQbxHhAAAHfvOmx6e	0	VERIFIED	\N	\N	\N	1	50	\N
51	2025-07-24 12:25:40.77777	2025-07-24 12:25:40.77777	\N	DRAYNA01	$2b$10$w0x1k22Pdl3ILrakdwtWBuQGkf1/p8qEm.2uUWWOZuhYweK5./F7a	0	VERIFIED	\N	\N	\N	1	51	\N
52	2025-07-24 12:25:40.85302	2025-07-24 12:25:40.85302	\N	RREAVI01	$2b$10$F8M.juAmong4f5HQICN82.S7fl6m4ELLSYTIBP5CCnkDf8V6CjgMq	0	VERIFIED	\N	\N	\N	1	52	\N
53	2025-07-24 12:25:40.928462	2025-07-24 12:25:40.928462	\N	TROHAU01	$2b$10$4HBX3432KUdF5Pk/CxZggeniiTcBYDeSLYRUasYEfcpynq/6JyjS.	0	VERIFIED	\N	\N	\N	1	53	\N
54	2025-07-24 12:25:41.005248	2025-07-24 12:25:41.005248	\N	ESENAR01	$2b$10$LQTqusz6Vx7i5Yy0TlMDEOsnlrkFDeFL5SwDGjrU0OKd3t2w3HCt6	0	VERIFIED	\N	\N	\N	1	54	\N
55	2025-07-24 12:25:41.076617	2025-07-24 12:25:41.076617	\N	FVENTU01	$2b$10$aiKC7a2xjUNkjgeFwjEWR.jaH/RVRUiKws/vUyMjbcRjpC14.lXi2	0	VERIFIED	\N	\N	\N	1	55	\N
56	2025-07-24 12:25:41.152117	2025-07-24 12:25:41.152117	\N	IVITTE01	$2b$10$n1LfscVV6y6hbGin5oePyOmK7pi3.3tC400y12QqoHlskyXUWWvd.	0	VERIFIED	\N	\N	\N	1	56	\N
57	2025-07-24 12:25:41.227528	2025-07-24 12:25:41.227528	\N	CWININ01	$2b$10$Xy/xWGmEYLbkWfMJwYTLyOsNVUTfZfGUqsw5PoKL8haC3U9EHv0mS	0	VERIFIED	\N	\N	\N	1	57	\N
58	2025-07-24 12:25:41.28471	2025-07-24 12:25:41.28471	\N	JTAYLO06	$2b$10$rvq1E0QBVTkZwHtzXoJWLumCw0o5DE7DcNeh33Vlxi5VhX6QLlibS	0	VERIFIED	\N	\N	\N	1	58	\N
59	2025-07-24 12:25:41.338536	2025-07-24 12:25:41.338536	\N	VHUBER01	$2b$10$2I/g45R4ghmVr/vz5ouNruehzTjy6nnM882s6j9zdVJkEJZprun52	0	VERIFIED	\N	\N	\N	1	59	\N
60	2025-07-24 12:25:41.393345	2025-07-24 12:25:41.393345	\N	ACOCAT01	$2b$10$NZXSWcrFnd.HicU9ScAikeLbxiI2TYcqp49QxbYBZMp5JHw6UEw9e	0	VERIFIED	\N	\N	\N	1	60	\N
61	2025-07-24 12:25:41.457356	2025-07-24 12:25:41.457356	\N	FHOUSS01	$2b$10$Hbk45TYFASlDSAfz5ADEsO0Jnm0uLhMOlChS87A3LUg2r2dBwc1eq	0	VERIFIED	\N	\N	\N	1	61	\N
65	2025-07-24 12:25:41.6619	2025-07-24 12:25:41.6619	\N	VLIMIT01	$2b$10$bWMzPfye8iUd4CwePUqZg.LUEYNnqq.PnSwPRaxDw/iLW3rDy7R3i	0	VERIFIED	\N	\N	\N	1	65	\N
62	2025-07-24 12:25:41.515334	2025-07-24 12:25:41.515334	\N	MDUPIN01	$2b$10$2UNnOa/MimwbTEQfxaW2Beuo9xuhdAvqpNDurAoq.xa4kuEiKJ7XW	0	VERIFIED	\N	\N	\N	1	62	\N
63	2025-07-24 12:25:41.562245	2025-07-24 12:25:41.562245	\N	AJIMEN02	$2b$10$1daGcfDZnpG6pCTPg4s4ae9p2iw9LQpJP4fv2cKw2k8EVMLJTUbSm	0	VERIFIED	\N	\N	\N	1	63	\N
64	2025-07-24 12:25:41.610338	2025-07-24 12:25:41.610338	\N	SETCHE01	$2b$10$vcqNGEYGLF4uRdQNtxCKZuAIDG65WmCssfdctwbkF/6W/hzUcx2Rm	0	VERIFIED	\N	\N	\N	1	64	\N
66	2025-07-24 12:45:30.194666	2025-07-24 13:58:17.912523	coralie.bordenave@dassault-aviation.com	CBORD	$2b$10$4XPNnMMrLPFxd4k8tdKg4urfjw2OfWiy.zuaygqfEPJ1DseUZ9lOW	0	VERIFIED	\N	\N	\N	1	66	\N
\.


--
-- Data for Name: areas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.areas (id, "createdAt", "updatedAt", title, image, "planeId") FROM stdin;
1	2025-07-24 09:34:45.796001	2025-07-24 09:34:45.796001	Entryway	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_08_CHAPITRE_2024-12-05.jpg	1
2	2025-07-24 09:34:45.829801	2025-07-24 09:34:45.829801	Cabin	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_04_CHAPITRE_2024-12-05.jpg	1
3	2025-07-24 09:34:45.848395	2025-07-24 09:34:45.848395	Aft Lavatory	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_02_CHAPITRE_2024-12-05.jpg	1
4	2025-07-24 09:35:09.516505	2025-07-24 09:35:09.516505	Forward Closet Finishing	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/HQ_CamChap_01_EntryWay_L4960H3507.jpg	2
5	2025-07-24 09:35:09.529634	2025-07-24 09:35:09.529634	Crew Rest Finishing	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/LQ_CamChap_01_CrewRest_L4960H3507.jpg	2
6	2025-07-24 09:35:09.539958	2025-07-24 09:35:09.539958	Forward Lavatory Finishing	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/HQ_CamChap_01_EntryWayFWDLav_L4960H3507.jpg	2
7	2025-07-24 09:35:09.550896	2025-07-24 09:35:09.550896	Galley Finishing	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/HQ_CamChap_01_EntryWay_L4960H3507.jpg	2
8	2025-07-24 09:35:09.566418	2025-07-24 09:35:09.566418	Club Lounge	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/HQ_CamChap_03_Lounge01ClubView_L4960H3507-01.jpg	2
9	2025-07-24 09:35:09.575052	2025-07-24 09:35:09.575052	Dining	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/HQ_CamChap_04_Lounge02Dining_L4960H3507.jpg	2
10	2025-07-24 09:35:09.58458	2025-07-24 09:35:09.58458	Meridian & Divan	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/HQ_CamChap_05_Lounge03Divan_L4960H3507co.jpg	2
11	2025-07-24 09:35:09.599422	2025-07-24 09:35:09.599422	Bedroom	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/HQ_CamCHAP_08_BedView_L4960H3507co.jpg	2
12	2025-07-24 09:35:09.611081	2025-07-24 09:35:09.611081	Falcon Privacy Suite Finishing	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/LQ_CamChap_06_Lounge04FPS02_L4960H3507co.jpg	2
13	2025-07-24 09:35:09.612966	2025-07-24 09:35:09.612966	Shower	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/LQ_CamCHAP_09_AftLavat_L4960H3507co.jpg	2
14	2025-07-24 09:35:09.630959	2025-07-24 09:35:09.630959	Bulkheads	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/LQ_CamCHAP_05b_ViewLH-Lounge1_LH-Club_L4960H3507.jpg	2
15	2025-07-24 09:35:09.647992	2025-07-24 09:35:09.647992	Classic Bathroom	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/HQ_CamChap_07_AftVanity01_L4960H3507.jpg	2
16	2025-07-24 09:35:09.665389	2025-07-24 09:35:09.665389	ENTRYWAY	https://api.dassaultfalcon.com/lacollection-smtp/photos/areas/HQ_CamChap_01_EntryWay_L4960H3507.jpg	2
17	2025-07-24 09:35:09.666386	2025-07-24 09:35:09.666386	MAIN CABIN	https://api.dassaultfalcon.com/lacollection-smtp/photos/areas/LQ_CamChap_02_CabinView_L4960H3507.jpg	2
18	2025-07-24 09:35:09.667375	2025-07-24 09:35:09.667375	AFT LAVATORY 	https://api.dassaultfalcon.com/lacollection-smtp/photos/areas/LQ_CamCHAP_09_AftLavat_L4960H3507.jpg	2
19	2025-07-24 09:35:09.668265	2025-07-24 09:35:09.668265	MAIN CABIN BULKHEAD 	https://api.dassaultfalcon.com/lacollection-smtp/photos/areas/LQ_CamCHAP_05b_ViewLH-Lounge1_LH-Club_L4960H3507.jpg	2
20	2025-07-24 09:35:25.806383	2025-07-24 09:35:25.806383	Galley bar 	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/HQ_Chapter1_EntryWay_L4960H35078bd.jpg	3
21	2025-07-24 09:35:25.827505	2025-07-24 09:35:25.827505	Forward lavatory	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/HQ_Chapter1_FwdLav_L4960H3507bd.jpg	3
22	2025-07-24 09:35:25.835114	2025-07-24 09:35:25.835114	Forward lounge	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/HQ_Chapter2_MainCabin_L4960H3507BD.jpg	3
23	2025-07-24 09:35:25.846268	2025-07-24 09:35:25.846268	Middle lounge	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/HQ_Chapter2-B_MiddleLounge_L4960H3507BD.jpg	3
24	2025-07-24 09:35:25.858793	2025-07-24 09:35:25.858793	Aft lounge	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/HQ_Chapter2-C_AftLounge_L4960H3507BD.jpg	3
25	2025-07-24 09:35:25.866939	2025-07-24 09:35:25.866939	Aft lavatory	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/HQ_Chapter3_AftLavatory_L3507H4960BD.jpg	3
26	2025-07-24 09:35:37.365093	2025-07-24 09:35:37.365093	entryway	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/F6X_SNxxx_DN_Sch01_HQ_View_EntryWay2_2023-01-05.jpg	4
27	2025-07-24 09:35:37.388219	2025-07-24 09:35:37.388219	forward lounge	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/HQ_View_CabinClub_L4960H3507_Night.jpg	4
28	2025-07-24 09:35:37.39962	2025-07-24 09:35:37.39962	middle lounge	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/HQ_View_CabinFWD_L4960H3507.jpg	4
29	2025-07-24 09:35:37.419301	2025-07-24 09:35:37.419301	aft lounge	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/F6X_SNxxx_DN_Sch01_HQ_View_DivanAFTView_2023-01-05_Coralie.jpg	4
30	2025-07-24 09:35:37.425154	2025-07-24 09:35:37.425154	aft lavatory	https://api.dassaultfalcon.com/lacollection-smtp/photos/planes/F6X_SNxxx_DN_Sch01_HQ_View_AftLavatory_2023-01-05_CORALIE.jpg	4
\.


--
-- Data for Name: options; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.options (id, "createdAt", "updatedAt", name, image, serial, weight, price, palette, type, "partId") FROM stdin;
1	2025-07-24 09:34:45.801322	2025-07-24 09:34:45.801322	Stainless Steel	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_13_TECH_2024-12-05.jpg	6.210.1	In Package	In Package		Essentials	1
2	2025-07-24 09:34:45.803845	2025-07-24 09:34:45.803845	Glaskote	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/F2L_SNxxx_DN_Scheme01_HQ_13_TECH_2024-12-05.jpg	6.210.12	0	7800	assets/images/palettes/Glaskote.png	Essentials	1
3	2025-07-24 09:34:45.807732	2025-07-24 09:34:45.807732	Solid Surface	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/F2L_SNxxx_DN_Scheme01_LQ_09_TECH_2024-12-05A.jpg	6.210.2a	0	In Package	assets/images/palettes/SolidSurface.png	Essentials	2
4	2025-07-24 09:34:45.809533	2025-07-24 09:34:45.809533	Stone	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/F2L_SNxxx_DN_Scheme01_LQ_09_TECH_2024-12-05.jpg	6.210.2	Standard	39200	assets/images/palettes/Stone.png	AvantGarde	2
5	2025-07-24 09:34:45.817593	2025-07-24 09:34:45.817593	Metal plated	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_12_TECH_2024-12-05.jpg	6.210.9a	0	In Package	assets/images/palettes/Stone.png	Essentials	3
6	2025-07-24 09:34:45.820013	2025-07-24 09:34:45.820013	Wood veneer	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_12_TECH_2024-12-05.jpg	6.210.9	Standard	No charge	assets/images/palettes/Wood.png	Essentials	3
7	2025-07-24 09:34:45.822857	2025-07-24 09:34:45.822857	Stainless steel	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_25_TECH_2024-12-05.jpg	6.500.10	In Package	In Package		Essentials	4
8	2025-07-24 09:34:45.824147	2025-07-24 09:34:45.824147	Glasskote	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_25_CHAPITRE_2024-12-05.jpg	6.500.1b	0.1	8700	assets/images/palettes/Glaskote.png	Essentials	4
9	2025-07-24 09:34:45.826992	2025-07-24 09:34:45.826992	Carpet	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_10_TECH_2024-12-05.jpg	6.500.0b	In Package	In Package	Carpet.png	Essentials	5
10	2025-07-24 09:34:45.828386	2025-07-24 09:34:45.828386	Vinyl	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_10_TECH_2024-12-05.jpg	6.500.2	10.6	10500	assets/images/palettes/Vinyl.png	Essentials	5
11	2025-07-24 09:34:45.832869	2025-07-24 09:34:45.832869	Wood veneer	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_05_CHAPITRE_2024-12-05.jpg	6.200.20	In Package	In Package	assets/images/palettes/Wood.png	Essentials	6
12	2025-07-24 09:34:45.835242	2025-07-24 09:34:45.835242	Wood vener	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_06_CHAPITRE_2024-12-05.jpg	6.200.30	In Package	In Package	assets/images/palettes/Wood.png	Essentials	7
13	2025-07-24 09:34:45.838108	2025-07-24 09:34:45.838108	Two (2), 1/8-Inch Metal Trim Strips and Vertical Join Seam below Tables	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_16_TECH_2024-12-05.jpg	6.300.5	In Package	In Package		Essentials	8
14	2025-07-24 09:34:45.839511	2025-07-24 09:34:45.839511	One (1), 1/8-Inch Metal Trim Strip and Vertical Join Seam below Tables	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_16_TECH_2024-12-05.jpg	6.300.5d	0.5	No charge		Essentials	8
15	2025-07-24 09:34:45.840847	2025-07-24 09:34:45.840847	Upholstery	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_19_TECH_2024-12-05.jpg	6.300.41	In Package	In Package		Essentials	8
16	2025-07-24 09:34:45.843697	2025-07-24 09:34:45.843697	Wood veneer	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_11_TECH_2024-12-05.jpg	6.300.7	In Package	In Package	assets/images/palettes/Wood.png	Essentials	9
17	2025-07-24 09:34:45.845255	2025-07-24 09:34:45.845255	One (1), 1/8-Inch Metal Trim Strip and Vertical Join Seam below Tables	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_14B_TECH_2024-12-05.jpg	6.400.1	0	In Package		Essentials	9
18	2025-07-24 09:34:45.846178	2025-07-24 09:34:45.846178	Wood Veneer with Door in Mirror	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_14_TECH_2024-12-05.jpg	6.400.1b	0	No charge		Essentials	9
19	2025-07-24 09:34:45.847265	2025-07-24 09:34:45.847265	Wood Veneer with Leather/Ultraleather insert	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_14_TECH_2024-12-05.jpg	6.400.1g	0.1	10100		AvantGarde	9
20	2025-07-24 09:34:45.852064	2025-07-24 09:34:45.852064	Glaskote	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_24_TECH_2024-12-05.jpg	6.210.12b	In Package	In Package	assets/images/palettes/Glaskote.png	Essentials	10
21	2025-07-24 09:34:45.854337	2025-07-24 09:34:45.854337	Solid Surface	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_21_TECH_2024-12-05.jpg	6.210.3a	In Package	In Package	assets/images/palettes/SolidSurface.png	Essentials	11
22	2025-07-24 09:34:45.855069	2025-07-24 09:34:45.855069	Stone	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_22_TECH_2024-12-05.jpg	6.210.3	1.6	21400	assets/images/palettes/Stone.png	AvantGarde	11
23	2025-07-24 09:34:45.856457	2025-07-24 09:34:45.856457	Carpet	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_23_TECH_2024-12-05.jpg	6.500.0a	In Package	In Package	assets/images/palettes/Carpet.png	Essentials	12
24	2025-07-24 09:34:45.857167	2025-07-24 09:34:45.857167	Vinyl	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_23_TECH_2024-12-05.jpg	6.500.2a	7.9	8000	assets/images/palettes/Vinyl.png	Essentials	12
25	2025-07-24 09:34:45.859294	2025-07-24 09:34:45.859294	Soft good	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_21_TECH_2024-12-05.jpg	6.400.2	In Package	In Package	assets/images/palettes/Wood.png	Essentials	13
26	2025-07-24 09:34:45.860606	2025-07-24 09:34:45.860606	Soft good	assets/images/options/F2L_SNxxx_DN_Scheme01_HQ_20_TECH_2024-12-05_V2.jpg	6.410.2	In Package	In Package	assets/images/palettes/Ultraleather.png	Essentials	13
27	2025-07-24 09:35:09.521262	2025-07-24 09:35:09.521262	Forward Entryway Closet Finishing: Wood Veneer /Paint with Wood Veneer/ Paint Door	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_01_EntryWCloset_L3507H4960_0036.jpg	6.240.10	In Package	In Package		Essentials	14
28	2025-07-24 09:35:09.523367	2025-07-24 09:35:09.523367	Forward Entryway Closet Finishing: Aft Side, Wood Veneer/ Paint	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_01_EntryWEntry_L3507H4960_0038.jpg	6.240.20	In Package	In Package		Essentials	14
29	2025-07-24 09:35:09.52523	2025-07-24 09:35:09.52523	Forward Entryway Closet Finishing: Wood Veneer /Paint with Mirror Door	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_01_EntryWCloset_L3507H4960_0035.jpg	6.240.11	1.4	Upgrade ($)		AvantGarde	14
30	2025-07-24 09:35:09.526752	2025-07-24 09:35:09.526752	Forward Entryway Closet Finishing: Aft Side, Wall Covering		6.240.21	-2.2	Upgrade ($)	assets/images/palettes/DecoFilm.png	AvantGarde	14
31	2025-07-24 09:35:09.532351	2025-07-24 09:35:09.532351	Crew Rest Forward Bulkhead Finishing: Forward Side, Wood Veneer / Paint	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_01_EntryWEntry_L3507H4960_0038.jpg	6.230.10	In Package	In Package		Essentials	16
32	2025-07-24 09:35:09.533796	2025-07-24 09:35:09.533796	Crew Rest Sliding Panel Finishing: Aft Face, Quilting	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_02_CrewRPanel_L3507H4960_0041.jpg	6.230.20	In Package	In Package		Essentials	16
33	2025-07-24 09:35:09.5354	2025-07-24 09:35:09.5354	Crew Rest Forward Bulkhead Finishing: Forward Side, Wall Covering	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_01_EntryWEntry_L3507H4960_0037.jpg	6.230.11	-2,2	Upgrade ($)	assets/images/palettes/DecoFilm.png	AvantGarde	16
34	2025-07-24 09:35:09.536683	2025-07-24 09:35:09.536683	Crew Rest Sliding Panel Finishing: Aft Face, Upholstery/Leather with Recess	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_02_CrewRPanel_L3507H4960_0040.jpg	6.230.21	-0,9	Upgrade ($)	assets/images/palettes/Ultraleather.png	AvantGarde	16
35	2025-07-24 09:35:09.538096	2025-07-24 09:35:09.538096	Crew Rest Sliding Panel Finishing: Aft Face, Upholstery/Leather	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_02_CrewRPanel_L3507H4960_0040BIS.jpg	6.230.22	Upgrade (Lbs)	Upgrade ($)	assets/images/palettes/Ultraleather.png	AvantGarde	16
66	2025-07-24 09:35:09.607879	2025-07-24 09:35:09.607879	Top: Wood Veneer/ Paint	https://api.dassaultfalcon.com/lacollection-smtp/photos/parts/LQ_CamTECH_01_BedCredenza_L3507H4960_0045.jpg	6.300.31A	In Package	In Package	assets/images/palettes/Wood.png	Essentials	30
36	2025-07-24 09:35:09.542475	2025-07-24 09:35:09.542475	Forward Lavatory Aft Bulkhead Finishing:  Forward Face, Wood Veneer/ Paint	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamChap_01_EntryWay_L4960H3507BIS.jpg	6.220.10	In Package	In Package	assets/images/palettes/Wood.png	Essentials	17
37	2025-07-24 09:35:09.545416	2025-07-24 09:35:09.545416	Sink : Glaskote	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_01_FWDLavat_L3507H4960_0031.jpg	6.210.12A	In Package	In Package	assets/images/palettes/Glaskote.png	Essentials	18
38	2025-07-24 09:35:09.548321	2025-07-24 09:35:09.548321	Forward Lavatory Backsplash Finishing: Solid Surface	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_01_FWDLavat_L3507H4960_0031.jpg	6.210.5	In Package	In Package	assets/images/palettes/SolidSurface.png	Essentials	19
39	2025-07-24 09:35:09.549631	2025-07-24 09:35:09.549631	Forward Lavatory Backsplash Finishing: Granite/Marble/Quartz	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_01_FWDLavat_L3507H4960_0030.jpg	6.210.5a	2.2	Upgrade ($)	assets/images/palettes/Stone.png	AvantGarde	19
40	2025-07-24 09:35:09.555048	2025-07-24 09:35:09.555048	Sink : Glaskote	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_01_GalleyCountSink_L3507H4960.jpg	6.210.12	In Package	In Package	assets/images/palettes/Glaskote.png	Essentials	21
41	2025-07-24 09:35:09.557588	2025-07-24 09:35:09.557588	Solid Surface	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_01_GalleyCountTop_L3507H4960_0030.jpg	6.210.2A	In Package	In Package	assets/images/palettes/SolidSurface.png	Essentials	22
42	2025-07-24 09:35:09.558695	2025-07-24 09:35:09.558695	Granite/Marble/Quartz	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_01_GalleyCountTop_L3507H4960_0031.jpg	6.210.2	4,0	Upgrade ($)	assets/images/palettes/Stone.png	AvantGarde	22
43	2025-07-24 09:35:09.560849	2025-07-24 09:35:09.560849	Carpet	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_01_EntryWFloor_L3507H4960_0034.jpg	6.500.0B	In Package	In Package	assets/images/palettes/Carpet.png	Essentials	23
44	2025-07-24 09:35:09.561949	2025-07-24 09:35:09.561949	Vinyl	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_01_EntryWFloor_L3507H4960_0033.jpg	6.500.2	21.1	Upgrade ($)	assets/images/palettes/Vinyl.png	Essentials	23
45	2025-07-24 09:35:09.562869	2025-07-24 09:35:09.562869	threshold plate: Polished Aluminium	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_03_CabinThreslholdP_L3507H4960_0045.jpg	6.500.10	In Package	In Package	assets/images/palettes/Metal.png	Essentials	23
46	2025-07-24 09:35:09.563772	2025-07-24 09:35:09.563772	Flooring: Granite/Marble/Quartz	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_01_EntryWFloor_L3507H4960_0032.jpg	6.500.3B	59,8	Upgrade ($)	assets/images/palettes/Stone.png	AvantGarde	23
47	2025-07-24 09:35:09.564541	2025-07-24 09:35:09.564541	Flooring: Hard Wood 	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_01_EntryWFloorWood_L3507H4960_WOOD.jpg	6.500.4B	22	Upgrade ($)	assets/images/palettes/Wood.png	AvantGarde	23
48	2025-07-24 09:35:09.565637	2025-07-24 09:35:09.565637	Threshold plate: Glaskote	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_03_CabinThreslholdP_L3507H4960_0044.jpg	6.500.1B	0	Upgrade ($)	assets/images/palettes/Glaskote.png	AvantGarde	23
49	2025-07-24 09:35:09.567962	2025-07-24 09:35:09.567962	Console Table Finishing: Wood Veneer/ Paint with Wood Veneer/ Paint Edge	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_02_ClubConsoleTable_L3507H4960.jpg	6.200.20A	In Package	In Package	assets/images/palettes/Wood.png	Essentials	24
50	2025-07-24 09:35:09.570646	2025-07-24 09:35:09.570646	Service Ledge Finishing: Upholstery/Leather w/ Seams	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_02_ClubSideWallFront_L3507H4960.jpg	6.300.40A	In Package	In Package	assets/images/palettes/Ultraleather.png	Essentials	25
51	2025-07-24 09:35:09.572119	2025-07-24 09:35:09.572119	Top Surface: Wood Veneer/ Paint	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_02_ClubSideWallTop_L3507H4960.jpg	6.300.41A	In Package	In Package	assets/images/palettes/Wood.png	Essentials	25
52	2025-07-24 09:35:09.573389	2025-07-24 09:35:09.573389	Sideledge Open Storage Interior: Upholstery/Leather	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_02_ClubSideWallInsert_L3507H4960.jpg	6.300.43A	In Package	In Package	assets/images/palettes/Ultraleather.png	Essentials	25
53	2025-07-24 09:35:09.578003	2025-07-24 09:35:09.578003	Wood Veneer/ Paint with Wood Veneer/ Paint Edge	https://api.dassaultfalcon.com/lacollection-smtp/photos/parts/HQ_CamChap_04_Lounge02Diningtable_L4960H3507.jpg	6.200.30A	In Package	In Package	assets/images/palettes/Wood.png	Essentials	26
54	2025-07-24 09:35:09.580791	2025-07-24 09:35:09.580791	Facade: Upholstery/Leather with Top Stitch	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_02_MidCabFacade_L3507H4960.jpg	6.300.30a	In Package	In Package	assets/images/palettes/Ultraleather.png	Essentials	27
55	2025-07-24 09:35:09.582011	2025-07-24 09:35:09.582011	Top: Wood Veneer/Paint	https://api.dassaultfalcon.com/lacollection-smtp/photos/parts/LQ_CamTECH_01_BedCredenza_L3507H4960_0045.jpg	6.300.31a	In Package	In Package	assets/images/palettes/Wood.png	Essentials	27
56	2025-07-24 09:35:09.583229	2025-07-24 09:35:09.583229	Top: Granite/Marble/Quartz	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_01_BedCredenza_L3507H4960_0046.jpg	6.300.31b	15.4	Upgrade ($)	assets/images/palettes/Stone.png	AvantGarde	27
57	2025-07-24 09:35:09.587695	2025-07-24 09:35:09.587695	Divan Lower Facade: Upholstery/Leather	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_04_DivanLowerFacade_L3507H4960.jpg	6.260.10	In Package	In Package	assets/images/palettes/Ultraleather.png	Essentials	28
58	2025-07-24 09:35:09.589407	2025-07-24 09:35:09.589407	Divan Headrest: Upholstery/Leather	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_04_DivanHeadrest_L3507H4960.jpg	6.260.20	In Package	In Package	assets/images/palettes/Ultraleather.png	Essentials	28
59	2025-07-24 09:35:09.591173	2025-07-24 09:35:09.591173	Divan Cushion: Upholstery/Leather	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_04_DivanCushion_L3507H4960.jpg	6.260.30	In Package	In Package	assets/images/palettes/Upholstery.png	Essentials	28
60	2025-07-24 09:35:09.594071	2025-07-24 09:35:09.594071	Divan Backrest: Upholstery/Leather	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_04_DivanBackrest_L3507H4960.jpg	6.260.40	In Package	In Package	assets/images/palettes/Upholstery.png	Essentials	28
61	2025-07-24 09:35:09.595975	2025-07-24 09:35:09.595975	Divan Armrest: Upholstery/Leather	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_04_DivanArmrest_L3507H4960.jpg	6.260.50	In Package	In Package	assets/images/palettes/Upholstery.png	Essentials	28
62	2025-07-24 09:35:09.597732	2025-07-24 09:35:09.597732	Divan Side Storage Top Surface: Wood Veneer/Paint	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_04_DivanSideStorage_L3507H4960.jpg	6.260.60	In Package	In Package	assets/images/palettes/Paint.png	Essentials	28
63	2025-07-24 09:35:09.601362	2025-07-24 09:35:09.601362	Bed Header Exterior: Quilting	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_01_BedBedHeader_L3507H4960_0034.jpg	6.270.10B	In Package	In Package	assets/images/palettes/QuiltedLeather.png	Essentials	29
64	2025-07-24 09:35:09.602686	2025-07-24 09:35:09.602686	Bed Header Exterior: Upholstery	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_01_BedBedHeader_L3507H4960_0035.jpg	6.270.11b	-0.7	Upgrade ($)	assets/images/palettes/Upholstery.png	AvantGarde	29
65	2025-07-24 09:35:09.606346	2025-07-24 09:35:09.606346	Facade: Upholstery/Leather w/ Top Stitc	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_02_MidCabFacade_L3507H4960.jpg	6.300.30A	In Package	In Package		Essentials	30
67	2025-07-24 09:35:09.609738	2025-07-24 09:35:09.609738	Multi-Purpose Storage Cabinet Top: Granite/Marble/Quartz	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_01_BedCredenza_L3507H4960_0046.jpg	6.300.31B	15.4	Upgrade ($)	assets/images/palettes/Stone.png	AvantGarde	30
68	2025-07-24 09:35:09.614929	2025-07-24 09:35:09.614929	Sink : Glaskote	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_02_AftVanityBackSplash_L3507H4960_0043.jpg	6.210.12B	In Package	In Package	assets/images/palettes/Glaskote.png	Essentials	32
69	2025-07-24 09:35:09.619016	2025-07-24 09:35:09.619016	Backsplash: Solid Surface	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_02_AftVanityBackSplash_L3507H4960_0044.jpg	6.210.31A	In Floorplan	In Floorplan	assets/images/palettes/SolidSurface.png	Essentials	33
70	2025-07-24 09:35:09.621053	2025-07-24 09:35:09.621053	Backsplash: Granite/Marble/Quartz	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_02_AftVanityBackSplash_L3507H4960_0043.jpg	6.210.31	1.1	Upgrade ($)	assets/images/palettes/Stone.png	AvantGarde	33
71	2025-07-24 09:35:09.62549	2025-07-24 09:35:09.62549	Right-Hand Closet Door: Wood Veneer/Paint	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_02_AftToiletCloset_L3507H4960_0041.jpg	6.212.1R0	In Package	In Package	assets/images/palettes/Wood.png	Essentials	35
72	2025-07-24 09:35:09.626592	2025-07-24 09:35:09.626592	Right-Hand Closet Door: Leather Padding	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_02_AftToiletCloset_L3507H4960_0042.jpg	6.212.1R1	4,0	Upgrade ($)	assets/images/palettes/Ultraleather.png	AvantGarde	35
73	2025-07-24 09:35:09.628881	2025-07-24 09:35:09.628881	Right-Hand Countertop: Solid Surface	https://api.dassaultfalcon.com/lacollection-smtp/photos/parts/LQ_CamTECH_02_AftToiletTOP_L3507H4960_0037.jpg	6.210.30a	In Package	In Package	assets/images/palettes/SolidSurface.png	Essentials	36
74	2025-07-24 09:35:09.63005	2025-07-24 09:35:09.63005	Right-Hand Countertop: Granite/Marble/Quartz	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_02_AftToiletTOP_L3507H4960_0036.jpg	6.210.30	4.0	Upgrade ($)	assets/images/palettes/Stone.png	AvantGarde	36
75	2025-07-24 09:35:09.633096	2025-07-24 09:35:09.633096	Forward Main Cabin Bulkhead Finishing: Wood Veneer/Paint (Each, per side)	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_03_CabinGallDivider_L3507H4960_0043.jpg	6.300.10	In Package	In Package	assets/images/palettes/Wood.png	Essentials	37
76	2025-07-24 09:35:09.635352	2025-07-24 09:35:09.635352	Forward Main Cabin Bulkhead Finishing: Upholstery (Each, per side)	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_03_CabinGallDivider_L3507H4960_0042.jpg	6.300.11	-2.2	Upgrade ($)	assets/images/palettes/Ultraleather.png	AvantGarde	37
77	2025-07-24 09:35:09.637624	2025-07-24 09:35:09.637624	Main Cabin Divider Finishing: Wood Veneer/Paint (Each, per side)	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_04_CabinMIDDivider_L3507H4960_0050.jpg	6.300.20	In Package	In Package	assets/images/palettes/Wood.png	Essentials	38
78	2025-07-24 09:35:09.639036	2025-07-24 09:35:09.639036	Main Cabin Divider Finishing: Upholstery (Each, per side)	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_04_CabinMIDDivider_L3507H4960_0051.jpg	6.300.21	-2.2	Upgrade ($)	assets/images/palettes/Ultraleather.png	AvantGarde	38
79	2025-07-24 09:35:09.640755	2025-07-24 09:35:09.640755	Main Cabin Divider Finishing: Upholstery/Leather with Wood Veneer/Paint Framed Mirror (Each, per side)	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_04_CabinMIDDivider_L3507H4960_0048.jpg	6.300.22	0.7	Upgrade ($)		AvantGarde	38
80	2025-07-24 09:35:09.642387	2025-07-24 09:35:09.642387	Main Cabin Divider Finishing: Quilting with Leather/Upholstery Insert and Piping (Each, per side)	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_04_CabinMIDDivider_L3507H4960_0049.jpg	6.300.23	2.6	Upgrade ($)	assets/images/palettes/Upholstery.png	AvantGarde	38
81	2025-07-24 09:35:09.645374	2025-07-24 09:35:09.645374	Aft Main Cabin Bulkhead Finishing: Wood Veneer/ Paint (Each, per side)	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_01_BedAftDivider_L3507H4960_0033.jpg	6.300.30	In Package	In Package	assets/images/palettes/Wood.png	Essentials	39
82	2025-07-24 09:35:09.64634	2025-07-24 09:35:09.64634	Aft Main Cabin Bulkhead Finishing: Upholstery (Each, per side)	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_01_BedAftDivider_L3507H4960_0032.jpg	6.300.31	-2.2	Upgrade ($)	assets/images/palettes/Ultraleather.png	AvantGarde	39
83	2025-07-24 09:35:09.647169	2025-07-24 09:35:09.647169	Aft Main Cabin Bulkhead Finishing: Upholstery/Leather with Insert and Recess (Each, per side)	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_01_BedAftDivider_L3507H4960_0031.jpg	6.300.32	-0.9	Upgrade ($)	assets/images/palettes/Ultraleather.png	AvantGarde	39
84	2025-07-24 09:35:09.649962	2025-07-24 09:35:09.649962	Sink : Glaskote	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_05_AFtLavatSink_L3507H4960.jpg	6.210.12B	In Package	In Package	assets/images/palettes/Glaskote.png	Essentials	40
85	2025-07-24 09:35:09.654816	2025-07-24 09:35:09.654816	kkk	https://api.dassaultfalcon.com/lacollection-smtp/photos/parts/LQ_CamTECH_02_AftToiletFloor_L3507H4960_0039.jpg					Essentials	42
86	2025-07-24 09:35:09.655914	2025-07-24 09:35:09.655914	kkk	https://api.dassaultfalcon.com/lacollection-smtp/photos/parts/LQ_CamTECH_02_AftToiletFloor_L3507H4960_0039.jpg					Essentials	42
87	2025-07-24 09:35:09.658115	2025-07-24 09:35:09.658115	Left-Hand  Closet Door: Wood Veneer/ Paint	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_02_AftToiletCloset_L3507H4960_0041.jpg	6.212.1L0	In Package	In Package	assets/images/palettes/Wood.png	Essentials	43
88	2025-07-24 09:35:09.659132	2025-07-24 09:35:09.659132	Left-Hand Closet Door: Leather Padding	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_02_AftToiletCloset_L3507H4960_0042.jpg	6.212.1L1	4,0	Upgrade ($)	assets/images/palettes/Ultraleather.png	AvantGarde	43
89	2025-07-24 09:35:09.660949	2025-07-24 09:35:09.660949	Carpet	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_05_AFtLavatFloor_L3507H4960_0053.jpg	6.500.0A	In Package	In Package	assets/images/palettes/Carpet.png	Essentials	44
90	2025-07-24 09:35:09.661687	2025-07-24 09:35:09.661687	Vinyl	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_05_AFtLavatFloor_L3507H4960_0054.jpg	6.500.2A	8.8	Upgrade ($)	assets/images/palettes/Vinyl.png	Essentials	44
91	2025-07-24 09:35:09.662978	2025-07-24 09:35:09.662978	FlooringGranite/Marble/Quartz Note: Included in shower configuration"	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_CamTECH_05_AFtLavatFloor_L3507H4960_0052.jpg	6.500.3A	24,9	Upgrade ($)	assets/images/palettes/Stone.png	AvantGarde	44
92	2025-07-24 09:35:09.664148	2025-07-24 09:35:09.664148	Flooring: Hard Wood 	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/LQ_CamTECH_05_AFtLavatFloorWood_L3507H4960.jpg	6.500.4A	7	Upgrade ($)	assets/images/palettes/Wood.png	AvantGarde	44
93	2025-07-24 09:35:25.81062	2025-07-24 09:35:25.81062	Stainless Steel	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_01-Entryway_Sink_L3507H4960_1011.jpg	6.210.1	In Package	In Package		Essentials	45
94	2025-07-24 09:35:25.81327	2025-07-24 09:35:25.81327	Glaskote	https://api.dassaultfalcon.com/lacollection-smtp/photos/parts/HQ_01-Entryway_Sink_L3507H4960_1010.jpg	6.210.12	0	7800	assets/images/palettes/Glaskote.png	Essentials	45
95	2025-07-24 09:35:25.816559	2025-07-24 09:35:25.816559	Solid Surface	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_01-Entryway_CounterTop_L3507H4960_1015.jpg	6.210.2a	In Package	In Package	assets/images/palettes/SolidSurface.png	Essentials	46
96	2025-07-24 09:35:25.818547	2025-07-24 09:35:25.818547	Stone	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_01-Entryway_CounterTop_L3507H4960_1016.jpg	6.210.2	5	45300	assets/images/palettes/Stone.png	AvantGarde	46
97	2025-07-24 09:35:25.821539	2025-07-24 09:35:25.821539	Carpet	https://api.dassaultfalcon.com/lacollection-smtp/photos/parts/HQ_01-Entryway_Flooring_L3507H4960_1021.jpg	6.500.0B	In Package	In Package	assets/images/palettes/Carpet.png	Essentials	47
98	2025-07-24 09:35:25.822925	2025-07-24 09:35:25.822925	Vinyl	https://api.dassaultfalcon.com/lacollection-smtp/photos/parts/HQ_01-Entryway_Flooring_L3507H4960_1022BD.jpg	6.500.2	22,4	$10,500	assets/images/palettes/Vinyl.png	Essentials	47
99	2025-07-24 09:35:25.824699	2025-07-24 09:35:25.824699	Stone	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_01-Entryway_Flooring_L3507H4960_1020BD.jpg	6.500.3B	32,3	$115,100	assets/images/palettes/Stone.png	AvantGarde	47
100	2025-07-24 09:35:25.826128	2025-07-24 09:35:25.826128	Wood Veneer	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_01-Entryway_Flooring_L3507H4960_1023BD.jpg	6.500.4B	10,9	$106,500	assets/images/palettes/Wood.png	AvantGarde	47
101	2025-07-24 09:35:25.830039	2025-07-24 09:35:25.830039	Glaskote	https://api.dassaultfalcon.com/lacollection-smtp/photos/parts/HQ_01-Entryway_FWDLavSink_L3507H4960_1010.jpg	6.210.12a	In Package	In Package	assets/images/palettes/Glaskote.png	Essentials	48
102	2025-07-24 09:35:25.83202	2025-07-24 09:35:25.83202	Solid Surface1	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_01-Entryway_FWDLavConterTop_L3507H4960_1015.jpg	6.210.3b	In Package	In Package	assets/images/palettes/SolidSurface.png	Essentials	49
103	2025-07-24 09:35:25.833389	2025-07-24 09:35:25.833389	Stone	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_01-Entryway_FWDLavConterTop_L3507H4960_1016BD.jpg	6.210.5 	1.5	18800	assets/images/palettes/Stone.png	AvantGarde	49
104	2025-07-24 09:35:25.837857	2025-07-24 09:35:25.837857	Wood Edge	assets/images/options/HQ_02-Cabin_ConsoleT_L3507H4960_1101.jpg	6.200.21	In Package	In Package	assets/images/palettes/Wood.png	Essentials	50
105	2025-07-24 09:35:25.838959	2025-07-24 09:35:25.838959	Painted Edge	assets/images/options/HQ_02-Cabin_ConsoleT_L3507H4960_1100.jpg	6.200.21a	0	30000	assets/images/palettes/Paint.png	AvantGarde	50
106	2025-07-24 09:35:25.841579	2025-07-24 09:35:25.841579	Wood Edge	assets/images/options/HQ_02-Cabin_SideLedge_L3507H4960_1102.jpg	6.300.40a	In Package	In Package	assets/images/palettes/Wood.png	Essentials	51
107	2025-07-24 09:35:25.842883	2025-07-24 09:35:25.842883	Upholstery	assets/images/options/HQ_02-Cabin_SideLedge_L3507H4960.jpg	6.300.41	In Package	In Package	assets/images/palettes/Upholstery.png	Essentials	51
108	2025-07-24 09:35:25.844562	2025-07-24 09:35:25.844562	Painted Edge	assets/images/options/HQ_02-Cabin_SideLedge_L3507H4960_1103.jpg	6.300.40	0	37000	assets/images/palettes/Paint.png	AvantGarde	51
109	2025-07-24 09:35:25.848845	2025-07-24 09:35:25.848845	Wood Edge	assets/images/options/HQ_02-Cabin_DiningT_L3507H4960_1101.jpg	6.300.31	In Package	In Package	assets/images/palettes/Wood.png	Essentials	52
110	2025-07-24 09:35:25.850531	2025-07-24 09:35:25.850531	Painted Edge	assets/images/options/HQ_02-Cabin_DiningT_L3507H4960_1100.jpg	6.300.31a	0	15000	assets/images/palettes/Paint.png	AvantGarde	52
111	2025-07-24 09:35:25.853399	2025-07-24 09:35:25.853399	Wood Door	assets/images/options/HQ_02-Cabin_Credenza_L3507H4960_1111.jpg	6.300.30	In Package	In Package	assets/images/palettes/Wood.png	Essentials	53
112	2025-07-24 09:35:25.854562	2025-07-24 09:35:25.854562	Leather Door	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_02-Cabin_Credenza_L3507H4960_1111221.jpg	6.300.31	0	No Charge	assets/images/palettes/Ultraleather.png	AvantGarde	53
113	2025-07-24 09:35:25.855439	2025-07-24 09:35:25.855439	Painted Door	https://api.dassaultfalcon.com/lacollection-smtp/photos/options/HQ_02-Cabin_Credenza_L3507H4960_1109.jpg	6.300.32	0	10000	assets/images/palettes/Paint.png	AvantGarde	53
114	2025-07-24 09:35:25.857269	2025-07-24 09:35:25.857269	Wood	assets/images/options/HQ_02-Cabin_AFTMidCabDividerFWD_L3507H4960.jpg	6.300.8	In Package	In Package	assets/images/palettes/Wood.png	Essentials	54
115	2025-07-24 09:35:25.857975	2025-07-24 09:35:25.857975	Upholstery Insert	assets/images/options/HQ_02-Cabin_AFTMidCabDividerFWD-LH_L3507H4960.jpg	6.300.8g	0	10100	assets/images/palettes/Upholstery.png	AvantGarde	54
116	2025-07-24 09:35:25.861391	2025-07-24 09:35:25.861391	Wood Door	assets/images/options/HQ_03-Divan_StorageCab_L3507H4960.jpg	6.300.30R	In Package	In Package	assets/images/palettes/Wood.png	Essentials	55
117	2025-07-24 09:35:25.86394	2025-07-24 09:35:25.86394	Wood	assets/images/options/HQ_03-Divan_AFTLavBulkhead_L3507H4960_1111.jpg	6.400.1	In Package	In Package	assets/images/palettes/Wood.png	Essentials	56
118	2025-07-24 09:35:25.865379	2025-07-24 09:35:25.865379	Door Mirror	assets/images/options/HQ_03-Divan_AFTLavBulkhead_L3507H4960_1112.jpg	6.400.1B	6	No charge	\N	Essentials	56
119	2025-07-24 09:35:25.869959	2025-07-24 09:35:25.869959	Glaskote	assets/images/options/HQ_04-Lavatory_Sink_L3507H4960_1010.jpg	6.210.12b	In Package	In Package	assets/images/palettes/Glaskote.png	Essentials	57
120	2025-07-24 09:35:25.872426	2025-07-24 09:35:25.872426	Solid Surface	assets/images/options/HQ_04-Lavatory_CounterTop_L3507H4960_1015.jpg	6.210.3a	In Package	In Package	assets/images/palettes/SolidSurface.png	Essentials	58
121	2025-07-24 09:35:25.873425	2025-07-24 09:35:25.873425	Stone	assets/images/options/HQ_04-Lavatory_CounterTop_L3507H4960_1016.jpg	6.210.3	0,3	21400	assets/images/palettes/Stone.png	AvantGarde	58
122	2025-07-24 09:35:25.875245	2025-07-24 09:35:25.875245	Carpet	assets/images/options/HQ_04-Lavatory_Flooring_L3507H4960_1021.jpg	6.500.0a	In Package	In Package	assets/images/palettes/Carpet.png	Essentials	59
123	2025-07-24 09:35:25.876409	2025-07-24 09:35:25.876409	Vinyl	assets/images/options/HQ_04-Lavatory_Flooring_L3507H4960_1022.jpg	6.500.2a	8,8	8000	assets/images/palettes/Vinyl.png	Essentials	59
124	2025-07-24 09:35:25.877965	2025-07-24 09:35:25.877965	Wood Veneer	assets/images/options/HQ_04-Lavatory_Flooring_L3507H4960_1023.jpg	6.500.4a	3,5	91100	assets/images/palettes/Wood.png	AvantGarde	59
125	2025-07-24 09:35:25.879279	2025-07-24 09:35:25.879279	Stone	assets/images/options/HQ_04-Lavatory_Flooring_L3507H4960_1020.jpg	6.500.3a	13,9	99800	assets/images/palettes/Stone.png	AvantGarde	59
126	2025-07-24 09:35:25.881224	2025-07-24 09:35:25.881224	Mirror	assets/images/options/HQ_04-Lavatory_BulkheadFWD_L3507H4960_1112.jpg	6.400.2	In Package	In Package		Essentials	60
127	2025-07-24 09:35:25.882935	2025-07-24 09:35:25.882935	Ultraleather	assets/images/options/HQ_04-Lavatory_BulkheadFWD_L3507H4960_11121.jpg	6.400.2a	-0.2	No charge	assets/images/palettes/Ultraleather.png	Essentials	60
128	2025-07-24 09:35:25.885277	2025-07-24 09:35:25.885277	Wood	assets/images/options/HQ_04-Lavatory_BulkheadAFT_L3507H4960_1113.jpg	6.410.2	In Package	In Package	assets/images/palettes/Wood.png	Essentials	60
129	2025-07-24 09:35:25.886889	2025-07-24 09:35:25.886889	Ultraleather	assets/images/options/HQ_04-Lavatory_BulkheadAFT_L3507H4960_1114.jpg	6.410.2a	-0,1	No Charge	assets/images/palettes/Ultraleather.png	Essentials	60
130	2025-07-24 09:35:37.369714	2025-07-24 09:35:37.369714	Stainless steel	assets/images/options/HQ_01-Entryway_Sink_L3507H4960_1003_CORALIE.jpg	6.210.1	In Package	In Package	\N	Essentials	61
131	2025-07-24 09:35:37.371996	2025-07-24 09:35:37.371996	Glaskote	assets/images/options/HQ_01-Entryway_Sink_L3507H4960_1004_CORALIE.jpg	6.210.12	0	7800	assets/images/palettes/Glaskote.png	Essentials	61
132	2025-07-24 09:35:37.374622	2025-07-24 09:35:37.374622	Solid surface	assets/images/options/HQ_01-Entryway_CounterTop_L3507H4960_1006_CORALIE.jpg	6.210.2a	In Package	In Package	assets/images/palettes/SolidSurface.png	Essentials	62
133	2025-07-24 09:35:37.377526	2025-07-24 09:35:37.377526	Stone	assets/images/options/HQ_01-Entryway_CounterTop_L3507H4960_1005_CORALIE.jpg	6.210.2	-1,5	45300	assets/images/palettes/Stone.png	AvantGarde	62
134	2025-07-24 09:35:37.381	2025-07-24 09:35:37.381	Carpet	assets/images/options/HQ_01-Entryway_Flooring_L3507H4960_1007_CORALIE.jpg	6.500.0b	In Package	In Package	assets/images/palettes/Carpet.png	Essentials	63
135	2025-07-24 09:35:37.383186	2025-07-24 09:35:37.383186	Vinyl	assets/images/options/HQ_01-Entryway_Flooring_L3507H4960_1009_CORALIE.jpg	6.500.2	13,3	10500	assets/images/palettes/Vinyl.png	Essentials	63
136	2025-07-24 09:35:37.385139	2025-07-24 09:35:37.385139	Wood Veneer	assets/images/options/HQ_01-Entryway_Flooring_L3507H4960_1010_CORALIE.jpg	6.500.4b	7.4	106000	assets/images/palettes/Wood.png	AvantGarde	63
137	2025-07-24 09:35:37.386658	2025-07-24 09:35:37.386658	Stone	assets/images/options/HQ_01-Entryway_Flooring_L3507H4960_1008_CORALIE.jpg	6.500.3b	24.8	115100	assets/images/palettes/Stone.png	AvantGarde	63
138	2025-07-24 09:35:37.390898	2025-07-24 09:35:37.390898	Wood Edge	assets/images/options/HQ_02-Cabin_ConsoleT_L3507H4960_1001_CORALIE.jpg	6.200.21	In Package	In Package	assets/images/palettes/Wood.png	Essentials	64
139	2025-07-24 09:35:37.392366	2025-07-24 09:35:37.392366	Painted Edge	assets/images/options/HQ_02-Cabin_ConsoleT_L3507H4960_1002_CORALIE.jpg	6.200.21a	0	30000	assets/images/palettes/Paint.png	AvantGarde	64
140	2025-07-24 09:35:37.395402	2025-07-24 09:35:37.395402	Wood Edge	assets/images/options/HQ_02-Cabin_SideLedge_L3507H4960_1018_CORALIE.jpg	6.300.40a	In Package	In Package	assets/images/palettes/Wood.png	Essentials	65
141	2025-07-24 09:35:37.396773	2025-07-24 09:35:37.396773	Upholstery	assets/images/options/HQ_02-Cabin_SideLedge_L3507H4960_1018__TEXTILE_CORALIE.jpg	6.300.41	In Package	In Package	assets/images/palettes/Upholstery.png	Essentials	65
142	2025-07-24 09:35:37.398155	2025-07-24 09:35:37.398155	Painted Edge	assets/images/options/HQ_02-Cabin_SideLedge_L3507H4960_1019_CORALIE.jpg	6.300.40	0	37000	assets/images/palettes/Paint.png	AvantGarde	65
143	2025-07-24 09:35:37.402216	2025-07-24 09:35:37.402216	Wood Edge	assets/images/options/HQ_02-Cabin_DiningT_L3507H4960_1001.jpg	6.200.31	In Package	In Package	assets/images/palettes/Wood.png	Essentials	66
144	2025-07-24 09:35:37.403422	2025-07-24 09:35:37.403422	Painted Edge	assets/images/options/HQ_02-Cabin_DiningT_L3507H4960_1002.jpg	6.200.31a	0	15000	assets/images/palettes/Paint.png	AvantGarde	66
145	2025-07-24 09:35:37.405949	2025-07-24 09:35:37.405949	Wood Door	assets/images/options/HQ_02-Cabin_Credenza_L3507H4960_1017.jpg	6.300.30	In Package	In Package	assets/images/palettes/Wood.png	Essentials	67
146	2025-07-24 09:35:37.407205	2025-07-24 09:35:37.407205	Painted Door	assets/images/options/HQ_02-Cabin_Credenza_L3507H4960_1016.jpg	6.300.32	0	10000	assets/images/palettes/Paint.png	Essentials	67
147	2025-07-24 09:35:37.408465	2025-07-24 09:35:37.408465	Leather Door	assets/images/options/HQ_02-Cabin_Credenza_L3507H4960_1015.jpg	6.300.31	0	No Charge	assets/images/palettes/QuiltedLeather.png	AvantGarde	67
148	2025-07-24 09:35:37.412256	2025-07-24 09:35:37.412256	Wood	assets/images/options/HQ_02-Cabin_AFTMidCabDividerFWD_L3507H4960_1023.jpg	6.300.8	In Package	In Package	assets/images/palettes/Wood.png	Essentials	68
149	2025-07-24 09:35:37.41364	2025-07-24 09:35:37.41364	Mirror Insert	assets/images/options/HQ_02-Cabin_AFTMidCabDividerFWD_L3507H4960_1022.jpg	6.300.8h	1	11900		Essentials	68
150	2025-07-24 09:35:37.414892	2025-07-24 09:35:37.414892	Wood	assets/images/options/HQ_02-Cabin_AFTMidCabDividerAFT_L3507H4960-01.jpg	6.300.9	In Package	In Package	assets/images/palettes/Wood.png	Essentials	68
151	2025-07-24 09:35:37.416358	2025-07-24 09:35:37.416358	Mirror Insert	assets/images/options/HQ_02-Cabin_AFTMidCabDividerAFT_L3507H4960-02.jpg	6.300.9h	1	12300		Essentials	68
152	2025-07-24 09:35:37.41777	2025-07-24 09:35:37.41777	Upholstery Insert	assets/images/options/HQ_02-Cabin_AFTMidCabDividerFWD_L3507H4960_1021.jpg	6.300.8g	0	10100	assets/images/palettes/Upholstery.png	AvantGarde	68
153	2025-07-24 09:35:37.421914	2025-07-24 09:35:37.421914	Wood Door	assets/images/options/HQ_03-Divan_StorageCab_L3507H4960_1002.jpg	6.300.30R	In Package	In Package	assets/images/palettes/Wood.png	Essentials	69
154	2025-07-24 09:35:37.42299	2025-07-24 09:35:37.42299	Painted Door	assets/images/options/HQ_03-Divan_StorageCab_L3507H4960_1003.jpg	6.300.32R	0	10000	assets/images/palettes/Paint.png	Essentials	69
155	2025-07-24 09:35:37.428784	2025-07-24 09:35:37.428784	Glaskote	assets/images/options/HQ_04-Lavatory_Sink_L3507H4960_1000_CORALIE.jpg	6.210.12b	In Package	In Package	assets/images/palettes/Glaskote.png	Essentials	70
156	2025-07-24 09:35:37.43159	2025-07-24 09:35:37.43159	Solid Surface	assets/images/options/HQ_04-Lavatory_CounterTop02_2023-01-19_CORALIE.jpg	6.210.3a	In Package	In Package	assets/images/palettes/SolidSurface.png	Essentials	71
157	2025-07-24 09:35:37.433265	2025-07-24 09:35:37.433265	Stone	assets/images/options/HQ_04-Lavatory_CounterTop01_2023-01-19_CORALIE.jpg	6.210.3	2.5	21400	assets/images/palettes/Stone.png	AvantGarde	71
158	2025-07-24 09:35:37.436054	2025-07-24 09:35:37.436054	Carpet	assets/images/options/HQ_04-Lavatory_Flooring_L3507H4960_1014_CORALIE.jpg	6.500.0a	In Package	In Package	assets/images/palettes/Carpet.png	Essentials	72
159	2025-07-24 09:35:37.43749	2025-07-24 09:35:37.43749	Vinyl	assets/images/options/HQ_04-Lavatory_Flooring_L3507H4960_1013_CORALIE.jpg	6.500.2a	3.2	8000	assets/images/palettes/Vinyl.png	Essentials	72
160	2025-07-24 09:35:37.438636	2025-07-24 09:35:37.438636	Wood Veneer	assets/images/options/HQ_04-Lavatory_Flooring_L3507H4960_1011_CORALIE.jpg	6.500.4a	0.8	90600	assets/images/palettes/Wood.png	AvantGarde	72
161	2025-07-24 09:35:37.439886	2025-07-24 09:35:37.439886	Stone	assets/images/options/HQ_04-Lavatory_Flooring_L3507H4960_1012_CORALIE.jpg	6.500.3a	9.6	99800	assets/images/palettes/Stone.png	AvantGarde	72
162	2025-07-24 09:35:37.442697	2025-07-24 09:35:37.442697	Wood	assets/images/options/HQ_04-Lavatory_BulkheadFWD_L3507H4960_1007.jpg	6.400.2	In Package	In Package	assets/images/palettes/Wood.png	Essentials	73
163	2025-07-24 09:35:37.44439	2025-07-24 09:35:37.44439	Ultraleather	assets/images/options/HQ_04-Lavatory_BulkheadFWD_L3507H4960_1008.jpg	6.400.2a	-0.8	No charge	assets/images/palettes/Ultraleather.png	Essentials	73
164	2025-07-24 09:35:37.44593	2025-07-24 09:35:37.44593	Wood	assets/images/options/HQ_04-Lavatory_BulkheadAFT_L3507H4960_1007.jpg	6.410.2	In Package	In Package	assets/images/palettes/Wood.png	Essentials	73
165	2025-07-24 09:35:37.447209	2025-07-24 09:35:37.447209	Ultraleather	assets/images/options/HQ_04-Lavatory_BulkheadAFT_L3507H4960_1008.jpg	6.410.2a	-0.2	No charge	assets/images/palettes/Ultraleather.png	Essentials	73
\.


--
-- Data for Name: otp; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.otp (id, "createdAt", "updatedAt", code, expiry) FROM stdin;
\.


--
-- Data for Name: parts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.parts (id, "createdAt", "updatedAt", title, "areaId") FROM stdin;
1	2025-07-24 09:34:45.798513	2025-07-24 09:34:45.798513	Sink	1
2	2025-07-24 09:34:45.806218	2025-07-24 09:34:45.806218	Countertop	1
3	2025-07-24 09:34:45.813405	2025-07-24 09:34:45.813405	Upper drawer	1
4	2025-07-24 09:34:45.821496	2025-07-24 09:34:45.821496	Threshold	1
5	2025-07-24 09:34:45.825611	2025-07-24 09:34:45.825611	Flooring	1
6	2025-07-24 09:34:45.831208	2025-07-24 09:34:45.831208	Console Table	2
7	2025-07-24 09:34:45.834308	2025-07-24 09:34:45.834308	Dining table	2
8	2025-07-24 09:34:45.836599	2025-07-24 09:34:45.836599	Sideledge	2
9	2025-07-24 09:34:45.84222	2025-07-24 09:34:45.84222	Bulkheads	2
10	2025-07-24 09:34:45.850469	2025-07-24 09:34:45.850469	Sink	3
11	2025-07-24 09:34:45.853483	2025-07-24 09:34:45.853483	Countertop	3
12	2025-07-24 09:34:45.855788	2025-07-24 09:34:45.855788	Flooring	3
13	2025-07-24 09:34:45.857879	2025-07-24 09:34:45.857879	Bulkheads	3
14	2025-07-24 09:35:09.519257	2025-07-24 09:35:09.519257	FORWARD CLOSET	4
15	2025-07-24 09:35:09.528202	2025-07-24 09:35:09.528202		4
16	2025-07-24 09:35:09.531007	2025-07-24 09:35:09.531007	 CREW REST	5
17	2025-07-24 09:35:09.541249	2025-07-24 09:35:09.541249	Bulkhead	6
18	2025-07-24 09:35:09.544035	2025-07-24 09:35:09.544035	Sink	6
19	2025-07-24 09:35:09.547043	2025-07-24 09:35:09.547043	Backsplash	6
20	2025-07-24 09:35:09.552125	2025-07-24 09:35:09.552125	Bulkhead	7
21	2025-07-24 09:35:09.553277	2025-07-24 09:35:09.553277	Sink	7
22	2025-07-24 09:35:09.556707	2025-07-24 09:35:09.556707	Countertop	7
23	2025-07-24 09:35:09.559832	2025-07-24 09:35:09.559832	Flooring	7
24	2025-07-24 09:35:09.56719	2025-07-24 09:35:09.56719	Console table	8
25	2025-07-24 09:35:09.569149	2025-07-24 09:35:09.569149	Sideledge	8
26	2025-07-24 09:35:09.576589	2025-07-24 09:35:09.576589	Dining Table	9
27	2025-07-24 09:35:09.579606	2025-07-24 09:35:09.579606	Credenza	9
28	2025-07-24 09:35:09.586226	2025-07-24 09:35:09.586226	Divan	10
29	2025-07-24 09:35:09.600549	2025-07-24 09:35:09.600549	Bed Header	11
30	2025-07-24 09:35:09.604616	2025-07-24 09:35:09.604616	Credenza	11
31	2025-07-24 09:35:09.61222	2025-07-24 09:35:09.61222	 	12
32	2025-07-24 09:35:09.613709	2025-07-24 09:35:09.613709	Sink	13
33	2025-07-24 09:35:09.616915	2025-07-24 09:35:09.616915	Vanity Backsplash	13
34	2025-07-24 09:35:09.623078	2025-07-24 09:35:09.623078		13
35	2025-07-24 09:35:09.624097	2025-07-24 09:35:09.624097	Closet Door	13
36	2025-07-24 09:35:09.627797	2025-07-24 09:35:09.627797	Right-Hand Countertop  	13
37	2025-07-24 09:35:09.631741	2025-07-24 09:35:09.631741	Forward Bulkhead	14
38	2025-07-24 09:35:09.636627	2025-07-24 09:35:09.636627	Main Cabin Divider	14
39	2025-07-24 09:35:09.644397	2025-07-24 09:35:09.644397	AFT Bulkhead	14
40	2025-07-24 09:35:09.648822	2025-07-24 09:35:09.648822	Sink	15
41	2025-07-24 09:35:09.650884	2025-07-24 09:35:09.650884		15
42	2025-07-24 09:35:09.652988	2025-07-24 09:35:09.652988		15
43	2025-07-24 09:35:09.657164	2025-07-24 09:35:09.657164	Closet Door	15
44	2025-07-24 09:35:09.660118	2025-07-24 09:35:09.660118	Flooring	15
45	2025-07-24 09:35:25.808484	2025-07-24 09:35:25.808484	Sink	20
46	2025-07-24 09:35:25.81477	2025-07-24 09:35:25.81477	Countertop	20
47	2025-07-24 09:35:25.820326	2025-07-24 09:35:25.820326	Flooring	20
48	2025-07-24 09:35:25.828839	2025-07-24 09:35:25.828839	Sink	21
49	2025-07-24 09:35:25.830975	2025-07-24 09:35:25.830975	Countertop	21
50	2025-07-24 09:35:25.836645	2025-07-24 09:35:25.836645	Console table	22
51	2025-07-24 09:35:25.840387	2025-07-24 09:35:25.840387	Sideledge	22
52	2025-07-24 09:35:25.847463	2025-07-24 09:35:25.847463	Dining Table	23
53	2025-07-24 09:35:25.852149	2025-07-24 09:35:25.852149	Credenza	23
54	2025-07-24 09:35:25.856202	2025-07-24 09:35:25.856202	Bulkheads	23
55	2025-07-24 09:35:25.860227	2025-07-24 09:35:25.860227	Divan Cabinet	24
56	2025-07-24 09:35:25.862622	2025-07-24 09:35:25.862622	Bulkheads	24
57	2025-07-24 09:35:25.868408	2025-07-24 09:35:25.868408	Sink	25
58	2025-07-24 09:35:25.871239	2025-07-24 09:35:25.871239	Countertop	25
59	2025-07-24 09:35:25.874338	2025-07-24 09:35:25.874338	Flooring	25
60	2025-07-24 09:35:25.880387	2025-07-24 09:35:25.880387	Bulkheads	25
61	2025-07-24 09:35:37.367534	2025-07-24 09:35:37.367534	Sink	26
62	2025-07-24 09:35:37.373324	2025-07-24 09:35:37.373324	Countertop	26
63	2025-07-24 09:35:37.379595	2025-07-24 09:35:37.379595	Flooring	26
64	2025-07-24 09:35:37.390009	2025-07-24 09:35:37.390009	Console Table	27
65	2025-07-24 09:35:37.393935	2025-07-24 09:35:37.393935	Sideledge	27
66	2025-07-24 09:35:37.401041	2025-07-24 09:35:37.401041	Dining Table	28
67	2025-07-24 09:35:37.404565	2025-07-24 09:35:37.404565	Credenza	28
68	2025-07-24 09:35:37.410472	2025-07-24 09:35:37.410472	Bulkheads	28
69	2025-07-24 09:35:37.420756	2025-07-24 09:35:37.420756	Divan Cabinet	29
70	2025-07-24 09:35:37.427122	2025-07-24 09:35:37.427122	Sink	30
71	2025-07-24 09:35:37.43023	2025-07-24 09:35:37.43023	Countertop	30
72	2025-07-24 09:35:37.434731	2025-07-24 09:35:37.434731	Flooring	30
73	2025-07-24 09:35:37.441234	2025-07-24 09:35:37.441234	Bulkheads	30
\.


--
-- Data for Name: permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.permissions (id, "createdAt", "updatedAt", action, subject, fields, conditions, inverted, reason, "roleId") FROM stdin;
1	2025-07-24 12:22:19.389855	2025-07-24 12:22:19.389855	manage	all	\N	\N	\N	\N	1
2	2025-07-24 12:22:49.937548	2025-07-24 12:22:49.937548	read	all	\N	\N	\N	\N	2
\.


--
-- Data for Name: planes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.planes (id, "createdAt", "updatedAt", name) FROM stdin;
1	2025-07-24 09:34:45.787842	2025-07-24 09:34:45.787842	2000LXS
2	2025-07-24 09:35:09.505266	2025-07-24 09:35:09.505266	10X
3	2025-07-24 09:35:25.796082	2025-07-24 09:35:25.796082	8X
4	2025-07-24 09:35:37.353568	2025-07-24 09:35:37.353568	6X
\.


--
-- Data for Name: preferences; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.preferences (id, "createdAt", "updatedAt", "salesEmails", "accountId") FROM stdin;
2	2025-07-24 12:25:37.733302	2025-07-24 12:25:37.733302		4
3	2025-07-24 12:25:37.804798	2025-07-24 12:25:37.804798		5
4	2025-07-24 12:25:37.870119	2025-07-24 12:25:37.870119		6
5	2025-07-24 12:25:37.946392	2025-07-24 12:25:37.946392		7
6	2025-07-24 12:25:38.016704	2025-07-24 12:25:38.016704		8
7	2025-07-24 12:25:38.077219	2025-07-24 12:25:38.077219	Carlos.Brana@dassault-aviation.com	9
8	2025-07-24 12:25:38.142533	2025-07-24 12:25:38.142533		10
9	2025-07-24 12:25:38.215283	2025-07-24 12:25:38.215283		11
10	2025-07-24 12:25:38.282918	2025-07-24 12:25:38.282918		12
11	2025-07-24 12:25:38.346273	2025-07-24 12:25:38.346273		13
12	2025-07-24 12:25:38.407978	2025-07-24 12:25:38.407978		14
13	2025-07-24 12:25:38.470501	2025-07-24 12:25:38.470501		15
14	2025-07-24 12:25:38.535905	2025-07-24 12:25:38.535905		16
15	2025-07-24 12:25:38.595088	2025-07-24 12:25:38.595088	Bertrand.Becker@dassault-aviation.com	17
16	2025-07-24 12:25:38.65321	2025-07-24 12:25:38.65321	Nicolas.Aubert@dassault-aviation.com	18
17	2025-07-24 12:25:38.711942	2025-07-24 12:25:38.711942	Jean-Michel.Fraisse@dassault-aviation.com	19
18	2025-07-24 12:25:38.780596	2025-07-24 12:25:38.780596		20
19	2025-07-24 12:25:38.854361	2025-07-24 12:25:38.854361		21
20	2025-07-24 12:25:38.928558	2025-07-24 12:25:38.928558		22
21	2025-07-24 12:25:38.998882	2025-07-24 12:25:38.998882		23
22	2025-07-24 12:25:39.062111	2025-07-24 12:25:39.062111		24
23	2025-07-24 12:25:39.122447	2025-07-24 12:25:39.122447		25
24	2025-07-24 12:25:39.179589	2025-07-24 12:25:39.179589	laetitia.ferelloc@dassault-aviation.com	26
25	2025-07-24 12:25:39.238639	2025-07-24 12:25:39.238639		27
26	2025-07-24 12:25:39.295585	2025-07-24 12:25:39.295585		28
27	2025-07-24 12:25:39.352084	2025-07-24 12:25:39.352084		29
28	2025-07-24 12:25:39.417987	2025-07-24 12:25:39.417987		30
29	2025-07-24 12:25:39.48435	2025-07-24 12:25:39.48435		31
30	2025-07-24 12:25:39.554119	2025-07-24 12:25:39.554119		32
31	2025-07-24 12:25:39.62569	2025-07-24 12:25:39.62569		33
32	2025-07-24 12:25:39.690238	2025-07-24 12:25:39.690238		34
33	2025-07-24 12:25:39.749728	2025-07-24 12:25:39.749728	Igor.Fain@dassault-aviation.com	35
34	2025-07-24 12:25:39.813365	2025-07-24 12:25:39.813365		36
35	2025-07-24 12:25:39.87695	2025-07-24 12:25:39.87695		37
36	2025-07-24 12:25:39.939979	2025-07-24 12:25:39.939979		38
37	2025-07-24 12:25:40.007127	2025-07-24 12:25:40.007127		39
38	2025-07-24 12:25:40.067849	2025-07-24 12:25:40.067849		40
39	2025-07-24 12:25:40.134974	2025-07-24 12:25:40.134974		41
40	2025-07-24 12:25:40.203516	2025-07-24 12:25:40.203516		42
41	2025-07-24 12:25:40.279122	2025-07-24 12:25:40.279122		43
42	2025-07-24 12:25:40.346445	2025-07-24 12:25:40.346445		44
43	2025-07-24 12:25:40.421357	2025-07-24 12:25:40.421357		45
44	2025-07-24 12:25:40.494491	2025-07-24 12:25:40.494491		46
45	2025-07-24 12:25:40.559572	2025-07-24 12:25:40.559572		47
46	2025-07-24 12:25:40.626402	2025-07-24 12:25:40.626402		48
47	2025-07-24 12:25:40.700164	2025-07-24 12:25:40.700164		49
48	2025-07-24 12:25:40.77334	2025-07-24 12:25:40.77334		50
49	2025-07-24 12:25:40.850226	2025-07-24 12:25:40.850226		51
50	2025-07-24 12:25:40.924992	2025-07-24 12:25:40.924992		52
51	2025-07-24 12:25:41.002536	2025-07-24 12:25:41.002536		53
52	2025-07-24 12:25:41.072525	2025-07-24 12:25:41.072525		54
53	2025-07-24 12:25:41.148824	2025-07-24 12:25:41.148824		55
54	2025-07-24 12:25:41.223765	2025-07-24 12:25:41.223765		56
55	2025-07-24 12:25:41.283041	2025-07-24 12:25:41.283041		57
56	2025-07-24 12:25:41.336726	2025-07-24 12:25:41.336726		58
57	2025-07-24 12:25:41.390238	2025-07-24 12:25:41.390238		59
58	2025-07-24 12:25:41.452362	2025-07-24 12:25:41.452362		60
59	2025-07-24 12:25:41.512365	2025-07-24 12:25:41.512365		61
60	2025-07-24 12:25:41.560529	2025-07-24 12:25:41.560529		62
61	2025-07-24 12:25:41.608482	2025-07-24 12:25:41.608482	adrian.jimenez@dassault-aviation.com	63
62	2025-07-24 12:25:41.659561	2025-07-24 12:25:41.659561		64
63	2025-07-24 12:25:41.713795	2025-07-24 12:25:41.713795		65
1	2025-07-24 12:25:37.672	2025-07-24 12:25:37.672		3
64	2025-07-24 13:38:38.231561	2025-07-24 13:38:38.231561	\N	66
\.


--
-- Data for Name: preferences_bookmarks_options; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.preferences_bookmarks_options ("preferencesId", "optionsId") FROM stdin;
57	9
1	138
\.


--
-- Data for Name: preferences_planes_planes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.preferences_planes_planes ("preferencesId", "planesId") FROM stdin;
1	4
1	3
2	4
3	3
3	4
3	1
4	1
4	4
4	3
5	2
5	1
5	4
5	3
6	1
6	4
6	3
8	4
8	3
9	4
9	3
10	4
10	3
11	4
11	3
12	4
12	3
13	4
13	3
14	4
14	3
18	4
18	3
19	4
19	3
20	4
20	3
21	4
21	3
22	4
22	3
23	4
23	3
25	4
25	3
26	4
26	3
27	4
27	3
28	4
28	3
29	3
29	4
30	3
30	4
31	4
31	3
32	4
32	3
34	4
34	3
35	4
35	3
36	3
36	4
37	4
37	3
38	4
38	3
39	4
39	3
40	3
40	4
41	3
41	4
42	4
42	3
43	3
43	4
44	4
44	3
45	4
45	3
46	4
46	3
47	4
47	3
48	4
48	3
49	4
49	3
50	4
50	3
51	4
51	3
52	4
52	3
53	4
53	3
54	4
54	3
55	4
55	3
58	4
58	3
58	1
59	2
59	1
59	4
59	3
62	4
62	3
62	1
63	4
63	3
63	1
64	1
64	2
64	3
64	4
\.


--
-- Data for Name: profiles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.profiles (id, "createdAt", "updatedAt", firstname, lastname, bio, gender, "phoneNumber", address, "photoUrl", "dateOfBirth") FROM stdin;
3	2025-07-24 12:25:37.601769	2025-07-24 12:25:37.601769	Dev	APPLE	\N	\N	\N	\N	\N	\N
4	2025-07-24 12:25:37.676	2025-07-24 12:25:37.676	Stephane	ARDOUIN	\N	\N	\N	\N	\N	\N
5	2025-07-24 12:25:37.73508	2025-07-24 12:25:37.73508	Falilou	GAYE	\N	\N	\N	\N	\N	\N
6	2025-07-24 12:25:37.808784	2025-07-24 12:25:37.808784	Remi	BACHELET	\N	\N	\N	\N	\N	\N
7	2025-07-24 12:25:37.872688	2025-07-24 12:25:37.872688	Aurore	NOUVELLON	\N	\N	\N	\N	\N	\N
8	2025-07-24 12:25:37.950202	2025-07-24 12:25:37.950202	Eloi	DUFOUR	\N	\N	\N	\N	\N	\N
9	2025-07-24 12:25:38.019576	2025-07-24 12:25:38.019576	Carlos	BRANA	\N	\N	\N	\N	\N	\N
10	2025-07-24 12:25:38.079166	2025-07-24 12:25:38.079166	Clement	BROZI	\N	\N	\N	\N	\N	\N
11	2025-07-24 12:25:38.14609	2025-07-24 12:25:38.14609	Jean-charles	FEDINI	\N	\N	\N	\N	\N	\N
12	2025-07-24 12:25:38.218694	2025-07-24 12:25:38.218694	Donna	DIKEN	\N	\N	\N	\N	\N	\N
13	2025-07-24 12:25:38.286307	2025-07-24 12:25:38.286307	Melanie	CANO	\N	\N	\N	\N	\N	\N
14	2025-07-24 12:25:38.349032	2025-07-24 12:25:38.349032	Karla	PALENCIA	\N	\N	\N	\N	\N	\N
15	2025-07-24 12:25:38.411415	2025-07-24 12:25:38.411415	Jennifer	HARPER	\N	\N	\N	\N	\N	\N
16	2025-07-24 12:25:38.473051	2025-07-24 12:25:38.473051	Lucie	WEBER	\N	\N	\N	\N	\N	\N
17	2025-07-24 12:25:38.538312	2025-07-24 12:25:38.538312	Bertrand	BECKER	\N	\N	\N	\N	\N	\N
18	2025-07-24 12:25:38.597497	2025-07-24 12:25:38.597497	Nicolas	AUBERT	\N	\N	\N	\N	\N	\N
19	2025-07-24 12:25:38.655358	2025-07-24 12:25:38.655358	Jean-michel	FRAISSE	\N	\N	\N	\N	\N	\N
20	2025-07-24 12:25:38.714022	2025-07-24 12:25:38.714022	Gilles	APOLLIS	\N	\N	\N	\N	\N	\N
21	2025-07-24 12:25:38.783723	2025-07-24 12:25:38.783723	Beatrice	ASHE	\N	\N	\N	\N	\N	\N
22	2025-07-24 12:25:38.857672	2025-07-24 12:25:38.857672	David	BAILEY	\N	\N	\N	\N	\N	\N
23	2025-07-24 12:25:38.931255	2025-07-24 12:25:38.931255	Thomas	CARLING	\N	\N	\N	\N	\N	\N
24	2025-07-24 12:25:39.001741	2025-07-24 12:25:39.001741	Nick	CHEN	\N	\N	\N	\N	\N	\N
25	2025-07-24 12:25:39.065252	2025-07-24 12:25:39.065252	Renaud	CLOATRE	\N	\N	\N	\N	\N	\N
26	2025-07-24 12:25:39.12571	2025-07-24 12:25:39.12571	Laetitia	FERELLOC	\N	\N	\N	\N	\N	\N
27	2025-07-24 12:25:39.18129	2025-07-24 12:25:39.18129	Gustavo	TOLEDO	\N	\N	\N	\N	\N	\N
28	2025-07-24 12:25:39.241408	2025-07-24 12:25:39.241408	Pierre	DELESTRADE	\N	\N	\N	\N	\N	\N
29	2025-07-24 12:25:39.297165	2025-07-24 12:25:39.297165	Jerome	DESMAZURES	\N	\N	\N	\N	\N	\N
30	2025-07-24 12:25:39.354521	2025-07-24 12:25:39.354521	Yvon	DESVIGNES	\N	\N	\N	\N	\N	\N
31	2025-07-24 12:25:39.42027	2025-07-24 12:25:39.42027	John	DE-TURRIS	\N	\N	\N	\N	\N	\N
32	2025-07-24 12:25:39.487953	2025-07-24 12:25:39.487953	Anne	DEVILLIERS	\N	\N	\N	\N	\N	\N
33	2025-07-24 12:25:39.557199	2025-07-24 12:25:39.557199	Jake	DEVRIES	\N	\N	\N	\N	\N	\N
34	2025-07-24 12:25:39.629081	2025-07-24 12:25:39.629081	Emilien	ETIENNE	\N	\N	\N	\N	\N	\N
35	2025-07-24 12:25:39.693085	2025-07-24 12:25:39.693085	Igor	FAIN	\N	\N	\N	\N	\N	\N
36	2025-07-24 12:25:39.751444	2025-07-24 12:25:39.751444	Paul	FLORECK	\N	\N	\N	\N	\N	\N
37	2025-07-24 12:25:39.81638	2025-07-24 12:25:39.81638	Robert	FRIEDLANDER	\N	\N	\N	\N	\N	\N
38	2025-07-24 12:25:39.879752	2025-07-24 12:25:39.879752	Jean-marie	GAUTHEROT	\N	\N	\N	\N	\N	\N
39	2025-07-24 12:25:39.943319	2025-07-24 12:25:39.943319	Gilles	GAUTIER	\N	\N	\N	\N	\N	\N
40	2025-07-24 12:25:40.009986	2025-07-24 12:25:40.009986	Renaud	LEMIRE	\N	\N	\N	\N	\N	\N
41	2025-07-24 12:25:40.070576	2025-07-24 12:25:40.070576	Mark	GREENWOOD	\N	\N	\N	\N	\N	\N
42	2025-07-24 12:25:40.137816	2025-07-24 12:25:40.137816	Aadil	GOULAMALY	\N	\N	\N	\N	\N	\N
43	2025-07-24 12:25:40.20722	2025-07-24 12:25:40.20722	Thomas	HETIER	\N	\N	\N	\N	\N	\N
44	2025-07-24 12:25:40.282115	2025-07-24 12:25:40.282115	Jean-michel	JACOB	\N	\N	\N	\N	\N	\N
45	2025-07-24 12:25:40.349395	2025-07-24 12:25:40.349395	Frederic	LE BASSER	\N	\N	\N	\N	\N	\N
46	2025-07-24 12:25:40.424373	2025-07-24 12:25:40.424373	Denis	LECULEE	\N	\N	\N	\N	\N	\N
47	2025-07-24 12:25:40.49759	2025-07-24 12:25:40.49759	Nicolas	MARTIN	\N	\N	\N	\N	\N	\N
48	2025-07-24 12:25:40.562594	2025-07-24 12:25:40.562594	Nicolas	MONCALIS	\N	\N	\N	\N	\N	\N
49	2025-07-24 12:25:40.629322	2025-07-24 12:25:40.629322	Rodrigo	PESOA	\N	\N	\N	\N	\N	\N
50	2025-07-24 12:25:40.702812	2025-07-24 12:25:40.702812	Xavier	PONS	\N	\N	\N	\N	\N	\N
51	2025-07-24 12:25:40.77777	2025-07-24 12:25:40.77777	Didier	RAYNARD	\N	\N	\N	\N	\N	\N
52	2025-07-24 12:25:40.85302	2025-07-24 12:25:40.85302	Rhett	REAVIS	\N	\N	\N	\N	\N	\N
53	2025-07-24 12:25:40.928462	2025-07-24 12:25:40.928462	Thomas	ROHAUT	\N	\N	\N	\N	\N	\N
54	2025-07-24 12:25:41.005248	2025-07-24 12:25:41.005248	Emmanuel	SENARD	\N	\N	\N	\N	\N	\N
55	2025-07-24 12:25:41.076617	2025-07-24 12:25:41.076617	Florent	VENTURINI	\N	\N	\N	\N	\N	\N
56	2025-07-24 12:25:41.152117	2025-07-24 12:25:41.152117	Isabelle	VITTET	\N	\N	\N	\N	\N	\N
57	2025-07-24 12:25:41.227528	2025-07-24 12:25:41.227528	Chad	WININGS	\N	\N	\N	\N	\N	\N
58	2025-07-24 12:25:41.28471	2025-07-24 12:25:41.28471	James	TAYLOR	\N	\N	\N	\N	\N	\N
59	2025-07-24 12:25:41.338536	2025-07-24 12:25:41.338536	Vincent	HUBERT	\N	\N	\N	\N	\N	\N
60	2025-07-24 12:25:41.393345	2025-07-24 12:25:41.393345	Axel	COCAT	\N	\N	\N	\N	\N	\N
61	2025-07-24 12:25:41.457356	2025-07-24 12:25:41.457356	Frederique	HOUSSARD	\N	\N	\N	\N	\N	\N
62	2025-07-24 12:25:41.515334	2025-07-24 12:25:41.515334	Marianne	DUPIN	\N	\N	\N	\N	\N	\N
63	2025-07-24 12:25:41.562245	2025-07-24 12:25:41.562245	Adrian	JIMENEZ	\N	\N	\N	\N	\N	\N
64	2025-07-24 12:25:41.610338	2025-07-24 12:25:41.610338	Simon	ETCHECOPAR	\N	\N	\N	\N	\N	\N
65	2025-07-24 12:25:41.6619	2025-07-24 12:25:41.6619	Veronique	LIMITO	\N	\N	\N	\N	\N	\N
66	2025-07-24 12:45:30.194666	2025-07-24 12:45:30.194666	Coralie	BORDENAVE	\N	\N	\N	\N	\N	\N
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.roles (id, "createdAt", "updatedAt", name, description) FROM stdin;
1	2025-07-24 12:22:19.389855	2025-07-24 12:22:19.389855	admin	\N
2	2025-07-24 12:22:49.937548	2025-07-24 12:22:49.937548	user	\N
\.


--
-- Name: accounts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.accounts_id_seq', 66, true);


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

SELECT pg_catalog.setval('public.preferences_id_seq', 64, true);


--
-- Name: profiles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.profiles_id_seq', 66, true);


--
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.roles_id_seq', 2, true);


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

