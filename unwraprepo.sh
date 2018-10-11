#!/bin/bash

# "Unwrap" the coursematerial repo:
# Create a directory for each tag and put
# the contents of the repo at that point in it

gitdir=coursematerial
unwrapdir=runningExample

if [ -d "$unwrapdir" ]; then
	rm -r $unwrapdir
fi


mkdir $unwrapdir

taglist=$(git -C $gitdir/ tag)

if [ ${#taglist} -eq 0 ]; then
	echo "No tags found in repo"
	exit 1
fi

for t in $taglist;
do
	cd $gitdir 
	git checkout $t
	cd ..
	cp -r $gitdir $unwrapdir/$t/

done

