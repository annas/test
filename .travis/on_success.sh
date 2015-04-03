#!/bin/bash
echo "Executing mvn javadoc:javadoc...\n"
mvn javadoc:javadoc

echo "Publishing javadoc...\n"

  cp -R target/site/javadocs $HOME/javadoc-latest
  
  cd $HOME
  git config --global user.email "travis@travis-ci.org"
  git config --global user.name "travis-ci"
  git clone --quiet --branch=gh-pages https://${GH_TOKEN}@github.com/annas/test gh-pages > /dev/null
  
  echo "Cloned and switched to the branch\n"
  
  cd gh-pages
  git rm -rf ./javadoc
  cp -Rf $HOME/javadoc-latest ./javadoc
  git add -f .
  git commit -m "Lastest javadoc on successful travis build $TRAVIS_BUILD_NUMBER auto-pushed to gh-pages"
  git push -fq origin gh-pages > /dev/null

  echo -e "Published Javadoc to gh-pages.\n"
