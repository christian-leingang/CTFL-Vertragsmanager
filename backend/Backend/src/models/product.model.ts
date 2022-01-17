import mongoose from 'mongoose';
import { customAlphabet } from 'nanoid';
import { UserDocument } from './user.model';
//import Label from "../enums/label";
//import Intervall from "../enums/intervall";

const nanoid = customAlphabet('abcdefghijklmnopqrstuvwxyz0123456789', 10);

export interface ProductInput {
  user: UserDocument["_id"];
  labelName: string;
  labelColor: string;
  images: String;
  description: string;
  intervall: string;
  beitrag: number;
  vertragsBeginn: string;
  vertragsEnde: string;
  kuendigungsfrist: string;
  erstZahlung: string;
}

export interface ProductDocument extends ProductInput, mongoose.Document {
  createdAt: Date;
  updatedAt: Date;
}

const productSchema = new mongoose.Schema(
  {
    productId: {
      type: String,
      required: true,
      unique: true,
      default: () => `product_${nanoid()}`,
    },
    user: { type: mongoose.Schema.Types.ObjectId, ref: 'User' },
    labelName: { type: String, required: false },
    labelColor: { type: String, required: false },
    description: { type: String, required: false },
    intervall: { type: String, required: false },
    beitrag: { type: Number, required: false },
    vertragsBeginn: { type: String, required: false },
    vertragsEnde: { type: String, required: false },
    kuendigungsfrist: { type: String, required: false },
    erstZahlung: { type: String, required: false },
  },
  {
    timestamps: true,
  }
);

const ProductModel = mongoose.model<ProductDocument>('Product', productSchema);
export default ProductModel;
