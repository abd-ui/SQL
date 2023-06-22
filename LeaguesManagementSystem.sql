

-- DROP TABLE Matchday
-- DROP TABLE MatchDetails
-- DROP TABLE Stadium
-- DROP TABLE Referee
-- DROP TABLE Manager
-- DROP TABLE Player
-- DROP TABLE standing
-- DROP TABLE Club
-- DROP TABLE League


-- Create League table
CREATE TABLE League (
    LeagueID VARCHAR(50),
    LeagueName VARCHAR(255),
    CONSTRAINT league_id_pk PRIMARY KEY (LeagueID)
);
-- Create Club table
CREATE TABLE Club (
    ClubID VARCHAR(50),
    ClubName VARCHAR(255),
    ClubLocation VARCHAR(255),
    ClubValue DECIMAL(10, 2),
    LeagueID VARCHAR(50)

    CONSTRAINT club_id_pk PRIMARY KEY (ClubID),
    CONSTRAINT club_name_unique UNIQUE (ClubName),
    CONSTRAINT club_location_not_null CHECK (ClubLocation IS NOT NULL),
    CONSTRAINT club_value_positive CHECK (ClubValue >= 0),
    CONSTRAINT club_league_fk FOREIGN KEY (LeagueID) REFERENCES League(LeagueID)

);
-- Create Player table
CREATE TABLE Player (
  PlayerID VARCHAR(50),
  PlayerName VARCHAR(255),
  PlayerAge INT,
  Nationality VARCHAR(255),
  ClubID VARCHAR(50),
  PlayerSalary DECIMAL(10, 2),
  GoalsScored INT,
  PlayerPosition VARCHAR(50),

  CONSTRAINT player_id_pk PRIMARY KEY (PlayerID),
  CONSTRAINT player_age_positive CHECK (PlayerAge > 0),
  CONSTRAINT player_nationality_not_null CHECK (Nationality IS NOT NULL),
  CONSTRAINT player_club_fk FOREIGN KEY (ClubID) REFERENCES Club(ClubID),
  CONSTRAINT player_salary_positive CHECK (PlayerSalary >= 0),
  CONSTRAINT player_goals_positive CHECK (GoalsScored >= 0),
  CONSTRAINT player_position_nn CHECK (PlayerPosition IS NOT NULL)
);


-- Create Referee table
CREATE TABLE Referee (
  RefereeID VARCHAR(50),
  RefereeName VARCHAR(255),
  Nationality VARCHAR(255),
  RefereeSalary DECIMAL(10, 2),

  CONSTRAINT referee_id_pk PRIMARY KEY (RefereeID),
  CONSTRAINT referee_name_unique UNIQUE (RefereeName),
  CONSTRAINT referee_nationality_not_null CHECK (Nationality IS NOT NULL),
  CONSTRAINT referee_salary_positive CHECK (RefereeSalary >= 0)
);

-- Create Stadium table
CREATE TABLE Stadium (
  StadiumID VARCHAR(50),
  StadiumName VARCHAR(255),
  StadiumLocation VARCHAR(255),
  Capacity INT,
  ClubID VARCHAR(50),

  CONSTRAINT stadium_id_pk PRIMARY KEY (StadiumID),
  CONSTRAINT stadium_name_unique UNIQUE (StadiumName),
  CONSTRAINT stadium_location_not_null CHECK (StadiumLocation IS NOT NULL),
  CONSTRAINT stadium_capacity_positive CHECK (Capacity > 0),
  CONSTRAINT stadium_club_fk FOREIGN KEY (ClubID) REFERENCES Club(ClubID)
);

-- Create Match table
CREATE TABLE MatchDetails (
  MatchDetailsID VARCHAR(50),
  MatchDate DATE,
  HomeClubScore INT,
  AwayClubScore INT,
  Attendance INT,
  HomeClubID VARCHAR(50),
  AwayClubID VARCHAR(50),
  RefereeID VARCHAR(50),
  StadiumID VARCHAR(50),

  CONSTRAINT match_id_pk PRIMARY KEY (MatchDetailsID),
  CONSTRAINT match_date_not_null CHECK (MatchDate IS NOT NULL),
  CONSTRAINT match_scores_positve CHECK (HomeClubScore >= 0 AND AwayClubScore >= 0),
  CONSTRAINT match_attendance_positve CHECK (Attendance >= 0),
  CONSTRAINT match_club_fk FOREIGN KEY (HomeClubID) REFERENCES Club(ClubID),
  CONSTRAINT match_away_club_fk FOREIGN KEY (AwayClubID) REFERENCES Club(ClubID),
  CONSTRAINT match_referee_fk FOREIGN KEY (RefereeID) REFERENCES Referee(RefereeID),
  CONSTRAINT match_stadium_fk FOREIGN KEY (StadiumID) REFERENCES Stadium(StadiumID)
);

-- Create MatchDay table
CREATE TABLE MatchDay(
  MatchDayID AS HomeClubID + '_' + AwayClubID,
  MatchDetailsID VARCHAR(50),
  HomeClubID VARCHAR(50) NOT NULL,
  AwayClubID VARCHAR(50) NOT NULL,

  CONSTRAINT matchday_id_pk PRIMARY KEY (MatchDayID),
  CONSTRAINT matchday_homeclub_fk FOREIGN KEY (HomeClubID) REFERENCES Club(ClubID),
  CONSTRAINT matchday_awayclub_fk FOREIGN KEY (AwayClubID) REFERENCES Club(ClubID),
  CONSTRAINT matchday_details_fk FOREIGN KEY (MatchDetailsID) REFERENCES MatchDetails(MatchDetailsID)
);



-- Create Manager table
CREATE TABLE Manager (
  ManagerID VARCHAR(50),
  ManagerName VARCHAR(255),
  Nationality VARCHAR(255),
  ClubID VARCHAR(50),

  CONSTRAINT manager_id_pk PRIMARY KEY (ManagerID),
  CONSTRAINT manager_club_fk FOREIGN KEY (ClubID) REFERENCES Club(ClubID)
);

-- Table for  standings
CREATE TABLE Standing (
  StandingID VARCHAR(50),
  ClubID VARCHAR(50),
  matches_played INT,
  wins INT,
  draws INT,
  losses INT,
  goals_for INT,
  goals_against INT,
  points INT,

  CONSTRAINT standing_id_pk PRIMARY KEY (StandingID),
  CONSTRAINT standing_club_fk FOREIGN KEY (ClubID) REFERENCES Club(ClubID)
);


-------------------------------------------------------------------------------------------
-- Insert data into League table
INSERT INTO League (LeagueID, LeagueName)
VALUES ('EPL', 'English Premier League'),
       ('LaLiga', 'Spanish La Liga'),
       ('SerieA', 'Italian Serie A'),
       ('Bundes', 'German Bundesliga'),
       ('Ligue1', 'French Ligue 1');

-- Insert data into Club table
INSERT INTO Club (ClubID, ClubName, ClubLocation, ClubValue, LeagueID)
VALUES ('MNU', 'Manchester United', 'Manchester', 750, 'EPL'),
       ('LIV', 'Liverpool', 'Liverpool', 600, 'EPL'),
       ('MCI', 'Manchester City', 'Manchester', 900, 'EPL'),
       ('CHE', 'Chelsea', 'London', 800, 'EPL'),
       ('ARS', 'Arsenal', 'London', 650, 'EPL'),
       ('RM', 'Real Madrid', 'Madrid', 1000, 'LaLiga'),
       ('BAR', 'Barcelona', 'Barcelona', 950, 'LaLiga'),
       ('ATM', 'Atletico Madrid', 'Madrid', 700, 'LaLiga'),
       ('JUV', 'Juventus', 'Turin', 850, 'SerieA'),
       ('INT', 'Inter Milan', 'Milan', 750, 'SerieA'),
       ('BAY', 'Bayern Munich', 'Munich', 950, 'Bundes'),
       ('BVB', 'Borussia Dortmund', 'Dortmund', 600, 'Bundes'),
       ('PSG', 'Paris Saint-Germain', 'Paris', 1100, 'Ligue1'),
       ('LYO', 'Olympique Lyon', 'Lyon', 500, 'Ligue1'),
       ('MAR', 'Marseille', 'Marseille', 550, 'Ligue1'),
       ('MON', 'AS Monaco', 'Monaco', 700, 'Ligue1');

-- Insert data into Player table
INSERT INTO Player (PlayerID, PlayerName, PlayerAge, Nationality, ClubID, PlayerSalary, GoalsScored, PlayerPosition)
VALUES
  ('PL1', 'Lionel Messi', 34, 'Argentina', 'BAR', 60.0, 30, 'Forward'),
  ('PL2', 'Cristiano Ronaldo', 36, 'Portugal', 'JUV', 50.0, 25, 'Forward'),
  ('PL3', 'Neymar Jr.', 29, 'Brazil', 'PSG', 36.0, 20, 'Forward'),
  ('PL4', 'Robert Lewandowski', 33, 'Poland', 'BAY', 25.0, 35, 'Forward'),
  ('PL5', 'Kevin De Bruyne', 30, 'Belgium', 'MCI', 30.0, 15, 'Midfielder'),
  ('PL6', 'Virgil van Dijk', 30, 'Netherlands', 'LIV', 20.0, 5, 'Defender'),
  ('PL7', 'Kylian Mbappe', 23, 'France', 'PSG', 25.0, 22, 'Forward'),
  ('PL8', 'Sergio Ramos', 35, 'Spain', 'PSG', 18.0, 10, 'Defender'),
  ('PL9', 'Luis Suarez', 34, 'Uruguay', 'ATM', 15.0, 28, 'Forward'),
  ('PL11', 'Sadio Mane', 29, 'Senegal', 'LIV', 18.0, 12, 'Forward'),
  ('PL12', 'Mohamed Salah', 29, 'Egypt', 'LIV', 20.0, 25, 'Forward'),
  ('PL13', 'Eden Hazard', 31, 'Belgium', 'RM', 22.0, 10, 'Midfielder'),
  ('PL14', 'Antoine Griezmann', 30, 'France', 'BAR', 20.0, 15, 'Forward'),
  ('PL16', 'Romelu Lukaku', 28, 'Belgium', 'INT', 22.0, 30, 'Forward'),
  ('PL17', 'Paul Pogba', 28, 'France', 'MNU', 18.0, 6, 'Midfielder'),
  ('PL18', 'Toni Kroos', 32, 'Germany', 'RM', 20.0, 5, 'Midfielder'),
  ('PL19', 'Joshua Kimmich', 26, 'Germany', 'BAY', 18.0, 8, 'Midfielder'),
  ('PL20', 'Raheem Sterling', 27, 'England', 'MCI', 18.0, 15, 'Forward'),
  ('PL21', 'NGolo Kante', 30, 'France', 'CHE', 20.0, 2, 'Midfielder'),
  ('PL22', 'Karim Benzema', 34, 'France', 'RM', 18.0, 23, 'Forward'),
  ('PL23', 'Thomas Muller', 32, 'Germany', 'BAY', 16.0, 10, 'Forward'),
  ('PL24', 'Luka Modric', 36, 'Croatia', 'RM', 15.0, 7, 'Midfielder'),
  ('PL25', 'Jan Oblak', 29, 'Slovenia', 'ATM', 12.0, 0, 'Goalkeeper'),
  ('PL26', 'Marc-Andre ter Stegen', 29, 'Germany', 'BAR', 16.0, 0, 'Goalkeeper'),
  ('PL27', 'Alisson Becker', 29, 'Brazil', 'LIV', 18.0, 0, 'Goalkeeper'),
  ('PL28', 'Ederson', 28, 'Brazil', 'MCI', 16.0, 0, 'Goalkeeper'),
  ('PL29', 'Sergio Aguero', 33, 'Argentina', 'BAR', 15.0, 15, 'Forward'),
  ('PL30', 'Erling Haaland', 21, 'Norway', 'BVB', 30.0, 40, 'Forward'),
  ('PL31', 'Bruno Fernandes', 27, 'Portugal', 'MNU', 25.0, 18, 'Midfielder'),
  ('PL33', 'Joshua Kimmich', 26, 'Germany', 'BAY', 22.0, 8, 'Midfielder'),
  ('PL34', 'Trent Alexander-Arnold', 22, 'England', 'LIV', 18.0, 5, 'Defender'),
  ('PL35', 'Andrew Robertson', 27, 'Scotland', 'LIV', 16.0, 2, 'Defender'),
  ('PL36', 'Aymeric Laporte', 27, 'France', 'MCI', 20.0, 4, 'Defender'),
  ('PL38', 'Sergio Busquets', 33, 'Spain', 'BAR', 15.0, 2, 'Midfielder'),
  ('PL39', 'Marquinhos', 27, 'Brazil', 'PSG', 16.0, 5, 'Defender'),
  ('PL40', 'Giorgio Chiellini', 37, 'Italy', 'JUV', 12.0, 2, 'Defender'),
  ('PL41', 'Jadon Sancho', 21, 'England', 'MNU', 25.0, 10, 'Forward'),
  ('PL42', 'Hakim Ziyech', 28, 'Morocco', 'CHE', 18.0, 6, 'Midfielder'),
  ('PL43', 'Pedri', 19, 'Spain', 'BAR', 15.0, 3, 'Midfielder'),
  ('PL44', 'Frenkie de Jong', 24, 'Netherlands', 'BAR', 20.0, 5, 'Midfielder'),
  ('PL45', 'Kai Havertz', 22, 'Germany', 'CHE', 25.0, 12, 'Midfielder'),
  ('PL46', 'Vinicius Junior', 21, 'Brazil', 'RM', 18.0, 10, 'Forward'),
  ('PL47', 'Ansu Fati', 18, 'Spain', 'BAR', 15.0, 8, 'Forward'),
  ('PL48', 'Phil Foden', 21, 'England', 'MCI', 20.0, 6, 'Midfielder'),
  ('PL49', 'Joao Felix', 21, 'Portugal', 'ATM', 22.0, 10, 'Forward'),
  ('PL50', 'Mason Mount', 22, 'England', 'CHE', 18.0, 10, 'Midfielder');

-- Insert data into Referee table
INSERT INTO Referee (RefereeID, RefereeName, Nationality, RefereeSalary)
VALUES
  ('R1', 'Michael Oliver', 'England', 50000.00),
  ('R2', 'Anthony Taylor', 'England', 45000.00),
  ('R3', 'Martin Atkinson', 'England', 48000.00),
  ('R4', 'Andre Marriner', 'England', 47000.00),
  ('R5', 'Mike Dean', 'England', 49000.00);

-- Insert data into Stadium table
INSERT INTO Stadium (StadiumID, StadiumName, StadiumLocation, Capacity, ClubID)
VALUES
  ('S1', 'Old Trafford', 'Manchester', 74609, 'MNU'),
  ('S2', 'Etihad Stadium', 'Manchester', 55017, 'MCI'),
  ('S3', 'Anfield', 'Liverpool', 53394, 'LIV'),
  ('S4', 'Emirates Stadium', 'London', 60432, 'ARS'),
  ('S5', 'Stamford Bridge', 'London', 40834, 'CHE');

  -- Insert data into Manager table
INSERT INTO Manager (ManagerID, ManagerName, Nationality, ClubID)
VALUES
  ('M1', 'Ole Gunnar Solskjaer', 'Norway', 'MNU'),
  ('M2', 'Pep Guardiola', 'Spain', 'MCI'),
  ('M3', 'Jurgen Klopp', 'Germany', 'LIV'),
  ('M4', 'Mikel Arteta', 'Spain', 'ARS'),
  ('M5', 'Thomas Tuchel', 'Germany', 'CHE'),
  ('M6', 'Mikel Arteta', 'Spain', 'ARS');

-- Insert data into MatchDetails table
INSERT INTO MatchDetails (MatchDetailsID, MatchDate, HomeClubScore, AwayClubScore, Attendance, HomeClubID, AwayClubID, RefereeID, StadiumID)
VALUES
  ('MD1', '2023-01-01', 2, 1, 50000, 'MNU', 'MCI', 'R1', 'S1'),
  ('MD2', '2023-01-02', 1, 1, 40000, 'LIV', 'ARS', 'R2', 'S3'),
  ('MD3', '2023-01-03', 3, 0, 55000, 'CHE', 'ARS', 'R3', 'S5'),
  ('MD4', '2023-01-06', 2, 1, 40000, 'MCI', 'LIV', 'R1', 'S2'),
  ('MD5', '2023-01-07', 0, 0, 45000, 'ARS', 'CHE', 'R2', 'S4'),
  ('MD6', '2023-01-08', 1, 1, 50000, 'MCI', 'MNU', 'R3', 'S2');

-- Insert data into MatchDay table
INSERT INTO MatchDay (MatchDetailsID, HomeClubID, AwayClubID)
VALUES
  ('MD1', 'MNU', 'MCI'),
  ('MD2', 'LIV', 'ARS'),
  ('MD3', 'CHE', 'ARS'),
  ('MD4', 'MCI', 'LIV'),
  ('MD5', 'ARS', 'CHE'),
  ('MD6', 'MCI', 'MNU');

-- Insert data into Standing table
INSERT INTO Standing (StandingID, ClubID, matches_played, wins, draws, losses, goals_for, goals_against, points)
VALUES
  ('S1', 'MNU', 20, 14, 4, 2, 45, 20, 46),
  ('S2', 'MCI', 20, 13, 5, 2, 40, 18, 44),
  ('S3', 'LIV', 20, 12, 6, 2, 38, 15, 42),
  ('S4', 'ARS', 20, 10, 4, 6, 30, 25, 34),
  ('S5', 'CHE', 20, 9, 6, 5, 33, 22, 33);


---------------------------------------------------------------------------------------

-- Get the team with the most wins

SELECT ClubID, wins 
FROM Standing
WHERE (wins = (SELECT max(wins) FROM Standing));

SELECT TOP 1 ClubID, wins
FROM Standing
ORDER BY wins DESC;

-- Get the stadium name from match details

SELECT m.MatchDetailsID, s.StadiumName  
FROM Stadium s, MatchDetails m
WHERE (m.StadiumID = s.StadiumID);

-- Get the average salary for barcelona players
SELECT c.ClubName, AVG(PlayerSalary) AS 'AverageSalary (M)'
FROM Player p
JOIN Club c ON p.ClubID = c.ClubID
GROUP BY c.ClubName;


-- Get the total goals scored for each club

SELECT c.ClubName, SUM(p.GoalsScored) AS TotalGoalsScored
FROM Player p
JOIN Club c ON p.ClubID = c.ClubID
GROUP BY c.ClubName;

-- Get top 5 most valuable clubs

SELECT TOP 5 ClubName, ClubValue
FROM Club
ORDER BY ClubValue DESC;

-- Get the club and their stadiums

SELECT c.ClubName, s.StadiumName
FROM Club c
JOIN Stadium s ON c.ClubID = s.ClubID;

-- Get the match with the highset attendence

SELECT MatchDetailsID, Attendance
FROM MatchDetails
WHERE Attendance = (SELECT MAX(Attendance) FROM MatchDetails);

-- Get league table

SELECT c.ClubName, s.matches_played, s.wins, s.draws, s.losses, s.goals_for, s.goals_against, s.points
FROM Club c
JOIN Standing s ON c.ClubID = s.ClubID
ORDER BY s.points DESC;

-- Get the referee and the number of matchs they refereed

SELECT r.RefereeName, COUNT(md.MatchDetailsID) AS MatchesOfficiated
FROM Referee r
JOIN MatchDetails md ON r.RefereeID = md.RefereeID
GROUP BY r.RefereeName;

-- Get the players nationality for a specific club

SELECT p.PlayerName, p.Nationality
FROM Player p
JOIN Club c ON p.ClubID = c.ClubID
WHERE c.ClubName = 'Real Madrid';


-- Change a player salary
UPDATE Player
SET PlayerSalary = 120
WHERE PlayerID = 'PL1';

SELECT PLayerName, PlayerSalary 
FROM Player
WHERE PlayerID = 'PL1';

-- Increase one year to all players

UPDATE Player
SET PlayerAge = PlayerAge + 1;

SELECT PLayerName, PlayerAge 
FROM Player;

-- Get players from the same nation

SELECT PlayerName, Nationality
FROM Player
WHERE Nationality = 'Brazil';
