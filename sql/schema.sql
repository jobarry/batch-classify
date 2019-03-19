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
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: pg_trgm; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_trgm WITH SCHEMA public;


--
-- Name: EXTENSION pg_trgm; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pg_trgm IS 'text similarity measurement and index searching based on trigrams';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: SequelizeMeta; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."SequelizeMeta" (
    name character varying(255) NOT NULL
);


--
-- Name: applications; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.applications (
    id integer NOT NULL,
    email character varying(255),
    name character varying(255),
    message text,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: applications_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.applications_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: applications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.applications_id_seq OWNED BY public.applications.id;


--
-- Name: customer_products; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.customer_products (
    id integer NOT NULL,
    last_delivered timestamp with time zone,
    margin double precision,
    period integer,
    outlier integer,
    month_value numeric(10,2),
    price numeric(10,2),
    growth double precision,
    active boolean DEFAULT true NOT NULL,
    customer_id integer NOT NULL,
    product_id integer NOT NULL,
    modified timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: customer_products_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.customer_products_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: customer_products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.customer_products_id_seq OWNED BY public.customer_products.id;


--
-- Name: customer_users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.customer_users (
    id integer NOT NULL,
    customer_id integer NOT NULL,
    user_id integer NOT NULL
);


--
-- Name: customer_users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.customer_users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: customer_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.customer_users_id_seq OWNED BY public.customer_users.id;


--
-- Name: customers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.customers (
    id integer NOT NULL,
    code character varying(255) NOT NULL,
    title character varying(255),
    address character varying(255),
    last_delivered timestamp with time zone,
    month_value numeric(10,2) DEFAULT 0 NOT NULL,
    threatened_value numeric(10,2) DEFAULT 0 NOT NULL,
    growth double precision,
    currency character varying(255) NOT NULL,
    supplier_id integer NOT NULL,
    modified timestamp with time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);


--
-- Name: customers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.customers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: customers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.customers_id_seq OWNED BY public.customers.id;


--
-- Name: notes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.notes (
    id integer NOT NULL,
    user_id integer NOT NULL,
    customer_id integer NOT NULL,
    note character varying(255),
    "timestamp" timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: notes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.notes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: notes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.notes_id_seq OWNED BY public.notes.id;


--
-- Name: products; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.products (
    id integer NOT NULL,
    code character varying(255) NOT NULL,
    list_price numeric(10,2),
    title character varying(255),
    supplier_id integer NOT NULL,
    modified timestamp with time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);


--
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.products_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;


--
-- Name: supplier_users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.supplier_users (
    id integer NOT NULL,
    supplier_id integer NOT NULL,
    user_id integer NOT NULL
);


--
-- Name: supplier_users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.supplier_users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: supplier_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.supplier_users_id_seq OWNED BY public.supplier_users.id;


--
-- Name: suppliers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.suppliers (
    id integer NOT NULL,
    title character varying(255),
    code character varying(255),
    password character varying(255)
);


--
-- Name: suppliers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.suppliers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: suppliers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.suppliers_id_seq OWNED BY public.suppliers.id;


--
-- Name: transactions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.transactions (
    id integer NOT NULL,
    cost numeric(10,2),
    delivered timestamp with time zone NOT NULL,
    price numeric(10,2),
    quantity double precision,
    customer_id integer NOT NULL,
    product_id integer NOT NULL,
    status character varying(255),
    modified timestamp with time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);


--
-- Name: transactions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.transactions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: transactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.transactions_id_seq OWNED BY public.transactions.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    phone character varying(255),
    cognito_username character varying(255) NOT NULL
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: applications id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.applications ALTER COLUMN id SET DEFAULT nextval('public.applications_id_seq'::regclass);


--
-- Name: customer_products id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.customer_products ALTER COLUMN id SET DEFAULT nextval('public.customer_products_id_seq'::regclass);


--
-- Name: customer_users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.customer_users ALTER COLUMN id SET DEFAULT nextval('public.customer_users_id_seq'::regclass);


--
-- Name: customers id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.customers ALTER COLUMN id SET DEFAULT nextval('public.customers_id_seq'::regclass);


--
-- Name: notes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notes ALTER COLUMN id SET DEFAULT nextval('public.notes_id_seq'::regclass);


--
-- Name: products id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);


--
-- Name: supplier_users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.supplier_users ALTER COLUMN id SET DEFAULT nextval('public.supplier_users_id_seq'::regclass);


--
-- Name: suppliers id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.suppliers ALTER COLUMN id SET DEFAULT nextval('public.suppliers_id_seq'::regclass);


--
-- Name: transactions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.transactions ALTER COLUMN id SET DEFAULT nextval('public.transactions_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: SequelizeMeta SequelizeMeta_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."SequelizeMeta"
    ADD CONSTRAINT "SequelizeMeta_pkey" PRIMARY KEY (name);


--
-- Name: applications applications_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.applications
    ADD CONSTRAINT applications_id_key UNIQUE (id);


--
-- Name: customer_products customer_products_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.customer_products
    ADD CONSTRAINT customer_products_pkey PRIMARY KEY (id);


--
-- Name: customer_users customer_users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.customer_users
    ADD CONSTRAINT customer_users_pkey PRIMARY KEY (id);


--
-- Name: customers customers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (id);


--
-- Name: notes notes_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notes
    ADD CONSTRAINT notes_id_key UNIQUE (id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: supplier_users supplier_users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.supplier_users
    ADD CONSTRAINT supplier_users_pkey PRIMARY KEY (id);


--
-- Name: suppliers suppliers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.suppliers
    ADD CONSTRAINT suppliers_pkey PRIMARY KEY (id);


--
-- Name: transactions transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_pkey PRIMARY KEY (id);


--
-- Name: users users_cognito_username_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_cognito_username_key UNIQUE (cognito_username);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_id_key UNIQUE (id);


--
-- Name: customer_products_customer_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX customer_products_customer_id ON public.customer_products USING btree (customer_id);


--
-- Name: customer_products_customer_id_product_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX customer_products_customer_id_product_id ON public.customer_products USING btree (customer_id, product_id);


--
-- Name: customer_products_product_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX customer_products_product_id ON public.customer_products USING btree (product_id);


--
-- Name: customer_users_customer_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX customer_users_customer_id ON public.customer_users USING btree (customer_id);


--
-- Name: customer_users_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX customer_users_user_id ON public.customer_users USING btree (user_id);


--
-- Name: customers_supplier_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX customers_supplier_id ON public.customers USING btree (supplier_id);


--
-- Name: customers_supplier_id_code; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX customers_supplier_id_code ON public.customers USING btree (supplier_id, code);


--
-- Name: idx_trgm_customer_code; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_trgm_customer_code ON public.customers USING gin (code public.gin_trgm_ops);


--
-- Name: idx_trgm_customer_title; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_trgm_customer_title ON public.customers USING gin (title public.gin_trgm_ops);


--
-- Name: products_supplier_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX products_supplier_id ON public.products USING btree (supplier_id);


--
-- Name: products_supplier_id_code; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX products_supplier_id_code ON public.products USING btree (supplier_id, code);


--
-- Name: supplier_users_supplier_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX supplier_users_supplier_id ON public.supplier_users USING btree (supplier_id);


--
-- Name: supplier_users_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX supplier_users_user_id ON public.supplier_users USING btree (user_id);


--
-- Name: suppliers_code; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX suppliers_code ON public.suppliers USING btree (code);


--
-- Name: transactions_customer_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX transactions_customer_id ON public.transactions USING btree (customer_id);


--
-- Name: transactions_customer_id_product_id_delivered; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX transactions_customer_id_product_id_delivered ON public.transactions USING btree (customer_id, product_id, delivered);


--
-- Name: transactions_product_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX transactions_product_id ON public.transactions USING btree (product_id);


--
-- Name: customer_products customer_products_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.customer_products
    ADD CONSTRAINT customer_products_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customers(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: customer_products customer_products_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.customer_products
    ADD CONSTRAINT customer_products_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: customer_users customer_users_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.customer_users
    ADD CONSTRAINT customer_users_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customers(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: customer_users customer_users_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.customer_users
    ADD CONSTRAINT customer_users_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: customers customers_supplier_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_supplier_id_fkey FOREIGN KEY (supplier_id) REFERENCES public.suppliers(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: notes notes_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notes
    ADD CONSTRAINT notes_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customers(id);


--
-- Name: notes notes_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notes
    ADD CONSTRAINT notes_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: products products_supplier_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_supplier_id_fkey FOREIGN KEY (supplier_id) REFERENCES public.suppliers(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: supplier_users supplier_users_supplier_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.supplier_users
    ADD CONSTRAINT supplier_users_supplier_id_fkey FOREIGN KEY (supplier_id) REFERENCES public.suppliers(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: supplier_users supplier_users_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.supplier_users
    ADD CONSTRAINT supplier_users_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: transactions transactions_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customers(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: transactions transactions_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

