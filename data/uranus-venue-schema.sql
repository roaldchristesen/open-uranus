--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2 (Postgres.app)
-- Dumped by pg_dump version 16.2 (Postgres.app)

-- Started on 2025-03-05 11:37:15 CET

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

--
-- TOC entry 12 (class 2615 OID 1086221)
-- Name: uranus; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA uranus;


--
-- TOC entry 802 (class 1255 OID 1086222)
-- Name: update_modified_at(); Type: FUNCTION; Schema: uranus; Owner: -
--

CREATE FUNCTION uranus.update_modified_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  NEW.modified_at = NOW();
  RETURN NEW;
END;
$$;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 531 (class 1259 OID 1086262)
-- Name: event; Type: TABLE; Schema: uranus; Owner: -
--

CREATE TABLE uranus.event (
    id integer NOT NULL,
    organizer_id integer NOT NULL,
    venue_id integer NOT NULL,
    space_id integer,
    title character varying(255) NOT NULL,
    description text NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    modified_at timestamp with time zone
);


--
-- TOC entry 541 (class 1259 OID 1086323)
-- Name: event_date; Type: TABLE; Schema: uranus; Owner: -
--

CREATE TABLE uranus.event_date (
    id integer NOT NULL,
    event_id integer NOT NULL,
    venue_id integer,
    space_id integer,
    date_start timestamp with time zone NOT NULL,
    date_end timestamp with time zone,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    modified_at timestamp with time zone,
    entry_time time with time zone
);


--
-- TOC entry 540 (class 1259 OID 1086322)
-- Name: event_date_id_seq; Type: SEQUENCE; Schema: uranus; Owner: -
--

ALTER TABLE uranus.event_date ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME uranus.event_date_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 556 (class 1259 OID 1086538)
-- Name: event_date_link_images; Type: TABLE; Schema: uranus; Owner: -
--

CREATE TABLE uranus.event_date_link_images (
    event_date_id integer NOT NULL,
    image_id integer NOT NULL,
    main_image boolean
);


--
-- TOC entry 530 (class 1259 OID 1086261)
-- Name: event_id_seq; Type: SEQUENCE; Schema: uranus; Owner: -
--

ALTER TABLE uranus.event ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME uranus.event_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 555 (class 1259 OID 1086525)
-- Name: event_link_images; Type: TABLE; Schema: uranus; Owner: -
--

CREATE TABLE uranus.event_link_images (
    event_id integer NOT NULL,
    image_id integer NOT NULL,
    main_image boolean
);


--
-- TOC entry 550 (class 1259 OID 1086457)
-- Name: event_link_types; Type: TABLE; Schema: uranus; Owner: -
--

CREATE TABLE uranus.event_link_types (
    event_id integer NOT NULL,
    event_type_id integer NOT NULL
);


--
-- TOC entry 549 (class 1259 OID 1086449)
-- Name: event_type; Type: TABLE; Schema: uranus; Owner: -
--

CREATE TABLE uranus.event_type (
    id integer NOT NULL,
    i18n_locale_id integer NOT NULL,
    name text NOT NULL,
    type_id integer NOT NULL,
    modified_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- TOC entry 551 (class 1259 OID 1086476)
-- Name: event_type_id_seq; Type: SEQUENCE; Schema: uranus; Owner: -
--

ALTER TABLE uranus.event_type ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME uranus.event_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 553 (class 1259 OID 1086496)
-- Name: genre_link_types; Type: TABLE; Schema: uranus; Owner: -
--

CREATE TABLE uranus.genre_link_types (
    event_id integer NOT NULL,
    genre_type_id integer NOT NULL
);


--
-- TOC entry 552 (class 1259 OID 1086488)
-- Name: genre_type; Type: TABLE; Schema: uranus; Owner: -
--

CREATE TABLE uranus.genre_type (
    id integer NOT NULL,
    i18n_locale_id integer NOT NULL,
    name text NOT NULL,
    type_id integer NOT NULL,
    modified_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- TOC entry 554 (class 1259 OID 1086502)
-- Name: genre_type_id_seq; Type: SEQUENCE; Schema: uranus; Owner: -
--

ALTER TABLE uranus.genre_type ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME uranus.genre_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 548 (class 1259 OID 1086405)
-- Name: i18n_locale; Type: TABLE; Schema: uranus; Owner: -
--

CREATE TABLE uranus.i18n_locale (
    id integer NOT NULL,
    iso_639_1 character varying(2) NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    modified_at timestamp with time zone
);


--
-- TOC entry 547 (class 1259 OID 1086404)
-- Name: i18n_locale_id_seq; Type: SEQUENCE; Schema: uranus; Owner: -
--

ALTER TABLE uranus.i18n_locale ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME uranus.i18n_locale_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 533 (class 1259 OID 1086286)
-- Name: image; Type: TABLE; Schema: uranus; Owner: -
--

CREATE TABLE uranus.image (
    id integer NOT NULL,
    origin_name character varying NOT NULL,
    mime_type character varying NOT NULL,
    license_type_id integer NOT NULL,
    created_by character varying,
    copyright character varying,
    image_type_id integer NOT NULL,
    alt_text text,
    caption text,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    modified_at timestamp with time zone,
    source_name character varying(64) NOT NULL
);


--
-- TOC entry 532 (class 1259 OID 1086285)
-- Name: image_id_seq; Type: SEQUENCE; Schema: uranus; Owner: -
--

ALTER TABLE uranus.image ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME uranus.image_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 560 (class 1259 OID 1086594)
-- Name: image_type; Type: TABLE; Schema: uranus; Owner: -
--

CREATE TABLE uranus.image_type (
    id integer NOT NULL,
    name character varying NOT NULL,
    description character varying,
    i18n_locale_id integer NOT NULL,
    type_id integer NOT NULL
);


--
-- TOC entry 559 (class 1259 OID 1086593)
-- Name: image_type_id_seq; Type: SEQUENCE; Schema: uranus; Owner: -
--

ALTER TABLE uranus.image_type ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME uranus.image_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 558 (class 1259 OID 1086581)
-- Name: license_type; Type: TABLE; Schema: uranus; Owner: -
--

CREATE TABLE uranus.license_type (
    id integer NOT NULL,
    name character varying NOT NULL,
    short_name character varying NOT NULL,
    url character varying NOT NULL
);


--
-- TOC entry 557 (class 1259 OID 1086580)
-- Name: license_type_id_seq; Type: SEQUENCE; Schema: uranus; Owner: -
--

ALTER TABLE uranus.license_type ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME uranus.license_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 535 (class 1259 OID 1086295)
-- Name: logo; Type: TABLE; Schema: uranus; Owner: -
--

CREATE TABLE uranus.logo (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    file_type character varying(50) NOT NULL,
    background_type character varying(50),
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    modified_at timestamp with time zone
);


--
-- TOC entry 534 (class 1259 OID 1086294)
-- Name: logo_id_seq; Type: SEQUENCE; Schema: uranus; Owner: -
--

ALTER TABLE uranus.logo ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME uranus.logo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 525 (class 1259 OID 1086224)
-- Name: organizer; Type: TABLE; Schema: uranus; Owner: -
--

CREATE TABLE uranus.organizer (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    description text,
    contact_email character varying(255),
    contact_phone character varying(50),
    website_url text,
    street character varying(255),
    house_number character varying(50),
    postal_code character varying(20),
    city character varying(100),
    country_code character varying(100),
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    modified_at timestamp with time zone
);


--
-- TOC entry 524 (class 1259 OID 1086223)
-- Name: organizer_id_seq; Type: SEQUENCE; Schema: uranus; Owner: -
--

ALTER TABLE uranus.organizer ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME uranus.organizer_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 529 (class 1259 OID 1086248)
-- Name: space; Type: TABLE; Schema: uranus; Owner: -
--

CREATE TABLE uranus.space (
    id integer NOT NULL,
    venue_id integer NOT NULL,
    name character varying(255) NOT NULL,
    total_capacity integer,
    seating_capacity integer,
    space_type_id integer,
    building_level integer,
    platform_lift character varying(255),
    wheelchair text,
    toilets text,
    elevator text,
    ramp text,
    tactile_guidance text,
    accessibility_info text,
    personalized_accessibility_services boolean,
    wheelchair_friendly_surface text,
    quiet_zones text,
    url text,
    floor_plan text,
    tech_rider text,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    modified_at timestamp with time zone,
    area numeric
);


--
-- TOC entry 528 (class 1259 OID 1086247)
-- Name: space_id_seq; Type: SEQUENCE; Schema: uranus; Owner: -
--

ALTER TABLE uranus.space ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME uranus.space_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 543 (class 1259 OID 1086352)
-- Name: space_type; Type: TABLE; Schema: uranus; Owner: -
--

CREATE TABLE uranus.space_type (
    id integer NOT NULL,
    i18n_locale_id integer NOT NULL,
    name text NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    modified_at timestamp with time zone,
    type_id integer NOT NULL
);


--
-- TOC entry 542 (class 1259 OID 1086351)
-- Name: space_type_id_seq; Type: SEQUENCE; Schema: uranus; Owner: -
--

ALTER TABLE uranus.space_type ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME uranus.space_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 537 (class 1259 OID 1086302)
-- Name: transport_station; Type: TABLE; Schema: uranus; Owner: -
--

CREATE TABLE uranus.transport_station (
    id integer NOT NULL,
    station_type character varying(50) NOT NULL,
    name character varying(255) NOT NULL,
    distance_by_foot integer,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    modified_at timestamp with time zone
);


--
-- TOC entry 536 (class 1259 OID 1086301)
-- Name: transport_station_id_seq; Type: SEQUENCE; Schema: uranus; Owner: -
--

ALTER TABLE uranus.transport_station ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME uranus.transport_station_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 527 (class 1259 OID 1086233)
-- Name: venue; Type: TABLE; Schema: uranus; Owner: -
--

CREATE TABLE uranus.venue (
    id integer NOT NULL,
    organizer_id integer,
    name character varying(255) NOT NULL,
    street character varying(255),
    house_number character varying(50),
    postal_code character varying(20),
    city character varying(100),
    country_code character(3),
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    modified_at timestamp with time zone,
    wkb_geometry public.geometry(Point,4326) NOT NULL,
    county_code character varying(10),
    opened_at date,
    closed_at date,
    CONSTRAINT country_length_check CHECK ((char_length((country_code)::text) = 3))
);


--
-- TOC entry 526 (class 1259 OID 1086232)
-- Name: venue_id_seq; Type: SEQUENCE; Schema: uranus; Owner: -
--

ALTER TABLE uranus.venue ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME uranus.venue_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 546 (class 1259 OID 1086378)
-- Name: venue_link_types; Type: TABLE; Schema: uranus; Owner: -
--

CREATE TABLE uranus.venue_link_types (
    venue_id integer NOT NULL,
    venue_type_id integer NOT NULL
);


--
-- TOC entry 545 (class 1259 OID 1086366)
-- Name: venue_type; Type: TABLE; Schema: uranus; Owner: -
--

CREATE TABLE uranus.venue_type (
    id integer NOT NULL,
    i18n_locale_id integer NOT NULL,
    name text NOT NULL,
    type_id integer NOT NULL,
    modified_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- TOC entry 544 (class 1259 OID 1086365)
-- Name: venue_type_id_seq; Type: SEQUENCE; Schema: uranus; Owner: -
--

ALTER TABLE uranus.venue_type ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME uranus.venue_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 539 (class 1259 OID 1086309)
-- Name: venue_url; Type: TABLE; Schema: uranus; Owner: -
--

CREATE TABLE uranus.venue_url (
    id integer NOT NULL,
    venue_id integer NOT NULL,
    link_type character varying(255),
    url text NOT NULL,
    title character varying(255),
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    modified_at timestamp with time zone
);


--
-- TOC entry 538 (class 1259 OID 1086308)
-- Name: venue_url_id_seq; Type: SEQUENCE; Schema: uranus; Owner: -
--

ALTER TABLE uranus.venue_url ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME uranus.venue_url_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 5353 (class 2606 OID 1086328)
-- Name: event_date event_date_pkey; Type: CONSTRAINT; Schema: uranus; Owner: -
--

ALTER TABLE ONLY uranus.event_date
    ADD CONSTRAINT event_date_pkey PRIMARY KEY (id);


--
-- TOC entry 5336 (class 2606 OID 1086269)
-- Name: event event_pkey; Type: CONSTRAINT; Schema: uranus; Owner: -
--

ALTER TABLE ONLY uranus.event
    ADD CONSTRAINT event_pkey PRIMARY KEY (id);


--
-- TOC entry 5371 (class 2606 OID 1086475)
-- Name: event_type event_type_pkey; Type: CONSTRAINT; Schema: uranus; Owner: -
--

ALTER TABLE ONLY uranus.event_type
    ADD CONSTRAINT event_type_pkey PRIMARY KEY (id);


--
-- TOC entry 5375 (class 2606 OID 1086501)
-- Name: genre_type genre_type_pkey; Type: CONSTRAINT; Schema: uranus; Owner: -
--

ALTER TABLE ONLY uranus.genre_type
    ADD CONSTRAINT genre_type_pkey PRIMARY KEY (id);


--
-- TOC entry 5368 (class 2606 OID 1086410)
-- Name: i18n_locale i18n_locale_pkey; Type: CONSTRAINT; Schema: uranus; Owner: -
--

ALTER TABLE ONLY uranus.i18n_locale
    ADD CONSTRAINT i18n_locale_pkey PRIMARY KEY (id);


--
-- TOC entry 5342 (class 2606 OID 1086293)
-- Name: image image_pkey; Type: CONSTRAINT; Schema: uranus; Owner: -
--

ALTER TABLE ONLY uranus.image
    ADD CONSTRAINT image_pkey PRIMARY KEY (id);


--
-- TOC entry 5382 (class 2606 OID 1086600)
-- Name: image_type image_type_pkey; Type: CONSTRAINT; Schema: uranus; Owner: -
--

ALTER TABLE ONLY uranus.image_type
    ADD CONSTRAINT image_type_pkey PRIMARY KEY (id);


--
-- TOC entry 5380 (class 2606 OID 1086587)
-- Name: license_type license_type_pkey; Type: CONSTRAINT; Schema: uranus; Owner: -
--

ALTER TABLE ONLY uranus.license_type
    ADD CONSTRAINT license_type_pkey PRIMARY KEY (id);


--
-- TOC entry 5345 (class 2606 OID 1086300)
-- Name: logo logo_pkey; Type: CONSTRAINT; Schema: uranus; Owner: -
--

ALTER TABLE ONLY uranus.logo
    ADD CONSTRAINT logo_pkey PRIMARY KEY (id);


--
-- TOC entry 5323 (class 2606 OID 1086231)
-- Name: organizer organizer_pkey; Type: CONSTRAINT; Schema: uranus; Owner: -
--

ALTER TABLE ONLY uranus.organizer
    ADD CONSTRAINT organizer_pkey PRIMARY KEY (id);


--
-- TOC entry 5332 (class 2606 OID 1086255)
-- Name: space space_pkey; Type: CONSTRAINT; Schema: uranus; Owner: -
--

ALTER TABLE ONLY uranus.space
    ADD CONSTRAINT space_pkey PRIMARY KEY (id);


--
-- TOC entry 5358 (class 2606 OID 1086359)
-- Name: space_type space_type_pkey; Type: CONSTRAINT; Schema: uranus; Owner: -
--

ALTER TABLE ONLY uranus.space_type
    ADD CONSTRAINT space_type_pkey PRIMARY KEY (id);


--
-- TOC entry 5347 (class 2606 OID 1086307)
-- Name: transport_station transport_station_pkey; Type: CONSTRAINT; Schema: uranus; Owner: -
--

ALTER TABLE ONLY uranus.transport_station
    ADD CONSTRAINT transport_station_pkey PRIMARY KEY (id);


--
-- TOC entry 5365 (class 2606 OID 1086382)
-- Name: venue_link_types venue_link_types_pkey; Type: CONSTRAINT; Schema: uranus; Owner: -
--

ALTER TABLE ONLY uranus.venue_link_types
    ADD CONSTRAINT venue_link_types_pkey PRIMARY KEY (venue_id, venue_type_id);


--
-- TOC entry 5328 (class 2606 OID 1086241)
-- Name: venue venue_pkey; Type: CONSTRAINT; Schema: uranus; Owner: -
--

ALTER TABLE ONLY uranus.venue
    ADD CONSTRAINT venue_pkey PRIMARY KEY (id);


--
-- TOC entry 5362 (class 2606 OID 1086372)
-- Name: venue_type venue_type_pkey; Type: CONSTRAINT; Schema: uranus; Owner: -
--

ALTER TABLE ONLY uranus.venue_type
    ADD CONSTRAINT venue_type_pkey PRIMARY KEY (id);


--
-- TOC entry 5349 (class 2606 OID 1086316)
-- Name: venue_url venue_url_pkey; Type: CONSTRAINT; Schema: uranus; Owner: -
--

ALTER TABLE ONLY uranus.venue_url
    ADD CONSTRAINT venue_url_pkey PRIMARY KEY (id);


--
-- TOC entry 5351 (class 1259 OID 1086562)
-- Name: event_date_event_id_idx; Type: INDEX; Schema: uranus; Owner: -
--

CREATE INDEX event_date_event_id_idx ON uranus.event_date USING btree (event_id);


--
-- TOC entry 5378 (class 1259 OID 1086609)
-- Name: event_date_link_images_event_date_id_image_id_main_image_idx; Type: INDEX; Schema: uranus; Owner: -
--

CREATE UNIQUE INDEX event_date_link_images_event_date_id_image_id_main_image_idx ON uranus.event_date_link_images USING btree (event_date_id, image_id, main_image);


--
-- TOC entry 5354 (class 1259 OID 1086564)
-- Name: event_date_space_id_idx; Type: INDEX; Schema: uranus; Owner: -
--

CREATE INDEX event_date_space_id_idx ON uranus.event_date USING btree (space_id);


--
-- TOC entry 5355 (class 1259 OID 1086563)
-- Name: event_date_venue_id_idx; Type: INDEX; Schema: uranus; Owner: -
--

CREATE INDEX event_date_venue_id_idx ON uranus.event_date USING btree (venue_id);


--
-- TOC entry 5377 (class 1259 OID 1086608)
-- Name: event_link_images_event_id_image_id_main_image_idx; Type: INDEX; Schema: uranus; Owner: -
--

CREATE UNIQUE INDEX event_link_images_event_id_image_id_main_image_idx ON uranus.event_link_images USING btree (event_id, image_id, main_image);


--
-- TOC entry 5334 (class 1259 OID 1086559)
-- Name: event_organizer_id_idx; Type: INDEX; Schema: uranus; Owner: -
--

CREATE INDEX event_organizer_id_idx ON uranus.event USING btree (organizer_id);


--
-- TOC entry 5337 (class 1259 OID 1086561)
-- Name: event_space_id_idx; Type: INDEX; Schema: uranus; Owner: -
--

CREATE INDEX event_space_id_idx ON uranus.event USING btree (space_id);


--
-- TOC entry 5369 (class 1259 OID 1086565)
-- Name: event_type_i18n_locale_id_idx; Type: INDEX; Schema: uranus; Owner: -
--

CREATE INDEX event_type_i18n_locale_id_idx ON uranus.event_type USING btree (i18n_locale_id);


--
-- TOC entry 5372 (class 1259 OID 1086566)
-- Name: event_type_type_id_idx; Type: INDEX; Schema: uranus; Owner: -
--

CREATE INDEX event_type_type_id_idx ON uranus.event_type USING btree (type_id);


--
-- TOC entry 5338 (class 1259 OID 1086560)
-- Name: event_venue_id_idx; Type: INDEX; Schema: uranus; Owner: -
--

CREATE INDEX event_venue_id_idx ON uranus.event USING btree (venue_id);


--
-- TOC entry 5373 (class 1259 OID 1086567)
-- Name: genre_type_i18n_locale_id_idx; Type: INDEX; Schema: uranus; Owner: -
--

CREATE INDEX genre_type_i18n_locale_id_idx ON uranus.genre_type USING btree (i18n_locale_id);


--
-- TOC entry 5376 (class 1259 OID 1086568)
-- Name: genre_type_type_id_idx; Type: INDEX; Schema: uranus; Owner: -
--

CREATE INDEX genre_type_type_id_idx ON uranus.genre_type USING btree (type_id);


--
-- TOC entry 5366 (class 1259 OID 1086569)
-- Name: i18n_locale_iso_639_1_idx; Type: INDEX; Schema: uranus; Owner: -
--

CREATE INDEX i18n_locale_iso_639_1_idx ON uranus.i18n_locale USING btree (iso_639_1);


--
-- TOC entry 5339 (class 1259 OID 1086558)
-- Name: image_image_type_id_idx; Type: INDEX; Schema: uranus; Owner: -
--

CREATE INDEX image_image_type_id_idx ON uranus.image USING btree (image_type_id);


--
-- TOC entry 5340 (class 1259 OID 1086557)
-- Name: image_license_type_id_idx; Type: INDEX; Schema: uranus; Owner: -
--

CREATE INDEX image_license_type_id_idx ON uranus.image USING btree (license_type_id);


--
-- TOC entry 5343 (class 1259 OID 1086606)
-- Name: image_source_name_idx; Type: INDEX; Schema: uranus; Owner: -
--

CREATE UNIQUE INDEX image_source_name_idx ON uranus.image USING btree (source_name);


--
-- TOC entry 5356 (class 1259 OID 1086571)
-- Name: space_type_i18n_locale_id_idx; Type: INDEX; Schema: uranus; Owner: -
--

CREATE INDEX space_type_i18n_locale_id_idx ON uranus.space_type USING btree (i18n_locale_id);


--
-- TOC entry 5359 (class 1259 OID 1086572)
-- Name: space_type_type_id_idx; Type: INDEX; Schema: uranus; Owner: -
--

CREATE INDEX space_type_type_id_idx ON uranus.space_type USING btree (type_id);


--
-- TOC entry 5333 (class 1259 OID 1086570)
-- Name: space_venue_id_idx; Type: INDEX; Schema: uranus; Owner: -
--

CREATE INDEX space_venue_id_idx ON uranus.space USING btree (venue_id);


--
-- TOC entry 5324 (class 1259 OID 1086577)
-- Name: venue_city_idx; Type: INDEX; Schema: uranus; Owner: -
--

CREATE INDEX venue_city_idx ON uranus.venue USING btree (city);


--
-- TOC entry 5325 (class 1259 OID 1086579)
-- Name: venue_country_code_idx; Type: INDEX; Schema: uranus; Owner: -
--

CREATE INDEX venue_country_code_idx ON uranus.venue USING btree (country_code);


--
-- TOC entry 5326 (class 1259 OID 1086573)
-- Name: venue_organizer_id_idx; Type: INDEX; Schema: uranus; Owner: -
--

CREATE INDEX venue_organizer_id_idx ON uranus.venue USING btree (organizer_id);


--
-- TOC entry 5329 (class 1259 OID 1086578)
-- Name: venue_postal_code_idx; Type: INDEX; Schema: uranus; Owner: -
--

CREATE INDEX venue_postal_code_idx ON uranus.venue USING btree (postal_code);


--
-- TOC entry 5360 (class 1259 OID 1086574)
-- Name: venue_type_i18n_locale_id_idx; Type: INDEX; Schema: uranus; Owner: -
--

CREATE INDEX venue_type_i18n_locale_id_idx ON uranus.venue_type USING btree (i18n_locale_id);


--
-- TOC entry 5363 (class 1259 OID 1086575)
-- Name: venue_type_type_id_idx; Type: INDEX; Schema: uranus; Owner: -
--

CREATE INDEX venue_type_type_id_idx ON uranus.venue_type USING btree (type_id);


--
-- TOC entry 5350 (class 1259 OID 1086576)
-- Name: venue_url_venue_id_idx; Type: INDEX; Schema: uranus; Owner: -
--

CREATE INDEX venue_url_venue_id_idx ON uranus.venue_url USING btree (venue_id);


--
-- TOC entry 5330 (class 1259 OID 1086607)
-- Name: venue_wkb_geometry_idx; Type: INDEX; Schema: uranus; Owner: -
--

CREATE INDEX venue_wkb_geometry_idx ON uranus.venue USING gist (wkb_geometry);


--
-- TOC entry 5406 (class 2620 OID 1086393)
-- Name: event set_modified_at; Type: TRIGGER; Schema: uranus; Owner: -
--

CREATE TRIGGER set_modified_at BEFORE UPDATE ON uranus.event FOR EACH ROW EXECUTE FUNCTION uranus.update_modified_at();


--
-- TOC entry 5411 (class 2620 OID 1086394)
-- Name: event_date set_modified_at; Type: TRIGGER; Schema: uranus; Owner: -
--

CREATE TRIGGER set_modified_at BEFORE UPDATE ON uranus.event_date FOR EACH ROW EXECUTE FUNCTION uranus.update_modified_at();


--
-- TOC entry 5407 (class 2620 OID 1086395)
-- Name: image set_modified_at; Type: TRIGGER; Schema: uranus; Owner: -
--

CREATE TRIGGER set_modified_at BEFORE UPDATE ON uranus.image FOR EACH ROW EXECUTE FUNCTION uranus.update_modified_at();


--
-- TOC entry 5408 (class 2620 OID 1086396)
-- Name: logo set_modified_at; Type: TRIGGER; Schema: uranus; Owner: -
--

CREATE TRIGGER set_modified_at BEFORE UPDATE ON uranus.logo FOR EACH ROW EXECUTE FUNCTION uranus.update_modified_at();


--
-- TOC entry 5403 (class 2620 OID 1086397)
-- Name: organizer set_modified_at; Type: TRIGGER; Schema: uranus; Owner: -
--

CREATE TRIGGER set_modified_at BEFORE UPDATE ON uranus.organizer FOR EACH ROW EXECUTE FUNCTION uranus.update_modified_at();


--
-- TOC entry 5405 (class 2620 OID 1086398)
-- Name: space set_modified_at; Type: TRIGGER; Schema: uranus; Owner: -
--

CREATE TRIGGER set_modified_at BEFORE UPDATE ON uranus.space FOR EACH ROW EXECUTE FUNCTION uranus.update_modified_at();


--
-- TOC entry 5412 (class 2620 OID 1086399)
-- Name: space_type set_modified_at; Type: TRIGGER; Schema: uranus; Owner: -
--

CREATE TRIGGER set_modified_at BEFORE UPDATE ON uranus.space_type FOR EACH ROW EXECUTE FUNCTION uranus.update_modified_at();


--
-- TOC entry 5409 (class 2620 OID 1086400)
-- Name: transport_station set_modified_at; Type: TRIGGER; Schema: uranus; Owner: -
--

CREATE TRIGGER set_modified_at BEFORE UPDATE ON uranus.transport_station FOR EACH ROW EXECUTE FUNCTION uranus.update_modified_at();


--
-- TOC entry 5404 (class 2620 OID 1086401)
-- Name: venue set_modified_at; Type: TRIGGER; Schema: uranus; Owner: -
--

CREATE TRIGGER set_modified_at BEFORE UPDATE ON uranus.venue FOR EACH ROW EXECUTE FUNCTION uranus.update_modified_at();


--
-- TOC entry 5413 (class 2620 OID 1086402)
-- Name: venue_type set_modified_at; Type: TRIGGER; Schema: uranus; Owner: -
--

CREATE TRIGGER set_modified_at BEFORE UPDATE ON uranus.venue_type FOR EACH ROW EXECUTE FUNCTION uranus.update_modified_at();


--
-- TOC entry 5410 (class 2620 OID 1086403)
-- Name: venue_url set_modified_at; Type: TRIGGER; Schema: uranus; Owner: -
--

CREATE TRIGGER set_modified_at BEFORE UPDATE ON uranus.venue_url FOR EACH ROW EXECUTE FUNCTION uranus.update_modified_at();


--
-- TOC entry 5390 (class 2606 OID 1086329)
-- Name: event_date event_date_event_id_fkey; Type: FK CONSTRAINT; Schema: uranus; Owner: -
--

ALTER TABLE ONLY uranus.event_date
    ADD CONSTRAINT event_date_event_id_fkey FOREIGN KEY (event_id) REFERENCES uranus.event(id) ON DELETE CASCADE;


--
-- TOC entry 5391 (class 2606 OID 1086339)
-- Name: event_date event_date_space_id_fkey; Type: FK CONSTRAINT; Schema: uranus; Owner: -
--

ALTER TABLE ONLY uranus.event_date
    ADD CONSTRAINT event_date_space_id_fkey FOREIGN KEY (space_id) REFERENCES uranus.space(id) ON DELETE SET NULL;


--
-- TOC entry 5392 (class 2606 OID 1086334)
-- Name: event_date event_date_venue_id_fkey; Type: FK CONSTRAINT; Schema: uranus; Owner: -
--

ALTER TABLE ONLY uranus.event_date
    ADD CONSTRAINT event_date_venue_id_fkey FOREIGN KEY (venue_id) REFERENCES uranus.venue(id) ON DELETE CASCADE;


--
-- TOC entry 5385 (class 2606 OID 1086275)
-- Name: event event_organizer_id_fkey; Type: FK CONSTRAINT; Schema: uranus; Owner: -
--

ALTER TABLE ONLY uranus.event
    ADD CONSTRAINT event_organizer_id_fkey FOREIGN KEY (organizer_id) REFERENCES uranus.organizer(id) ON DELETE CASCADE;


--
-- TOC entry 5386 (class 2606 OID 1086270)
-- Name: event event_space_id_fkey; Type: FK CONSTRAINT; Schema: uranus; Owner: -
--

ALTER TABLE ONLY uranus.event
    ADD CONSTRAINT event_space_id_fkey FOREIGN KEY (space_id) REFERENCES uranus.space(id) ON DELETE SET NULL;


--
-- TOC entry 5387 (class 2606 OID 1086280)
-- Name: event event_venue_id_fkey; Type: FK CONSTRAINT; Schema: uranus; Owner: -
--

ALTER TABLE ONLY uranus.event
    ADD CONSTRAINT event_venue_id_fkey FOREIGN KEY (venue_id) REFERENCES uranus.venue(id) ON DELETE CASCADE;


--
-- TOC entry 5400 (class 2606 OID 1086541)
-- Name: event_date_link_images fk_event_date_id; Type: FK CONSTRAINT; Schema: uranus; Owner: -
--

ALTER TABLE ONLY uranus.event_date_link_images
    ADD CONSTRAINT fk_event_date_id FOREIGN KEY (event_date_id) REFERENCES uranus.event_date(id) ON DELETE CASCADE;


--
-- TOC entry 5395 (class 2606 OID 1086461)
-- Name: event_link_types fk_event_id; Type: FK CONSTRAINT; Schema: uranus; Owner: -
--

ALTER TABLE ONLY uranus.event_link_types
    ADD CONSTRAINT fk_event_id FOREIGN KEY (event_id) REFERENCES uranus.event(id);


--
-- TOC entry 5397 (class 2606 OID 1086514)
-- Name: genre_link_types fk_event_id; Type: FK CONSTRAINT; Schema: uranus; Owner: -
--

ALTER TABLE ONLY uranus.genre_link_types
    ADD CONSTRAINT fk_event_id FOREIGN KEY (event_id) REFERENCES uranus.event(id);


--
-- TOC entry 5398 (class 2606 OID 1086528)
-- Name: event_link_images fk_event_id; Type: FK CONSTRAINT; Schema: uranus; Owner: -
--

ALTER TABLE ONLY uranus.event_link_images
    ADD CONSTRAINT fk_event_id FOREIGN KEY (event_id) REFERENCES uranus.event(id) ON DELETE CASCADE;


--
-- TOC entry 5396 (class 2606 OID 1086478)
-- Name: event_link_types fk_event_type_id; Type: FK CONSTRAINT; Schema: uranus; Owner: -
--

ALTER TABLE ONLY uranus.event_link_types
    ADD CONSTRAINT fk_event_type_id FOREIGN KEY (event_type_id) REFERENCES uranus.event_type(id);


--
-- TOC entry 5393 (class 2606 OID 1086444)
-- Name: space_type fk_i18n_locale_id; Type: FK CONSTRAINT; Schema: uranus; Owner: -
--

ALTER TABLE ONLY uranus.space_type
    ADD CONSTRAINT fk_i18n_locale_id FOREIGN KEY (i18n_locale_id) REFERENCES uranus.i18n_locale(id);


--
-- TOC entry 5402 (class 2606 OID 1086601)
-- Name: image_type fk_i18n_locale_id; Type: FK CONSTRAINT; Schema: uranus; Owner: -
--

ALTER TABLE ONLY uranus.image_type
    ADD CONSTRAINT fk_i18n_locale_id FOREIGN KEY (i18n_locale_id) REFERENCES uranus.i18n_locale(id);


--
-- TOC entry 5399 (class 2606 OID 1086533)
-- Name: event_link_images fk_image_id; Type: FK CONSTRAINT; Schema: uranus; Owner: -
--

ALTER TABLE ONLY uranus.event_link_images
    ADD CONSTRAINT fk_image_id FOREIGN KEY (image_id) REFERENCES uranus.image(id) ON DELETE CASCADE;


--
-- TOC entry 5401 (class 2606 OID 1086546)
-- Name: event_date_link_images fk_image_id; Type: FK CONSTRAINT; Schema: uranus; Owner: -
--

ALTER TABLE ONLY uranus.event_date_link_images
    ADD CONSTRAINT fk_image_id FOREIGN KEY (image_id) REFERENCES uranus.image(id) ON DELETE CASCADE;


--
-- TOC entry 5388 (class 2606 OID 1086588)
-- Name: image fk_license_type_id; Type: FK CONSTRAINT; Schema: uranus; Owner: -
--

ALTER TABLE ONLY uranus.image
    ADD CONSTRAINT fk_license_type_id FOREIGN KEY (license_type_id) REFERENCES uranus.license_type(id);


--
-- TOC entry 5384 (class 2606 OID 1086256)
-- Name: space space_venue_id_fkey; Type: FK CONSTRAINT; Schema: uranus; Owner: -
--

ALTER TABLE ONLY uranus.space
    ADD CONSTRAINT space_venue_id_fkey FOREIGN KEY (venue_id) REFERENCES uranus.venue(id) ON DELETE CASCADE;


--
-- TOC entry 5394 (class 2606 OID 1086383)
-- Name: venue_link_types venue_link_types_venue_id_fkey; Type: FK CONSTRAINT; Schema: uranus; Owner: -
--

ALTER TABLE ONLY uranus.venue_link_types
    ADD CONSTRAINT venue_link_types_venue_id_fkey FOREIGN KEY (venue_id) REFERENCES uranus.venue(id) ON DELETE CASCADE;


--
-- TOC entry 5383 (class 2606 OID 1086242)
-- Name: venue venue_organizer_id_fkey; Type: FK CONSTRAINT; Schema: uranus; Owner: -
--

ALTER TABLE ONLY uranus.venue
    ADD CONSTRAINT venue_organizer_id_fkey FOREIGN KEY (organizer_id) REFERENCES uranus.organizer(id);


--
-- TOC entry 5389 (class 2606 OID 1086317)
-- Name: venue_url venue_url_venue_id_fkey; Type: FK CONSTRAINT; Schema: uranus; Owner: -
--

ALTER TABLE ONLY uranus.venue_url
    ADD CONSTRAINT venue_url_venue_id_fkey FOREIGN KEY (venue_id) REFERENCES uranus.venue(id) ON DELETE CASCADE;


-- Completed on 2025-03-05 11:37:15 CET

--
-- PostgreSQL database dump complete
--

