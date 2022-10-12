-- Add foreign keys
ALTER TABLE ONLY public.allstar_full
    ADD CONSTRAINT allstar_full_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.people(id);

ALTER TABLE ONLY public.allstar_full
    ADD CONSTRAINT allstar_full_year_id_team_id_fkey FOREIGN KEY (team_id) REFERENCES public.teams(id);

ALTER TABLE ONLY public.appearances
    ADD CONSTRAINT appearances_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.people(id);

ALTER TABLE ONLY public.appearances
    ADD CONSTRAINT appearances_year_id_team_id_fkey FOREIGN KEY (team_id) REFERENCES public.teams(id);

ALTER TABLE ONLY public.awards_managers
    ADD CONSTRAINT awards_managers_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.people(id);

ALTER TABLE ONLY public.awards_players
    ADD CONSTRAINT awards_players_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.people(id);

ALTER TABLE ONLY public.awards_share_managers
    ADD CONSTRAINT awards_share_managers_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.people(id);

ALTER TABLE ONLY public.awards_share_players
    ADD CONSTRAINT awards_share_players_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.people(id);

ALTER TABLE ONLY public.batting
    ADD CONSTRAINT batting_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.people(id);

ALTER TABLE ONLY public.batting_post
    ADD CONSTRAINT batting_post_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.people(id);

ALTER TABLE ONLY public.batting_post
    ADD CONSTRAINT batting_post_year_id_team_id_fkey FOREIGN KEY (team_id) REFERENCES public.teams(id);

ALTER TABLE ONLY public.batting
    ADD CONSTRAINT batting_year_id_team_id_fkey FOREIGN KEY (team_id) REFERENCES public.teams(id);

ALTER TABLE ONLY public.college_playing
    ADD CONSTRAINT college_playing_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.people(id);

ALTER TABLE ONLY public.college_playing
    ADD CONSTRAINT college_playing_school_id_fkey FOREIGN KEY (school_id) REFERENCES public.schools(id);

ALTER TABLE ONLY public.fielding_of
    ADD CONSTRAINT fielding_of_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.people(id);

ALTER TABLE ONLY public.fielding_of_split
    ADD CONSTRAINT fielding_of_split_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.people(id);

ALTER TABLE ONLY public.fielding_of_split
    ADD CONSTRAINT fielding_of_split_year_id_team_id_fkey FOREIGN KEY (team_id) REFERENCES public.teams(id);

ALTER TABLE ONLY public.fielding
    ADD CONSTRAINT fielding_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.people(id);

ALTER TABLE ONLY public.fielding_post
    ADD CONSTRAINT fielding_post_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.people(id);

ALTER TABLE ONLY public.fielding_post
    ADD CONSTRAINT fielding_post_year_id_team_id_fkey FOREIGN KEY (team_id) REFERENCES public.teams(id);

ALTER TABLE ONLY public.fielding
    ADD CONSTRAINT fielding_year_id_team_id_fkey FOREIGN KEY (team_id) REFERENCES public.teams(id);

ALTER TABLE ONLY public.hall_of_fame
    ADD CONSTRAINT hall_of_fame_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.people(id);

ALTER TABLE ONLY public.home_games
    ADD CONSTRAINT home_games_park_id_fkey FOREIGN KEY (park_id) REFERENCES public.parks(id);

ALTER TABLE ONLY public.home_games
    ADD CONSTRAINT home_games_year_id_team_id_fkey FOREIGN KEY (team_id) REFERENCES public.teams(id);

ALTER TABLE ONLY public.managers_half
    ADD CONSTRAINT managers_half_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.people(id);

ALTER TABLE ONLY public.managers_half
    ADD CONSTRAINT managers_half_year_id_team_id_fkey FOREIGN KEY (team_id) REFERENCES public.teams(id);

ALTER TABLE ONLY public.managers
    ADD CONSTRAINT managers_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.people(id);

ALTER TABLE ONLY public.managers
    ADD CONSTRAINT managers_year_id_team_id_fkey FOREIGN KEY (team_id) REFERENCES public.teams(id);

ALTER TABLE ONLY public.pitching
    ADD CONSTRAINT pitching_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.people(id);

ALTER TABLE ONLY public.pitching_post
    ADD CONSTRAINT pitching_post_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.people(id);

ALTER TABLE ONLY public.pitching_post
    ADD CONSTRAINT pitching_post_year_id_team_id_fkey FOREIGN KEY (team_id) REFERENCES public.teams(id);

ALTER TABLE ONLY public.pitching
    ADD CONSTRAINT pitching_year_id_team_id_fkey FOREIGN KEY (team_id) REFERENCES public.teams(id);

ALTER TABLE ONLY public.salaries
    ADD CONSTRAINT salaries_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.people(id);

ALTER TABLE ONLY public.salaries
    ADD CONSTRAINT salaries_year_id_team_id_fkey FOREIGN KEY (team_id) REFERENCES public.teams(id);

ALTER TABLE ONLY public.series_post
    ADD CONSTRAINT series_post_year_id_team_id_loser_fkey FOREIGN KEY (team_id_loser) REFERENCES public.teams(id);

ALTER TABLE ONLY public.series_post
    ADD CONSTRAINT series_post_year_id_team_id_winner_fkey FOREIGN KEY (team_id_winner) REFERENCES public.teams(id);

ALTER TABLE ONLY public.teams
    ADD CONSTRAINT teams_franch_id_fkey FOREIGN KEY (franch_id) REFERENCES public.teams_franchises(id);

ALTER TABLE ONLY public.teams_half
    ADD CONSTRAINT teams_half_year_id_team_id_fkey FOREIGN KEY (team_id) REFERENCES public.teams(id);
