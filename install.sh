#!/bin/bash
echo "Ekstrak File"
mkdir moses
unzip moses.zip
mv $PWD/mosesdecoder-master/* $PWD/moses
rmdir $PWD/mosesdecoder-master
tar -zxvf boost_1_64_0.tar.gz && mv $PWD/boost_1_64_0 $PWD/moses
tar -zxvf srilm.tar.gz
mkdir giza-pp
unzip giza-pp-master.zip && mv $PWD/giza-pp-master/* $PWD/giza-pp
rmdir giza-pp-master
rm moses.zip boost_1_64_0.tar.gz srilm.tar.gz giza-pp-master.zip
echo "=== Proses Ekstrak File Selesai"
echo "=== instal moses berlangsung dengan boost ==="
echo "=== mengeksekusi ./bjam --with-boost=$PWD/moses/boost_1_64_0 -j8 ==="
cd $PWD/moses && ./bjam --with-boost=$PWD/moses/boost_1_64_0 -j8
cd ..
echo "=== proses instal moses selesai ==="

echo "=== proses instal srilm ==="
cd $PWD/srilm
make
cd ..
echo "=== proses instal srilm selesai ==="

echo "=== proses instal giza ++ ==="
cd $PWD/giza-pp
make
cd ..
mkdir training-tools
cp giza-pp/GIZA++-v2/GIZA++ giza-pp/GIZA++-v2/snt2cooc.out giza-pp/mkcls-v2/mkcls training-tools
echo "=== proses instal giza ++ selesai ==="
