#!/bin/bash

# Connect to database
PSQL="psql --username=freecodecamp --dbname=salon --no-align --tuples-only -c"
echo -e "\n~~~ SALON ~~~\n"

# Menu to select services
MAIN_MENU() {
  if [[ $1 ]]
  then
    echo -e "\n$1"
  fi

  echo "Welcome to the Salon!"
  SERVICES=$($PSQL "SELECT service_id, name FROM services;")

  # Lists each service in the format 1) service_name
  echo "$SERVICES" | while IFS="|" read SERVICE_ID NAME
  do
    echo "$SERVICE_ID) $NAME"
  done

  # Gets user selected id
  echo -e "\nEnter the number of the service you want"
  read SERVICE_ID_SELECTED

  # Check if service exists
  SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id = $SERVICE_ID_SELECTED;")
  if [[ -z $SERVICE_NAME ]]
  then
    # Sends back to main menu if doesn't exist
    MAIN_MENU "This service does not exist. Please pick a valid service."
  else
    # Get customer phone
    echo -e "\nWhat is your phone number?"
    read CUSTOMER_PHONE

    CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE';")

    if [[ -z $CUSTOMER_NAME ]]
    then
      echo -e "\nI don't have a record for that number, what is your name?"
      read CUSTOMER_NAME

      # If phone doesn't exist put name into customer table
      INSERT_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers(phone,name) VALUES('$CUSTOMER_PHONE', '$CUSTOMER_NAME');")
    fi

    # Get customer_id
    CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE';")

    # Get the service time
    echo -e "\nWhat time would you like your $SERVICE_NAME, $CUSTOMER_NAME? (ex. 10:30)"
    read SERVICE_TIME

    # Inserts appointment row
    INSERT_APPOINTMENT_RESULT=$($PSQL "INSERT INTO appointments(time, customer_id, service_id) VALUES('$SERVICE_TIME', '$CUSTOMER_ID', '$SERVICE_ID_SELECTED');")

    # Final message
    SERVICE_NAME_FORMATTED=$(echo $SERVICE_NAME | sed 's/ //g')
    CUSTOMER_NAME_FORMATTED=$(echo $CUSTOMER_NAME | sed 's/ //g')

    echo -e "\nI have put you down for a $SERVICE_NAME_FORMATTED at $SERVICE_TIME, $CUSTOMER_NAME_FORMATTED."
  fi
}

MAIN_MENU