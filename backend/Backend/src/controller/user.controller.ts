import { Request, Response } from "express";
import { omit } from "lodash";
import contractModel from "../models/contract.model";
import { UserDocument } from "../models/user.model";
import { changePasswordInput, CreateUserInput, DeleteUserInput } from "../schema/user.schema";
import { deletecontract } from "../service/contract.service";
import { getAllcontractsByUserID } from "../service/contractUser.service";
import { changePassword, createUser, deleteUser, findUser } from "../service/user.service";
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
    var userContracts: any[] = [];
    console.log("Übergebene Email:" + email);
    console.log("Übergebenes Passwort:" + password)
    const user = await findUser({email});
    const userIdAny = user?.id;
    const userId = String(userIdAny);
    console.log("Passwort in Datenbank:" + user?.password)
    if (!user) {
      return res.sendStatus(404);
    }
    const isValid = await user.comparePassword(password);
    console.log("Gültiges Passwort:" + isValid);
    userContracts = await getAllcontractsByUserID({userId});
    console.log(userContracts);
    if(isValid){
      for(const contract of userContracts){
        await deletecontract(contract);
        console.log(contract.contractId);
      }
      await deleteUser({ email });
      return res.send(user);
    }
    return res.sendStatus(404);
    
  } catch (e: any) {
    logger.error(e);
    return res.status(409).send(e.message);
  }
}

export async function changePasswordHandler(req: Request<changePasswordInput['params']>, res: Response) {
  const oldPassword = req.body.oldPassword;
  const newPassword = req.body.password;
  const passwordConfirmation = req.body.passwordConfirmation;
  const email = req.params.email;
  const update = req.body;
  const user = await findUser({ email });
  console.log(update);
  if (!user) {
    return res.sendStatus(404);
  }
  console.log(user);
  const isValid = await user.comparePassword(oldPassword);
  console.log(isValid);
  if(!isValid){
    return res.sendStatus(404);
  }
  if(newPassword != passwordConfirmation){
    return res.sendStatus(404);
  }
  const updatedUser = await changePassword({ email }, update, {
    new: true,
  });
  console.log(updatedUser);
  return res.send(updatedUser);
}




