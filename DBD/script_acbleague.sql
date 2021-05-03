GO
SET ANSI_NULLS ON
GO

select * from master.[dbo].[game];

CREATE FUNCTION DISPLAYGAMES
    (
    )
    RETURNS TABLE
        AS RETURN
            (
                SELECT master.[dbo].game.id,
                       master.[dbo].game.competition_phase,
                       master.[dbo].game.journey,
                       iif(month(master.[dbo].game.kickoff_time) < 7,
                           year(master.[dbo].game.kickoff_time) - 1,
                           year(master.[dbo].game.kickoff_time)) as season,
                       h.name                       as home_team_name,
                       master.[dbo].game.score_home,
                       a.name                       as away_team_name,
                       master.[dbo].game.score_away
                FROM master.[dbo].game
                         join master.dbo.teamName h on master.[dbo].game.team_home_id = h.id
                         join master.dbo.teamName a on master.[dbo].game.team_away_id = a.id
            );

CREATE FUNCTION DISPLAYGAMES2
    (
        @journey int,
        @season int
    )
    RETURNS TABLE
        AS RETURN
            (
                SELECT master.[dbo].game.id,
                       master.[dbo].game.competition_phase,
--                        master.[dbo].game.journey,
--                        iif(month(master.[dbo].game.kickoff_time) < 7,
--                            year(master.[dbo].game.kickoff_time) - 1,
--                            year(master.[dbo].game.kickoff_time)) as season,
                       h.name as home_team_name,
                       master.[dbo].game.score_home,
                       a.name as away_team_name,
                       master.[dbo].game.score_away
                FROM master.[dbo].game
                         join master.dbo.teamName h on master.[dbo].game.team_home_id = h.id
                         join master.dbo.teamName a on master.[dbo].game.team_away_id = a.id
                where @journey = master.[dbo].game.journey and @season = master.[dbo].game.season
            );


select * from DISPLAYGAMES()

select * from DISPLAYGAMES2(1, 2016)

CREATE FUNCTION DISPLAYGAMES3
    (
    )
    RETURNS TABLE
        AS RETURN
            (
                SELECT master.[dbo].game.id,
                       master.[dbo].game.competition_phase,
                       master.[dbo].game.journey,
                       master.[dbo].game.season,
                       h.name                       as home_team_name,
                       master.[dbo].game.score_home,
                       a.name                       as away_team_name,
                       master.[dbo].game.score_away
                FROM master.[dbo].game
                         join master.dbo.teamName h on master.[dbo].game.team_home_id = h.id
                         join master.dbo.teamName a on master.[dbo].game.team_away_id = a.id
            );

select * from DISPLAYGAMES3()
