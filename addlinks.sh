#!/bin/bash

gitrepoprefix=https://github.com/UoMResearchIT/RSE18-shiny-workshop-materials/commit/

taglist=$(git -C coursematerial/ tag)

regex=""

for t in $taglist;
do
	commitid=$(git -C coursematerial/ rev-list -n 1 $t)
	regex="${regex}s!(\[git:$t\])\(\)!\1\($gitrepoprefix$commitid\)!g;"
#        sed -E "s!(\[git:$t\])\(\)!\1\($gitrepoprefix$commitid\)!g" $1
done

sed -E $regex $1 >$2
