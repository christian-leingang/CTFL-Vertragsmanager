# ctfl_vertragsmanager

## Installation

Download the Flutter SDK from [Get Started](https://docs.flutter.dev/get-started/install)
and unzip it into the desired location (not in a directory with elevated privileges like "C:\Program Files\")

Update the path environment variable like [this](https://docs.flutter.dev/get-started/install/windows#update-your-path)

Run `flutter doctor` in your terminal. Here you can check which steps you have to take

Download and install [Android Studio](https://developer.android.com/studio), then launch it

Go to "more actions" -> SDK manager.
Make sure you have checked those elements like here (if not check and install them):
![image](https://user-images.githubusercontent.com/40596710/145706245-e87d3424-03bd-49cc-b1ed-4ff754054205.png)

Go to "more actions" -> AVD manager. Create a new virtual device. At step 2 you have to download the Android version 11.

At the end you have to run the following command:

```
flutter doctor --android-licenses
```

Say yes to all of them.

To make sure everything is working, run `flutter doctor` again.

### Todos

- Verträge mit Listview.builder generieren
- Sprache ändern: https://stackoverflow.com/questions/61529343/how-to-change-language-of-show-date-picker-in-flutter
