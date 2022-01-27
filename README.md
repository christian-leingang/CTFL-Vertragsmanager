# <img src="https://user-images.githubusercontent.com/57496350/150943492-d3499ff5-fc92-4efc-a9ee-dcfc4ebab8e0.jpg" width="48"> CTFL-Vertragsmanager

## Über uns
Beim CTFL-Vertragsmanager handelt es sich um ein Projekt der Vorlesung [Mobile Applikationen](https://github.com/michael-spengler/Entwicklung-mobiler-applikationen-p-f). Die Vorlesung wird im 5. und 6. Semester des Studiengangs "Wirtschaftsinformatik - Software Engineering" gehalten. CTFL wird von [Levana Fallböhmer](https://github.com/Levana-Fallboehmer), [Tobias Hoffmann](https://github.com/tobiashoffmann) und [Christian Leingang](https://github.com/MrChrisse) entwickelt.

## Einleitung und Motivation
Der CTFL-Vertragsmanager soll dem Nutzer eine zentrale Plattform bieten, auf der er alle seine Verträge organisieren und verwalten kann. Dabei soll sich der Anwender von überall auf seinem Konto anmelden und seine Verträge abrufen können. Auf dem Smartphone besteht zusätzlich die Möglichkeit die Verträge auch offline einzusehen. 
Mit der Nutzung unserer App können unerwartet hohe Kosten wegen verpasster Fristen vermieden werden.

## Funktionen
### derzeit implementierte Funktionen
Die App umfasst die drei Hauptseiten "Verträge", "Kalender" und "Profil". Auf der "Verträgeseite" werden alle angelegten Verträge angezeigt. Hier können außerdem neue Verträge angelegt und bestehende Verträge bearbeitet oder gelöscht werden. Mit Klick auf einen Vertrag öffnet sich die Detailansicht und zusätzliche Informationen können eingesehen werden. Der Kalender bietet eine Übersicht über alle in den Verträgen hinterlegten Daten. Das Profil stellt eine klassische Übersicht über die Nutzerdaten zur verfügung und ermöglich unter anderem das Bearbeiten und löschen der Logindaten.

### zukünftig geplante Funktionen
In einem ersten Schritt sollen zukünftig Popup- und E-Mail-Benachrichtigungen für die im Kalender hinterlegten Daten realisiert werden. Auch sollen die Verträge auf der "Verträge"-Seite nach verschiedenen Kriterien sortiert und gefiltert werden können. Zusätzlich soll es dem Nutzer möglich sein die original Vertragsunterlagen an den Vertrag anzuhängen. In einem weiteren Schritt soll der in der App enthaltene Kalender exportiert und so in den Hauptkalender des Nutzers integriert werden können.
Zusätzlich soll einen neuen Vertrag durch das einscannen der Vertragsunterlagen generieren werden können. Des weiteren soll es eine Anbindung an Vergleichsplattformen geben um aktuelle Verträge zu optimieren.
Um die Sicherheit der App zu erhöhen soll außerdem das Passwort bereits im Frontend gehashed werden. Außerdem soll die Passwortrücksetzung implementiert werden.

## Design
Uns war es wichtig, dass die App über ein einfaches, ansprechendes und einheitliches Design verfügt. Aus diesem Grund haben wir ein klickbares Modell in [Figma](https://www.figma.com/) erstellt. Dieses ist unter folgendem [Link](https://www.figma.com/proto/tNzzgoQMN49njU15ywjfPN/Design-CTFL-Vertragsmanager?node-id=5%3A5&scaling=scale-down&page-id=0%3A1&starting-point-node-id=5%3A5) zu finden.
Das von uns verwendete Logo haben wir mit [Hatchful](https://hatchful.shopify.com/de/) designed.


## Umsetzung
## I. Frontend
### Allgemeine Anforderungen und Entscheidungen
Von Anfang an war es uns wichtig, dass die App von überall aus zugängig ist und der Nutzer von allen ihm zu verfügung stehenden Geräten an jedem Ort auf seine Verträge zugreifen kann. Aus diesem Grund haben wir uns entschieden eine plattformunabhängige App zu schreiben. Um dem Nutzer auch eine offline-Version für das Smartphone liefern zu können, war es uns zusätzlich wichtig eine native App, die im App-Store heruntergeladen werden kann, anzubieten. Das Framework, welches diese Anforderung unserer Meinung nach am Besten erfüllt, ist [Flutter](https://flutter.dev/). Zusätzlich bietet [pub.dev](https://pub.dev/) eine Vielzahl von Packages um die Programmierung zu erleichtern. Bei Flutter handelt es sich um ein sehr modernes Entwicklungstool welches eine große Community bietet und viele Probleme und Themen in offenen Diskussion behandelt. Auch die Dokumentation der im Framework enthaltenen Funktionen ist zentral über folgenden [Link](https://docs.flutter.dev/development/ui/widgets) erreichbar und sehr ausführlich. Zusätzlich ist eine einfache Integration der auf [Google Fonts](https://fonts.google.com) zur Verfügung stehenden Elemente, wie Schriftarten oder Icons, möglich. 

### Flutter
Das Frontend wird in [Flutter](https://flutter.dev/) implementiert. Flutter ermöglicht es den Entwicklern Apps für alle Plattformen und Bildschirmgrößen aus einer Codebasis zu generieren. Das vereinfacht und verschnellert den Entwicklungsprozess, da nur diese eine Codebasis entwickelt werden muss. Durch die Integration von Android Studio kann das Verhalten der App auf einem echten Smartphone simuliert werden. Die Anleitung zur Installation ist [hier](https://docs.flutter.dev/get-started/install) verlinkt.

### Packages
Die Webseite [pub.dev](https://pub.dev/) bietet eine große Unterstützung für Flutter-Projekte. Hier können EntwicklerInnen eigenentwickelte Widgets oder Packages in Form von Packages der Allgemeinheit zur Verfügung stellen. Auf diese Weise können viele Appkomponenten übernommen werden und müssen nicht von jedem/r EntwicklerIn neu implementiert werden.
Wir haben für das Frontend des CTFL-Vertragsmanagers folgende Packages genutzt:
- [table_calendar 3.0.3](https://pub.dev/packages/table_calendar)
- [flutter_launcher_icons 0.9.2](https://pub.dev/packages/flutter_launcher_icons)
- [flutter_native_splash 1.3.3](https://pub.dev/packages/flutter_native_splash)
- [introduction_screen 2.1.0](https://pub.dev/packages/introduction_screen)
- [flutter_login 3.1.0](https://pub.dev/packages/flutter_login)
- [path_provider 2.0.8](https://pub.dev/packages/path_provider)
- [http 0.13.4](https://pub.dev/packages/http)
- [dropdown_plus 0.0.9](https://pub.dev/packages/dropdown_plus)
- [hive 2.0.5](https://pub.dev/packages/hive)
- [hive_flutter 1.1.0](https://pub.dev/packages/hive_flutter)
- [provider 6.0.2](https://pub.dev/packages/provider)
- [datetime_picker_formfield 2.0.0](https://pub.dev/packages/datetime_picker_formfield)

### Lokale Hive Datenbank
Bei [Hive](https://pub.dev/packages/hive) handelt es sich um Package in [pub.dev](https://pub.dev/) welches eine lokale Datenbank auf einem Endgerät erstellt und verwaltet. Wir haben in dieser Datenbank die angelegten Verträge und Labels abgespeichert. Auf diese Weise kann sich der Nutzer auch ohne Internetverbindung seine Verträge anschauen. Das Erstellen, Bearbeiten und Löschen von Verträgen ist im offline-Modus jedoch nicht möglich. Beim Starten der App wird die Hive-Datenbank mit den Daten aus dem Backend abgeglichen und aktualisiert. Zur Applaufzeit werden die Verträge aus der Hive-Datenbank angezeigt. Ein Zugriff auf das Backend erfolgt dann nur noch bei Erstellen, Bearbeiten und Löschen von Verträgen bzw bei Veränderung der Login-Daten.

## II. Backend
Als Laufzeitumgebung wird im Backend NodeJS verwendet. Der Grund dafür ist vor allem die vielzahl an bereits verfügbaren Modulen und die bereits gesammelte Erfahrung der Projektteilnehmer. 
Das Backend wird in TypeScript implementiert. Dies dient zur Weiterbildung, da bisher noch kein Backend in TypeScript implementiert wurde. Die von Microsoft entwickelte Programmiersprache TypeScript ist eine Obermenge von JavaScript und ergänzt somit JS mit weiteren Funktionen. Des Weiteren wurden eine Vielzahl von Frameworks und Libraries zur Umsetzung verwendet:
* Express
* Mongoose
* Zod
* bcrypt
* Json Web Token

### Express
[Express](http://expressjs.com/) ist ein einfaches, flexibles und zugleich das beliebteste NodeJS Framework, welches zahlreiche Features und Funktionen für Webanwendungen und mobile Anwendungen bereitstellt. Die Verwendung von Express ermöglicht somit die effizientere Entwicklung von REST-API's. 
### MongoDB / Mongoose
Um Daten Geräteübergreifend für den Nutzer bereitstellen zu können, bedarf es dem Backend an einer Datenbank. Dazu wurde eine [MongoDB](https://www.mongodb.com/de-de) verwendet.
Das zugehörige NodeJS Framework ist [Mongoose](https://mongoosejs.com/). Mongoose vereinfacht den Zugriff und die Objektmodellierung in einer MongoDB. 
### Zod
Um Daten in einer MongoDB zu speichern, wird mit Hilfe von Mongoose ein Schema für das Objekt angelegt. Dort werden beispielsweise die Attribute des Objekts defininiert. Die Library [Zod](https://github.com/colinhacks/zod) dient zur Schema validation. In unserem Backend wird Zod als Middleware verwendet, um fehlerhafte und unvollständige JSON Objects aus dem Frontend abzufangen.
### bcrypt
bcryptjs ist eine Library für JavaScript, um Passwörter zu ver- und entschlüsseln. Passwörter werden vor dem Speichern in der Datenbank mit SHA256 verschlüsselt und als Hash-Wert gespeichert. Zur Password validation bei der Anmeldungen werden nicht die Passwörter, sondern die entsprechenden Hash-Werte miteinander verglichen.
### Json Web Token (JWT)
JSon Web Tokens ermöglichen den Austausch von verifizierbaren Claims. Es wird in einer REST-API typischerweise zur An- und Abmeldung verwendet. Dabei werden Access- und Refreshtokens generiert, die den Nutzer zur Anmeldung verifizieren.

### Verfügbare API - Calls
```typescript
app.post('/api/users', validateResource(createUserSchema), createUserHandler); //Registrieren
app.post('/api/sessions', validateResource(createSessionSchema), createUserSessionHandler); //Einloggen
app.get('/api/sessions', requireUser, getUserSessionsHandler); //Aktive Sessions returnen
app.delete('/api/sessions', requireUser, deleteSessionHandler); //Ausloggen
app.post('/api/products', [requireUser, validateResource(createProductSchema)], createProductHandler); //Vertrag anlegen
app.put('/api/products/:productId', [requireUser, validateResource(updateProductSchema)], updateProductHandler); //Vertrag bearbeiten
app.get('/api/products/:productId', validateResource(getProductSchema), getProductHandler); //Vertrag abrufen
app.delete('/api/products/:productId', [requireUser, validateResource(deleteProductSchema)], deleteProductHandler); //Vertrag löschen
app.post('/api/labels', validateResource(createLabelSchema), createLabelHandler); //Label anlegen
app.get('/api/labels', getLabelHandler); //ALLE labels returnen
app.get('/api/productsUser/:userId', validateResource(getProductByIDSchema), getProductByUserIDHandler); //ALLE Verträge eines Users returnen
 app.get('/healthcheck', (req: Request, res: Response) => res.sendStatus(200)); //Check ob Server läuft
```

## IV. Organisation
Wir haben bereits öfter im Rahmen von Hochschulprojekten zusammengearbeitet und haben daher bereits einen Discor-Server den wir für die Kommunikation nutzen.
In einem ersten Schritt haben wir die gewünschten Features in einem [Github Project](https://github.com/MrChrisse/CTFL-Vertragsmanager/projects/1) festgehalten, organisiert und priorisiert.
Dann haben wir uns in ein Frondend- und ein Backend-Team unterteilt und in einer ersten Phase getrennt voneinander entwickelt. Die Entwicklungsphasen haben wir als Pair-Programming mit Live-Share gestaltet. Als im Backend eine funktionsfähige Datenbank bereitstand und im Frontend die ersten Modells standen, haben wir uns wieder zusammengesetzt und festgelegt, was in der Datenbank gespeichert werden soll. 
Im Anschluss hat das Backend-Team die entsprechenden API-Calls bereitgestellt und Frontend-Team weitere Masken entwickelt. 
Zuletzt haben wir gemeinsam die Datenbankfunktionen an das Frontend angebunden.
