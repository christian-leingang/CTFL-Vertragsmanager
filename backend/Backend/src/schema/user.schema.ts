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

export type CreateUserInput = TypeOf<typeof createUserSchema>;
export type DeleteUserInput = TypeOf<typeof deleteUserSchema>;
