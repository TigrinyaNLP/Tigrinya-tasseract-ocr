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
wget https://raw.githubusercontent.com/tesseract-ocr/langdata/master/tir/tir.training_text
wget https://raw.githubusercontent.com/tesseract-ocr/langdata/master/tir/tir.punc
wget https://raw.githubusercontent.com/tesseract-ocr/langdata/master/tir/tir.numbers
wget https://raw.githubusercontent.com/tesseract-ocr/langdata/master/tir/tir.wordlist

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