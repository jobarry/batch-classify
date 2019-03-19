--
-- PostgreSQL database dump
--

-- Dumped from database version 10.3
-- Dumped by pg_dump version 10.3

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Data for Name: suppliers; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.suppliers (id, title, code, password) FROM stdin;
1	First Supplier	supplier1	\N
2	Second Supplier	supplier2	\N
\.


--
-- Data for Name: customers; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.customers (id, code, currency, title, supplier_id, modified) FROM stdin;
1	AAAA	EUR	Customer A	1	1990-01-01 00:00:00+00
2	BBBB	GBP	Customer B	1	1990-01-01 00:00:00+00
3	CCCC	USD	Customer C	1	1990-01-01 00:00:00+00
4	DDDD	EUR	Customer D	2	1990-01-01 00:00:00+00
5	EEEE	GBP	Customer E	2	1990-01-01 00:00:00+00
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.products (id, code, list_price, title, supplier_id, modified) FROM stdin;
1	ZZZZ	5.00	Product Z	1	1990-01-01 00:00:00+00
2	YYYY	10.00	Product Y	1	1990-01-01 00:00:00+00
3	XXXX	15.00	Product X	1	1990-01-01 00:00:00+00
4	WWWW	5.00	Product W	2	1990-01-01 00:00:00+00
5	VVVV	10.00	Product V	2	1990-01-01 00:00:00+00
\.


--
-- Data for Name: customer_products; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.customer_products (id, last_delivered, margin, outlier, month_value, period, price, active, customer_id, product_id, modified) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.users (id, email, name, phone, cognito_username) FROM stdin;
1	test@email.com	Test User	\N	xxxx-xxxx-xxxx-xxxx
\.


--
-- Data for Name: customer_users; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.customer_users (id, customer_id, user_id) FROM stdin;
\.


--
-- Data for Name: supplier_users; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.supplier_users (id, supplier_id, user_id) FROM stdin;
1	1	1
2	2	1
\.


--
-- Data for Name: transactions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.transactions (id, cost, delivered, price, quantity, customer_id, product_id, status, modified) FROM stdin;
1	2.00	2000-01-01 00:00:00+00	4.00	5	1	1	\N	2000-01-01 00:00:00+00
2	4.00	2000-01-01 00:00:00+00	8.00	4	1	2	\N	2000-01-01 00:00:00+00
3	6.00	2000-01-01 00:00:00+00	12.00	2	1	3	\N	2000-01-01 00:00:00+00
4	2.00	2000-01-01 00:00:00+00	6.00	10	2	1	\N	2000-01-01 00:00:00+00
5	6.00	2000-01-01 00:00:00+00	12.00	8	2	2	\N	2000-01-01 00:00:00+00
6	12.00	2000-01-01 00:00:00+00	18.00	1	2	3	\N	2000-01-01 00:00:00+00
7	3.00	2000-01-01 00:00:00+00	5.00	12	3	1	\N	2000-01-01 00:00:00+00
8	5.00	2000-01-01 00:00:00+00	10.00	6	3	2	\N	2000-01-01 00:00:00+00
9	8.00	2000-01-01 00:00:00+00	15.00	3	3	3	\N	2000-01-01 00:00:00+00
10	2.00	2000-01-01 00:00:00+00	4.00	12	4	4	\N	2000-01-01 00:00:00+00
11	4.00	2000-01-01 00:00:00+00	8.00	6	5	5	\N	2000-01-01 00:00:00+00
12	6.00	2000-01-01 00:00:00+00	12.00	3	4	5	\N	2000-01-01 00:00:00+00
\.


--
-- Name: customer_products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.customer_products_id_seq', 1, false);


--
-- Name: customer_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.customer_users_id_seq', 1, false);


--
-- Name: customers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.customers_id_seq', 6, false);


--
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.products_id_seq', 6, false);


--
-- Name: supplier_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.supplier_users_id_seq', 3, false);


--
-- Name: suppliers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.suppliers_id_seq', 3, false);


--
-- Name: transactions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.transactions_id_seq', 13, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.users_id_seq', 1, false);


--
-- PostgreSQL database dump complete
--

