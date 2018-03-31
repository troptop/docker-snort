#!/bin/bash

sourceDir=/opt/log
DestDir=/var/log/snort
inotifywait -m $sourceDir -e create |
    while read path action file; do
	filetmstp=$(echo $file | sed 's/\.[0-9]*//g')
	fileproc=$(echo $filetmstp | tr '.' '-')
	kill -9 $(eval echo \$$fileproc)
        echo "The file '$file' appeared in directory '$path' via '$action'"
        # do something with the file
	tail -f $path"/"$file > $DestDir"/"$file &
	eval $fileproc=\$'!'
	eval echo \$$fileproc		
    done
