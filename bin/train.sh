
if [ "$1" = "scratch" ]; then
    TIR_TESSDATA="~/build/tirtrain/tir/tir.traineddata"
else if [ "$1" = "best" ]; then
    TIR_TESSDATA="~/build/best/tir.traineddata"
else
    echo "Usage: train.sh [ scratch | best ]  -- start training from already existing best tir.tessdata or train from scratch from the empty one built earlier"
    exit 1;
fi

mkdir ~/build/tiroutput
lstmtraining   --traineddata "$TIR_TESSDATA"  \
               --old_traineddata ~/build/best/tir.traineddata  \
               --net_spec '[1,36,0,1Ct3,3,16Mp3,3Lfys48Lfx96Lrx96Lfx128O1c1]' \
               --learning_rate 0.001 \
               --momentum  0.5 \
               --max_iterations 10498000 \
               --debug_interval -1  \
               --model_output ~/build/tiroutput/base \
               --train_listfile ~/build/tirtrain/tir.training_files.txt \
               --eval_listfile ~/build/tirtrain/tir.training_files.txt


#lstmtraining --stop_training  --continue_from ~/build/tiroutput/base_checkpoint  --traineddata ~/build/tirtrain/tir/tir.traineddata   --model_output ~/tesstutorial/tiroutput/tir.traineddata

# TEST
# tesseract  --tessdata-dir ~/build/tiroutput/ -l tir  ~/Tigrinya-tasseract-ocr/resources/test/tif/tir.bible_01.tif  tir.bible_01
