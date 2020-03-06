# MIMUW-SO
Assignments for SO class (Operating Systems class)

## A4 task build and run

    nasm -f elf64 -o mac.o mac.asm
    gcc -c -Wall -O2 -o mac_test.o mac_test.c
    gcc -o mac_test mac.o mac_test.o
    ./mac_test
