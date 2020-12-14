#!/bin/bash
lualatex Schichtplan_E_2021.tex
lualatex Kalender2021.tex
which gsed && mysed=gsed || mysed=sed
$mysed -i 's/$/\r/' Schichtplan_E_2021.ics
rm {Schichtplan_E_,Kalender}2021.{aux,log}
