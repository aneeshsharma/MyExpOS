#!/bin/bash

STAGE=16

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
./spl $DIR/scheduler_module.spl
./spl $DIR/device_manager.spl
./spl $DIR/resource_manager.spl
./spl $DIR/console_interrupt_handler.spl
./spl $DIR/int6.spl

echo "Compiled SPL"

cd ../expl

./expl $DIR/idle.expl
./expl $DIR/even.expl
./expl $DIR/odd.expl
./expl $DIR/prime.expl
./expl $DIR/read.expl
./expl $DIR/gcd.expl

echo "Compliled EXPL"

echo "Loading into disk..."

cd ../xfs-interface

./xfs-interface load --os $DIR/os_startup.xsm
./xfs-interface load --library ../expl/library.lib
./xfs-interface load --exhandler $DIR/exhandler.xsm
./xfs-interface load --int=10 $DIR/halt_prog.xsm
./xfs-interface load --module 7 $DIR/boot_module.xsm
./xfs-interface load --module 5 $DIR/scheduler_module.xsm
./xfs-interface load --module 4 $DIR/device_manager.xsm
./xfs-interface load --module 0 $DIR/resource_manager.xsm
./xfs-interface load --int=timer $DIR/timer_int.xsm
./xfs-interface load --int=console $DIR/console_interrupt_handler.xsm
./xfs-interface load --int=7 $DIR/int7.xsm
./xfs-interface load --int=6 $DIR/int6.xsm

./xfs-interface load --idle $DIR/idle.xsm
./xfs-interface load --init $DIR/gcd.xsm
./xfs-interface rm odd.xsm
./xfs-interface rm prime.xsm
./xfs-interface load --exec $DIR/odd.xsm
./xfs-interface load --exec $DIR/prime.xsm

echo "Loaded files to disk succesfully"
echo "Run the xsm machine to test"
