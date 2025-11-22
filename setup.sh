#!/bin/bash

echo "--starting setup ---"

PROJECT_NAME="devops_day_1"

if ! command -v node &> /dev/null; then

    echo "Node is not installed! please install it manually."
    exit 1
else 
    echo "Node is installed. Proceeding...."

fi

echo "Creating project: $PROJECT_NAME"
 mkdir $PROJECT_NAME

 cd $PROJECT_NAME
 mkdir frontend
 mkdir backend

 echo "---Setup complete ---"