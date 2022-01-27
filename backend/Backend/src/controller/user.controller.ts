import { Request, Response } from "express";
import { omit } from "lodash";
import { CreateUserInput, DeleteUserInput } from "../schema/user.schema";
import { createUser, deleteUser } from "../service/user.service";
import logger from "../utils/logger";

export async function createUserHandler(
  req: Request<{}, {}, CreateUserInput["body"]>,
  res: Response
) {
  try {
    const user = await createUser(req.body);
    return res.send(user);
  } catch (e: any) {
    logger.error(e);
    return res.status(409).send(e.message);
  }
}

/*export async function deleteUserHandler(
  req: Request<DeleteUserInput["params"]>,
  res: Response
) {
  try {
    const user = await deleteUser(req.body);
    return res.send(user);
  } catch (e: any) {
    logger.error(e);
    return res.status(409).send(e.message);
  }
}
*/
