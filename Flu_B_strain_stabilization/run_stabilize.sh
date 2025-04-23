folder=outputs

rm tracer*
rm -rf $folder
mkdir $folder

mpirun -np 90 $ROSETTA_BIN/rosetta_scripts.mpi.linuxgccrelease -parser:protocol stabilizeinterface.xml \
-s E1E2_relaxed_1.pdb \
-nstruct 500 \
-linmem_ig 100 \
-overwrite \
-write_all_connect_info \
-jd2:failed_job_exception false \
-out:path:pdb ./$folder/ \
-out:file:scorefile scores.sc \
-mpi_tracer_to_file tracer.log 
