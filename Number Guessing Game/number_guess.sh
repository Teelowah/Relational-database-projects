#!/bin/bash

# Initialize connection to database
PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

# Initial output message
echo -e "\n~~~ Fun Guessing Game ~~~\n"

# Randomly generates a number between 1 and 1000
SECRET_NUMBER=$((RANDOM % 1000 + 1))

# Guess counter
NUMBER_OF_GUESSES=0
GUESS=0

# Get username from user
echo -e "Enter your username: "
read USERNAME

# Get usernames from database
USERNAME_RESULT=$($PSQL "SELECT games_played, best_game FROM user_information WHERE username = '$USERNAME';")

# Check if name exists in database
if [[ -z $USERNAME_RESULT ]]
then
  # Username not used before
  echo -e "Welcome, $USERNAME! It looks like this is your first time here."

else
  # Username used before
  
  # Gets games_played and best game from SQL query
  # Username used before - split by the pipe character '|'
  IFS='|' read -r GAMES_PLAYED BEST_GAME <<< "$USERNAME_RESULT"
  
  # Trim whitespace from the database result
  GAMES_PLAYED=$(echo "$GAMES_PLAYED" | xargs)
  BEST_GAME=$(echo "$BEST_GAME" | xargs)

  # Output message
  echo -e "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
fi

# User guesses secret number message
echo -e "Guess the secret number between 1 and 1000:"

# Loop for guesses until guessed correctly
while [[ $GUESS -ne $SECRET_NUMBER ]]
do
  read GUESS

  # Check if guess is a number
  if ! [[ $GUESS =~ ^[0-9]+$ ]]
  then
    echo -e "That is not an integer, guess again:"
  else
    # Increment guess count
    ((NUMBER_OF_GUESSES++))

    # Output message if guess greater/smaller than secret number
    if [[ $GUESS -gt $SECRET_NUMBER ]]
    then
      echo -e "It's lower than that, guess again:"
    elif [[ $GUESS -lt $SECRET_NUMBER ]]
    then 
      echo -e "It's higher than that, guess again:"
    fi
  fi
done

# Secret number is guessed
echo -e "You guessed it in $NUMBER_OF_GUESSES tries. The secret number was $SECRET_NUMBER. Nice job!"

# Update database
if [[ -z $USERNAME_RESULT ]]
then
  # New user: Insert into database with 1 game played and new best game
  INSERT_USER_RESULT=$($PSQL "INSERT INTO user_information(username, games_played, best_game) VALUES('$USERNAME',1,$NUMBER_OF_GUESSES);")
else
  # Returning user: Update information
  
  # Increment games played
  NEW_GAMES_PLAYED=$(( $GAMES_PLAYED + 1 ))

  if [[ $NUMBER_OF_GUESSES -lt $BEST_GAME ]]
  then
    # Update games played and set a new best game
    UPDATE_RESULT=$($PSQL "UPDATE user_information SET games_played = $NEW_GAMES_PLAYED, best_game = $NUMBER_OF_GUESSES WHERE username = '$USERNAME'")
  else
    # Just update games played, keeping the old best game
    UPDATE_RESULT=$($PSQL "UPDATE user_information SET games_played = $NEW_GAMES_PLAYED WHERE username = '$USERNAME'")
  fi
fi
