export R_LIBS=/home/kondziu/R_LIBS/
for i in *
do 
    ~/R-dyntrace/bin/R CMD INSTALL --with-keep.source --preclean --clean --byte-compile CRAN/contrib/$i
done
