#!/bin/bash

for word in $( cat /usr/share/dict/words ); do
    echo $word | gpg -re ./chall3.gpg
done
