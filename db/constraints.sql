--
-- Name: allstar_full allstar_full_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.allstar_full
    ADD CONSTRAINT allstar_full_pkey PRIMARY KEY (player_id, year_id);


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
    ADD CONSTRAINT fielding_of_split_pkey PRIMARY KEY (player_id, year_id, stint, team_id, pos);


--
-- Name: fielding fielding_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fielding
    ADD CONSTRAINT fielding_pkey PRIMARY KEY (player_id, year_id, stint, team_id, pos);


--
-- Name: fielding_post fielding_post_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fielding_post
    ADD CONSTRAINT fielding_post_pkey PRIMARY KEY (player_id, year_id, round_id, pos);


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
    ADD CONSTRAINT teams_pkey PRIMARY KEY (year_id, team_id);


--
-- Name: allstar_full allstar_full_player_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.allstar_full
    ADD CONSTRAINT allstar_full_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.people(player_id);


--
-- Name: allstar_full allstar_full_year_id_team_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.allstar_full
    ADD CONSTRAINT allstar_full_year_id_team_id_fkey FOREIGN KEY (year_id, team_id) REFERENCES public.teams(year_id, team_id);


--
-- Name: appearances appearances_player_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.appearances
    ADD CONSTRAINT appearances_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.people(player_id);


--
-- Name: appearances appearances_year_id_team_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.appearances
    ADD CONSTRAINT appearances_year_id_team_id_fkey FOREIGN KEY (year_id, team_id) REFERENCES public.teams(year_id, team_id);


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
-- Name: batting_post batting_post_year_id_team_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.batting_post
    ADD CONSTRAINT batting_post_year_id_team_id_fkey FOREIGN KEY (year_id, team_id) REFERENCES public.teams(year_id, team_id);


--
-- Name: batting batting_year_id_team_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.batting
    ADD CONSTRAINT batting_year_id_team_id_fkey FOREIGN KEY (year_id, team_id) REFERENCES public.teams(year_id, team_id);


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
-- Name: fielding_of_split fielding_of_split_year_id_team_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fielding_of_split
    ADD CONSTRAINT fielding_of_split_year_id_team_id_fkey FOREIGN KEY (year_id, team_id) REFERENCES public.teams(year_id, team_id);


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
-- Name: fielding_post fielding_post_year_id_team_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fielding_post
    ADD CONSTRAINT fielding_post_year_id_team_id_fkey FOREIGN KEY (year_id, team_id) REFERENCES public.teams(year_id, team_id);


--
-- Name: fielding fielding_year_id_team_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fielding
    ADD CONSTRAINT fielding_year_id_team_id_fkey FOREIGN KEY (year_id, team_id) REFERENCES public.teams(year_id, team_id);


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
-- Name: home_games home_games_year_id_team_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.home_games
    ADD CONSTRAINT home_games_year_id_team_id_fkey FOREIGN KEY (year_id, team_id) REFERENCES public.teams(year_id, team_id);


--
-- Name: managers_half managers_half_player_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.managers_half
    ADD CONSTRAINT managers_half_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.people(player_id);


--
-- Name: managers_half managers_half_year_id_team_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.managers_half
    ADD CONSTRAINT managers_half_year_id_team_id_fkey FOREIGN KEY (year_id, team_id) REFERENCES public.teams(year_id, team_id);


--
-- Name: managers managers_player_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.managers
    ADD CONSTRAINT managers_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.people(player_id);


--
-- Name: managers managers_year_id_team_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.managers
    ADD CONSTRAINT managers_year_id_team_id_fkey FOREIGN KEY (year_id, team_id) REFERENCES public.teams(year_id, team_id);


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
-- Name: pitching_post pitching_post_year_id_team_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pitching_post
    ADD CONSTRAINT pitching_post_year_id_team_id_fkey FOREIGN KEY (year_id, team_id) REFERENCES public.teams(year_id, team_id);


--
-- Name: pitching pitching_year_id_team_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pitching
    ADD CONSTRAINT pitching_year_id_team_id_fkey FOREIGN KEY (year_id, team_id) REFERENCES public.teams(year_id, team_id);


--
-- Name: salaries salaries_player_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.salaries
    ADD CONSTRAINT salaries_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.people(player_id);


--
-- Name: salaries salaries_year_id_team_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.salaries
    ADD CONSTRAINT salaries_year_id_team_id_fkey FOREIGN KEY (year_id, team_id) REFERENCES public.teams(year_id, team_id);


--
-- Name: series_post series_post_year_id_team_id_loser_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.series_post
    ADD CONSTRAINT series_post_year_id_team_id_loser_fkey FOREIGN KEY (year_id, team_id_loser) REFERENCES public.teams(year_id, team_id);


--
-- Name: series_post series_post_year_id_team_id_winner_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.series_post
    ADD CONSTRAINT series_post_year_id_team_id_winner_fkey FOREIGN KEY (year_id, team_id_winner) REFERENCES public.teams(year_id, team_id);


--
-- Name: teams teams_franch_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.teams
    ADD CONSTRAINT teams_franch_id_fkey FOREIGN KEY (franch_id) REFERENCES public.teams_franchises(franch_id);


--
-- Name: teams_half teams_half_year_id_team_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.teams_half
    ADD CONSTRAINT teams_half_year_id_team_id_fkey FOREIGN KEY (year_id, team_id) REFERENCES public.teams(year_id, team_id);
