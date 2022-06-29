import { object, string, TypeOf } from 'zod';

export const createUserSchema = object({
  body: object({
    password: string({
      required_error: 'Name is required',
    }).min(6, 'Password too short - should be 6 chars minimum'),
    email: string({
      required_error: 'email is required',
    }).email('Not a valid email'),
  }),
});

export const deleteUserSchema = object({
  body: object({
    email: string({
      required_error: 'email is required',
    }),
    password: string({
      required_error: 'email is required',
    }),
  }),
});

export const forgotPasswordSchema = object({
  body: object({
    email: string({
      required_error: 'email is required',
    }),
    passwordClear: string({
      required_error: 'password is required',
    }),
    passwordHashed: string({
      required_error: 'hashed password is required',
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
    }).min(6, 'Password too short - should be 6 chars minimum'),
    passwordConfirmation: string({
      required_error: "password confirmation is required",
    }).min(6, 'Password too short - should be 6 chars minimum'),
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
export type forgotPasswordInput = TypeOf<typeof forgotPasswordSchema>;