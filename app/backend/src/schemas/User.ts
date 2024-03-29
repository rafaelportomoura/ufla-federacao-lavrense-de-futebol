import Joi from 'joi';

const password = Joi.string().min(8).max(64);
const user_email = Joi.string().regex(/[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?/);
const codigo = Joi.number().min(0).max(999999);

export const post_user = Joi.object().keys({
  email: user_email.required(),
  password: password.required(),
});

export const login_user = Joi.object().keys({
  email: user_email.required(),
  password: password.required(),
});

export const change_password = Joi.object().keys({
  email: user_email.required(),
  password: password.required(),
});

export const reset_password = Joi.object().keys({
  email: user_email.required(),
  password: password.required(),
  codigo: codigo.required(),
});