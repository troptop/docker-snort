#!/bin/bash

sourceDir=/opt/log
DestDir=/var/log/snort
inotifywait -m $sourceDir -e create |
    while read path action file; do
        filetmstp=$(echo $file | sed 's/\.[0-9]\{10\}//g')
        echo $filetmstp
        fileproc=$(echo $filetmstp | tr '.' '_' | tr '-' '_')
        echo $fileproc
        kill -9 $(eval echo \$$fileproc)
        echo "The file '$file' appeared in directory '$path' via '$action'"
        # do something with the file
        tail -f $path"/"$file > $DestDir"/"$file &
        eval $fileproc=\$'!'
        echo "the $fileproc PID process is : "
        eval echo \$$fileproc
    done

