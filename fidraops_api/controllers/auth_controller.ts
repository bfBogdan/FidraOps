import { Request, Response } from 'express';
import bcrypt from "bcrypt";
import { QueryResult } from 'pg';
import pool from '../config/db';

export const getToken = async (req: Request, res: Response) => {
  try {
      const response = await fetch('https://dev-a2ewfek815vado31.us.auth0.com/oauth/token', {
        method: 'POST',
        headers: { 'content-type': 'application/json' },
        body: JSON.stringify({
          "client_id":"gnzNv6d4Rm9IApJsXLzfjN198oIK56U5",
          "client_secret":"4h_cRvTStbqsfroxzkOkIXkxven8Nq968oT6HE7AUcvyn9yo3zV3yCTOJmJS-3MB",
          "audience":"https://dev-a2ewfek815vado31.us.auth0.com/api/v2/",
          "grant_type":"client_credentials"
        }),
      });

      if (!response.ok) {
          res.status(500).json({ error: 'Internal server error' });
          //throw new Error('Network response was not ok');
      }

      const data = await response.json();
      res.json(data);
  } catch (_error) {
      res.status(403).json({ error: _error});
  }
};