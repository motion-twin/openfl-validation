
PWD=${WORKSPACE}
REPORT=${PWD}/JENKINS.md

echo "Jenkins report">$REPORT
echo "--------------">>$REPORT
echo "Hi, I am [JenkinsMT](${JENKINS_URL}), I am not a human, I am a testing software which
pushes the dev branch on the master branch (stablish) when the tests are successful.">>$REPORT
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


LAST_BUILD=$(curl ${JENKINS_URL}/job/openfl-validation-linux64/lastStableBuild/buildNumber)
echo "The last successfull build on Jenkins is
[build-${LAST_BUILD}](${JENKINS_URL}/job/openfl-validation-linux64/${LAST_BUILD})">>$REPORT

echo "generated on $(date)"

cd /data/workspace/openfl-validation-linux64/
cp $PWD/JENKINS.md ./
git commit -am "jenkins report"
git push origin master


