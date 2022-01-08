import { object, number, string, TypeOf, date } from "zod";
//import Label from "../enums/label";

const payload = {
  body: object({
    label: string({
      required_error: "Label is required",
    }),
    description: string({
      required_error: "Description is required",
    }).min(120, "Description should be at least 120 characters long"),
    intervall: string({
      required_error: "Price is required",
    }),
    beitrag: number({
      required_error: "Price is required",
    }),
    vertragsBeginn: string({
      required_error: "Vertragsbeginn is required",
    }),
    vertragsEnde: string({
      required_error: "Vertragsbeginn is required",
    }),
    kuendigungsfrist: string({
      required_error: "Kündigungsfrist is required",
    }),
    erstZahlung: string({
      required_error: "Erstzahlung is required",
    }),
    naechsteZahlung: string({
      required_error: "Nächste Zahlung is required",
    }),
  }),
};

const params = {
  params: object({
    userId: string({
      required_error: "userId is required",
    }),
  }),
};





export const getProductUserSchema = object({
  ...params,
});


export type ReadProductInput = TypeOf<typeof getProductUserSchema>;

