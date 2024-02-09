# Expo Quickstart for HyperTrack SDK

[![GitHub](https://img.shields.io/github/license/hypertrack/quickstart-expo?color=orange)](./LICENSE)
[![hypertrack-sdk-expo](https://img.shields.io/badge/hypertrack_sdk_expo-4.1.0-brightgreen.svg)](https://github.com/hypertrack/sdk-expo)
[![hypertrack-sdk-react-native](https://img.shields.io/badge/hypertrack_sdk_react_native-13.1.0-brightgreen.svg)](https://github.com/hypertrack/sdk-react-native)

[HyperTrack](https://www.hypertrack.com/) lets you add live location tracking to your mobile app. Live location is made available along with ongoing activity, tracking controls and tracking outage with reasons.

This repo contains an example React Native app that has everything you need to get started.

For information about how to get started with React Native SDK, please check this [Guide](https://www.hypertrack.com/docs/install-sdk-react-native).

## How to get started?

### Create HyperTrack Account

[Sign up](https://dashboard.hypertrack.com/signup) for HyperTrack and get your publishable key from the [Setup page](https://dashboard.hypertrack.com/setup).

### Clone Quickstart app

### Setup the project

- `npm install`
- `npx expo prebuild`
- `npx pod-install`

### Set your publishable key

Set your HyperTrack publishable key in `app.json` as the value for `publishableKey` (search project for `Paste_your_publishable_key_here` if you don't see it)

### Setup silent push notifications

Push notification setup depends on the workflow of your choosing.

#### Managed workflow

HyperTrack SDK needs Firebase Cloud Messaging to manage on-device tracking as well as enable using HyperTrack cloud APIs from your server to control the tracking.

- For iOS, to enable push notifcations you need to add [push notifications credentials](https://docs.expo.dev/app-signing/managed-credentials/#ios)
- For Android, to enable push notifcations you need to use [FCM for Push Notifications](https://docs.expo.dev/push-notifications/using-fcm/)

#### Bare workflow

Follow the instructions on setting up silent push notifications [in our docs](https://hypertrack.com/docs/install-sdk-expo/#set-up-silent-push-notifications).

HyperTrack SDK needs Firebase Cloud Messaging and APNS to manage on-device tracking as well as enable using HyperTrack cloud APIs from your server to control the tracking.

### Run the app

Depending on your workflow you'll want to run the project in following ways:

- managed: [build and run the app with Expo EAS build](https://docs.expo.dev/build/setup/)
- bare:
  - android: `npx expo run:android`
  - ios: `npx expo run:ios`

### Enable permissions

Enable location and activity permissions (choose "Always Allow" for location).

### Start tracking

Press `Start tracking` button.

To see the device on a map, open the [HyperTrack dashboard](https://dashboard.hypertrack.com/).

## Support

Join our [Slack community](https://join.slack.com/t/hypertracksupport/shared_invite/enQtNDA0MDYxMzY1MDMxLTdmNDQ1ZDA1MTQxOTU2NTgwZTNiMzUyZDk0OThlMmJkNmE0ZGI2NGY2ZGRhYjY0Yzc0NTJlZWY2ZmE5ZTA2NjI) for instant responses. You can also email us at help@hypertrack.com
