import bodyParser from 'body-parser';
import { object, number, string, TypeOf } from 'zod';

const payload = {
  body: object({
    name: string({
      required_error: 'Vertragsname is required',
    }),
    //   labelName: string({
    //     required_error: "Label-Name is required",
    //   }),
    //   labelColor: string({
    //     required_error: "Label-Color is required",
    //   }),
    //   images: string({
    //     required_error: "Images required",
    //   }),
    //   description: string({
    //     required_error: "Description is required",
    //   }).min(120, "Description should be at least 120 characters long"),
    //   intervall: string({
    //     required_error: "Price is required",
    //   }),
    //   beitrag: number({
    //     required_error: "Price is required",
    //   }),
    //   vertragsBeginn: string({
    //     required_error: "Vertragsbeginn is required",
    //   }),
    //   vertragsEnde: string({
    //     required_error: "Vertragsbeginn is required",
    //   }),
    //   kuendigungsfrist: string({
    //     required_error: "Kündigungsfrist is required",
    //   }),
    //   erstZahlung: string({
    //     required_error: "Erstzahlung is required",
    //   }),
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
