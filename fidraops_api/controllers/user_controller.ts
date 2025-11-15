import { Request, Response } from 'express';
import { QueryResult } from 'pg';
import pool from '../config/db';

const checkIfUser = async (userID: number) => {
    try {
        const query = 'SELECT is_admin FROM users WHERE id = $1';
        
        const result = await pool.query(query, [userID]);

        if (result.rows.length > 0) {
            const isAdmin = result.rows[0].is_admin;
            
            return isAdmin === 0 || isAdmin === false;
        } else {
            return false;
        }

    } catch (error) {
        return false;
    }
};

export const getUser = async (req: Request, res: Response) => {
    const userId = parseInt(req.params.userId);

    if (await checkIfUser(userId)) {
        try {
            const result: QueryResult = await pool.query('SELECT * FROM users WHERE id = $1', [userId]);
            if (result.rows.length === 0) {
                return res.status(404).json({ error: 'User not found' });
            }
            res.json(result.rows[0]);
        } catch (error: any) {
            console.error('Error fetching user:', error);
            res.status(500).json({ error: 'Internal server error' });
        }
    } else {
        res.status(403).json({ error: 'Not a valid user!' });
    }
};

export const getAllActiveAssignedSOPs = async (req: Request, res: Response) => {
    const userId = parseInt(req.params.userId);

    if (await checkIfUser(userId)) {
        try {
            const result: QueryResult = await pool.query('SELECT * FROM active_sop WHERE status IN (0, 1) AND CAST($1 AS TEXT) = ANY(string_to_array(users_id, \',\'))', [userId]);
            res.json(result.rows);
        } catch (error: any) {
            console.error('Error fetching user:', error);
            res.status(500).json({ error: 'Internal server error' });
        }
    } else {
        res.status(403).json({ error: 'Not a valid user!' });
    }
};

export const getActiveAssignedSOPTasks = async (req: Request, res: Response) => {
    const userId = parseInt(req.params.userId);
    const sopId = parseInt(req.params.sopId);

    if (await checkIfUser(userId)) {
        try {
            const result: QueryResult = await pool.query('SELECT * FROM active_sop_task WHERE sop_id = $1', [sopId]);
            res.json(result.rows);
        } catch (error: any) {
            console.error('Error fetching user:', error);
            res.status(500).json({ error: 'Internal server error' });
        }
    } else {
        res.status(403).json({ error: 'Not a valid user!' });
    }
};

export const getInventoryOfAssignedActiveSOP = async (req: Request, res: Response) => {
    const userId = parseInt(req.params.userId);
    const intemsIdArray = req.params.itemsIdArray.split(',').map((id: string) => parseInt(id));

    if (await checkIfUser(userId)) {
        try {
            const result: QueryResult = await pool.query('SELECT * FROM inventory_item WHERE id = ANY($1)',[intemsIdArray]);
            res.json(result.rows);
        } catch (error: any) {
            console.error('Error fetching user:', error);
            res.status(500).json({ error: 'Internal server error' });
        }
    } else {
        res.status(403).json({ error: 'Not a valid user!' });
    }
};