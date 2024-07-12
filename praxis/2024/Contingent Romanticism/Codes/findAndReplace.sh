#!/bin/bash

inputFile=$1
outputFile=$2

sed  's/n=\"[0-9][0-9][0-9]\"//g'  $inputFile>tmp1.xml

sed  's/n=\"[0-9][0-9]\"//g'  tmp1.xml>tmp2.xml

sed  's/n=\"[0-9]\"//g'  tmp2.xml>$outputFile

rm tmp1.xml
rm tmp2.xml


