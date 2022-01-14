import { object, string, TypeOf} from "zod";

const payload = {
  body: object({
    labelName: string({
      required_error: "Label-Name is required",
    }),
    labelColor: string({
      required_error: "Label-Color is required",
    }),
  }),
};


export const createLabelSchema = object({
  ...payload,
});

export const getLabelSchema = object({
});

export type CreateLabelInput = TypeOf<typeof createLabelSchema>;
export type ReadLabelInput = TypeOf<typeof getLabelSchema>;

