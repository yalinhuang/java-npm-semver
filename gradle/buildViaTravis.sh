#!/bin/bash
# This script will build the project.

SWITCHES="--info --stacktrace"

GRADLE_VERSION=$(./gradlew -version | grep Gradle | cut -d ' ' -f 2)

if [ "$TRAVIS_PULL_REQUEST" != "false" ]; then
  echo -e "Build Pull Request #$TRAVIS_PULL_REQUEST => Branch [$TRAVIS_BRANCH]"
  ./gradlew build $SWITCHES
elif [ "$TRAVIS_PULL_REQUEST" == "false" ] && [ "$TRAVIS_TAG" == "" ]; then
  echo -e 'Build Branch with Snapshot => Branch ['$TRAVIS_BRANCH']'
  ./gradlew build $SWITCHES
elif [ "$TRAVIS_PULL_REQUEST" == "false" ] && [ "$TRAVIS_TAG" != "" ]; then
  echo -e 'Build Branch for Release => Branch ['$TRAVIS_BRANCH']  Tag ['$TRAVIS_TAG']'
  case "$TRAVIS_TAG" in
  v.*)
    ./gradlew -DpkgVersion="${$TRAVIS_TAG:1}" -Dbintray.user=$bintrayUser -Dbintray.key=$bintrayKey -Dbintray.gpgPassphrase=$gpgPassphrase -Dsonatype.user=$sonatypeUser -Dsonatype.password=$sonatypePassword bintrayUpload $SWITCHES
    ;;
  *)
    ./gradlew build $SWITCHES
    ;;
  esac
else
  echo -e 'WARN: Should not be here => Branch ['$TRAVIS_BRANCH']  Tag ['$TRAVIS_TAG']  Pull Request ['$TRAVIS_PULL_REQUEST']'
  ./gradlew build $SWITCHES
fi

EXIT=$?

rm -f "$HOME/.gradle/caches/modules-2/modules-2.lock"
rm -rf "$HOME/.gradle/caches/$GRADLE_VERSION/plugin-resolution"

exit $EXIT
