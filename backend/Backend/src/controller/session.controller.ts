import { Request, Response } from 'express';
import config from 'config';
import { createSession, findSessions, updateSession } from '../service/session.service';
import { validatePassword } from '../service/user.service';
import { signJwt } from '../utils/jwt.utils';
import UserModel from '../models/user.model';

export async function createUserSessionHandler(req: Request, res: Response) {
  const user = await validatePassword(req.body);

  if (!user) {
    return res.status(401).send('Invalid email or password');
  }
  const session = await createSession(user._id, req.get('user-agent') || '');
  const accessToken = signJwt(
    { ...user, session: session._id },
    'accessTokenPrivateKey',
    { expiresIn: config.get('accessTokenTtl') } // 15 minutes,
  );

  const refreshToken = signJwt(
    { ...user, session: session._id },
    'refreshTokenPrivateKey',
    { expiresIn: config.get('refreshTokenTtl') } // 15 minutes
  );

  const email = req.body.email;
  const userWithId = await UserModel.findOne({ email });

  if (userWithId) {
    const userId = userWithId!._id;
    return res.send({ accessToken, refreshToken, userId });
  }
  return res.send({ accessToken, refreshToken });
}

export async function getUserSessionsHandler(req: Request, res: Response) {
  const userId = res.locals.user._id;
  const sessions = await findSessions({ user: userId, valid: true });
  return res.send(sessions);
}

export async function deleteSessionHandler(req: Request, res: Response) {
  const sessionId = res.locals.user.session;
  await updateSession({ _id: sessionId }, { valid: false });
  return res.send({
    accessToken: null,
    refreshToken: null,
  });
}
