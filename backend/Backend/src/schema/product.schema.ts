import { object, number, string, TypeOf, date } from "zod";
//import Label from "../enums/label";

const payload = {
  body: object({
    //Muss als String aus enum dann ausgelesen werden
    labelName: string({
      required_error: "Label-Name is required",
    }),
    labelColor: string({
      required_error: "Label-Color is required",
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
  }),
};

const params = {
  params: object({
    productId: string({
      required_error: "productId is required",
    }),
  }),
};

export const createProductSchema = object({
  ...payload,
});

export const updateProductSchema = object({
  ...payload,
  ...params,
});

export const deleteProductSchema = object({
  ...params,
});

export const getProductSchema = object({
  ...params,
});

export type CreateProductInput = TypeOf<typeof createProductSchema>;
export type UpdateProductInput = TypeOf<typeof updateProductSchema>;
export type ReadProductInput = TypeOf<typeof getProductSchema>;
export type DeleteProductInput = TypeOf<typeof deleteProductSchema>;
