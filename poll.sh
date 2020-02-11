#!/bin/bash

INTERVAL=${1:-1}
COUNTER=0

MIN=1000000000
MAX=0
AVG=0
CURTIME=0
CURSEQ=0
OLDTIME=0
OLDSEQ=0
DIFFTIME=0
OLDDIFFTIME=0

printf "%10s%10s%10s%10s%10s\n" COUNTER MIN MAX AVG DIFFTIME
rm output/out.csv
while true; do
	# MILLI rippled --silent --conf conf/rippled.cfg server_info | python3 -c "import sys, json, datetime; data=json.load(sys.stdin); print(datetime.datetime.strptime(data['result']['info']['time'], '%Y-%b-%d %H:%M:%S.%f'),',',data['result']['info']['validated_ledger']['seq'])" >> out.csv
	VALUES=$(rippled --silent --conf conf/rippled.cfg server_info | python3 -c "import sys, json, datetime; data=json.load(sys.stdin); print(datetime.datetime.strptime(data['result']['info']['time'], '%Y-%b-%d %H:%M:%S.%f').strftime('%Y%m%d%H%M%S.%f'),',',data['result']['info']['validated_ledger']['seq'])")

	echo "$VALUES" >> output/out.csv
	read CURTIME CURSEQ <<< $( echo ${VALUES} | awk -F"," 'gsub(/\./,"",$1){print $1 $2}' )

	if [ $COUNTER -eq 0 ]; then
		OLDTIME=$CURTIME
		OLDSEQ=$CURSEQ
	else
		if [ $OLDSEQ -ne $CURSEQ ]; then
			DIFFTIME=$((CURTIME - OLDTIME))
			AVG=$(((DIFFTIME + OLDDIFFTIME) / COUNTER))
			if [ $DIFFTIME -gt $MAX ]; then
				MAX=$DIFFTIME
			fi
			if [ $DIFFTIME -lt $MIN ]; then
				MIN=$DIFFTIME
			fi

			printf "%10d%10d%10d%10d%10d\n" $COUNTER $MIN $MAX $AVG $DIFFTIME

			OLDTIME=$CURTIME
			OLDSEQ=$CURSEQ
			OLDDIFFTIME=$DIFFTIME
		fi
	fi

	((COUNTER=COUNTER+1))
	sleep $INTERVAL
done
