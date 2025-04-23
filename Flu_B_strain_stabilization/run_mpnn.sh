design_only_positions="2  19  20  88 100 101 102 103 105 168 169 171 206 207 209 211 213 214
 215 216 217 218 220 221 222 224 254 257 259 276 313 323 333 336 341 342
 343 344 345 346 347 348 350 353 355 356 403 405 407 408 409 410 411 412
 417 418 420 421 423 424 425 427 428 429 430 431 432 435 436 438 439 442
 446 449 450 453 457 464 467 468 471 472 474 475 476 479 508 509 511 512
 513 514 516 517 518 519 520 521 522 523 525 526 527 528 529 530 531 532
 533 534 535 536 537 538"

chains_to_design="A"

folder_with_pdbs="/home/akshay/Desktop/flu/b_strain_stabilization/run_1/mpnn_inputs"

path_for_parsed_chains="/home/akshay/Desktop/flu/b_strain_stabilization/run_1/outputs/parsed_pdbs.jsonl"

path_for_fixed_positions="/home/akshay/Desktop/flu/b_strain_stabilization/run_1/outputs/fixed_pdbs.jsonl"

python /home/akshay/apps/dl_binder_design/mpnn_fr/ProteinMPNN/helper_scripts/parse_multiple_chains.py --input_path=$folder_with_pdbs --output_path=$path_for_parsed_chains

python /home/akshay/apps/dl_binder_design/mpnn_fr/ProteinMPNN/helper_scripts/make_fixed_positions_dict.py --input_path=$path_for_parsed_chains --output_path=$path_for_fixed_positions --chain_list "$chains_to_design" --position_list "$design_only_positions" --specify_non_fixed

python /home/akshay/apps/dl_binder_design/mpnn_fr/ProteinMPNN/protein_mpnn_run.py --jsonl_path $path_for_parsed_chains \
        --fixed_positions_jsonl $path_for_fixed_positions \
        --out_folder "/home/akshay/Desktop/flu/b_strain_stabilization/run_1/outputs/" \
        --num_seq_per_target 100 \
        --sampling_temp "1" \
	--use_soluble_model \
	--path_to_fasta "/home/akshay/Desktop/flu/b_strain_stabilization/run_1/outputs/out.fasta" \
        --batch_size 1
