
import { object, string, TypeOf} from "zod";


const params = {
  params: object({
    userId: string({
      required_error: "userId is required",
    }),
  }),
};


export const getcontractByIDSchema = object({
  ...params,
});


export type ReadcontractIDInput = TypeOf<typeof getcontractByIDSchema>;

