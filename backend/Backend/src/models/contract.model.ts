import mongoose from 'mongoose';
import { customAlphabet } from 'nanoid';
import { UserDocument } from './user.model';

const nanoid = customAlphabet('abcdefghijklmnopqrstuvwxyz0123456789', 10);

export interface contractInput {
  userId: UserDocument['_id'];
  name: string;
  beitrag: number;
}

export interface contractDocument extends contractInput, mongoose.Document {
  createdAt: Date;
  updatedAt: Date;
}

const contractSchema = new mongoose.Schema(
  {
    contractId: {
      type: String,
      required: true,
      unique: true,
      default: () => `contract_${nanoid()}`,
    },
    userId: { type: mongoose.Schema.Types.ObjectId, ref: 'User' },
    name: { type: String, required: true },
    vertragspartner: { type: String, required: false },
    labelName: { type: String, required: false },
    description: { type: String, required: false },
    intervall: { type: String, required: false },
    beitrag: { type: Number, required: true },
    vertragsBeginn: { type: String, required: false },
    vertragsEnde: { type: String, required: false },
    kuendigungsfrist: { type: String, required: false },
    erstZahlung: { type: String, required: false },
    PDFTitel: {type: String, required: false},
    PDFUrl: {type: String, required: false},
  },
  {
    timestamps: true,
  }
);

const contractModel = mongoose.model<contractDocument>('contract', contractSchema);
export default contractModel;
