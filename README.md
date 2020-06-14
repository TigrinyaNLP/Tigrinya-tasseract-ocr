# Customizing Language Technologies to Tigrinya

We are all familiar with spelling checks, speech recognition and optical character recognition (OCR) Technologies. We know how useful they are. Unfortunately they are not readily available for minority languages like Tigrinya.  Many companies focus on the financial gain when supporting new language in their product. The odds are not in favor of Tigrinya in this regard. The good news is that, the majority of these preparatory products are built on top of an open source engine. And these open source technologies are customizable for any language. With a bit of creativity and hard work, Tigrinya can also be the beneficiary of these technologies. Most importantly, successful adoption of these technologies highly depends on the quality of the corpus.  

## Corpus Building

[Corpus](https://en.wikipedia.org/wiki/Corpus_linguistics) may have a broader meaning in Linguists study. For the purpose of this document, Corpus is a complete list of words/phrases of a language that adheres to the morphological structure (grammatical syntax) of that language.  Most Language technologies are based on machine learning algorithms. Knowing the spelling of the words and their derivation helps navigating the learning algorithms to the right learning path.

For example when running OCR the word ስምካ could be seen by the OCR application as ስምካ ሰምካ ከምካ or ክምካ, because all these texts are visually very similar. But only one word is a valid corpus entry. With the help of the corpus, the application can produce a correct output. Corpus can also be used in part of speech tagging, germination and other analysis that could improve the accuracy of character recognition applications, spell checkers, voice recognition, translation services and other NLP applications.

There are few Tigrinya related works on this regard. Few years ago Biniam Gebremichael collected all Tigrinya webpages from internet and extracted [400,000 Tigrinya words] (http://www.cs.ru.nl/~biniam/geez/crawl.php) along with their frequency of occurrence. The list give a good overview of the commonly used Tigrinya words. It can be used as a starting point. However this is far from what a corpus is, for several reasons.

* No guarantee that all words are correctly spelled
* There is no word derivation rule
* The list does not contain all words, There are words that are valid entry, but not in the list

Following this work, M. Geiser worked on [morphological analysis of Tigrinya] (http://homes.sice.indiana.edu/gasser/L3/horn2.2.pdf) (alongside of Amharic and Oromo). The work was translated to a python code called [HornMorpho](https://github.com/fgaim/HornMorpho). Geiser uses Finite State Transition to represent word patens and their attributes. This helps construct and dissect a complex word from/to simple verb and attributes. 

For example the word ኣይፈለጠን is analyzed by HornMorpho as follows: grammatical transformation of the root word ፈለጠ, with linguistic features – third person masculine subject, and perfective and negative grammatically. 

```
import l3
l3.anal('ti', 'ኣይፈለጠን')
POS: verb, root: <flT>, citation: ፈለጠ
subject: 3, sing, masc
grammar: perfective, negative
```

HornMorpho can also work backwards, meaning giving a root word and grammatical features, it can derive the compound Tigrinya words. This is a good work that could enrich the corpus with correct grammatical derivation, but HornMorpho lucks completeness. The work only covers Tigrinya Verbs. Tigrinya Nouns, adjectives are not covered. Also there are some patterns of Tigrinya verbs that are not covered.

## Optical Character Recognition (OCR)

[OCR](https://en.wikipedia.org/wiki/Optical_character_recognition) technology is the conversion of image (scanned) documents into electronic editable text. OCR technology comes in many formats. For examples some printers can scan a document and save it as a word document ready to be edited. Most of this applications use underlying OCR engine which can be trained to recognize any character.

OCR can be a relevant technology in Tigrinya Language. To name some of the use cases:
* There are a lot of Tigrinya Books written long time ago. Usually the best Tigrinya books that have a lot of cultural and historical relevance are older books. OCR can help in making this books available for wider audience and it will make it possible to search though the text
* At a bigger picture, we can think about all the documents and legal papers stored at government offices, municipalities and other institutes in our country. OCR can be a good asset to digitize these documents and save them from degradation. Make services easy by organizing them digitally
* OCR can also contribute to the development of Tigrinya Corpus. Making more Tigrinya resources available for researchers and Tigrinya scholars will help speed up the process and narrow the technology gap.

### Tesseract
There are several OCR engines. A notable and Unicode freely application we found is called [Tesseract](https://github.com/tesseract-ocr/tesseract) by Google. Google has made their OCR engine available in the open source community for anyone to use and customize.  It is a good candidate we can rely for Tigrinya OCR. Tesseract has basic support for language with Geez script (including Tigrinya), however for accurate recognition, one has to train the application with enough test samples. As said earlier, availability of good corpus can improve the results, but even without one, Tesseract can produce a descent output, especially if it is well trained and uses clear and good scanned document with common Geez fonts.

In this project we are aiming to train Tesseract so that it will recognize Geez fonts properly and convert them correctly. This means we need to prepare training files for Tesseract OCR. Following that we will develop proper frontend user interface that will help users to easily convert scanned image Tigrinya documents into electronic editable text. 

## Installation
To train Tesseract we need to install [tesseract-ocr](https://github.com/tesseract-ocr/tesseract/releases). 

Other application we need to install includes:
* [Cygwin](https://www.cygwin.com/) - if we are using Windows 
* [Qr-box-editor](https://github.com/zdenop/qt-box-editor/downloads) - to fix the boxes generated by Tesseract, and ensure we feed the right data into it.

Tesseract comes with English as a default language. During the instalation process we can add Tigrinya language which addes the tir.traineddata file into the C:\Program Files\Tesseract-OCR\tessdata folder. Note that ‘**tir**’ is language code for Tigrinya in Tesseract. This tir.traineddata file is the file that is trained to recognize Geez fonts. Since it is fresh instalation, the file is not well trained. As a starting point we can download [tir.traineddata](https://github.com/tesseract-ocr/tessdata/blob/master/tir.traineddata) and save the file in /usr/share/tessdata folder. 

Once you put the file in the correct folder run the following command to tell Tesseract where the language definitions are:

```
export TESSDATA_PREFIX=/usr/share/tessdata
``` 

### Run Tesseract 
Now we are ready to run OCR on Tigrinya document. The command is as follows:

```
tesseract -l [language name] [input file name] [output file name]
```

Make a one page jpg or tif formatted image containing Tigrinya text. Save it as ‘page01.tif’ and run the following command:

```
tesseract -l tir page01.tif output01
``` 

The outputo1 file will contain the editable text version of the scanned document.

### Training Tesseract (making training files for Tesseract OCR)
Now we will discuss how to train Tesseract...
