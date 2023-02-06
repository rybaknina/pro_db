--
-- PostgreSQL database dump
--

-- Dumped from database version 14.6 (Ubuntu 14.6-0ubuntu0.22.04.1)
-- Dumped by pg_dump version 14.6 (Ubuntu 14.6-0ubuntu0.22.04.1)

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
-- Name: communities; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.communities (
    id integer NOT NULL,
    name character varying(120),
    creator_id integer NOT NULL,
    created_at timestamp without time zone
);


ALTER TABLE public.communities OWNER TO postgres;

--
-- Name: communities_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.communities_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.communities_id_seq OWNER TO postgres;

--
-- Name: communities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.communities_id_seq OWNED BY public.communities.id;


--
-- Name: communities_users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.communities_users (
    community_id integer NOT NULL,
    user_id integer NOT NULL,
    created_at timestamp without time zone
);


ALTER TABLE public.communities_users OWNER TO postgres;

--
-- Name: friendship; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.friendship (
    id integer NOT NULL,
    requested_by_user_id integer NOT NULL,
    requested_to_user_id integer NOT NULL,
    status_id integer NOT NULL,
    requested_at timestamp without time zone,
    confirmed_at timestamp without time zone
);


ALTER TABLE public.friendship OWNER TO postgres;

--
-- Name: friendship_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.friendship_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.friendship_id_seq OWNER TO postgres;

--
-- Name: friendship_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.friendship_id_seq OWNED BY public.friendship.id;


--
-- Name: friendship_statuses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.friendship_statuses (
    id integer NOT NULL,
    name character varying(30)
);


ALTER TABLE public.friendship_statuses OWNER TO postgres;

--
-- Name: friendship_statuses_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.friendship_statuses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.friendship_statuses_id_seq OWNER TO postgres;

--
-- Name: friendship_statuses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.friendship_statuses_id_seq OWNED BY public.friendship_statuses.id;


--
-- Name: messages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.messages (
    id integer NOT NULL,
    from_user_id integer NOT NULL,
    to_user_id integer NOT NULL,
    body text,
    is_important boolean,
    is_delivered boolean,
    created_at timestamp without time zone
);


ALTER TABLE public.messages OWNER TO postgres;

--
-- Name: messages_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.messages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.messages_id_seq OWNER TO postgres;

--
-- Name: messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.messages_id_seq OWNED BY public.messages.id;


--
-- Name: photo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.photo (
    id integer NOT NULL,
    url character varying(250) NOT NULL,
    owner_id integer NOT NULL,
    description character varying(250) NOT NULL,
    uploaded_at timestamp without time zone NOT NULL,
    size integer NOT NULL
);


ALTER TABLE public.photo OWNER TO postgres;

--
-- Name: photo_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.photo_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.photo_id_seq OWNER TO postgres;

--
-- Name: photo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.photo_id_seq OWNED BY public.photo.id;


--
-- Name: subscription; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.subscription (
    id integer NOT NULL,
    user_id integer NOT NULL,
    subscribed_to_id integer NOT NULL,
    type_id integer NOT NULL,
    created_at timestamp without time zone
);


ALTER TABLE public.subscription OWNER TO postgres;

--
-- Name: subscription_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.subscription_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.subscription_id_seq OWNER TO postgres;

--
-- Name: subscription_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.subscription_id_seq OWNED BY public.subscription.id;


--
-- Name: subscription_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.subscription_types (
    id integer NOT NULL,
    name character varying(30)
);


ALTER TABLE public.subscription_types OWNER TO postgres;

--
-- Name: subscription_types_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.subscription_types_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.subscription_types_id_seq OWNER TO postgres;

--
-- Name: subscription_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.subscription_types_id_seq OWNED BY public.subscription_types.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    first_name character varying(50) NOT NULL,
    last_name character varying(50) NOT NULL,
    email character varying(120) NOT NULL,
    phone character varying(15),
    main_photo_id integer,
    created_at timestamp without time zone
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: video; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.video (
    id integer NOT NULL,
    url character varying(250) NOT NULL,
    owner_id integer NOT NULL,
    description character varying(250) NOT NULL,
    uploaded_at timestamp without time zone NOT NULL,
    size integer NOT NULL
);


ALTER TABLE public.video OWNER TO postgres;

--
-- Name: video_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.video_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.video_id_seq OWNER TO postgres;

--
-- Name: video_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.video_id_seq OWNED BY public.video.id;


--
-- Name: communities id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.communities ALTER COLUMN id SET DEFAULT nextval('public.communities_id_seq'::regclass);


--
-- Name: friendship id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.friendship ALTER COLUMN id SET DEFAULT nextval('public.friendship_id_seq'::regclass);


--
-- Name: friendship_statuses id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.friendship_statuses ALTER COLUMN id SET DEFAULT nextval('public.friendship_statuses_id_seq'::regclass);


--
-- Name: messages id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages ALTER COLUMN id SET DEFAULT nextval('public.messages_id_seq'::regclass);


--
-- Name: photo id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.photo ALTER COLUMN id SET DEFAULT nextval('public.photo_id_seq'::regclass);


--
-- Name: subscription id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subscription ALTER COLUMN id SET DEFAULT nextval('public.subscription_id_seq'::regclass);


--
-- Name: subscription_types id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subscription_types ALTER COLUMN id SET DEFAULT nextval('public.subscription_types_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: video id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.video ALTER COLUMN id SET DEFAULT nextval('public.video_id_seq'::regclass);


--
-- Data for Name: communities; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.communities VALUES (1, 'Sapien Molestie LLC', 7, '2022-09-04 08:34:53');
INSERT INTO public.communities VALUES (2, 'Phasellus Dapibus Industries', 15, '2023-02-16 11:41:29');
INSERT INTO public.communities VALUES (3, 'Proin Mi Aliquam Ltd', 2, '2023-06-11 11:17:16');
INSERT INTO public.communities VALUES (4, 'Rhoncus Id Consulting', 13, '2023-12-21 14:26:37');
INSERT INTO public.communities VALUES (5, 'Imperdiet Ullamcorper Foundation', 4, '2022-12-02 03:42:20');
INSERT INTO public.communities VALUES (6, 'Amet Faucibus LLC', 1, '2023-07-18 20:58:46');
INSERT INTO public.communities VALUES (7, 'Turpis Ltd', 4, '2023-08-07 19:10:51');
INSERT INTO public.communities VALUES (8, 'Eu Tempor Corp.', 14, '2023-12-11 04:00:00');
INSERT INTO public.communities VALUES (9, 'Semper Et Corporation', 4, '2022-11-09 21:48:38');
INSERT INTO public.communities VALUES (10, 'Vel Arcu Eu Limited', 9, '2022-11-30 00:19:13');
INSERT INTO public.communities VALUES (11, 'Sed Dui Fusce Institute', 5, '2022-08-10 11:50:57');
INSERT INTO public.communities VALUES (12, 'Lacus Quisque Associates', 4, '2022-03-20 12:34:00');
INSERT INTO public.communities VALUES (13, 'Enim Condimentum LLC', 11, '2023-01-26 02:28:37');
INSERT INTO public.communities VALUES (14, 'Accumsan Interdum Institute', 1, '2023-06-13 17:56:37');
INSERT INTO public.communities VALUES (15, 'Arcu Aliquam Ultrices Limited', 5, '2022-03-27 04:26:55');


--
-- Data for Name: communities_users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.communities_users VALUES (5, 2, '2023-01-17 14:11:45');
INSERT INTO public.communities_users VALUES (5, 13, '2023-04-10 14:16:04');
INSERT INTO public.communities_users VALUES (2, 1, '2022-09-17 07:52:29');
INSERT INTO public.communities_users VALUES (4, 9, '2022-03-10 21:46:26');
INSERT INTO public.communities_users VALUES (6, 8, '2023-09-19 18:38:02');
INSERT INTO public.communities_users VALUES (9, 2, '2023-08-02 20:36:42');
INSERT INTO public.communities_users VALUES (6, 7, '2022-05-22 03:23:23');
INSERT INTO public.communities_users VALUES (13, 2, '2023-02-15 04:24:52');
INSERT INTO public.communities_users VALUES (1, 4, '2022-06-29 23:12:41');
INSERT INTO public.communities_users VALUES (2, 7, '2022-08-28 19:13:23');
INSERT INTO public.communities_users VALUES (2, 6, '2022-05-16 05:22:25');
INSERT INTO public.communities_users VALUES (13, 7, '2023-09-17 20:38:53');
INSERT INTO public.communities_users VALUES (2, 14, '2023-01-07 18:36:43');
INSERT INTO public.communities_users VALUES (14, 11, '2022-12-22 21:33:31');


--
-- Data for Name: friendship; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.friendship VALUES (1, 5, 2, 10, '2023-04-20 10:07:05', '2023-12-31 22:06:43');
INSERT INTO public.friendship VALUES (2, 13, 11, 6, '2022-08-20 07:40:45', '2022-05-22 05:53:29');
INSERT INTO public.friendship VALUES (3, 11, 13, 1, '2023-10-19 18:26:09', '2022-10-25 13:22:08');
INSERT INTO public.friendship VALUES (4, 11, 14, 2, '2022-05-06 05:53:20', '2022-03-12 04:33:59');
INSERT INTO public.friendship VALUES (5, 12, 12, 14, '2023-08-30 05:04:27', '2023-03-03 20:56:38');
INSERT INTO public.friendship VALUES (6, 14, 15, 11, '2023-09-07 03:11:23', '2022-05-22 17:57:27');
INSERT INTO public.friendship VALUES (7, 8, 13, 9, '2023-03-04 03:41:08', '2022-06-16 11:20:04');
INSERT INTO public.friendship VALUES (8, 0, 1, 1, '2023-01-10 02:22:50', '2022-03-05 02:53:33');
INSERT INTO public.friendship VALUES (9, 5, 10, 15, '2023-10-11 05:52:49', '2022-06-04 08:23:02');
INSERT INTO public.friendship VALUES (10, 12, 6, 14, '2022-03-30 08:29:18', '2022-12-08 13:50:21');
INSERT INTO public.friendship VALUES (11, 11, 1, 3, '2024-01-20 19:43:32', '2022-12-14 10:57:21');
INSERT INTO public.friendship VALUES (12, 6, 11, 5, '2023-02-18 23:17:07', '2022-04-02 10:20:23');
INSERT INTO public.friendship VALUES (13, 14, 3, 8, '2022-04-21 01:17:42', '2023-04-19 16:51:26');
INSERT INTO public.friendship VALUES (14, 9, 1, 11, '2022-06-22 06:48:12', '2022-04-02 09:45:07');
INSERT INTO public.friendship VALUES (15, 5, 12, 14, '2023-03-18 12:27:01', '2022-06-16 09:51:12');


--
-- Data for Name: friendship_statuses; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.friendship_statuses VALUES (3, 'pies');
INSERT INTO public.friendship_statuses VALUES (4, 'sandwiches');
INSERT INTO public.friendship_statuses VALUES (5, 'pasta');
INSERT INTO public.friendship_statuses VALUES (6, 'salads');
INSERT INTO public.friendship_statuses VALUES (7, 'cereals');
INSERT INTO public.friendship_statuses VALUES (8, 'seafood');


--
-- Data for Name: messages; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.messages VALUES (1, 14, 5, 'Phasellus dapibus quam quis diam. Pellentesque habitant morbi tristique', false, true, '2023-02-13 23:57:00');
INSERT INTO public.messages VALUES (2, 14, 3, 'ante lectus convallis', false, false, '2022-12-24 12:01:22');
INSERT INTO public.messages VALUES (3, 2, 5, 'Maecenas malesuada fringilla est. Mauris eu', true, true, '2022-09-14 18:57:55');
INSERT INTO public.messages VALUES (4, 15, 1, 'urna, nec luctus felis purus ac', false, false, '2023-08-23 21:45:17');
INSERT INTO public.messages VALUES (5, 3, 3, 'magnis dis parturient montes, nascetur ridiculus mus.', false, true, '2023-08-22 16:54:41');
INSERT INTO public.messages VALUES (6, 4, 15, 'Nulla aliquet. Proin velit. Sed malesuada augue ut lacus.', true, false, '2024-01-26 17:27:02');
INSERT INTO public.messages VALUES (7, 5, 14, 'dui lectus rutrum', true, true, '2022-11-22 12:55:07');
INSERT INTO public.messages VALUES (8, 10, 5, 'varius. Nam porttitor', false, true, '2023-07-14 17:28:19');
INSERT INTO public.messages VALUES (9, 13, 9, 'urna et', true, true, '2023-11-18 03:07:10');
INSERT INTO public.messages VALUES (10, 5, 0, 'eu', false, true, '2023-01-07 22:54:00');
INSERT INTO public.messages VALUES (11, 2, 12, 'erat. Sed nunc est, mollis non,', false, false, '2023-08-25 05:48:17');
INSERT INTO public.messages VALUES (12, 3, 0, 'risus. Quisque libero lacus, varius', false, false, '2022-04-08 05:02:20');
INSERT INTO public.messages VALUES (13, 10, 0, 'egestas hendrerit neque. In ornare', false, false, '2023-01-02 16:18:53');
INSERT INTO public.messages VALUES (14, 11, 8, 'sit amet, consectetuer adipiscing elit. Aliquam auctor, velit eget laoreet', false, false, '2022-06-29 04:29:29');
INSERT INTO public.messages VALUES (15, 1, 7, 'Curabitur dictum. Phasellus in felis. Nulla tempor augue', false, true, '2022-07-27 02:49:22');


--
-- Data for Name: photo; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.photo VALUES (1, 'https://instagram.com/en-us?search=1&q=de', 11, 'dapibus id, blandit at, nisi. Cum sociis natoque penatibus', '2022-03-12 15:27:06', 13);
INSERT INTO public.photo VALUES (2, 'https://zoom.us/en-ca?str=se', 10, 'ornare tortor at risus. Nunc ac sem ut dolor', '2022-09-06 01:30:05', 18);
INSERT INTO public.photo VALUES (3, 'https://bbc.co.uk/group/9?search=1', 5, 'Proin nisl sem, consequat nec, mollis vitae, posuere at,', '2022-07-15 05:54:14', 22);
INSERT INTO public.photo VALUES (4, 'http://wikipedia.org/one?q=0', 8, 'Quisque ac libero nec ligula consectetuer', '2023-09-18 13:36:47', 29);
INSERT INTO public.photo VALUES (5, 'http://baidu.com/en-ca?q=4', 8, 'dolor sit amet, consectetuer adipiscing elit. Curabitur', '2023-08-05 23:41:50', 9);
INSERT INTO public.photo VALUES (6, 'https://pinterest.com/sub?k=0', 13, 'nec, mollis vitae, posuere at, velit. Cras lorem lorem,', '2023-08-09 13:27:43', 40);
INSERT INTO public.photo VALUES (7, 'http://guardian.co.uk/fr?q=4', 8, 'nonummy ultricies ornare, elit elit fermentum risus, at fringilla', '2022-09-14 18:05:07', 21);
INSERT INTO public.photo VALUES (8, 'http://twitter.com/sub/cars?p=8', 15, 'nec ligula consectetuer rhoncus. Nullam velit dui, semper', '2023-05-15 07:32:54', 17);
INSERT INTO public.photo VALUES (9, 'http://reddit.com/site?str=se', 4, 'In faucibus. Morbi vehicula. Pellentesque tincidunt tempus risus. Donec egestas.', '2023-10-16 08:50:00', 37);
INSERT INTO public.photo VALUES (10, 'https://nytimes.com/user/110?ab=441&aad=2', 14, 'amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam', '2023-02-09 14:57:08', 46);
INSERT INTO public.photo VALUES (11, 'http://cnn.com/en-ca?q=4', 10, 'id enim. Curabitur massa. Vestibulum accumsan neque et', '2022-08-05 21:58:26', 37);
INSERT INTO public.photo VALUES (12, 'http://naver.com/en-ca?ab=441&aad=2', 10, 'nulla. Cras eu tellus eu augue porttitor', '2022-08-10 06:24:26', 11);
INSERT INTO public.photo VALUES (13, 'http://zoom.us/group/9?q=0', 1, 'Nulla tincidunt, neque vitae semper egestas, urna justo faucibus', '2022-12-23 05:35:58', 29);
INSERT INTO public.photo VALUES (14, 'http://instagram.com/one?search=1', 0, 'eu, euismod ac, fermentum vel, mauris.', '2023-07-25 04:17:37', 29);
INSERT INTO public.photo VALUES (15, 'https://zoom.us/site?k=0', 12, 'rhoncus. Nullam velit dui, semper', '2023-04-25 17:04:31', 18);


--
-- Data for Name: subscription; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.subscription VALUES (1, 1, 3, 4, '2022-10-07 04:55:34');
INSERT INTO public.subscription VALUES (2, 14, 6, 3, '2022-09-23 01:27:18');
INSERT INTO public.subscription VALUES (3, 9, 10, 3, '2023-03-25 13:43:47');
INSERT INTO public.subscription VALUES (4, 8, 12, 4, '2022-09-05 04:52:23');
INSERT INTO public.subscription VALUES (5, 13, 8, 1, '2022-10-31 05:58:47');
INSERT INTO public.subscription VALUES (6, 6, 10, 2, '2023-09-15 07:45:52');
INSERT INTO public.subscription VALUES (7, 4, 15, 4, '2023-05-06 17:01:34');
INSERT INTO public.subscription VALUES (8, 4, 9, 1, '2023-09-14 11:41:46');
INSERT INTO public.subscription VALUES (9, 1, 15, 2, '2022-09-10 17:26:59');
INSERT INTO public.subscription VALUES (10, 1, 14, 2, '2023-09-06 08:39:03');
INSERT INTO public.subscription VALUES (11, 9, 10, 4, '2023-11-27 12:36:47');
INSERT INTO public.subscription VALUES (12, 6, 7, 5, '2022-09-18 11:51:04');
INSERT INTO public.subscription VALUES (13, 0, 12, 5, '2022-02-26 09:35:12');
INSERT INTO public.subscription VALUES (14, 4, 7, 4, '2022-07-02 05:45:41');
INSERT INTO public.subscription VALUES (15, 9, 12, 4, '2023-06-09 00:59:32');


--
-- Data for Name: subscription_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.subscription_types VALUES (1, 'community');
INSERT INTO public.subscription_types VALUES (2, 'user');


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.users VALUES (1, 'Halla', 'Humphrey', 'nunc.sed@yahoo.org', '1-305-336-8436', 13, '2022-02-27 01:58:49');
INSERT INTO public.users VALUES (2, 'Vera', 'Graves', 'nec.quam@outlook.couk', '1-247-716-8816', 4, '2022-12-29 19:20:21');
INSERT INTO public.users VALUES (3, 'Ethan', 'Park', 'fermentum.convallis.ligula@icloud.net', '1-655-811-2062', 15, '2023-02-25 04:35:57');
INSERT INTO public.users VALUES (4, 'Sasha', 'Hickman', 'fermentum.risus.at@yahoo.org', '428-4349', 6, '2023-01-02 01:50:20');
INSERT INTO public.users VALUES (5, 'Howard', 'Wagner', 'elit.pretium@outlook.ca', '1-369-525-8628', 14, '2023-09-03 17:23:18');
INSERT INTO public.users VALUES (6, 'Thane', 'Elliott', 'ultricies.adipiscing@protonmail.com', '472-6557', 3, '2023-11-21 22:31:39');
INSERT INTO public.users VALUES (7, 'Jael', 'Fleming', 'metus@aol.com', '1-283-671-7828', 9, '2022-08-29 06:16:57');
INSERT INTO public.users VALUES (8, 'Olivia', 'Petty', 'dolor.quisque@icloud.org', '442-1526', 13, '2022-11-05 16:10:12');
INSERT INTO public.users VALUES (9, 'Keaton', 'Harrington', 'nullam@yahoo.couk', '723-6326', 0, '2023-06-18 22:53:47');
INSERT INTO public.users VALUES (10, 'Cole', 'Jones', 'lorem.sit@google.ca', '269-4298', 7, '2023-01-07 13:25:58');
INSERT INTO public.users VALUES (11, 'Brock', 'Cantrell', 'hendrerit.id.ante@hotmail.couk', '728-0208', 12, '2022-07-27 23:24:19');
INSERT INTO public.users VALUES (12, 'Clark', 'West', 'sed.est@yahoo.org', '1-617-443-5553', 4, '2023-10-14 19:33:11');
INSERT INTO public.users VALUES (13, 'Vaughan', 'Holman', 'sed@protonmail.ca', '768-4948', 6, '2022-11-02 17:09:43');
INSERT INTO public.users VALUES (14, 'Heidi', 'O''donnell', 'quisque.libero@hotmail.edu', '1-447-818-0441', 11, '2024-01-23 03:03:11');
INSERT INTO public.users VALUES (15, 'Fritz', 'Hays', 'at.sem.molestie@google.com', '365-1172', 10, '2022-06-24 23:41:46');


--
-- Data for Name: video; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.video VALUES (1, 'https://reddit.com/site?search=1&q=de', 11, 'Curae Donec tincidunt. Donec vitae erat vel', '2022-11-21 11:43:00', 35);
INSERT INTO public.video VALUES (2, 'http://wikipedia.org/en-us?search=1&q=de', 8, 'est. Mauris eu turpis. Nulla', '2022-03-21 19:37:11', 29);
INSERT INTO public.video VALUES (3, 'https://reddit.com/en-us?ab=441&aad=2', 7, 'rutrum urna, nec luctus felis', '2023-10-24 01:42:35', 39);
INSERT INTO public.video VALUES (4, 'https://facebook.com/en-ca?client=g', 3, 'nonummy ut, molestie in, tempus eu, ligula. Aenean', '2022-02-17 00:38:14', 12);
INSERT INTO public.video VALUES (5, 'http://wikipedia.org/group/9?g=1', 10, 'dui nec urna suscipit nonummy. Fusce fermentum fermentum arcu.', '2023-01-24 20:47:55', 16);
INSERT INTO public.video VALUES (6, 'http://nytimes.com/en-ca?gi=100', 11, 'Duis gravida. Praesent eu nulla at', '2022-05-22 07:02:19', 20);
INSERT INTO public.video VALUES (7, 'http://reddit.com/group/9?q=11', 3, 'augue ut lacus. Nulla tincidunt, neque vitae', '2022-12-04 03:17:06', 45);
INSERT INTO public.video VALUES (8, 'http://facebook.com/user/110?client=g', 5, 'urna suscipit nonummy. Fusce fermentum fermentum arcu. Vestibulum', '2023-09-05 00:30:37', 38);
INSERT INTO public.video VALUES (9, 'http://yahoo.com/group/9?q=test', 4, 'ultricies adipiscing, enim mi tempor lorem, eget mollis', '2023-06-04 15:45:47', 47);
INSERT INTO public.video VALUES (10, 'https://netflix.com/group/9?p=8', 14, 'tellus. Phasellus elit pede, malesuada', '2024-01-13 09:36:27', 43);
INSERT INTO public.video VALUES (11, 'https://wikipedia.org/settings?g=1', 10, 'velit. Aliquam nisl. Nulla eu neque pellentesque massa', '2023-04-05 03:12:31', 50);
INSERT INTO public.video VALUES (12, 'https://cnn.com/en-ca?search=1', 9, 'vel turpis. Aliquam adipiscing lobortis risus. In mi pede, nonummy', '2022-08-22 19:19:04', 14);
INSERT INTO public.video VALUES (13, 'https://google.com/group/9?ad=115', 9, 'erat eget ipsum. Suspendisse sagittis. Nullam vitae', '2023-06-13 09:48:20', 36);
INSERT INTO public.video VALUES (14, 'https://google.com/sub?ab=441&aad=2', 1, 'malesuada vel, convallis in, cursus et,', '2022-10-16 22:10:06', 17);
INSERT INTO public.video VALUES (15, 'http://whatsapp.com/sub?q=0', 13, 'arcu. Vestibulum ut eros non enim commodo', '2022-05-10 05:31:19', 19);


--
-- Name: communities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.communities_id_seq', 15, true);


--
-- Name: friendship_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.friendship_id_seq', 15, true);


--
-- Name: friendship_statuses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.friendship_statuses_id_seq', 8, true);


--
-- Name: messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.messages_id_seq', 15, true);


--
-- Name: photo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.photo_id_seq', 15, true);


--
-- Name: subscription_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.subscription_id_seq', 15, true);


--
-- Name: subscription_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.subscription_types_id_seq', 2, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 15, true);


--
-- Name: video_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.video_id_seq', 15, true);


--
-- Name: communities communities_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.communities
    ADD CONSTRAINT communities_name_key UNIQUE (name);


--
-- Name: communities communities_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.communities
    ADD CONSTRAINT communities_pkey PRIMARY KEY (id);


--
-- Name: communities_users communities_users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.communities_users
    ADD CONSTRAINT communities_users_pkey PRIMARY KEY (community_id, user_id);


--
-- Name: friendship friendship_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.friendship
    ADD CONSTRAINT friendship_pkey PRIMARY KEY (id);


--
-- Name: friendship_statuses friendship_statuses_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.friendship_statuses
    ADD CONSTRAINT friendship_statuses_name_key UNIQUE (name);


--
-- Name: friendship_statuses friendship_statuses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.friendship_statuses
    ADD CONSTRAINT friendship_statuses_pkey PRIMARY KEY (id);


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id);


--
-- Name: photo photo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.photo
    ADD CONSTRAINT photo_pkey PRIMARY KEY (id);


--
-- Name: photo photo_url_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.photo
    ADD CONSTRAINT photo_url_key UNIQUE (url);


--
-- Name: subscription subscription_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subscription
    ADD CONSTRAINT subscription_pkey PRIMARY KEY (id);


--
-- Name: subscription_types subscription_types_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subscription_types
    ADD CONSTRAINT subscription_types_name_key UNIQUE (name);


--
-- Name: subscription_types subscription_types_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subscription_types
    ADD CONSTRAINT subscription_types_pkey PRIMARY KEY (id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_phone_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_phone_key UNIQUE (phone);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: video video_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.video
    ADD CONSTRAINT video_pkey PRIMARY KEY (id);


--
-- Name: video video_url_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.video
    ADD CONSTRAINT video_url_key UNIQUE (url);


--
-- PostgreSQL database dump complete
--

