alias a := add-plugin
alias ael := add-expo-plugin-local
alias aep := add-expo-plugin
alias al := add-plugin-local
alias ap := add-plugin
alias cfrn := copy-js-code-from-quickstart-react-native
alias cl := clean
alias cm := compile
alias d := doctor
alias ev := expo-version
alias ogp := open-github-prs
alias oi := open-ios
alias p := prebuild
alias pc := prebuild-clean
alias pa := prebuild-android
alias pac := prebuild-android-clean
alias pi := prebuild-ios
alias pic := prebuild-ios-clean
alias ra := run-android
alias rad := run-android-device
alias radc := run-android-device-clean
alias re := reset-env
alias ri := run-ios
alias rid := run-ios-device
alias ridc := run-ios-device-clean
alias s:= setup
alias sm := start-metro
alias urs := update-react-native-sdk
alias v := version

SDK_NAME := "HyperTrack SDK Expo"
SDK_REPOSITORY_NAME := "sdk-expo"
QUICKSTART_REPOSITORY_NAME := "quickstart-expo"

# Source: https://semver.org/#is-there-a-suggested-regular-expression-regex-to-check-a-semver-string
# \ are escaped
SEMVER_REGEX := "(0|[1-9]\\d*)\\.(0|[1-9]\\d*)\\.(0|[1-9]\\d*)(?:-((?:0|[1-9]\\d*|\\d*[a-zA-Z-][0-9a-zA-Z-]*)(?:\\.(?:0|[1-9]\\d*|\\d*[a-zA-Z-][0-9a-zA-Z-]*))*))?(?:\\+([0-9a-zA-Z-]+(?:\\.[0-9a-zA-Z-]+)*))?"

ACTIVITY_SERVICE_GOOGLE_PLUGIN_LOCAL_PATH := "../sdk-react-native/plugin_android_activity_service_google"
LOCATION_SERVICES_GOOGLE_PLUGIN_LOCAL_PATH := "../sdk-react-native/plugin_android_location_services_google"
LOCATION_SERVICES_GOOGLE_19_0_1_PLUGIN_LOCAL_PATH := "../sdk-react-native/plugin_android_location_services_google_19_0_1"
PUSH_SERVICE_FIREBASE_PLUGIN_LOCAL_PATH := "../sdk-react-native/plugin_android_push_service_firebase"
QUICKSTART_REACT_NATIVE_LOCAL_PATH := "../quickstart-react-native"
SDK_PLUGIN_LOCAL_PATH := "../sdk-react-native/sdk"

add-expo-plugin version: hooks
    #!/usr/bin/env sh
    set -euo pipefail

    if grep -q '"hypertrack-sdk-expo"' package.json; then
      npm uninstall hypertrack-sdk-expo
    fi
    npm i --save-exact hypertrack-sdk-expo@{{version}}

add-expo-plugin-local: hooks
    npm install --save ../sdk-expo

add-plugin version: hooks
    #!/usr/bin/env sh
    set -euo pipefail

    if grep -q '"hypertrack-sdk-react-native"' package.json; then
        npm uninstall hypertrack-sdk-react-native
    fi
    if grep -q '"hypertrack-sdk-react-native-plugin-android-activity-service-google"' package.json; then
        npm uninstall hypertrack-sdk-react-native-plugin-android-activity-service-google
    fi
    if grep -q '"hypertrack-sdk-react-native-plugin-android-location-services-google"' package.json; then
        npm uninstall hypertrack-sdk-react-native-plugin-android-location-services-google
    fi
    if grep -q '"hypertrack-sdk-react-native-plugin-android-push-service-firebase"' package.json; then
        npm uninstall hypertrack-sdk-react-native-plugin-android-push-service-firebase
    fi

    MAJOR_VERSION=$(echo {{version}} | grep -o '^[0-9]\+')
    if [ $MAJOR_VERSION -ge 12 ]; then
        npm i --save-exact hypertrack-sdk-react-native-plugin-android-activity-service-google@{{version}}
        npm i --save-exact hypertrack-sdk-react-native-plugin-android-location-services-google@{{version}}
        npm i --save-exact hypertrack-sdk-react-native-plugin-android-push-service-firebase@{{version}}
    fi
    npm i --save-exact hypertrack-sdk-react-native@{{version}}

add-plugin-local: hooks
    #!/usr/bin/env sh
    set -euo pipefail

    if grep -q '"hypertrack-sdk-react-native"' package.json; then
        npm uninstall hypertrack-sdk-react-native
    fi
    if grep -q '"hypertrack-sdk-react-native-plugin-android-activity-service-google"' package.json; then
        npm uninstall hypertrack-sdk-react-native-plugin-android-activity-service-google
    fi
    if grep -q '"hypertrack-sdk-react-native-plugin-android-location-services-google"' package.json; then
        npm uninstall hypertrack-sdk-react-native-plugin-android-location-services-google
    fi
    if grep -q '"hypertrack-sdk-react-native-plugin-android-push-service-firebase"' package.json; then
        npm uninstall hypertrack-sdk-react-native-plugin-android-push-service-firebase
    fi
    npm i hypertrack-sdk-react-native@file:{{SDK_PLUGIN_LOCAL_PATH}}
    npm i hypertrack-sdk-react-native-plugin-android-activity-service-google@file:{{ACTIVITY_SERVICE_GOOGLE_PLUGIN_LOCAL_PATH}}
    npm i hypertrack-sdk-react-native-plugin-android-location-services-google@file:{{LOCATION_SERVICES_GOOGLE_PLUGIN_LOCAL_PATH}}
    npm i hypertrack-sdk-react-native-plugin-android-push-service-firebase@file:{{PUSH_SERVICE_FIREBASE_PLUGIN_LOCAL_PATH}}

build-android-online:
  eas build:run -p android

clean remove-lock="false" clean-npm-cache="false" clean-cocoapods-cache="false":
  #!/usr/bin/env sh
  set -euo pipefail

  rm -rf node_modules

  if {{remove-lock}}; then
    rm -f package-lock.json
  fi

  if {{clean-npm-cache}}; then
    npm cache clean --force
  fi

  if {{clean-cocoapods-cache}}; then
    rm -rf ~/.cocoapods/repos/
    npx pod deintegrate ios/quickstartexpo.xcodeproj
  fi

compile:
  npx tsc --noEmit

doctor:
  npx expo-doctor

copy-js-code-from-quickstart-react-native:
  cp -f {{QUICKSTART_REACT_NATIVE_LOCAL_PATH}}/src/App.tsx .

create-eas-online-build:
  eas build -p android --profile preview

expo-version:
  @cat package.json | grep hypertrack-sdk-expo | head -n 1 | grep -o -E '{{SEMVER_REGEX}}'

extract-plugin-nm:
    rm -rf {{SDK_PLUGIN_LOCAL_PATH}}/node_modules
    mkdir {{SDK_PLUGIN_LOCAL_PATH}}/node_modules
    cp -r node_modules/hypertrack-sdk-react-native/node_modules {{SDK_PLUGIN_LOCAL_PATH}}/node_modules

hooks:
  chmod +x .githooks/pre-push
  git config core.hooksPath .githooks

open-android:
  studio android

open-github-prs:
    open "https://github.com/hypertrack/{{QUICKSTART_REPOSITORY_NAME}}/pulls"

open-ios:
  open ios/quickstartexpo.xcworkspace

[working-directory: 'ios']
pod-install repo_update="false":
  #!/usr/bin/env sh
  set -euo pipefail

  rm -f Podfile.lock

  if [ "{{repo_update}}" = "true" ]; then
    pod install --repo-update
  else
    pod install
  fi

[private]
_prebuild flags="":
  npx expo prebuild {{flags}}

prebuild: _prebuild
prebuild-clean: (_prebuild "--clean")

prebuild-android: (_prebuild "--platform android")
prebuild-android-clean: (_prebuild "--platform android --clean")

prebuild-ios: (_prebuild "--platform ios")
prebuild-ios-clean: (_prebuild "--platform ios --clean")

reset-env:
  # remove-lock=true
  just clean true
  npm install
  just prebuild-clean
  just pod-install

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
  npm install --global expo-cli
  npm install
  just prebuild
  cd ios && pod install

start-metro flags="": compile
  npm start {{flags}}

start-metro-clean: (start-metro "-c")

update-react-native-sdk version: hooks
    git checkout -b update-sdk-{{version}}
    just add-plugin {{version}}
    git commit -am "Update HyperTrack SDK React Native to {{version}}"
    just open-github-prs

version:
    @cat package.json | grep hypertrack-sdk-react-native | head -n 1 | grep -o -E '{{SEMVER_REGEX}}'

