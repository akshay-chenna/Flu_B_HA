sudo docker run -it 71e02ff2a7b1 rosetta_scripts.cxx11threadmpiserializationtensorflowtorch.linuxgccrelease
sudo docker run -it 71e02ff2a7b1 /bin/bash
sudo docker ps -a
sudo docker stop $(sudo docker ps -q)

sudo docker run -it -v $(pwd):/data -w /data 71e02ff2a7b1 /bin/bash

find ~/Desktop/ -name "*xml"
find ~/Desktop/ -name "relax*sh"

tmux new -s rosetta
tmux detach-client -s rosetta
sudo docker run -dit 71e02ff2a7b1 /bin/bash

silentfrompdbs trimer_relaxed_0001_chA.pdb > trimer_relaxed_0001_chA.silent

for i in {1..50} ; do python /home/akshay/apps/dl_binder_design/mpnn_fr/dl_interface_design.py -silent trimer_relaxed_0001_chA.silent -outsilent soluble_HA_${i}.silent -seqs_per_struct 50 -checkpoint_path /home/akshay/apps/dl_binder_design/mpnn_fr/ProteinMPNN/soluble_model_weights/v_48_020.pt -temperature 1  & ; done

