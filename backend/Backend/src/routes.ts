import { Express, Request, Response } from 'express';
import { createLabelHandler, getLabelHandler } from './controller/label.controller';
import {createcontractHandler,getcontractHandler,updatecontractHandler,deletecontractHandler,getcontractByUserIDHandler} from './controller/contract.controller';
import {createUserSessionHandler,getUserSessionsHandler,deleteSessionHandler} from './controller/session.controller';
import { changePasswordHandler, createUserHandler, deleteUserHandler } from './controller/user.controller';
import requireUser from './middleware/requireUser';
import validateResource from './middleware/validateResource';
import { createLabelSchema, getLabelSchema } from './schema/label.schema';
import {createcontractSchema,deletecontractSchema,getcontractSchema,updatecontractSchema} from './schema/contract.schema';
import { getcontractByIDSchema } from './schema/contractUser.model';
import { createSessionSchema } from './schema/session.schema';
import { changePasswordSchema, createUserSchema, deleteUserSchema } from './schema/user.schema';

function routes(app: Express) {
  app.post('/api/users', validateResource(createUserSchema), createUserHandler); //Registrieren
  app.post('/api/deleteUsers', validateResource(deleteUserSchema), deleteUserHandler); 
  app.put('/api/changePassword/:email', validateResource(changePasswordSchema), changePasswordHandler); //Passwort ändern
  app.post('/api/sessions', validateResource(createSessionSchema), createUserSessionHandler); //Einloggen
  app.get('/api/sessions', requireUser, getUserSessionsHandler); //Aktive Sessions returnen
  app.delete('/api/sessions', requireUser, deleteSessionHandler); //Ausloggen
  app.post('/api/contracts', [requireUser, validateResource(createcontractSchema)], createcontractHandler); //Vertrag anlegen
  app.put('/api/contracts/:contractId', [requireUser, validateResource(updatecontractSchema)], updatecontractHandler); //Vertrag bearbeiten
  app.get('/api/contracts/:contractId', validateResource(getcontractSchema), getcontractHandler); //Vertrag abrufen
  app.delete('/api/contracts/:contractId',[requireUser, validateResource(deletecontractSchema)],deletecontractHandler); //Vertrag löschen
  app.post('/api/labels', validateResource(createLabelSchema), createLabelHandler); //Label anlegen
  app.get('/api/labels', getLabelHandler); //ALLE labels returnen
  app.get('/api/contractsUser/:userId', validateResource(getcontractByIDSchema), getcontractByUserIDHandler); //ALLE Verträge eines Users returnen
  app.get('/healthcheck', (req: Request, res: Response) => res.sendStatus(200)); //Check ob Server läuft
}

export default routes;
