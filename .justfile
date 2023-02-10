prebuild-android:
    rm -rf android 
    npx expo prebuild --no-install --platform android
    # --clean

prebuild-ios:
    rm -rf android 
    npx expo prebuild --no-install --platform ios
    cd ios && pod install && cd ..

create-eas-online-build:
    eas build -p android --profile preview

build-android-online:
    eas build:run -p android

start-metro:
    npx react-native start

clear-nm:
    rm -rf node_modules/hypertrack-sdk-expo

alias pa := prebuild-android
alias pi := prebuild-ios
alias sm := start-metro
alias cn := clear-nm
