import { Request, Response } from "express";
import {
  CreatecontractInput,
  UpdatecontractInput,
} from "../schema/contract.schema";
import { ReadcontractIDInput } from "../schema/contractUser.model";
import {
  createcontract,
  deletecontract,
  findAndUpdatecontract,
  findcontract,
} from "../service/contract.service";
import { getAllcontractsByUserID } from "../service/contractUser.service";

export async function createcontractHandler(
  req: Request<{}, {}, CreatecontractInput["body"]>,
  res: Response
) {
  const userId = res.locals.user._id;
  const body = req.body;
  const contract = await createcontract({ ...body, userId: userId });
  return res.send(contract);
}

export async function updatecontractHandler(
  req: Request<UpdatecontractInput["params"]>,
  res: Response
) {
  const userId = res.locals.user._id;
  const contractId = req.params.contractId;
  const update = req.body;
  const contract = await findcontract({ contractId });

  if (!contract) {
    return res.sendStatus(404);
  }

  if (String(contract.userId) !== userId) {
    return res.sendStatus(403);
  }

  const updatedcontract = await findAndUpdatecontract({ contractId }, update, {
    new: true,
  });

  return res.send(updatedcontract);
}

export async function getcontractHandler(
  req: Request<UpdatecontractInput["params"]>,
  res: Response
) {
  const contractId = req.params.contractId;
  const contract = await findcontract({ contractId });

  if (!contract) {
    return res.sendStatus(404);
  }

  return res.send(contract);
}

export async function getcontractByUserIDHandler(
  req: Request<ReadcontractIDInput["params"]>,
  res: Response
) {
  
  const userId = req.params.userId;
  console.log(userId);
  const contract = await getAllcontractsByUserID({ userId });

  if (!contract) {
    return res.sendStatus(404);
  }
  console.log(contract)
  return res.send(contract); 
}

export async function deletecontractHandler(
  req: Request<UpdatecontractInput["params"]>,
  res: Response
) {
  const userId = res.locals.user._id;
  const contractId = req.params.contractId;

  const contract = await findcontract({ contractId });

  if (!contract) {
    return res.sendStatus(404);
  }

  if (String(contract.userId) !== userId) {
    return res.sendStatus(403);
  }

  await deletecontract({ contractId });

  return res.sendStatus(200);
}
