sudo docker run -dit -v "$(pwd)":/data -w /data 71e02ff2a7b1 /bin/bash
CONTAINER_ID=$(sudo docker ps -q --filter "ancestor=71e02ff2a7b1")
sudo docker cp esm2_t33_650M_UR50D ${CONTAINER_ID}:/usr/local/database/protocol_data/tensorflow_graphs/tensorflow_graph_repo_submodule/ESM/

sudo docker exec ${CONTAINER_ID} rosetta_scripts.cxx11threadmpiserializationtensorflowtorch.linuxgccrelease -parser:protocol score.xml \
-s trimer_relaxed.pdb \
-total_threads 4 \
-nstruct 1 \
-out:file:scorefile score_probs_metrics.sc

sudo docker stop ${CONTAINER_ID}
sudo docker rm ${CONTAINER_ID}

#-linmem_ig 100 \
#-overwrite \
#-write_all_connect_info \
#-jd2:failed_job_exception false \
#-out:path:pdb ./$folder/ \
#-auto_download \
#-mpi_tracer_to_file tracer.log 
