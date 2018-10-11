#!/bin/bash

gitrepoprefix=https://github.com/UoMResearchIT/r-shiny-course-materials/commit/

taglist=$(git -C coursematerial/ tag)

if [ ${#taglist} -eq 0 ]; then
	echo "No tags found in repo"
	exit 1
fi


regex=""

# Prepare a long regex containing all possible tags and their hashes
for t in $taglist;
do
	commitid=$(git -C coursematerial/ rev-list -n 1 $t)
	regex="${regex}s!(\[git:$t\])\(\)!\1\($gitrepoprefix$commitid\)!g;"
done

# Do the replacement 
sed -E $regex $1 >$2

# Check whether we have any [git:xxxx]() links that are 
# still empty
echo $2
grep -E '\[git:.+\]\(\)' $2
exit_status=$?
if [ $exit_status -ne 1 ]; then 
	echo "Unresolved links found"
	exit 1

fi

