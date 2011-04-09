#!/bin/sh

java -cp project/boot/scala-2.8.1/lib/scala-library.jar:lib_managed/scala_2.8.1/compile/*:target/scala_2.8.1/bbt_2.8.1-1.0.jar bbt.TodoServer --configFile src/main/resources/blueeyes.conf
