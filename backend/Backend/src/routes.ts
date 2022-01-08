import { Express, Request, Response } from 'express';
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
import {
  createProductSchema,
  deleteProductSchema,
  getProductSchema,
  updateProductSchema,
} from './schema/product.schema';
import { getProductUserSchema } from './schema/productUser.schema';
import { createSessionSchema } from './schema/session.schema';
import { createUserSchema } from './schema/user.schema';

function routes(app: Express) {
  app.post('/api/users', validateResource(createUserSchema), createUserHandler);
  app.post('/api/sessions', validateResource(createSessionSchema), createUserSessionHandler);
  app.get('/api/sessions', requireUser, getUserSessionsHandler);
  app.delete('/api/sessions', requireUser, deleteSessionHandler);
  app.post('/api/products', [requireUser, validateResource(createProductSchema)], createProductHandler);
  app.put('/api/products/:productId', [requireUser, validateResource(updateProductSchema)], updateProductHandler);
  app.get('/api/products/:productId', validateResource(getProductSchema), getProductHandler);
  app.delete('/api/products/:productId', [requireUser, validateResource(deleteProductSchema)], deleteProductHandler);
  //app.get("/api/productsUser/:userId", validateResource(getProductUserSchema),getProductByUserIDHandler);
  app.get('/healthcheck', (req: Request, res: Response) => res.sendStatus(200));
}

export default routes;
