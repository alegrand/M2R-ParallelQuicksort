
OUTPUT_DIRECTORY=data/`hostname`_`date +%F`
mkdir -p $OUTPUT_DIRECTORY
OUTPUT_FILE=$OUTPUT_DIRECTORY/measurements_`date +%R`.txt

touch $OUTPUT_FILE

for rep in `seq 1 5`; do
	for i in 10 50 100 500 1000 5000 10000 50000 100000 500000 1000000; do
		echo "Size: $i" >> $OUTPUT_FILE;
		./src/parallelQuicksort $i >> $OUTPUT_FILE;
	done
done
