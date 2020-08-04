mkdir ~/tesstutorial
cd ~/tesstutorial

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
wget https://raw.githubusercontent.com/TigrinyaNLP/Tigrinya-tasseract-ocr/master/resources/langdata/tir/tir.training_text
wget https://raw.githubusercontent.com/TigrinyaNLP/Tigrinya-tasseract-ocr/master/resources/langdata/tir/tir.wordlist
wget https://raw.githubusercontent.com/tesseract-ocr/langdata/master/tir/tir.punc
wget https://raw.githubusercontent.com/tesseract-ocr/langdata/master/tir/tir.numbers
mkdir fonts
mkdir fonts/truetype
mkdir fonts/truetype/abyssinica
cd fonts/truetype/abyssinica
wget https://raw.githubusercontent.com/TigrinyaNLP/Tigrinya-tasseract-ocr/master/resources/fonts/truetype/abyssinica/AbyssinicaSIL.ttf

cd ~/tesstutorial
git clone --depth 1 https://github.com/tesseract-ocr/tesseract.git
cd tesseract/tessdata
wget https://github.com/tesseract-ocr/tessdata/raw/master/tir.traineddata
wget https://github.com/tesseract-ocr/tessdata/raw/master/osd.traineddata
mkdir best
cd best
wget https://github.com/tesseract-ocr/tessdata_best/raw/master/tir.traineddata
wget https://github.com/tesseract-ocr/tessdata_best/raw/master/heb.traineddata
wget https://github.com/tesseract-ocr/tessdata_best/raw/master/chi_sim.traineddata




tesstrain.sh --fonts_dir ~/tesstutorial/langdata/fonts --lang tir --linedata_only  --noextract_font_properties --langdata_dir langdata  --tessdata_dir tesseract/tessdata --output_dir ~/tesstutorial/tirtrain --fontlist "Abyssinica SIL"

tesstrain.sh --fonts_dir ~/tesstutorial/langdata/fonts --lang tir --linedata_only  --noextract_font_properties --langdata_dir langdata  --tessdata_dir tesseract/tessdata --fontlist "Abyssinica SIL" --output_dir ~/tesstutorial/tireval

mkdir -p ~/tesstutorial/tiroutput
mkdir -p ~/tesstutorial/tiroutput/base
lstmtraining --debug_interval 100   --traineddata ~/tesstutorial/tirtrain/tir/tir.traineddata   --net_spec '[1,36,0,1 Ct3,3,16 Mp3,3 Lfys48 Lfx96 Lrx96 Lfx256 O1c352]'  --model_output ~/tesstutorial/tiroutput/base --learning_rate 20e-4   --train_listfile ~/tesstutorial/tirtrain/tir.training_files.txt   --eval_listfile ~/tesstutorial/tireval/tir.training_files.txt   --max_iterations 5000 debug_interval -1  &>~/tesstutorial/tiroutput/basetrain.log