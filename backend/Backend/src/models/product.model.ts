import mongoose from "mongoose";
import { customAlphabet } from "nanoid";
import { UserDocument } from "./user.model";
//import Label from "../enums/label";
//import Intervall from "../enums/intervall";

const nanoid = customAlphabet("abcdefghijklmnopqrstuvwxyz0123456789", 10);

export interface ProductInput {
  /* OLD FORMAT
  title: string;
  description: string;
  price: number;
  image: string; */
  user: UserDocument["_id"];
  label: string;
  description: string;
  intervall: string;
  beitrag: number;
  vertragsBeginn: string;
  vertragsEnde: string;
  kuendigungsfrist: string;
  erstZahlung: string;
  naechsteZahlung: string;
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
    user: { type: mongoose.Schema.Types.ObjectId, ref: "User" },
    label: { type: String, required: true },
    description: { type: String, required: true },
    intervall: { type: String, required: true },
    beitrag: { type: Number, required: true },
    vertragsBeginn: { type: String, required: true},
    vertragsEnde: { type: String, required: true},
    kuendigungsfrist: { type: String, required: true},
    erstZahlung: { type: String, required: true},
    naechsteZahlung: { type: String, required: true},
  },
  {
    timestamps: true,
  }
);

const ProductModel = mongoose.model<ProductDocument>("Product", productSchema);
export default ProductModel;
