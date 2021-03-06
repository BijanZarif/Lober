# _* sh *_

FILENAME_A="separ."
FILENAME_B=""
FILENAME_I=0
FILENAME_F=5

OPT="-DENS 2 10"
RSLTF="lobes.out"

I=$FILENAME_I

STOP="no"
if [ -f $RSLTF ]; then
    rm -rf $RSLTF
fi
touch lobes.out

while [ "$STOP" = "no" ]; do  
    STOP2="no"
    J=`expr $I + 1`
    while [ "$STOP2" = "no" ]; do
	###############################
	# RUN LOBER $I, $J ############
	###############################
	F1=$FILENAME_A$I$FILENAME_B
	F2=$FILENAME_A$J$FILENAME_B
	CMD="lober -light "$F1" "$F2" lobe.out "$OPT
	echo $CMD
	$CMD
	mv $RSLTF lobes.tmp
	( cat lobes.tmp ; echo -n $I"   "$J ; cat lobe.out ) > $RSLTF
	rm lobes.tmp
	###############################
	J=`expr $J + 1`
	if [ $J -gt $FILENAME_F ]; then
	    STOP2="yes"
	fi
    done

    I=`expr $I + 1`
    if [ $I -ge $FILENAME_F ]; then
	STOP="yes"
    fi
done
