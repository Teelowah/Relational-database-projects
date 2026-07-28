#!/bin/bash

# Connect to database
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

# Check if an argument is provided
if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
  exit
fi

# Determine if the argument is a number or a string (symbol/name)
if [[ $1 =~ ^[0-9]+$ ]]
then
  CONDITION="atomic_number = $1"
else
  CONDITION="symbol = '$1' OR name = '$1'"
fi

# Query the database for the element data
ELEMENT_INFO=$($PSQL "SELECT atomic_number, name, symbol, types.type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements JOIN properties USING(atomic_number) JOIN types USING(type_id) WHERE $CONDITION;")

# Check if the element exists in the database
if [[ -z $ELEMENT_INFO ]]
then
  echo "I could not find that element in the database."
else
  # Read the pipeline output into variables
  echo "$ELEMENT_INFO" | while IFS="|" read ATOMIC_NUMBER NAME SYMBOL TYPE MASS MELTING BOILING
  do
    echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
  done
fi