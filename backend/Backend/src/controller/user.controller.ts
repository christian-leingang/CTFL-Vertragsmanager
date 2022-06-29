import { Request, Response } from "express";
import { changePasswordInput, CreateUserInput, DeleteUserInput } from "../schema/user.schema";
import { deletecontract } from "../service/contract.service";
import { getAllcontractsByUserID } from "../service/contractUser.service";
import { changePassword, createUser, deleteUser, findUser } from "../service/user.service";
import logger from "../utils/logger";
import bcrypt from 'bcrypt';
import config from 'config';
import { sendMail } from "../utils/mailer";

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
  const salt = await bcrypt.genSalt(config.get<number>('saltWorkFactor'));
  if (!user) {
    return res.sendStatus(404);
  }
  const isValid = await user.comparePassword(oldPassword);
  console.log(isValid);
  if(!isValid){
    return res.sendStatus(404);
  }
  if(newPassword != passwordConfirmation){
    return res.sendStatus(404);
  }
  console.log(update.password);
  update.password = await bcrypt.hashSync(update.password, salt);
  console.log(update.password);
  const updatedUser = await changePassword({ email }, update, {
    new: true,
  });
  console.log(updatedUser);
  return res.send(updatedUser);
}

export async function forgotPasswordHandler(
  req: Request<DeleteUserInput["body"]>,
  res: Response
){
  try{
    const email = req.body.email;
    const update = req.body;
    const passwordClear = req.body.passwordClear;
    const passwordHashed = req.body.passwordHashed;
    const salt = await bcrypt.genSalt(config.get<number>('saltWorkFactor'));
    const user = await findUser({email});
    if (!user) {
      return res.sendStatus(404);
    }
    console.log(update.password);
    update.password = await bcrypt.hashSync(passwordHashed, salt);
    const updatedUser = await changePassword({ email }, update, {
      new: true,
    });
    console.log(update.password);
    const emailText = `Das Passwort wurde auf ${passwordClear} zurückgesetzt. Bitte das Passwort sofort ändern!`;
    await sendMail(emailText, email);
    return res.send(updatedUser);
  } catch (e: any){
    logger.error(e);
    return res.send(409).send(e.message);
  }
  
}



