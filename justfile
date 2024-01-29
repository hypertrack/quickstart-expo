alias cl := clean
alias cm := compile
alias pa := prebuild-android
alias pi := prebuild-ios
alias ra := run-android
alias rad := run-android-device
alias radc := run-android-device-clean
alias ri := run-ios
alias rid := run-ios-device
alias ridc := run-ios-device-clean
alias s:= setup
alias sm := start-metro
alias ul := use-local-expo-dependency

build-android-online:
  eas build:run -p android

clean:
  rm -rf node_modules
  npx yarn cache clean
  npx pod deintegrate ios/quickstartexpo.xcodeproj
  cd android && ./gradlew clean && cd ..

compile:
  npx tsc

create-eas-online-build:
  eas build -p android --profile preview

hooks:
  chmod +x .githooks/pre-push
  git config core.hooksPath .githooks

open-android:
  studio android

open-ios:
  open ios/quickstartexpo.xcworkspace

[private]
_prebuild flags="":
  npx expo prebuild {{flags}}

prebuild: _prebuild
prebuild-clean: (_prebuild "--clean")

prebuild-android: (_prebuild "--platform android")
prebuild-android-clean: (_prebuild "--platform android --clean")

prebuild-ios: (_prebuild "--platform ios")
prebuild-ios-clean: (_prebuild "--platform ios --clean")

[private]
_run target="" flags="":
  npx expo run{{target}} {{flags}}

run-android: compile
  just _run ":android"
run-android-device device="": compile
  just _run ":android" "-d {{device}}"
run-android-device-clean device="": compile
  just _run ":android" "-d {{device}} --no-build-cache"

run-ios: compile
  just _run ":ios"
run-ios-device device="": compile
  just _run ":ios" "-d {{device}}"
run-ios-device-clean device="": compile
  just _run ":ios" "-d {{device}} --no-build-cache"

setup: hooks
  yarn install
  just prebuild
  npx pod-install

start-metro flags="": compile
  npx yarn start {{flags}}

start-metro-clean: (start-metro "-c")

use-local-expo-dependency: hooks
  yarn add hypertrack-sdk-expo@file:../sdk-expo
