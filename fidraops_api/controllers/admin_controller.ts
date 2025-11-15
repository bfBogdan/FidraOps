import { Request, Response } from 'express';
import bcrypt from "bcrypt";
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

const generatePassword = (length = 6) => {
    const chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    let pass = "";
    for (let i = 0; i < length; i++) {
        pass += chars.charAt(Math.floor(Math.random() * chars.length));
    }
    return pass;
};

export const createUser = async (req: Request, res: Response) => {
    const orgId = parseInt(req.params.orgId);
    const adminId = parseInt(req.params.adminId);

    // get from body
    const { name, email } = req.body;

    const generatedPass = generatePassword(6);

    // Hash the password
    const hashed_pass = await bcrypt.hash(generatedPass, 10);

    if (!(await checkIfAdmin(adminId))) {
        return res.status(403).json({ error: "Not admin!" });
    }

    try {
        const result = await pool.query(
            `INSERT INTO users (name, email, password, organisation_id) VALUES ($1, $2, $3, $4) RETURNING *`, [name, email, hashed_pass, orgId]
        );

        res.status(201).json({ message: "User created", project: result.rows[0] });

    } catch (error: any) {
        console.error("Error creating user:", error);
        res.status(500).json({ error: "Internal server error" });
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

export const getProjectSOPs = async (req: Request, res: Response) => {
    const orgId = req.params.orgId;
    const projectId = req.params.projectId;
    if (await checkIfAdmin(parseInt(req.params.adminId))){
        try {
            const result = await pool.query('SELECT * FROM sop WHERE organisation_id = $1 AND project_id = $2', [orgId, projectId]);
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

export const createProject = async (req: Request, res: Response) => {
    const orgId = parseInt(req.params.orgId);
    const adminId = parseInt(req.params.adminId);

    // get from body
    const { title, description } = req.body;

    if (!(await checkIfAdmin(adminId))) {
        return res.status(403).json({ error: "Not admin!" });
    }

    try {
        const result = await pool.query(
            `INSERT INTO projects (title, description, organisation_id) VALUES ($1, $2, $3) RETURNING *`, [title, description, orgId]
        );

        res.status(201).json({ message: "Project created", project: result.rows[0] });

    } catch (error: any) {
        console.error("Error creating project:", error);
        res.status(500).json({ error: "Internal server error" });
    }
};

export const deleteProject = async (req: Request, res: Response) => {
    const orgId = parseInt(req.params.orgId);
    const adminId = parseInt(req.params.adminId);
    const projectId = parseInt(req.params.projectId);

    if (!(await checkIfAdmin(adminId))) {
        return res.status(403).json({ error: "Not admin!" });
    }

    try {
        const result = await pool.query(
            `DELETE FROM projects WHERE id = $1 AND organisation_id = $2 RETURNING *`, [projectId, orgId]
        );

        if (result.rowCount === 0) {
            return res.status(404).json({ error: "Project not found or not in this organisation" });
        }

        res.json({ message: "Project deleted", deletedProject: result.rows[0] });

    } catch (error: any) {
        console.error("Error deleting project:", error);
        res.status(500).json({ error: "Internal server error" });
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

export const createInventoryProduct = async (req: Request, res: Response) => {
    const orgId = parseInt(req.params.orgId);
    const adminId = parseInt(req.params.adminId);

    // get from body
    const { title, quantity } = req.body;

    if (!(await checkIfAdmin(adminId))) {
        return res.status(403).json({ error: "Not admin!" });
    }

    try {
        const result = await pool.query(
            `INSERT INTO inventory_item (title, quantity, organisation_id) VALUES ($1, $2, $3) RETURNING *`, [title, quantity, orgId]
        );

        res.status(201).json({ message: "Project created", project: result.rows[0] });

    } catch (error: any) {
        console.error("Error creating project:", error);
        res.status(500).json({ error: "Internal server error" });
    }
};

export const updateInventoryProduct = async (req: Request, res: Response) => {
    const orgId = parseInt(req.params.orgId);
    const adminId = parseInt(req.params.adminId);
    const productId = parseInt(req.params.productId);

    if (!(await checkIfAdmin(adminId))) {
        return res.status(403).json({ error: "Not admin!" });
    }

    const fields = req.body;

    if (Object.keys(fields).length === 0) {
        return res.status(400).json({ error: "No fields provided to update" });
    }

    const setClauses = [];
    const values = [];
    let index = 1;

    for (const [key, value] of Object.entries(fields)) {
        setClauses.push(`${key} = $${index}`);
        values.push(value);
        index++;
    }
    values.push(productId);
    values.push(orgId);

    const query = `UPDATE inventory_item SET ${setClauses.join(", ")} WHERE id = $${index} AND organisation_id = $${index + 1} RETURNING *`;

    try {
        const result = await pool.query(query, values);

        if (result.rowCount === 0) {
            return res.status(404).json({ error: "Inventory item not found in this organisation" });
        }

        res.json({ message: "Inventory item updated", project: result.rows[0] });

    } catch (error: any) {
        console.error("Error updating inventory item:", error);
        res.status(500).json({ error: "Internal server error" });
    }
};

export const deleteInventoryProduct = async (req: Request, res: Response) => {
    const orgId = parseInt(req.params.orgId);
    const adminId = parseInt(req.params.adminId);
    const productId = parseInt(req.params.productId);

    if (!(await checkIfAdmin(adminId))) {
        return res.status(403).json({ error: "Not admin!" });
    }

    try {
        const result = await pool.query(
            `DELETE FROM inventory_item WHERE id = $1 AND organisation_id = $2 RETURNING *`, [productId, orgId]
        );

        if (result.rowCount === 0) {
            return res.status(404).json({ error: "Inventory item not found or not in this organisation" });
        }

        res.json({ message: "Inventory item deleted", deletedProject: result.rows[0] });

    } catch (error: any) {
        console.error("Error deleting inventory item:", error);
        res.status(500).json({ error: "Internal server error" });
    }
};