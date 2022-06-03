import { Request, Response } from "express";
import { omit } from "lodash";
import { CreateUserInput, DeleteUserInput } from "../schema/user.schema";
import { createUser, deleteUser, findUser } from "../service/user.service";
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

export async function deleteUserHandler(
  req: Request<DeleteUserInput["body"]>,
  res: Response
) {
  try {
    const email = req.body.email;
    const password = req.body.password;
    console.log("Übergebene Email:" + email);
    console.log("Übergebenes Passwort:" + password)
    const user = await findUser({email});
    console.log("Passwort in Datenbank:" + user?.password)
    if (!user) {
      return res.sendStatus(404);
    }
    const isValid = await user.comparePassword(password);
    console.log("Gültiges Passwort:" + isValid);
    if(isValid){
      await deleteUser({ email });
      return res.send(user);
    }
    return res.sendStatus(404);
    
  } catch (e: any) {
    logger.error(e);
    return res.status(409).send(e.message);
  }
}




