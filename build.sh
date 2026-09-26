#!/bin/bash
set -e

echo "Building project..."

nasm -f bin bootloader/bootloader.asm -I ./ -o bootloader/bootloader.bin
nasm -f bin kernel.asm -I ./ -o kernel.bin
cat bootloader/bootloader.bin kernel.bin > disk.img

echo "Build successful! Created disk.img."
