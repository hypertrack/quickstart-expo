# Expo Quickstart for HyperTrack SDK

![GitHub](https://img.shields.io/github/license/hypertrack/quickstart-expo.svg)
HyperTrack React Native Plugin: ![HyperTrack React Native Plugin](https://img.shields.io/npm/v/hypertrack-sdk-react-native.svg) 
HyperTrack Expo Plugin: ![HyperTrack Expo Plugin](https://img.shields.io/npm/v/hypertrack-sdk-expo.svg) 
 
[HyperTrack](https://www.hypertrack.com/) lets you add live location tracking to your mobile app. Live location is made available along with ongoing activity, tracking controls and tracking outage with reasons. 

This repo contains an example React Native app that has everything you need to get started.

For information about how to get started with React Native SDK, please check this [Guide](https://www.hypertrack.com/docs/install-sdk-react-native).

## How to get started?

### Create HyperTrack Account

[Sign up](https://dashboard.hypertrack.com/signup) for HyperTrack and get your publishable key from the [Setup page](https://dashboard.hypertrack.com/setup).

### Clone Quickstart app

### Install Dependencies

Run
- `yarn`

### Update the publishable key

Insert your HyperTrack publishable key to `const PUBLISHABLE_KEY` in `App.tsx`

### [Set up silent push notifications](https://hypertrack.com/docs/install-sdk-expo/#set-up-silent-push-notifications)

HyperTrack SDK needs Firebase Cloud Messaging to manage on-device tracking as well as enable using HyperTrack cloud APIs from your server to control the tracking.

- For iOS, to enable push notifcations you need to add [push notifications credentials](https://docs.expo.dev/app-signing/managed-credentials/#ios)
- For Android, to enable push notifcations you need to use [FCM for Push Notifications](https://docs.expo.dev/push-notifications/using-fcm/)

### Run the app

[Build and run the app with Expo EAS build](https://docs.expo.dev/build/setup/)

### Enable permissions

Enable location and activity permissions (choose "Always Allow" for location).

### Start tracking

Press `Start tracking` button.

To see the device on a map, open the [HyperTrack dashboard](https://dashboard.hypertrack.com/).

## Support

Join our [Slack community](https://join.slack.com/t/hypertracksupport/shared_invite/enQtNDA0MDYxMzY1MDMxLTdmNDQ1ZDA1MTQxOTU2NTgwZTNiMzUyZDk0OThlMmJkNmE0ZGI2NGY2ZGRhYjY0Yzc0NTJlZWY2ZmE5ZTA2NjI) for instant responses. You can also email us at help@hypertrack.com
