import { FilterQuery, QueryOptions, UpdateQuery } from "mongoose";
import LabelModel, {
  LabelDocument,
  LabelInput,
} from "../models/label.model";

export async function createLabel(input: LabelInput) {
  try {
    const result = await LabelModel.create(input);
    return result;
  } catch (e) {
    throw e;
  }
}

export async function getAllLabels(){
    var labels = {};
    try {
        labels = await LabelModel.find();
        return labels;
      } catch (e) {
        throw e;
    }
}