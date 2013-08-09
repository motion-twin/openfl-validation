#!/bin/bash
echo "path is $JENKINS_URL"
PWD=$(pwd)
REPORT=${PWD}/JENKINS.md

echo "Jenkins report">$REPORT
echo "--------------">>$REPORT
echo "Hi, I am [JenkinsMT]($JENKINS_URL), I am not a human, I am a testing software which
pushes the dev branch on the master branch (stablish) when the tests are successful. ${JENKINS_URL} ">>$REPORT
echo " ">>$REPORT

echo "Here are the version of the libraries I used for the tests :">>$REPORT

cd /usr/lib/haxe/lib/openfl/git
GIT_REV=$(git rev-parse --verify HEAD)
echo "* [openfl](https://github.com/motion-twin/openfl) revision
[${GIT_REV}](https://github.com/motion-twin/openfl/commit/$GIT_REV)">>$REPORT

cd /data/workspace/openfl-validation-linux64
GIT_REV=$(git rev-parse --verify HEAD)
echo "* [openfl-validation](https://github.com/motion-twin/openfl-validation) revision
[${GIT_REV}](https://github.com/motion-twin/openfl-validation/commit/$GIT_REV)">>$REPORT

cd /usr/lib/haxe/lib/openfl-tools/git
GIT_REV=$(git rev-parse --verify HEAD)
echo "* [openfl-tools](https://github.com/motion-twin/openfl-tools) revision
[${GIT_REV}](https://github.com/motion-twin/openfl-tools/commit/$GIT_REV)">>$REPORT



echo " ">>$REPORT

LAST_BUILD=$(curl ${JENKINS_URL}/job/openfl-validation-linux64/lastStableBuild/buildNumber)
echo "The last successfull build on Jenkins is
[build-${LAST_BUILD}](${JENKINS_URL}/job/openfl-validation-linux64/${LAST_BUILD})">>$REPORT

echo "generated on $(date)"

#commit report
cd /data/workspace/openfl-validation-linux64/
git checkout master
git commit -am "jenkins report"
git push origin master

#push on master branch of openfl
cd /usr/lib/haxe/lib/openfl/git
git checkout dev
git push origin master

#push on master branch of openfl-tools
cd /usr/lib/haxe/lib/openfl-tools/git
git checkout dev
git push origin master



