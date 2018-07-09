#!/bin/bash

gitrepoprefix=https://github.com/UoMResearchIT/RSE18-shiny-workshop-materials/commit/

taglist=$(git -C coursematerial/ tag)

for t in $taglist;
do
	echo tag $t
	commitid=$(git -C coursematerial/ rev-list -n 1 $t)
        sed -E "s!(\[git:$t\])\(\)!\1\($gitrepoprefix$commitid\)!" $1
done

