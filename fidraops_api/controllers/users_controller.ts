import { Request, Response } from 'express';
import { QueryResult } from 'pg';
import { User } from '../models/user.model';
import pool from '../config/db';

type GetAllUsersResponse = User[] | { error: string };
type GetAllSOPsResponse = any;

export const getAllUsers = async (req: Request<{ orgId: number }>, res: Response<GetAllUsersResponse>) => {
    const orgId = req.params.orgId;

    try {
        const result: QueryResult<User> = await pool.query('SELECT * FROM users WHERE organisation_id = $1', [orgId]);
        res.json(result.rows);
    } catch (error: any) {
        console.error('Error fetching users:', error);
        res.status(500).json({ error: 'Internal server error' });
    }
};

export const getAllSOPs = async (req: Request<{ orgId: number }>, res: Response) => {
    const orgId = req.params.orgId;
    try {
        const result: QueryResult = await pool.query('SELECT * FROM sops WHERE organisationId = $1', [orgId]);
        res.json(result.rows);
    } catch (error: any) {
        console.error('Error fetching SOPs:', error);
        res.status(500).json({ error: 'Internal server error' });
    }
};

export const getAllProjects = async (req: Request<{ orgId: number }>, res: Response) => {
    const orgId = req.params.orgId;
    try {
        const result: QueryResult = await pool.query('SELECT * FROM projects WHERE organisationId = $1', [orgId]);
        res.json(result.rows);
    } catch (error: any) {
        console.error('Error fetching projects:', error);
        res.status(500).json({ error: 'Internal server error' });
    }
};

export const getAllWorkFlows = async (req: Request<{ orgId: number }>, res: Response) => {
    const orgId = req.params.orgId;
    try {
        const result: QueryResult = await pool.query('SELECT * FROM workflows WHERE organisationId = $1', [orgId]);
        res.json(result.rows);
    } catch (error: any) {
        console.error('Error fetching workflows:', error);
        res.status(500).json({ error: 'Internal server error' });
    }
};

export const getAllInventory = async (req: Request<{ orgId: number }>, res: Response) => {
    const orgId = req.params.orgId;
    try {
        const result: QueryResult = await pool.query('SELECT * FROM inventory WHERE organisationId = $1', [orgId]);
        res.json(result.rows);
    } catch (error: any) {
        console.error('Error fetching inventory:', error);
        res.status(500).json({ error: 'Internal server error' });
    }
};
