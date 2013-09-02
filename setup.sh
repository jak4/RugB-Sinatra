#!/bin/bash

PLATFORM=$2

if [ -z $5 ]; then
 PLATFORM="android"
fi

if [ $PLATFORM == "android" ]
then
  SUB_PATH="/assets/www"
elif [ $PLATFORM == "ios" ]
then
  SUB_PATH="/www"
else
 echo "Unkonwn Platform provided"
 exit -99
fi

REL_PATH="../../MobileApp/platforms/"$PLATFORM$SUB_PATH

#FILES=( cordova.js cordova_plugins.js index.html )
# as long as ripple doesn't support 3.0 use 2.8 instead
FILES=( cordova_plugins.js index.html )

for i in "${FILES[@]}"
do
  rm -rf www/$i && ln -s $REL_PATH/$i www/$i
done

DIRS=( css img js plugins res spec )

for i in "${DIRS[@]}"
do
  rm -rf www/$i && ln -s $REL_PATH/$i www/$i
done

# setup src dir
rm -rf src && ln -s ../MobileApp/src

# create grunt.sh file
rm -rf gruntjs.sh
echo "#!/bin/bash" >> gruntjs.sh
echo "source ~/.bashrc" >> gruntjs.sh
echo "cd ../MobileApp" >> gruntjs.sh
echo "grunt --target=$PLATFORM" >> gruntjs.sh
chmod +x gruntjs.sh

# create cordova build shell script
rm -rf cordova_build.sh
echo "#!/bin/bash" >> cordova_build.sh
echo "cd ../MobileApp" >> cordova_build.sh
echo "cordova build $PLATFORM" >> cordova_build.sh
chmod +x cordova_build.sh
