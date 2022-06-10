import { FilterQuery, QueryOptions, UpdateQuery } from "mongoose";
import { omit, update } from "lodash";
import UserModel, { UserDocument, UserInput } from "../models/user.model";

export async function createUser(input: UserInput) {
  try {
    const user = await UserModel.create(input);

    return omit(user.toJSON(), "password");
  } catch (e: any) {
    throw new Error(e);
  }
}

export async function validatePassword({
  email,
  password,
}: {
  email: string;
  password: string;
}) {
  const user = await UserModel.findOne({ email });

  if (!user) {
    return false;
  }

  const isValid = await user.comparePassword(password);

  if (!isValid) return false;

  return omit(user.toJSON(), "password");
}

export async function findUser(
  query: FilterQuery<UserDocument>,
  options: QueryOptions = { lean: true }
) {
  try {
    const result = await UserModel.findOne(query);
    return result;
  } catch (e) {
    throw e;
  }
}

export async function deleteUser(query: FilterQuery<UserDocument>) {
  return UserModel.deleteOne(query);
}

export async function changePassword(
  query: FilterQuery<UserDocument>,
  update: UpdateQuery<UserDocument>,
  options: QueryOptions
) {
  return UserModel.findOneAndUpdate(query, update, options);
}

