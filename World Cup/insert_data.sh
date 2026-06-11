#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
CLEAR_RESULT=$($PSQL "TRUNCATE TABLE teams, games;")

FILE="games.csv"

# Read in the file line by line (gets values split by commas)
while IFS="," read -r YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS

# Loop for each row in file
do
  # Skips header row
  if [[ $YEAR != "year" ]]
  then
    # 1. Insert Winner (or fetch ID if it exists) in ONE query
  WINNER_ID=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER') ON CONFLICT (name) DO UPDATE SET name=EXCLUDED.name RETURNING team_id;")
  # Checks in case of no result
  if [[ -z $WINNER_ID ]]
  then
    WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER';")
  fi

  # 2. Insert Opponent (or fetch ID if it exists) in ONE query
  OPPONENT_ID=$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT') ON CONFLICT (name) DO UPDATE SET name=EXCLUDED.name RETURNING team_id;")
    if [[ -z $OPPONENT_ID ]]
    then 
      OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT';")
    fi

    # Add games data to games table
    INSERT_GAMES_RESULT=$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES($YEAR, '$ROUND', $WINNER_ID, $OPPONENT_ID,$WINNER_GOALS, $OPPONENT_GOALS);")
  fi
done


:' Old inefficient input method
# Get team ids
    WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER';")
    OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT';")
    
    # Check if winner team_id exists
    if [[ -z $WINNER_ID ]]
    then
        # Insert new team into teams table
        INSERT_WINNER_ID_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER');")

        # Get new team_id
        WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER';")
    fi

     # Check if opponent team_id exists
    if [[ -z $OPPONENT_ID ]]
    then
        # Insert new team into teams table
        INSERT_OPPONENT_ID_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT');")

        # Get new team_id
        OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT';")
    fi
'