import { Request, Response } from 'express';
import { QueryResult } from 'pg';
import pool from '../config/db';

export const getAllUsers = async (req: Request, res: Response) => {
    const orgId = req.params.orgId;

    try {
        const result = await pool.query('SELECT * FROM users WHERE organisation_id = $1', [orgId]);
        res.json(result.rows);
    } catch (error: any) {
        console.error('Error fetching users:', error);
        res.status(500).json({ error: 'Internal server error' });
    }
};

export const getAllSOPs = async (req: Request, res: Response) => {
    const orgId = req.params.orgId;
    try {
        const result = await pool.query('SELECT * FROM sop WHERE organisation_id = $1', [orgId]);
        res.json(result.rows);
    } catch (error: any) {
        console.error('Error fetching SOPs:', error);
        res.status(500).json({ error: 'Internal server error' });
    }
};

export const getAllSOPTasks = async (req: Request, res: Response) => {
    const orgId = req.params.orgId;
    const sopId = req.params.sopId;
    try {
        const result = await pool.query('SELECT * FROM sop_task WHERE organisation_id = $1 AND sop_id = $2', [orgId, sopId]);
        res.json(result.rows);
    } catch (error: any) {
        console.error('Error fetching SOPs:', error);
        res.status(500).json({ error: 'Internal server error' });
    }
};

export const getAllProjects = async (req: Request, res: Response) => {
    const orgId = req.params.orgId;
    try {
        const result = await pool.query('SELECT * FROM projects WHERE organisation_id = $1', [orgId]);
        res.json(result.rows);
    } catch (error: any) {
        console.error('Error fetching projects:', error);
        res.status(500).json({ error: 'Internal server error' });
    }
};

export const getAllWorkFlows = async (req: Request, res: Response) => {
    const orgId = req.params.orgId;
    try {
        const result = await pool.query('SELECT * FROM workflow WHERE organisation_id = $1', [orgId]);
        res.json(result.rows);
    } catch (error: any) {
        console.error('Error fetching workflows:', error);
        res.status(500).json({ error: 'Internal server error' });
    }
};

export const getAllWorkFlowTasks = async (req: Request, res: Response) => {
    const orgId = req.params.orgId;
    try {
        const result = await pool.query('SELECT * FROM workflow_task WHERE organisation_id = $1', [orgId]);
        res.json(result.rows);
    } catch (error: any) {
        console.error('Error fetching workflows:', error);
        res.status(500).json({ error: 'Internal server error' });
    }
};

export const getWorkOrder = async (req: Request, res: Response) => {
    const orgId = req.params.orgId;
    const projectId = req.params.projectId;
    try {
        const result = await pool.query('SELECT * FROM work_order WHERE organisation_id = $1', [orgId]);
        res.json(result.rows);
    } catch (error: any) {
        console.error('Error fetching workflows:', error);
        res.status(500).json({ error: 'Internal server error' });
    }
};

export const getAllInventory = async (req: Request, res: Response) => {
    const orgId = req.params.orgId;
    try {
        const result = await pool.query('SELECT * FROM inventory_item WHERE organisation_id = $1', [orgId]);
        res.json(result.rows);
    } catch (error: any) {
        console.error('Error fetching inventory:', error);
        res.status(500).json({ error: 'Internal server error' });
    }
};

export const getAllInventoryRental = async (req: Request, res: Response) => {
    const orgId = req.params.orgId;
    const ItemId = req.params.itemId;
    try {
        const result = await pool.query('SELECT * FROM inventory_rental WHERE organisation_id = $1 AND item_id = $2', [orgId, ItemId]);
        res.json(result.rows);
    } catch (error: any) {
        console.error('Error fetching inventory:', error);
        res.status(500).json({ error: 'Internal server error' });
    }
};