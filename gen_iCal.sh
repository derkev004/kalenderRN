pdflatex gen_iCal.tex | \
tail -n +16 > ./Schichtplan.ics && \
head -n $(( $(wc -l ./Schichtplan.ics | awk '{print $1}') - 7 )) ./Schichtplan.ics | \
tee ./Schichtplan.ics > /dev/null && \
rm gen_iCal.{aux,log}
