
import { object, string, TypeOf} from "zod";
//import Label from "../enums/label";

const params = {
  params: object({
    userId: string({
      required_error: "userId is required",
    }),
  }),
};


export const getProductByIDSchema = object({
  ...params,
});


export type ReadProductIDInput = TypeOf<typeof getProductByIDSchema>;

