#!/bin/bash

STAGE=13

DIR=../history/stage$STAGE

cd ~/code/MyExpOS/

echo "Starting build..."

cd spl

./spl $DIR/os_startup.spl
./spl $DIR/boot_module.spl
./spl $DIR/halt_prog.spl
./spl $DIR/timer_int.spl
./spl $DIR/exhandler.spl
./spl $DIR/int7.spl

echo "Compiled SPL"

cd ../expl

./expl $DIR/idle.expl
./expl $DIR/even.expl
./expl $DIR/odd.expl

echo "Compliled EXPL"

echo "Loading into disk..."

cd ../xfs-interface

./xfs-interface load --os $DIR/os_startup.xsm
./xfs-interface load --library ../expl/library.lib
./xfs-interface load --exhandler $DIR/exhandler.xsm
./xfs-interface load --int=10 $DIR/halt_prog.xsm
./xfs-interface load --module 7 $DIR/boot_module.xsm
./xfs-interface load --int=timer $DIR/timer_int.xsm
./xfs-interface load --int=7 $DIR/int7.xsm

./xfs-interface load --idle $DIR/idle.xsm
./xfs-interface load --init $DIR/even.xsm

echo "Loaded files to disk succesfully"
echo "Run the xsm machine to test"
