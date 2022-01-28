import { FilterQuery, QueryOptions, UpdateQuery } from "mongoose";
import contractModel, {
  contractDocument,
} from "../models/contract.model";

export async function getAllcontractsByUserID(query: FilterQuery<contractDocument>){
    var contract = {}
    var toprint = query;
    console.log(toprint);
    try{
        contract = await contractModel.find(query);
        return contract;
    }catch(e){
        throw e;
    }
}