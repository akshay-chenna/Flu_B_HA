for i in x{000..100}
do 
	l=`tail -1 $i`
	python -m bioemu.sample --sequence ${l} --num_samples 1000 --output_dir ./o_${i}
	rm sequence.fasta
done
