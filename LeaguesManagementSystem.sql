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
    CurrentPosition INT,
    LeagueID VARCHAR(50),

    CONSTRAINT club_id_pk PRIMARY KEY (ClubID),
    CONSTRAINT club_name_unique UNIQUE (ClubName),
    CONSTRAINT club_location_not_null CHECK (ClubLocation IS NOT NULL),
    CONSTRAINT club_value_positive CHECK (ClubValue >= 0),
    CONSTRAINT current_position_positive CHECK (CurrentPosition >= 0),
    CONSTRAINT club_league_fk FOREIGN KEY (LeagueID) REFERENCES League(LeagueID),

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

  CONSTRAINT player_id_pk PRIMARY KEY (PlayerID),
  CONSTRAINT player_age_positive CHECK (PlayerAge > 0),
  CONSTRAINT player_nationality_not_null CHECK (Nationality IS NOT NULL),
  CONSTRAINT player_club_fk FOREIGN KEY (ClubID) REFERENCES Club(ClubID),
  CONSTRAINT player_salary_positive CHECK (PlayerSalary >= 0),
  CONSTRAINT player_goals_positive CHECK (GoalsScored >= 0)
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

  CONSTRAINT stadium_id_pk PRIMARY KEY (StadiumID),
  CONSTRAINT stadium_name_unique UNIQUE (StadiumName),
  CONSTRAINT stadium_location_not_null CHECK (StadiumLocation IS NOT NULL),
  CONSTRAINT stadium_capacity_positive CHECK (Capacity > 0)
);

-- Create Match table
CREATE TABLE Match (
  MatchID VARCHAR(50),
  MatchDate DATE,
  HomeClubScore INT,
  AwayClubScore INT,
  Attendance INT,
  HomeClubID VARCHAR(50),
  AwayClubID VARCHAR(50),
  RefereeID VARCHAR(50),
  StadiumID VARCHAR(50),

  CONSTRAINT match_id_pk PRIMARY KEY (MatchID),
  CONSTRAINT match_date_not_null CHECK (MatchDate IS NOT NULL),
  CONSTRAINT match_scores_positve CHECK (HomeClubScore >= 0 AND AwayClubScore >= 0),
  CONSTRAINT match_attendance_positve CHECK (Attendance >= 0),
  CONSTRAINT match_club_fk FOREIGN KEY (HomeClubID) REFERENCES Club(ClubID),
  CONSTRAINT match_away_club_fk FOREIGN KEY (AwayClubID) REFERENCES Club(ClubID),
  CONSTRAINT match_referee_fk FOREIGN KEY (RefereeID) REFERENCES Referee(RefereeID),
  CONSTRAINT match_stadium_fk FOREIGN KEY (StadiumID) REFERENCES Stadium(StadiumID)
);
-- Create Season table
CREATE TABLE Season (
  SeasonID VARCHAR(50),
  StartYear INT,
  EndYear INT,

  CONSTRAINT season_id_pk PRIMARY KEY (SeasonID),
  CONSTRAINT start_year_end_year_check CHECK (StartYear < EndYear)
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

-- Create ClubSeason table
CREATE TABLE ClubSeason (
    ClubID VARCHAR(50),
    SeasonID VARCHAR(50),
    LeagueID VARCHAR(50),
    Position INT,

    CONSTRAINT clubseason_id_pk PRIMARY KEY (ClubID, SeasonID),
    CONSTRAINT clubseason_club_fk FOREIGN KEY (ClubID) REFERENCES Club(ClubID),
    CONSTRAINT clubseason_season_fk FOREIGN KEY (SeasonID) REFERENCES Season(SeasonID),
    CONSTRAINT clubseason_league_fk FOREIGN KEY (LeagueID) REFERENCES League(LeagueID),
    CONSTRAINT position_positive CHECK (Position > 0)
);


-------------------------------------------------------------------------------------------

-- Club table
INSERT INTO Club (ClubID, ClubName, ClubLocation, ClubValue, CurrentPosition, LeagueID) VALUES
('MU1', 'Manchester United', 'Manchester, England', 1000000, 1, 'PL1'),
('AR2', 'Arsenal', 'London, England', 750000, 2, 'PL1'),
('CH3', 'Chelsea', 'London, England', 500000, 3, 'PL1'),
('PSG1', 'Paris Saint-Germain', 'Paris, France', 2000000, 1, 'L1'),
('MC2', 'Manchester City', 'Manchester, England', 1500000, 4, 'PL1'),
('RM3', 'Real Madrid', 'Madrid, Spain', 1250000, 3, 'LL1'),
('BV4', 'Bayern Munich', 'Munich, Germany', 1000000, 1, 'BL1'),
('AC5', 'AC Milan', 'Milan, Italy', 750000, 1, 'SA1');


-- Player table
INSERT INTO Player (PlayerID, PlayerName, PlayerAge, Nationality, ClubID, PlayerSalary, GoalsScored) VALUES
('CR7', 'Cristiano Ronaldo', 37, 'Portugal', 'MU1', 5000000, 20),
('LM10', 'Lionel Messi', 35, 'Argentina', 'AR2', 4000000, 30),
('NJR', 'Neymar', 30, 'Brazil', 'CH3', 3000000, 25),
('MBappe', 'Kylian Mbappe', 23, 'France', 'PSG1', 4500000, 25),
('Haaland', 'Erling Haaland', 21, 'Norway', 'MC2', 5000000, 30),
('Modric', 'Luka Modric', 37, 'Croatia', 'RM3', 3500000, 15),
('Benzema', 'Karim Benzema', 34, 'France', 'RM3', 4000000, 25),
('Salah', 'Mohamed Salah', 29, 'Egypt', 'MC2', 4000000, 20),
('Mane', 'Sadio Mane', 30, 'Senegal', 'MC2', 4000000, 20),
('KDB', 'Kevin De Bruyne', 31, 'Belgium', 'MC2', 4500000, 25);


-- Match table
INSERT INTO Match (MatchID, MatchDate, HomeClubScore, AwayClubScore, Attendance, HomeClubID, AwayClubID, RefereeID, StadiumID) VALUES
('MU1-AR2', '2023-06-15', 1, 0, 10000, 'MU1', 'AR2', 'MO1', 'OT1'),
('CH3-AR2', '2023-06-17', 2, 1, 20000, 'CH3', 'AR2', 'JM1', 'SB1');

-- Referee table
INSERT INTO Referee (RefereeID, RefereeName, Nationality, RefereeSalary) VALUES
('MD1', 'Mike Dean', 'England', 200000),
('JM1', 'Jon Moss', 'England', 150000),
('MO1', 'Micheal Oliver', 'England', 100000);

-- Stadium table
INSERT INTO Stadium (StadiumID, StadiumName, StadiumLocation, Capacity) VALUES
('OT1', 'Old Trafford', 'Manchester, England', 75000),
('ES1', 'Emirates Stadium', 'London, England', 60000),
('SB1', 'Stamford Bridge', 'London, England', 40000);

-- Season table
INSERT INTO Season (SeasonID, StartYear, EndYear) VALUES
('S1', 2022, 2023),
('S2', 2023, 2024);

-- League table
INSERT INTO League (LeagueID, LeagueName) VALUES 
('L1', 'Legue 1'),
('SA1', 'Seria A'),
('LL1', 'La Liga'),
('PL1', 'Premier League'),
('LA1', 'La Liga'),
('BL1', 'Bundesliga');

-- Manager table
INSERT INTO Manager (ManagerID, ManagerName, Nationality, ClubID) VALUES
('OGS1', 'Ole Gunnar Solskjaer', 'Norway', 'MU1'),
('MA1', 'Mike Arteta', 'Spain', 'AR2'),
('TT1', 'Thomas Tuchel', 'Germany', 'CH3');

-- ClubSeason table
INSERT INTO ClubSeason (ClubID, SeasonID, LeagueID, Position) VALUES
('MU1', 'S1', 'PL1', 1),
('AR2', 'S1', 'PL1', 2),
('CH3', 'S1', 'PL1', 3);


INSERT INTO Club (ClubID, ClubName, ClubLocation) VALUES
('MU1', 'Manchester United', 'Manchester, England')

SELECT * FROM player;
