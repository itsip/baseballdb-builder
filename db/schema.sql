--
-- PostgreSQL database dump
--

-- Dumped from database version 14.5 (Homebrew)
-- Dumped by pg_dump version 14.5 (Homebrew)

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
-- Name: allstar_full; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.allstar_full (
    id serial primary key,
    player_id character varying NOT NULL,
    year_id integer NOT NULL,
    game_num integer,
    game_id character varying,
    team_id character varying,
    lg_id character varying,
    gp integer,
    starting_pos integer
);


--
-- Name: appearances; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.appearances (
    id serial primary key,
    year_id integer NOT NULL,
    team_id character varying NOT NULL,
    lg_id character varying,
    player_id character varying NOT NULL,
    g_all integer,
    gs integer,
    g_batting integer,
    g_defense integer,
    g_p integer,
    g_c integer,
    g_1b integer,
    g_2b integer,
    g_3b integer,
    g_ss integer,
    g_lf integer,
    g_cf integer,
    g_rf integer,
    g_of integer,
    g_dh integer,
    g_ph integer,
    g_pr integer
);


--
-- Name: awards_managers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.awards_managers (
    id serial primary key,
    player_id character varying NOT NULL,
    award_id character varying NOT NULL,
    year_id integer NOT NULL,
    lg_id character varying,
    tie character varying,
    notes character varying
);


--
-- Name: awards_players; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.awards_players (
    id serial primary key,
    player_id character varying NOT NULL,
    award_id character varying NOT NULL,
    year_id integer NOT NULL,
    lg_id character varying,
    tie character varying,
    notes character varying
);


--
-- Name: awards_share_managers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.awards_share_managers (
    id serial primary key,
    award_id character varying NOT NULL,
    year_id integer NOT NULL,
    lg_id character varying,
    player_id character varying NOT NULL,
    points_won integer,
    points_max integer,
    votes_first integer
);


--
-- Name: awards_share_players; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.awards_share_players (
    id serial primary key,
    award_id character varying NOT NULL,
    year_id integer NOT NULL,
    lg_id character varying,
    player_id character varying NOT NULL,
    points_won integer,
    points_max integer,
    votes_first integer
);


--
-- Name: batting; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.batting (
    id serial primary key,
    player_id character varying NOT NULL,
    year_id integer NOT NULL,
    stint integer NOT NULL,
    team_id character varying NOT NULL,
    lg_id character varying,
    g integer,
    ab integer,
    r integer,
    h integer,
    "2b" integer,
    "3b" integer,
    hr integer,
    rbi integer,
    sb integer,
    cs integer,
    bb integer,
    so integer,
    ibb integer,
    hbp integer,
    sh integer,
    sf integer,
    gidp integer
);


--
-- Name: batting_post; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.batting_post (
    id serial primary key,
    year_id integer NOT NULL,
    round_id character varying NOT NULL,
    player_id character varying NOT NULL,
    team_id character varying,
    lg_id character varying,
    g integer,
    ab integer,
    r integer,
    h integer,
    "2B" integer,
    "3B" integer,
    hr integer,
    rbi integer,
    sb integer,
    cs integer,
    bb integer,
    so integer,
    ibb integer,
    hbp integer,
    sh integer,
    sf integer,
    gidp integer
);


--
-- Name: college_playing; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.college_playing (
    id serial primary key,
    player_id character varying NOT NULL,
    school_id character varying NOT NULL,
    year_id integer NOT NULL
);


--
-- Name: fielding; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.fielding (
    id serial primary key,
    player_id character varying NOT NULL,
    year_id integer NOT NULL,
    stint integer NOT NULL,
    team_id character varying NOT NULL,
    lg_id character varying,
    pos character varying NOT NULL,
    g integer,
    gs integer,
    inn_outs integer,
    po integer,
    a integer,
    e integer,
    dp integer,
    pb integer,
    wp integer,
    sb integer,
    cs integer,
    zr integer
);


--
-- Name: fielding_of; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.fielding_of (
    id serial primary key,
    player_id character varying NOT NULL,
    year_id integer NOT NULL,
    stint integer NOT NULL,
    g_lf integer,
    g_cf integer,
    g_rf integer
);


--
-- Name: fielding_of_split; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.fielding_of_split (
    id serial primary key,
    player_id character varying NOT NULL,
    year_id integer NOT NULL,
    stint integer NOT NULL,
    team_id character varying NOT NULL,
    lgid character varying,
    pos character varying NOT NULL,
    g integer,
    gs integer,
    innouts integer,
    po integer,
    a integer,
    e integer,
    dp integer,
    pb integer,
    wp integer,
    sb integer,
    cs integer,
    zr integer
);


--
-- Name: fielding_post; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.fielding_post (
    id serial primary key,
    player_id character varying NOT NULL,
    year_id integer NOT NULL,
    team_id character varying,
    lg_id character varying,
    round_id character varying NOT NULL,
    pos character varying NOT NULL,
    g integer,
    gs integer,
    inn_outs integer,
    po integer,
    a integer,
    e integer,
    dp integer,
    tp integer,
    pb integer,
    sb integer,
    cs integer
);


--
-- Name: hall_of_fame; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.hall_of_fame (
    id serial primary key,
    player_id character varying NOT NULL,
    year_id integer NOT NULL,
    voted_by character varying,
    ballots integer,
    needed integer,
    votes integer,
    inducted character varying,
    category character varying,
    needed_note character varying
);


--
-- Name: home_games; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.home_games (
    id serial primary key,
    year_id integer NOT NULL,
    league_id character varying,
    team_id character varying NOT NULL,
    park_id character varying NOT NULL,
    span_first date,
    span_last date,
    games integer,
    openings integer,
    attendance integer
);


--
-- Name: managers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.managers (
    id serial primary key,
    player_id character varying NOT NULL,
    year_id integer NOT NULL,
    team_id character varying NOT NULL,
    lg_id character varying,
    inseason integer NOT NULL,
    g integer,
    w integer,
    l integer,
    standings_rank integer,
    plyr_mgr character varying
);


--
-- Name: managers_half; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.managers_half (
    id serial primary key,
    player_id character varying NOT NULL,
    year_id integer NOT NULL,
    team_id character varying NOT NULL,
    lg_id character varying,
    inseason integer NOT NULL,
    half integer NOT NULL,
    g integer,
    w integer,
    l integer,
    standings_rank integer
);


--
-- Name: parks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.parks (
    id serial primary key,
    park_id character varying NOT NULL,
    park_name character varying,
    park_alias character varying,
    city character varying,
    state character varying,
    country character varying
);


--
-- Name: people; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.people (
    id serial primary key,
    player_id character varying NOT NULL,
    birth_year integer,
    birth_month integer,
    birthday integer,
    birth_country character varying,
    birth_state character varying,
    birth_city character varying,
    death_year integer,
    death_month integer,
    death_day integer,
    death_country character varying,
    death_state character varying,
    death_city character varying,
    name_first character varying,
    name_last character varying,
    name_given character varying,
    weight integer,
    height integer,
    bats character varying,
    throws character varying,
    debut date,
    final_game date,
    retro_id character varying,
    bbref_id character varying
);


--
-- Name: pitching; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.pitching (
    id serial primary key,
    player_id character varying NOT NULL,
    year_id integer NOT NULL,
    stint integer NOT NULL,
    team_id character varying NOT NULL,
    lg_id character varying,
    w integer,
    l integer,
    g integer,
    gs integer,
    cg integer,
    sho integer,
    sv integer,
    ipouts integer,
    h integer,
    er integer,
    hr integer,
    bb integer,
    so integer,
    baopp numeric,
    era numeric,
    ibb integer,
    wp integer,
    hbp integer,
    bk integer,
    bfp integer,
    gf integer,
    r integer,
    sh integer,
    sf integer,
    gidp integer
);


--
-- Name: pitching_post; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.pitching_post (
    id serial primary key,
    player_id character varying NOT NULL,
    year_id integer NOT NULL,
    round_id character varying NOT NULL,
    team_id character varying,
    lg_id character varying,
    w integer,
    l integer,
    g integer,
    gs integer,
    cg integer,
    sho integer,
    sv integer,
    ipouts integer,
    h integer,
    er integer,
    hr integer,
    bb integer,
    so integer,
    baopp numeric,
    era numeric,
    ibb integer,
    wp integer,
    hbp integer,
    bk integer,
    bfp integer,
    gf integer,
    r integer,
    sh integer,
    sf integer,
    gidp integer
);


--
-- Name: salaries; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.salaries (
    id serial primary key,
    year_id integer NOT NULL,
    team_id character varying NOT NULL,
    lg_id character varying,
    player_id character varying NOT NULL,
    salary integer
);


--
-- Name: schools; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schools (
    id serial primary key,
    school_id character varying NOT NULL,
    name_full character varying,
    city character varying,
    state character varying,
    country character varying
);


--
-- Name: series_post; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.series_post (
    id serial primary key,
    year_id integer NOT NULL,
    round_id character varying NOT NULL,
    team_id_winner character varying,
    lg_id_winner character varying,
    team_id_loser character varying,
    lg_id_loser character varying,
    n_wins integer,
    n_losses integer,
    n_ties integer
);


--
-- Name: teams; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.teams (
    id serial primary key,
    year_id integer NOT NULL,
    lg_id character varying,
    team_id character varying NOT NULL,
    franch_id character varying,
    div_id character varying,
    standings_rank integer,
    g integer,
    g_home integer,
    w integer,
    l integer,
    div_win character varying,
    wc_win character varying,
    lg_win character varying,
    ws_win character varying,
    r integer,
    ab integer,
    h integer,
    "2B" integer,
    "3B" integer,
    hr integer,
    bb integer,
    so integer,
    sb integer,
    cs integer,
    hbp integer,
    sf integer,
    ra integer,
    er integer,
    era numeric,
    cg integer,
    sho integer,
    sv integer,
    ip_outs integer,
    ha integer,
    hra integer,
    bba integer,
    soa integer,
    e integer,
    dp integer,
    fp numeric,
    name character varying,
    park character varying,
    attendance integer,
    bpf integer,
    ppf integer,
    team_id_br character varying,
    team_id_lahman45 character varying,
    team_id_retro character varying
);


--
-- Name: teams_franchises; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.teams_franchises (
    id serial primary key,
    franch_id character varying NOT NULL,
    franch_name character varying,
    active character varying,
    na_assoc character varying
);


--
-- Name: teams_half; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.teams_half (
    id serial primary key,
    year_id integer,
    lg_id character varying,
    team_id character varying,
    half integer,
    div_id character varying,
    div_win character varying,
    standings_rank integer,
    g integer,
    w integer,
    l integer
);


--
-- PostgreSQL database dump complete
--

