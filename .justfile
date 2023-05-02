alias ule := use-local-expo-dependency
alias pa := prebuild-android
alias pi := prebuild-ios
alias sm := start-metro
alias cn := clear-nm
alias cen := clear-expo-plugin-nm
alias c := compile
alias ra := run-android

compile:
    npx tsc

hooks:
    chmod +x .githooks/pre-push
    git config core.hooksPath .githooks

run-android: compile
    npx react-native run-android

prebuild-android: hooks
    rm -rf android 
    npx expo prebuild --no-install --platform android
    # --clean

prebuild-ios: hooks
    rm -rf ios 
    npx expo prebuild --no-install --platform ios
    cd ios && pod install && cd ..

create-eas-online-build:
    eas build -p android --profile preview

build-android-online:
    eas build:run -p android

start-metro:
    npx react-native start

clear-nm:
    rm -rf node_modules
    rm yarn.lock

clear-expo-plugin-nm:
    rm -rf node_modules/hypertrack-sdk-expo

use-local-expo-dependency: hooks clear-expo-plugin-nm
    yarn add hypertrack-sdk-expo@file:../sdk-expo
