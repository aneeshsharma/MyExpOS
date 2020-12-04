#!/bin/bash

STAGE=22

DIR=../history/stage$STAGE

cd ~/code/MyExpOS/

echo "This script will build and prepare the XSM machine"
echo
echo "Starting build..."

cd spl

echo "Compiling kernel..."
./spl $DIR/os_startup.spl
./spl $DIR/boot_module.spl
./spl $DIR/timer_int.spl
./spl $DIR/exhandler.spl
./spl $DIR/int7.spl
./spl $DIR/scheduler_module.spl
./spl $DIR/device_manager.spl
./spl $DIR/resource_manager.spl
./spl $DIR/console_interrupt_handler.spl
./spl $DIR/int6.spl
./spl $DIR/int9.spl
./spl $DIR/process_manager.spl
./spl $DIR/memory_manager.spl
./spl $DIR/disk_int.spl
./spl $DIR/int8.spl
./spl $DIR/int10.spl
./spl $DIR/int11.spl
./spl $DIR/int15.spl
./spl $DIR/int13.spl
./spl $DIR/int14.spl

echo "Kernel build completed!"

cd ../expl

echo "Compiling user programs..."

./expl $DIR/idle.expl
./expl $DIR/shell.expl
./expl $DIR/even.expl
./expl $DIR/odd.expl
./expl $DIR/prime.expl
./expl $DIR/read.expl
./expl $DIR/gcd.expl
./expl $DIR/init.expl
./expl $DIR/exc_test.expl
./expl $DIR/test.expl
./expl $DIR/bubble.expl
./expl $DIR/list.expl
./expl $DIR/exp.expl
./expl $DIR/create.expl
./expl $DIR/two_list.expl
./expl $DIR/two_p.expl
./expl $DIR/pid.expl
./expl $DIR/fork.expl
./expl $DIR/rw.expl
./expl $DIR/parent.expl
./expl $DIR/child.expl
./expl $DIR/seq-sort.expl
./expl $DIR/cc-sort.expl

echo "User programs built!"

echo "Loading kernel to disk..."

cd ../xfs-interface

./xfs-interface load --os $DIR/os_startup.xsm
./xfs-interface load --library ../expl/library.lib
./xfs-interface load --exhandler $DIR/exhandler.xsm
./xfs-interface load --module 7 $DIR/boot_module.xsm
./xfs-interface load --module 5 $DIR/scheduler_module.xsm
./xfs-interface load --module 4 $DIR/device_manager.xsm
./xfs-interface load --module 2 $DIR/memory_manager.xsm
./xfs-interface load --module 1 $DIR/process_manager.xsm
./xfs-interface load --module 0 $DIR/resource_manager.xsm
./xfs-interface load --int=timer $DIR/timer_int.xsm
./xfs-interface load --int=console $DIR/console_interrupt_handler.xsm
./xfs-interface load --int=disk $DIR/disk_int.xsm
./xfs-interface load --int=7 $DIR/int7.xsm
./xfs-interface load --int=6 $DIR/int6.xsm
./xfs-interface load --int=9 $DIR/int9.xsm
./xfs-interface load --int=8 $DIR/int8.xsm
./xfs-interface load --int=10 $DIR/int10.xsm
./xfs-interface load --int=11 $DIR/int11.xsm
./xfs-interface load --int=13 $DIR/int13.xsm
./xfs-interface load --int=14 $DIR/int14.xsm
./xfs-interface load --int=15 $DIR/int15.xsm

echo "Loading user programs to disk..."

./xfs-interface load --idle $DIR/idle.xsm
./xfs-interface load --init $DIR/shell.xsm
./xfs-interface rm odd.xsm
./xfs-interface rm prime.xsm
./xfs-interface rm even.xsm
./xfs-interface rm gcd.xsm
./xfs-interface rm exc_test.xsm
./xfs-interface rm test.xsm
./xfs-interface rm bubble.xsm
./xfs-interface rm list.xsm
./xfs-interface rm exp.xsm
./xfs-interface rm create.xsm
./xfs-interface rm two_list.xsm
./xfs-interface rm two_p.xsm
./xfs-interface rm pid.xsm
./xfs-interface rm fork.xsm
./xfs-interface rm rw.xsm
./xfs-interface rm parent.xsm
./xfs-interface rm child.xsm
./xfs-interface rm seq-sort.xsm
./xfs-interface rm cc-sort.xsm

./xfs-interface load --exec $DIR/odd.xsm
./xfs-interface load --exec $DIR/prime.xsm
./xfs-interface load --exec $DIR/even.xsm
./xfs-interface load --exec $DIR/gcd.xsm
./xfs-interface load --exec $DIR/exc_test.xsm
./xfs-interface load --exec $DIR/test.xsm
./xfs-interface load --exec $DIR/bubble.xsm
./xfs-interface load --exec $DIR/list.xsm
./xfs-interface load --exec $DIR/exp.xsm
./xfs-interface load --exec $DIR/create.xsm
./xfs-interface load --exec $DIR/two_list.xsm
./xfs-interface load --exec $DIR/two_p.xsm
./xfs-interface load --exec $DIR/pid.xsm
./xfs-interface load --exec $DIR/fork.xsm
./xfs-interface load --exec $DIR/rw.xsm
./xfs-interface load --exec $DIR/parent.xsm
./xfs-interface load --exec $DIR/child.xsm
./xfs-interface load --exec $DIR/seq-sort.xsm
./xfs-interface load --exec $DIR/cc-sort.xsm

echo "Disk load complete!"
echo
echo "Run the XSM machine to test"
