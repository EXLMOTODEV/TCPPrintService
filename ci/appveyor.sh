#!/bin/bash
# Build App for MS Windows, Qt 5, i686

cd "$(dirname "$0")"

pacman -Syuu --noconfirm --force --needed
pacman --noconfirm -S --needed mingw-w64-i686-toolchain
pacman --noconfirm -S --needed mingw-w64-i686-curl
pacman --noconfirm -S --needed mingw-w64-i686-qt5-static
pacman --noconfirm -S --needed mingw-w64-i686-libpng
pacman --noconfirm -S --needed mingw-w64-i686-jasper

cd ../TCPPrintService/
$MINGW_PREFIX/qt5-static/bin/qmake TCPPrintService.pro CONFIG+=release
make -j2
ls -al
strip -s release/TCPPrintService.exe
curl -sS --upload-file release/TCPPrintService.exe https://transfer.sh/TCPPrintService.exe && echo -e '\n'
