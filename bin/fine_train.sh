#
# rebuild tir.traineddata from scratch
# adopted from https://tesseract-ocr.github.io/tessdoc/TrainingTesseract-4.00.html#tesstutorial
#

mkdir ~/build
cd ~/build
mkdir langdata
cd langdata
wget https://raw.githubusercontent.com/tesseract-ocr/langdata_lstm/master/radical-stroke.txt
wget https://raw.githubusercontent.com/tesseract-ocr/langdata_lstm/master/common.punc
wget https://raw.githubusercontent.com/tesseract-ocr/langdata_lstm/master/font_properties
wget https://raw.githubusercontent.com/tesseract-ocr/langdata_lstm/master/Latin.unicharset
wget https://raw.githubusercontent.com/tesseract-ocr/langdata/master/Ethiopic.unicharset
wget https://raw.githubusercontent.com/tesseract-ocr/langdata/master/Ethiopic.xheights
wget https://raw.githubusercontent.com/tesseract-ocr/langdata_lstm/master/Latin.xheights
mkdir tir
cd tir
wget https://raw.githubusercontent.com/tesseract-ocr/langdata/master/tir/tir.punc
wget https://raw.githubusercontent.com/tesseract-ocr/langdata_lstm/master/tir/forbidden_characters
wget https://raw.githubusercontent.com/tesseract-ocr/langdata_lstm/master/tir/okfonts.txt
wget https://raw.githubusercontent.com/tesseract-ocr/langdata_lstm/master/tir/tir.punc
wget https://raw.githubusercontent.com/tesseract-ocr/langdata_lstm/master/tir/tir.singles_text
wget https://raw.githubusercontent.com/tesseract-ocr/langdata_lstm/master/tir/tir.training_text
#wget https://raw.githubusercontent.com/TigrinyaNLP/Tigrinya-tasseract-ocr/master/resources/langdata/tir/tir.training_text
wget https://raw.githubusercontent.com/tesseract-ocr/langdata_lstm/master/tir/tir.unicharset
wget https://raw.githubusercontent.com/tesseract-ocr/langdata_lstm/master/tir/tir.wordlist
#wget https://raw.githubusercontent.com/TigrinyaNLP/Tigrinya-tasseract-ocr/master/resources/langdata/tir/tir.wordlist

mkdir fonts
cd fonts
wget https://raw.githubusercontent.com/TigrinyaNLP/Tigrinya-tasseract-ocr/master/resources/fonts/truetype/abyssinica/AbyssinicaSIL.ttf

cd ~/build
git clone --depth 1 https://github.com/tesseract-ocr/tesseract.git
cd ~/build/tesseract/tessdata
wget https://github.com/tesseract-ocr/tessdata_best/raw/master/tir.traineddata

cd ~/build


tesstrain.sh --fonts_dir ~/build/langdata/tir/fonts \
             --lang tir \
             --linedata_only \
             --noextract_font_properties \
             --langdata_dir langdata  \
             --tessdata_dir  ~/build/tesseract/tessdata \
             --save_box_tiff \
             --output_dir ~/build/tirtrain \
             --fontlist "Abyssinica SIL"


#evaluage
combine_tessdata -e ~/build/tesseract/tessdata/tir.traineddata tir.lstm

lstmeval --model ~/build/tir.lstm --traineddata  ~/build/tesseract/tessdata/tir.traineddata --eval_listfile ~/build/tirtrain/tir.training_files.txt

#train
cd ~build
mkdir ~/build/tiroutput
lstmtraining   --continue_from tir.lstm \
               --model_output ~/build/tiroutput/base \
               --traineddata  ~/build/tesseract/tessdata/tir.traineddata \
               --train_listfile ~/build/tirtrain/tir.training_files.txt \
               --max_iterations 1000 \
               --debug_interval -1

lstmtraining --stop_training \
             --continue_from ~/build/tiroutput/base_checkpoint \
             --traineddata  ~/build/tesseract/tessdata/tir.traineddata \
              --model_output ~/tesstutorial/tiroutput/tir.traineddata