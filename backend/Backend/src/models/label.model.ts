import mongoose from "mongoose";

export interface LabelInput {
  labelName: String;
  labelColor: String;
}

export interface LabelDocument extends LabelInput, mongoose.Document {
  createdAt: Date;
  updatedAt: Date;
}

const labelSchema = new mongoose.Schema(
  {
    labelName: { type: String, required: true},
    labelColor: { type: String, required: true}
  },
  {
    timestamps: true,
  }
);

const labelModel = mongoose.model<LabelDocument>("label", labelSchema);
export default labelModel;
