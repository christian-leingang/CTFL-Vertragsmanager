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

- Themes erstellen (Dark, Light, change mit themeMode), Color constants
- leere Felder in Details nicht anzeigen
- Package intl einbauen, um mehrere Sprachen zu unterstützen
- um kompletten Screen auszufüllen in "leeren" Bereich Spacer() nutzen
- Github Actions einrichten
- Sprache ändern: https://stackoverflow.com/questions/61529343/how-to-change-language-of-show-date-picker-in-flutter

## Nützliche Tipps

(aus [diesem Video](https://www.youtube.com/watch?v=5vDq5DXXxss))

### Wichtig (!)

- 23 SplashScreen ! (Startscreen für 1 sec)
- 22 Snackbar ! (als Info nach Erstellen/Löschen eines neuen Vertrags, floating möglich; alternativ auch Toast möglich)
- 9 Google Fonts ! (für DHBW sinnvoll, ändern der Schrift mit package google_fonts)
- 4 Null-Aware Operator ! (Anzeige von alternativen Text, falls Variable null ist)
- 2 LauncherIcon ! (Anpassung des LauncherIcons)
- Package Signature (zum Erstellen einer Unterschrift)

### Nice to have / evtl. benötigt (?)

- 30 IntruductionScreen ? (für DHBW ja, für CTFL evtl)
- 28/27 Flexible/Expanded ? (passt Größe an, wie flex in WebDev)
- 26 Circle Avatar ? (runder Border um Bild, inkl. Backgroundcolor)
- 25 Wrap ? (wie Row, nur mit Zeilenumbruch)
- 21 Visibility ? (kann ein Element ein/ausblenden)
- 20 Spread Operator ? (Objekte direkt in Parent einfügen mit "...", anstatt ein Widget zu erstellen)
- 19/18 StatusBar/NavBar Color ? (transparent: StatusBar bekommt z.B. Farbe der NavBar)
- 16 SafeArea ? (um zu verhindern, dass Inhalt am Rand verschwindet)
- 15 ClipRRect ? (um roundedCorners einzufügen, bei Container lieber BoxDecoration nehmen)
- 13 Future Builder ? (zeigt für gewissen Zeitraum ein Ladescreen an, für Backend)
- 11 Platform Checking ? (Boolean, ob Gerät Android ist (Platform.isAndroid))
- 10 MediaQuery ? (Rückgabe des Bildschirmdimensionen in Pixel)
- 8 Selectable Text ? (Text, markierbar machen)
- 7 Hero ? (sorgt dafür, dass Bild bei Screenwechsel animiert wird, wie Morph bei PowerPoint)
- 3 Lint ? (statische Codeanalyse): Auto-fix: `dart fix --apply`

### Spielerei / keine Anwendung gesehen (/)

- 29 RichText / (weitere Anpassungen der Schrift)
- 24 FittedBox / (passt Childgröße an Parent an)
- 17 Body behind AppBar /
- 14 SliverAppBar / (bewirkt, dass AppBar beim Scrollen ausgeblendet wird)
- 12 Cupertino /
- 6 Animated Icon / (Animation, um Icon zu wechseln)
- 5 Animated Container / (Spielzeug)
- 1 Interactive / (Macht Widget zoombar)
