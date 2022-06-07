import { object, string, TypeOf } from 'zod';

export const createUserSchema = object({
  body: object({
    password: string({
      required_error: 'Name is required',
    }).min(6, 'Password too short - should be 6 chars minimum'),
    email: string({
      required_error: 'Email is required',
    }).email('Not a valid email'),
  }),
});

export const deleteUserSchema = object({
  body: object({
    email: string({
      required_error: 'email is required',
    }),
    password: string({
      required_error: 'Email is required',
    }),
  }),
});

const payload = {
  body: object({
    oldPassword: string({
      required_error: 'old password is required',
    }),
    password: string({
      required_error: "password is required",
    }),
    passwordConfirmation: string({
      required_error: "password confirmatio is required",
    }),
  }),
};

const params = {
  params: object({
    email: string({
      required_error: 'email is required',
    }),
  }),
};

export const changePasswordSchema = object({
  ...payload,
  ...params,
});

export type CreateUserInput = TypeOf<typeof createUserSchema>;
export type DeleteUserInput = TypeOf<typeof deleteUserSchema>;
export type changePasswordInput = TypeOf<typeof changePasswordSchema>;
