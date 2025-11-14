import { Router } from 'express';
import * as adminController from '../controllers/admin_controller';

const router = Router({ mergeParams: true });

// - users endpoints -
router.get("/:orgId/getUsers", adminController.getAllUsers);

// - sop endpoints -
router.get("/:orgId/getSOPs", adminController.getAllSOPs);
router.get("/:orgId/:sopId/getSOPTasks", adminController.getAllSOPTasks);

// - projects endpoints -
router.get("/:orgId/getProjects", adminController.getAllProjects);

// - workflows endpoints -
router.get("/:orgId/getWorkFlows", adminController.getAllWorkFlows);
router.get("/:orgId/:workflowId/getWorkFlowTasks", adminController.getAllWorkFlowTasks);
router.get("/:orgId/getWorkOrder", adminController.getWorkOrder);

// - inventory endpoints -
router.get("/:orgId/getInventory", adminController.getAllInventory);
router.get("/:orgId/itemId/getInventoryRental", adminController.getAllInventoryRental);

export default router;