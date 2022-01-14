import { FilterQuery, QueryOptions, UpdateQuery } from "mongoose";
import ProductModel, {
  ProductDocument,
} from "../models/product.model";

export async function getAllProductsByUserID(query: FilterQuery<ProductDocument>){
    var contract = {}
    try{
        contract = await ProductModel.find(query);
        return contract;
    }catch(e){
        throw e;
    }
}