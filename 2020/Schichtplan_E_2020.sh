#!/bin/bash
lualatex Schichtplan_E_2020.tex
gsed -i 's/$/\r/' Schichtplan_E_2020.ics
rm Schichtplan_E_2020.{aux,log}
