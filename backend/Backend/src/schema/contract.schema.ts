import { object, number, string, TypeOf } from 'zod';

const payload = {
  body: object({
    name: string({
      required_error: 'Vertragsname is required',
    }),
    beitrag: number({
      required_error: "Price is required",
    }),
  }),
};

const params = {
  params: object({
    contractId: string({
      required_error: 'contractId is required',
    }),
  }),
};

export const createcontractSchema = object({
  ...payload,
});

export const updatecontractSchema = object({
  ...payload,
  ...params,
});

export const deletecontractSchema = object({
  ...params,
});

export const getcontractSchema = object({
  ...params,
});

export type CreatecontractInput = TypeOf<typeof createcontractSchema>;
export type UpdatecontractInput = TypeOf<typeof updatecontractSchema>;
export type ReadcontractInput = TypeOf<typeof getcontractSchema>;
export type DeletecontractInput = TypeOf<typeof deletecontractSchema>;
