alias c := compile
alias cen := clear-expo-plugin-nm
alias cn := clear-nm
alias pa := prebuild-android
alias pi := prebuild-ios
alias ra := run-android
alias sm := start-metro
alias ul := use-local-expo-dependency

build-android-online:
    eas build:run -p android

clear-nm:
    rm -rf node_modules
    rm yarn.lock

clear-expo-plugin-nm:
    rm -rf node_modules/hypertrack-sdk-expo

compile:
    npx tsc

create-eas-online-build:
    eas build -p android --profile preview

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

start-metro:
    npx react-native start

use-local-expo-dependency: hooks clear-expo-plugin-nm
    yarn add hypertrack-sdk-expo@file:../sdk-expo
