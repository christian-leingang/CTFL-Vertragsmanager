# CTFL-Vertragsmanager

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

### Design
Uns war es wichtig, dass die App über ein einfaches, ansprechendes und einheitliches Design verfügt. Aus diesem Grund haben wir ein klickbares Modell in [Figma](https://www.figma.com/) erstellt. Dieses ist unter folgendem [Link] (https://www.figma.com/proto/tNzzgoQMN49njU15ywjfPN/Design-CTFL-Vertragsmanager?node-id=5%3A5&scaling=scale-down&page-id=0%3A1&starting-point-node-id=5%3A5) zu finden.

## Umsetzung
## I. Frontend
### Allgemeine Anforderungen und Entscheidungen
Von Anfang an war es uns wichtig, dass die App von überall aus zugängig ist und der Nutzer von allen ihm zu verfügung stehenden Geräten an jedem Ort auf seine Verträge zugreifen kann. Aus diesem Grund haben wir uns entschieden eine plattformunabhängige App zu schreiben. Um dem Nutzer auch eine offline-Version für das Smartphone liefern zu können, war es uns zusätzlich wichtig eine native App, die im App-Store heruntergeladen werden kann, anzubieten. Das Framework, welches diese Anforderung unserer Meinung nach am Besten erfüllt, ist [Flutter](https://flutter.dev/). Zusätzlich bietet [pub.dev](https://pub.dev/) eine Vielzahl von Packages um die Programmierung zu erleichtern. Bei Flutter handelt es sich um ein sehr modernes Entwicklungstool welches eine große Community bietet und viele Probleme und Themen in offenen Diskussion behandelt. Auch die Dokumentation der im Framework enthaltenen Funktionen ist zentral über folgenden [Link] (https://docs.flutter.dev/development/ui/widgets) erreichbar und sehr ausführlich. Zusätzlich ist eine einfache Integration der auf [Google Fonts] (https://fonts.google.com) zur Verfügung stehenden Elemente, wie Schriftarten oder Icons, möglich. 

### Flutter
Das Frontend wird in [Flutter](https://flutter.dev/) implementiert.

### Packages

### Lokale Hive Datenbank


## II. Backend
Als Laufzeitumgebung wird im Backend NodeJS verwendet. Der Grund dafür ist vor allem die vielzahl an bereits verfügbaren Modulen und die bereits gesammelte Erfahrung der Projektteilnehmer.
Das Backend wird in TypeScript implementiert. Dies dient zur Weiterbildung, da bisher noch kein Backend in TypeScript implementiert wurde.
### Benutzte Frameworks und Libraries
* Express
* Mongoose
* Zod
* bcrypt
* Json Web Token
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

#### III. Design
Um das Design der App zu entwickeln und in Mockups darzustellen, wird das Online UI-Tool [Figma](https://www.figma.com/) verwendet.
##### Figma
##### Hatchful

#### IV. Organisation

### Features

#### umgestetzte Features

#### Backlog
