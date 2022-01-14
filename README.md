# CTFL-Vertragsmanager

## Über uns
Beim CTFL-Vertragsmanager handelt es sich um ein Projekt der Vorlesung [Mobile Applikationen](https://github.com/michael-spengler/Entwicklung-mobiler-applikationen-p-f). Die Vorlesung wird im 5. Semester des Studiengangs "Wirtschaftsinformatik - Software Engineering" gehalten. CTFL wird von [Levana Fallböhmer](https://github.com/Levana-Fallboehmer), [Tobias Hoffmann](https://github.com/tobiashoffmann), [Christian Leingang](https://github.com/MrChrisse) und [Florian Schmitt](https://github.com/Fl0rianSchmitt) entwickelt.


## CTFL-Vertragsmanager
### Einleitung und Motivation
Der CTFL-Vertragsmanager soll dem Nutzer eine detaillierte Übersicht über seine Verträge geben. Verträge sollen dabei vom Nutzer selbst hinzugefügt werden können. Dies kann per Ausfüllen eines Formulars oder dem hochladen der Vertrags-PDF geschehen.
Angelegte Verträge können sortiert, bearbeitet und gelöscht werden. Zusätzlich sollen per Pop-Up Nachricht oder Mails Erinnerungen über Kündigungsfristen, Vertragsenden und Zahlungstagen an den Nutzer gesendet werden. 

## Umsetzung
## I. Frontend
### Flutter
### Packages
### Lokale Hive Datenbank
Das Frontend wird in [Flutter](https://flutter.dev/) implementiert.

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
