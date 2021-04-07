#!/bin/bash

reponse="a"
until [ "${reponse:0:1}" = "n" ] || [ "${reponse:0:1}" = "o" ]
do
	read -p "Etes-vous satisfait? (o/n) " reponse
done
