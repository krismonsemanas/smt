# Mesin Penerjemah Statistik

Proses pembuatan mesin penerjemah statistik mengunakan [MOSES DECODER](http://www2.statmt.org/moses/) dan [SRILM](https://www.google.com/search?client=firefox-b-lm&q=srilm) sebagai languange model dalam studi kasus penerjemahan Bahasa Indonesia ke dalam Bahasa Melayu Sambas

## Persiapan Install

### OS
Linux
### Update Linux Package
```bash
sudo apt-get upgrade
sudo apt-get upgrade -y
```
### Install Package Moses Distro Ubuntu

```bash
sudo apt-get install  g++ git subversion automake libtool zlib1g-dev libicu-dev libboost-all-dev libbz2-dev liblzma-dev python-dev graphviz imagemagick make cmake libgoogle-perftools-dev autoconf doxygen
```
Untuk distro linux selain ubunut cara nya bisa cek [disini](http://www2.statmt.org/moses/?n=Development.GetStarted)

## Clone Project
Clone projek ini dengan terminal 
```bash
git clone https://github.com/krismonsemanas/smt.git smt
```
```
cd smt
```
## Proses Instal
Ketikan perintah di bawah ini
```bash
chmod +x ./install.sh
```
Tunggu sampai proses installasi selesai

## Perintah Moses
Agar proses berjalan lancar pastikan terminal berada di folder yang telah di clone, contoh korpus ada di dalam folder corpus
### Clean
```bash
$PWD/moses/scripts/training/clean-corpus-n.perl corpus/corpus id sbs $PWD/corpus/clean 1 200
```
### Lowercase
```bash
$PWD/moses/scripts/tokenizer/lowercase.perl < $PWD/corpus/clean.id > $PWD/corpus/lowercased.id
$PWD/moses/scripts/tokenizer/lowercase.perl < $PWD/corpus/clean.sbs > $PWD/corpus/lowercased.sbs
```
### Tokenize
```bash
$PWD/moses/scripts/tokenizer/lowercase.perl < $PWD/corpus/clean.id > $PWD/corpus/lowercased.id
$PWD/moses/scripts/tokenizer/lowercase.perl < $PWD/corpus/clean.sbs > $PWD/corpus/lowercased.sbs
```
### Languange Model
```bash
$PWD/srilm/bin/i686-m64/ngram-count -order 3 interpolate -unk -text $PWD/corpus/tokenized.sbs -lm $PWD/corpus/lm/sbs.lm
```
### Training
```bash
$PWD/moses/scripts/training/train-model.perl -root-dir $PWD/corpus --corpus $PWD/corpus/tokenized --f id --e sbs --lm 0:3:$PWD/corpus/lm/sbs.lm -external-bin-dir $PWD/training-tools
```
### Tes Menerjemahkan
```bash
$PWD/moses/bin/moses -f $PWD/corpus/model/moses.
```
Untuk mencoba kalimat silahkan masukan Bahasa Indonesia, Maka akan keluar hasilnya dalam Bahas Melayu Sambas, untuk keluar setelah selesai tes tekan CTRL + C
### Uji Akurasi BLEU
```bash 
$PWD/moses/bin/moses -f $PWD/corpus/model/moses.ini < $PWD/corpus/tokenized.id > $PWD/corpus/output/out
$PWD/moses/scripts/generic/multi-bleu.perl $PWD/corpus/tokenized.sbs < $PWD/corpus/output/out
```
### RESOURCE
[Moses Decoder](https://github.com/moses-smt/mosesdecoder/tree/RELEASE-4.0)\
[SRILM](http://www.speech.sri.com/projects/srilm/)\
[GIZA++](https://github.com/moses-smt/giza-pp)
