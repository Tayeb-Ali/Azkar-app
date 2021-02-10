#!/bin/bash 
PATH_PROJECT=$(pwd)

# build apk
flutter build apk --release

# move file app-release.aab to folder certs
cp "$PATH_PROJECT/build/app/outputs/apk/release/app-release.apk" "$PATH_PROJECT/market deliveryboy.apk"