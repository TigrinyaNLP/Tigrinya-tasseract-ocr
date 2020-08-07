lstmtraining   --traineddata ~/build/tirtrain/tir/tir.traineddata  \
               --net_spec '[1,36,0,1Ct3,3,16Mp3,3Lfys48Lfx96Lrx96Lfx128O1c1]' \
               --learning_rate 0.001 \
               --momentum  0.5 \
               --max_iterations 10498000 \
               --debug_interval -1  \
               --model_output ~/build/tiroutput/base \
               --train_listfile ~/build/tirtrain/tir.training_files.txt \
               --eval_listfile ~/build/tireval/tir.training_files.txt
