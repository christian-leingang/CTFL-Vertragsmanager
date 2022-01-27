import { Request, Response } from "express";
import {
  CreateLabelInput,
  ReadLabelInput,
} from "../schema/label.schema";
import {
  createLabel,
  getAllLabels
} from "../service/label.service";

export async function createLabelHandler(
  req: Request<CreateLabelInput["body"]>,
  res: Response
) {

    const body = req.body;
    const label = await createLabel({ ...body});
    return res.send(label);
}
  


export async function getLabelHandler(
    req: Request<ReadLabelInput>,
    res: Response
  ) {
    
    const label = await getAllLabels();
  
    if (!label) {
      return res.sendStatus(404);
    }
    return res.send(label);
}