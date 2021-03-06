-- Modify it to show the matchid and player name for all goals scored by Germany. 
--To identify German players, check for: teamid = 'GER'

SELECT matchid, player FROM goal 
WHERE teamid = 'GER';

-- Show id, stadium, team1, team2 for just game 1012

SELECT id,stadium,team1,team2
FROM game
WHERE id = 1012;

-- Modify it to show the player, teamid, stadium and mdate for every German goal.

SELECT player, teamid, stadium, mdate
FROM game JOIN goal ON (id = matchid)
WHERE teamid = 'GER';

-- Show the team1, team2 and player for every goal scored by a player called Mario player LIKE 'Mario%'

SELECT team1, team2, player
FROM game JOIN goal ON (id = matchid)
WHERE player LIKE 'Mario%';

-- Show player, teamid, coach, gtime for all goals scored in the first 10 minutes gtime<=10

SELECT player, teamid, coach, gtime
FROM goal JOIN eteam on teamid = id
WHERE gtime<=10;

-- List the dates of the matches and the name of the team in which 'Fernando Santos' was the team1 coach.

SELECT mdate, teamname
FROM game JOIN eteam ON team1 = eteam.id
WHERE coach = 'Fernando Santos';

-- List the player for every goal scored in a game where the stadium was 'National Stadium, Warsaw'

SELECT player
FROM game JOIN goal ON game.id = goal.matchid
WHERE game.stadium = 'National Stadium, Warsaw';

-- show the name of all players who scored a goal against Germany.
-- HINT
-- Select goals scored only by non-German players in matches 
-- where GER was the id of either team1 or team2.
-- You can use teamid!='GER' to prevent listing German players.
-- You can use DISTINCT to stop players being listed twice.]

SELECT DISTINCT player
FROM game JOIN goal on game.id = goal.matchid
WHERE 'GER' IN (game.team1, game.team2) 
AND goal.teamid != 'GER';

-- Show teamname and the total number of goals scored.
-- COUNT and GROUP BY
-- You should COUNT(*) in the SELECT line and GROUP BY teamname

SELECT eteam.teamname, COUNT(*) AS goals
FROM eteam JOIN goal ON eteam.id = goal.teamid
GROUP BY teamname;

-- Show the stadium and the number of goals scored in each stadium.

SELECT game.stadium, COUNT(*) AS goals
FROM game JOIN goal ON game.id = goal.matchid
GROUP BY stadium;

-- For every match involving 'POL', 
-- show the matchid, date and the number of goals scored.

SELECT goal.matchid, game.mdate, COUNT(goal.teamid)
FROM game JOIN goal on game.id = goal.matchid
WHERE 'POL' in (game.team1, game.team2)
GROUP BY matchid, mdate;

-- For every match where 'GER' scored, 
-- show matchid, match date and the number of goals scored by 'GER'

SELECT goal.matchid, game.mdate, COUNT(goal.teamid)
FROM game JOIN goal on game.id = goal.matchid
WHERE goal.teamid = 'GER'
GROUP BY matchid, mdate;

-- List every match with the goals scored by each team as shown. 
-- This will use "CASE WHEN" which has not been explained in any previous exercises.

SELECT game.mdate,
       game.team1,
       SUM(CASE WHEN goal.teamid = game.team1 THEN 1 ELSE 0 END) AS score1,
       game.team2,
       SUM(CASE WHEN goal.teamid = game.team2 THEN 1 ELSE 0 END) AS score2

FROM game LEFT OUTER JOIN goal on game.id = goal.matchid
GROUP BY game.mdate, goal.matchid, game.team1, game.team2;
