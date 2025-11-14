import { Request, Response } from 'express';
import { QueryResult } from 'pg';
import pool from '../config/db';

const checkIfAdmin = async (adminID: number) => {
    try {
        const query = 'SELECT is_admin FROM users WHERE id = $1';
        
        const result = await pool.query(query, [adminID]);

        if (result.rows.length > 0) {
            const isAdmin = result.rows[0].is_admin;
            
            return isAdmin === 1 || isAdmin === true;
        } else {
            return false;
        }

    } catch (error) {
        return false;
    }
};

export const getOrganisationAdmin = async (req: Request, res: Response) => {
    const orgId = parseInt(req.params.orgId);
    const adminId = parseInt(req.params.adminId);
    if (await checkIfAdmin(parseInt(req.params.adminId))){
        try {
            const result = await pool.query('SELECT * FROM users WHERE organisation_id = $1 AND id = $2', [orgId, adminId]);
            res.json(result.rows);
        } catch (error: any) {
            console.error('Error fetching admin:', error);
            res.status(500).json({ error: 'Internal server error' });
        }
    }
    else {
        res.status(403).json({ error: 'Not admin!' });
    }
};

export const getOrganisationDetails = async (req: Request, res: Response) => {
    const orgId = parseInt(req.params.orgId);
    if (await checkIfAdmin(parseInt(req.params.adminId))){
        try {
            const result = await pool.query('SELECT * FROM organisation WHERE id = $1', [orgId]);
            res.json(result.rows);
        } catch (error: any) {
            console.error('Error fetching organisation details:', error);
            res.status(500).json({ error: 'Internal server error' });
        }
    }
    else {
        res.status(403).json({ error: 'Not admin!' });
    }
};

export const getAllUsers = async (req: Request, res: Response) => {
    const orgId = req.params.orgId;
    
    if (await checkIfAdmin(parseInt(req.params.adminId))){
        try {
            const result = await pool.query('SELECT * FROM users WHERE organisation_id = $1', [orgId]);
            res.json(result.rows);
        } catch (error: any) {
            console.error('Error fetching users:', error);
            res.status(500).json({ error: 'Internal server error' });
        }
    }
    else {
        res.status(403).json({ error: 'Not admin!' });
    }
};

export const getAllSOPs = async (req: Request, res: Response) => {
    const orgId = req.params.orgId;
    if (await checkIfAdmin(parseInt(req.params.adminId))){
        try {
            const result = await pool.query('SELECT * FROM sop WHERE organisation_id = $1', [orgId]);
            res.json(result.rows);
        } catch (error: any) {
            console.error('Error fetching SOPs:', error);
            res.status(500).json({ error: 'Internal server error' });
        }
    }
    else {
        res.status(403).json({ error: 'Not admin!' });
    }
};

export const getAllSOPTasks = async (req: Request, res: Response) => {
    const orgId = req.params.orgId;
    const sopId = req.params.sopId;
    if (await checkIfAdmin(parseInt(req.params.adminId))){
        try {
            const result = await pool.query('SELECT * FROM sop_task WHERE organisation_id = $1 AND sop_id = $2', [orgId, sopId]);
            res.json(result.rows);
        } catch (error: any) {
            console.error('Error fetching SOPs:', error);
            res.status(500).json({ error: 'Internal server error' });
        }
    }
    else {
        res.status(403).json({ error: 'Not admin!' });
    }
};

export const getAllActiveSOPs = async (req: Request, res: Response) => {
    const orgId = req.params.orgId;
    if (await checkIfAdmin(parseInt(req.params.adminId))){
        try {
            const result = await pool.query('SELECT * FROM active_sop WHERE organisation_id = $1', [orgId]);
            res.json(result.rows);
        } catch (error: any) {
            console.error('Error fetching SOPs:', error);
            res.status(500).json({ error: 'Internal server error' });
        }
    }
    else {
        res.status(403).json({ error: 'Not admin!' });
    }
};

export const getAllActiveSOPTasks = async (req: Request, res: Response) => {
    const orgId = req.params.orgId;
    const sopId = req.params.sopId;
    if (await checkIfAdmin(parseInt(req.params.adminId))){
        try {
            const result = await pool.query('SELECT * FROM active_sop_task WHERE organisation_id = $1 AND sop_id = $2', [orgId, sopId]);
            res.json(result.rows);
        } catch (error: any) {
            console.error('Error fetching SOPs:', error);
            res.status(500).json({ error: 'Internal server error' });
        }
    }
    else {
        res.status(403).json({ error: 'Not admin!' });
    }
};

export const getAllProjects = async (req: Request, res: Response) => {
    const orgId = req.params.orgId;
    if (await checkIfAdmin(parseInt(req.params.adminId))){
        try {
            const result = await pool.query('SELECT * FROM projects WHERE organisation_id = $1', [orgId]);
            res.json(result.rows);
        } catch (error: any) {
            console.error('Error fetching projects:', error);
            res.status(500).json({ error: 'Internal server error' });
        }
    }
    else {
        res.status(403).json({ error: 'Not admin!' });
    }
};

export const getAllInventory = async (req: Request, res: Response) => {
    const orgId = req.params.orgId;
    if (await checkIfAdmin(parseInt(req.params.adminId))){
        try {
            const result = await pool.query('SELECT * FROM inventory_item WHERE organisation_id = $1', [orgId]);
            res.json(result.rows);
        } catch (error: any) {
            console.error('Error fetching inventory:', error);
            res.status(500).json({ error: 'Internal server error' });
        }
    }
    else {
        res.status(403).json({ error: 'Not admin!' });
    }
};

export const getItemInventoryRental = async (req: Request, res: Response) => {
    const orgId = req.params.orgId;
    const ItemId = req.params.itemId;
    if (await checkIfAdmin(parseInt(req.params.adminId))){
        try {
            const result = await pool.query('SELECT * FROM inventory_rental WHERE organisation_id = $1 AND item_id = $2', [orgId, ItemId]);
            res.json(result.rows);
        } catch (error: any) {
            console.error('Error fetching inventory:', error);
            res.status(500).json({ error: 'Internal server error' });
        }
    }
    else {
        res.status(403).json({ error: 'Not admin!' });
    }
};