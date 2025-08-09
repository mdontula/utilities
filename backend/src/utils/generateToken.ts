import jwt from 'jsonwebtoken';

export const generateToken = (id: string): string => {
  const secret = process.env.JWT_SECRET || 'fallback-secret';
  
  return jwt.sign({ id }, secret, { 
    expiresIn: process.env.JWT_EXPIRE || '7d' 
  } as any);
};
