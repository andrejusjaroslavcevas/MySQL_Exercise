# Create a database
CREATE DATABASE football_transfermarkt;

# Set a database for using    
USE football_transfermarkt;
    
# Create a table named "players"
CREATE TABLE players (
	player_id INT PRIMARY KEY AUTO_INCREMENT,
	player_name VARCHAR(100),
	player_last_name VARCHAR(100),
	player_nationality VARCHAR(100)
);

# Insert values into table "players"    
INSERT INTO players 
(player_name, player_last_name, player_nationality)
VALUES
('Kylian', 'Mbappé', 'France'),
('Philippe', 'Coutinho', 'Brazil'),
('João', 'Félix', 'Portugal'),
('Jack', 'Grealish', 'England'),
('Cristiano', 'Ronaldo', 'Portugal'),
('Jadon', 'Sancho', 'England'),
('James', 'Rodríguez', 'Columbia'),
('Zlatan', 'Ibrahimović', 'Sweden'),
('Ousmane', 'Dembélé', 'France'),
('Álvaro', 'Morata', 'Spain');
    
# Create a table named "players_facts"   
CREATE TABLE players_facts(
	player_id INT PRIMARY KEY AUTO_INCREMENT,
	player_age INT,
	position VARCHAR(100),
	season VARCHAR(100),
	player_market_value_at_time INT,
	transfer_fee INT,
	FOREIGN KEY(player_id) REFERENCES players(player_id) ON UPDATE CASCADE ON DELETE CASCADE
);
    
# Insert values into table "players_facts"    
INSERT INTO players_facts
(player_age, position, season, player_market_value_at_time, transfer_fee)
VALUES 
(25, 'Centre-Forward', '2018-2019', 120.00, 180.00),
(25, 'Left Winger', '2017-2018', 90.00, 135.00),
(19, 'Second Striker', '2019-2020', 70.00, 127.20),
(25, 'Left Winger', '2021-2022', 65.00, 117.50),
(24, 'Centre-Forward', '2009-2010', 60.00, 94.00),
(21, 'Left Winger', '2021-2022', 100.00, 85.00),
(23, 'Attacking Midfield', '2014-2015', 60.00, 75.00),
(27, 'Centre-Forward', '2009-2010', 45.00, 65.50),
(20, 'Right Winger', '2017-2018', 33.00, 140.00),
(24, 'Centre-Forward', '2017-2018', 40.00, 66.00);

# Create a table named "team_information"    
CREATE TABLE team_information (
	team_id INT PRIMARY KEY AUTO_INCREMENT,
	left_team VARCHAR(100),
	left_team_competition VARCHAR(100),
	joined_team VARCHAR(100),
	joined_team_competition VARCHAR(100),
	player_id INT,
	FOREIGN KEY(player_id) REFERENCES players_facts(player_id) ON UPDATE CASCADE ON DELETE CASCADE
);
    
# Insert values into table "team_information"
INSERT INTO team_information
(left_team, left_team_competition, joined_team, joined_team_competition, player_id)
VALUES
('Monaco', 'Ligue 1', 'Paris SG', 'Ligue 1', 1),
('Liverpool', 'Premier League', 'Barcelona', 'LaLiga', 2),
('Benfca', 'Liga NOS', 'Atlético Madrid', 'LaLiga', 3),
('Aston Villa', 'Premier League', 'Man City', 'Premier League', 4),
('Manchester United', 'Premier League', 'Real Madrid', 'LaLiga', 5),
('Borussia Dortmund', 'Bundesliga', 'Manchester United', 'Premier League', 6),
('Monaco', 'Ligue 1', 'Real Madrid', 'LaLiga', 7),
('Inter', 'Seria A', 'Barcelona', 'LaLiga', 8),
('Borussia Dortmund', 'Bundesliga', 'Barcelona', 'Bundesliga', 9),
('Real Madrid', 'LaLiga', 'Chelsea', 'Premier League', 10);

# Print player name, last name, age, position, team to which player has been transferred and the season in which transfer made, order by age from younger   
SELECT p.player_id AS 'Player ID', p.player_name AS 'Name', p.player_last_name AS 'Last Name', 
pf.player_age AS 'Age', pf.position AS 'Position', ti.joined_team AS 'Team', pf.season AS 'Season'
FROM players as p
INNER JOIN players_facts as pf
ON p.player_id = pf.player_id
INNER JOIN team_information as ti
ON pf.player_id = ti.player_id
ORDER BY Age; 

SELECT player_name, player_last_name, joined_team,
CASE 
WHEN player_market_value_at_time < 50
THEN 'Cheap'
WHEN player_market_value_at_time >= 50 AND player_market_value_at_time < 100
THEN 'Avarage'
WHEN player_market_value_at_time >= 100
THEN 'Expensive'
END AS players_value
FROM players_facts AS pf
INNER JOIN players AS p
ON p.player_id = pf.player_id
INNER JOIN team_information AS ti
ON pf.player_id = ti.player_id
GROUP BY player_name
