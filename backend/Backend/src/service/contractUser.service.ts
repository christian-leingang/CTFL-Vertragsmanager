import { FilterQuery, QueryOptions, UpdateQuery } from 'mongoose';
import contractModel, { contractDocument } from '../models/contract.model';

export async function getAllcontractsByUserID(query: FilterQuery<contractDocument>){
    var toprint = query;
    //console.log(toprint);
    try{
        const contracts = await contractModel.find(query);
        return contracts;
    }catch(e){
        throw e;
    }
}
