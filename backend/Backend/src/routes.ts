import { Express, Request, Response } from 'express';
import { createLabelHandler, getLabelHandler } from './controller/label.controller';
import {
  createProductHandler,
  getProductHandler,
  updateProductHandler,
  deleteProductHandler,
  getProductByUserIDHandler,
} from './controller/product.controller';
import {
  createUserSessionHandler,
  getUserSessionsHandler,
  deleteSessionHandler,
} from './controller/session.controller';
import { createUserHandler } from './controller/user.controller';
import requireUser from './middleware/requireUser';
import validateResource from './middleware/validateResource';
import { createLabelSchema, getLabelSchema } from './schema/label.schema';
import {
  createProductSchema,
  deleteProductSchema,
  getProductSchema,
  updateProductSchema,
} from './schema/product.schema';
import { getProductByIDSchema } from './schema/productUser.model';
import { createSessionSchema } from './schema/session.schema';
import { createUserSchema } from './schema/user.schema';

function routes(app: Express) {
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
  
}

export default routes;
