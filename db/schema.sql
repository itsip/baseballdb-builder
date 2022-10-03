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
    player_id character varying NOT NULL,
    year_id integer,
    game_num integer,
    game_id character varying NOT NULL,
    team_id character varying,
    lg_id character varying,
    gp integer,
    starting_pos integer
);


--
-- Name: appearances; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.appearances (
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
    player_id character varying NOT NULL,
    school_id character varying NOT NULL,
    year_id integer NOT NULL
);


--
-- Name: fielding; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.fielding (
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
    player_id character varying NOT NULL,
    year_id integer NOT NULL,
    stint integer NOT NULL,
    team_id character varying,
    lgid character varying,
    pos integer,
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
    player_id character varying NOT NULL,
    year_id integer NOT NULL,
    team_id character varying,
    lg_id character varying,
    round_id integer NOT NULL,
    pos integer,
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
    year_id integer,
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
    franch_id character varying NOT NULL,
    franch_name character varying,
    active character varying,
    na_assoc character varying
);


--
-- Name: teams_half; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.teams_half (
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
-- Name: allstar_full allstar_full_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.allstar_full
    ADD CONSTRAINT allstar_full_pkey PRIMARY KEY (player_id, game_id);


--
-- Name: appearances appearances_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.appearances
    ADD CONSTRAINT appearances_pkey PRIMARY KEY (year_id, team_id, player_id);


--
-- Name: awards_managers awards_managers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.awards_managers
    ADD CONSTRAINT awards_managers_pkey PRIMARY KEY (player_id, award_id, year_id);


--
-- Name: awards_players awards_players_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.awards_players
    ADD CONSTRAINT awards_players_pkey PRIMARY KEY (player_id, award_id, year_id);


--
-- Name: awards_share_managers awards_share_managers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.awards_share_managers
    ADD CONSTRAINT awards_share_managers_pkey PRIMARY KEY (award_id, year_id, player_id);


--
-- Name: awards_share_players awards_share_players_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.awards_share_players
    ADD CONSTRAINT awards_share_players_pkey PRIMARY KEY (award_id, year_id, player_id);


--
-- Name: batting batting_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.batting
    ADD CONSTRAINT batting_pkey PRIMARY KEY (player_id, year_id, stint, team_id);


--
-- Name: batting_post batting_post_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.batting_post
    ADD CONSTRAINT batting_post_pkey PRIMARY KEY (year_id, round_id, player_id);


--
-- Name: college_playing college_playing_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.college_playing
    ADD CONSTRAINT college_playing_pkey PRIMARY KEY (player_id, school_id, year_id);


--
-- Name: fielding_of fielding_of_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fielding_of
    ADD CONSTRAINT fielding_of_pkey PRIMARY KEY (player_id, year_id, stint);


--
-- Name: fielding_of_split fielding_of_split_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fielding_of_split
    ADD CONSTRAINT fielding_of_split_pkey PRIMARY KEY (player_id, year_id, stint);


--
-- Name: fielding fielding_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fielding
    ADD CONSTRAINT fielding_pkey PRIMARY KEY (player_id, year_id, stint, team_id, pos);


--
-- Name: fielding_post fielding_post_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fielding_post
    ADD CONSTRAINT fielding_post_pkey PRIMARY KEY (player_id, year_id, round_id);


--
-- Name: hall_of_fame hall_of_fame_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hall_of_fame
    ADD CONSTRAINT hall_of_fame_pkey PRIMARY KEY (player_id, year_id);


--
-- Name: home_games home_games_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.home_games
    ADD CONSTRAINT home_games_pkey PRIMARY KEY (year_id, team_id, park_id);


--
-- Name: managers_half managers_half_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.managers_half
    ADD CONSTRAINT managers_half_pkey PRIMARY KEY (player_id, year_id, team_id, inseason, half);


--
-- Name: managers managers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.managers
    ADD CONSTRAINT managers_pkey PRIMARY KEY (player_id, year_id, team_id, inseason);


--
-- Name: parks parks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.parks
    ADD CONSTRAINT parks_pkey PRIMARY KEY (park_id);


--
-- Name: people people_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.people
    ADD CONSTRAINT people_pkey PRIMARY KEY (player_id);


--
-- Name: pitching pitching_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pitching
    ADD CONSTRAINT pitching_pkey PRIMARY KEY (player_id, year_id, stint, team_id);


--
-- Name: pitching_post pitching_post_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pitching_post
    ADD CONSTRAINT pitching_post_pkey PRIMARY KEY (player_id, round_id, year_id);


--
-- Name: salaries salaries_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.salaries
    ADD CONSTRAINT salaries_pkey PRIMARY KEY (year_id, team_id, player_id);


--
-- Name: schools schools_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schools
    ADD CONSTRAINT schools_pkey PRIMARY KEY (school_id);


--
-- Name: series_post series_post_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.series_post
    ADD CONSTRAINT series_post_pkey PRIMARY KEY (year_id, round_id);


--
-- Name: teams_franchises teams_franchises_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.teams_franchises
    ADD CONSTRAINT teams_franchises_pkey PRIMARY KEY (franch_id);


--
-- Name: teams teams_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.teams
    ADD CONSTRAINT teams_pkey PRIMARY KEY (team_id);


--
-- Name: allstar_full allstar_full_player_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.allstar_full
    ADD CONSTRAINT allstar_full_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.people(player_id);


--
-- Name: allstar_full allstar_full_team_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.allstar_full
    ADD CONSTRAINT allstar_full_team_id_fkey FOREIGN KEY (team_id) REFERENCES public.teams(team_id);


--
-- Name: appearances appearances_player_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.appearances
    ADD CONSTRAINT appearances_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.people(player_id);


--
-- Name: appearances appearances_team_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.appearances
    ADD CONSTRAINT appearances_team_id_fkey FOREIGN KEY (team_id) REFERENCES public.teams(team_id);


--
-- Name: awards_managers awards_managers_player_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.awards_managers
    ADD CONSTRAINT awards_managers_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.people(player_id);


--
-- Name: awards_players awards_players_player_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.awards_players
    ADD CONSTRAINT awards_players_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.people(player_id);


--
-- Name: awards_share_managers awards_share_managers_player_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.awards_share_managers
    ADD CONSTRAINT awards_share_managers_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.people(player_id);


--
-- Name: awards_share_players awards_share_players_player_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.awards_share_players
    ADD CONSTRAINT awards_share_players_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.people(player_id);


--
-- Name: batting batting_player_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.batting
    ADD CONSTRAINT batting_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.people(player_id);


--
-- Name: batting_post batting_post_player_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.batting_post
    ADD CONSTRAINT batting_post_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.people(player_id);


--
-- Name: batting_post batting_post_team_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.batting_post
    ADD CONSTRAINT batting_post_team_id_fkey FOREIGN KEY (team_id) REFERENCES public.teams(team_id);


--
-- Name: batting batting_team_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.batting
    ADD CONSTRAINT batting_team_id_fkey FOREIGN KEY (team_id) REFERENCES public.teams(team_id);


--
-- Name: college_playing college_playing_player_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.college_playing
    ADD CONSTRAINT college_playing_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.people(player_id);


--
-- Name: college_playing college_playing_school_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.college_playing
    ADD CONSTRAINT college_playing_school_id_fkey FOREIGN KEY (school_id) REFERENCES public.schools(school_id);


--
-- Name: fielding_of fielding_of_player_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fielding_of
    ADD CONSTRAINT fielding_of_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.people(player_id);


--
-- Name: fielding_of_split fielding_of_split_player_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fielding_of_split
    ADD CONSTRAINT fielding_of_split_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.people(player_id);


--
-- Name: fielding_of_split fielding_of_split_team_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fielding_of_split
    ADD CONSTRAINT fielding_of_split_team_id_fkey FOREIGN KEY (team_id) REFERENCES public.teams(team_id);


--
-- Name: fielding fielding_player_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fielding
    ADD CONSTRAINT fielding_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.people(player_id);


--
-- Name: fielding_post fielding_post_player_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fielding_post
    ADD CONSTRAINT fielding_post_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.people(player_id);


--
-- Name: fielding_post fielding_post_team_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fielding_post
    ADD CONSTRAINT fielding_post_team_id_fkey FOREIGN KEY (team_id) REFERENCES public.teams(team_id);


--
-- Name: fielding fielding_team_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fielding
    ADD CONSTRAINT fielding_team_id_fkey FOREIGN KEY (team_id) REFERENCES public.teams(team_id);


--
-- Name: hall_of_fame hall_of_fame_player_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hall_of_fame
    ADD CONSTRAINT hall_of_fame_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.people(player_id);


--
-- Name: home_games home_games_park_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.home_games
    ADD CONSTRAINT home_games_park_id_fkey FOREIGN KEY (park_id) REFERENCES public.parks(park_id);


--
-- Name: home_games home_games_team_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.home_games
    ADD CONSTRAINT home_games_team_id_fkey FOREIGN KEY (team_id) REFERENCES public.teams(team_id);


--
-- Name: managers_half managers_half_player_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.managers_half
    ADD CONSTRAINT managers_half_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.people(player_id);


--
-- Name: managers_half managers_half_team_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.managers_half
    ADD CONSTRAINT managers_half_team_id_fkey FOREIGN KEY (team_id) REFERENCES public.teams(team_id);


--
-- Name: managers managers_player_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.managers
    ADD CONSTRAINT managers_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.people(player_id);


--
-- Name: managers managers_team_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.managers
    ADD CONSTRAINT managers_team_id_fkey FOREIGN KEY (team_id) REFERENCES public.teams(team_id);


--
-- Name: pitching pitching_player_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pitching
    ADD CONSTRAINT pitching_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.people(player_id);


--
-- Name: pitching_post pitching_post_player_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pitching_post
    ADD CONSTRAINT pitching_post_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.people(player_id);


--
-- Name: pitching_post pitching_post_team_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pitching_post
    ADD CONSTRAINT pitching_post_team_id_fkey FOREIGN KEY (team_id) REFERENCES public.teams(team_id);


--
-- Name: pitching pitching_team_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pitching
    ADD CONSTRAINT pitching_team_id_fkey FOREIGN KEY (team_id) REFERENCES public.teams(team_id);


--
-- Name: salaries salaries_player_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.salaries
    ADD CONSTRAINT salaries_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.people(player_id);


--
-- Name: salaries salaries_team_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.salaries
    ADD CONSTRAINT salaries_team_id_fkey FOREIGN KEY (team_id) REFERENCES public.teams(team_id);


--
-- Name: series_post series_post_team_id_loser_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.series_post
    ADD CONSTRAINT series_post_team_id_loser_fkey FOREIGN KEY (team_id_loser) REFERENCES public.teams(team_id);


--
-- Name: series_post series_post_team_id_winner_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.series_post
    ADD CONSTRAINT series_post_team_id_winner_fkey FOREIGN KEY (team_id_winner) REFERENCES public.teams(team_id);


--
-- Name: teams teams_franch_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.teams
    ADD CONSTRAINT teams_franch_id_fkey FOREIGN KEY (franch_id) REFERENCES public.teams_franchises(franch_id);


--
-- Name: teams_half teams_half_team_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.teams_half
    ADD CONSTRAINT teams_half_team_id_fkey FOREIGN KEY (team_id) REFERENCES public.teams(team_id);


--
-- PostgreSQL database dump complete
--

