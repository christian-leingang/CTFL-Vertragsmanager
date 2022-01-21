import { FilterQuery, QueryOptions, UpdateQuery } from "mongoose";
import contractModel, {
  contractDocument,
  contractInput,
} from "../models/contract.model";


export async function createcontract(input: contractInput) {
  try {
    const result = await contractModel.create(input);
    return result;
  } catch (e) {
    throw e;
  }
}

export async function findcontract(
  query: FilterQuery<contractDocument>,
  options: QueryOptions = { lean: true }
) {
  try {
    const result = await contractModel.findOne(query, {}, options);
    return result;
  } catch (e) {
    throw e;
  }
}

export async function findAndUpdatecontract(
  query: FilterQuery<contractDocument>,
  update: UpdateQuery<contractDocument>,
  options: QueryOptions
) {
  return contractModel.findOneAndUpdate(query, update, options);
}

export async function deletecontract(query: FilterQuery<contractDocument>) {
  return contractModel.deleteOne(query);
}
