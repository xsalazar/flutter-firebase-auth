# Using Firebase Authentication in Flutter

A Flutter project meant to demonstrate simple usage outline for Firebase.

## Getting Started

Reference the following packages in your [pubspec.yaml](pubspec.yaml):
- [google_sign_in](https://pub.dev/packages/google_sign_in)
- [firebase_auth](https://pub.dev/packages/firebase_auth)

Ensure you have a [Firebase](https://firebase.google.com/) account as well as a project for this example. Go through the process of registering your application as well as downloading the .json file to your project.

## Firebase Settings
Under the authentication tab, enable at least one 'sign-in method'. This example uses both Google and email/password authentication.

In order to use Google authentication, ensure you have **both** a support email defined and debug SHA certificate fingerprints registered. These can both be set in the project settings.

### Generating Debug SHA certificate fingerprints
Through a terminal follow the instructions [here](https://developers.google.com/android/guides/client-auth) to retrieve the **debug** certificate fingerprints.

```console
$ keytool -list -v -alias androiddebugkey -keystore ~\.android\debug.keystore
```

Note the default password is: **android**

## Example
### Home Screen
<img src="https://i.imgur.com/RLrri5X.jpg" width=300>

### Google Authentication
<img src="https://i.imgur.com/3IyP3GA.jpg" width=300>

### Logged in Screen
<img src="https://i.imgur.com/egJTROq.jpg" width=300>

### Email Account Creation/Authentication
<img src="https://i.imgur.com/pwBjMXg.jpg" width=300>

### Firebase Console
<img src="https://i.imgur.com/6nvVCy4.png" width=600>

## References
Code snippets taken from the included packages example docs