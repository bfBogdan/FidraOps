import { Router } from 'express';
import * as adminController from '../controllers/admin_controller';

const router = Router({ mergeParams: true });

router.get("/:adminId/:orgId/getAdmin", adminController.getOrganisationAdmin);

router.get("/:adminId/:orgId/getOrganisationDetails", adminController.getOrganisationDetails);

// - users endpoints -
router.get("/:adminId/:orgId/getUsers", adminController.getAllUsers);

// - sop library endpoints -
router.get("/:adminId/:orgId/getSOPs", adminController.getAllSOPs);
router.get("/:adminId/:orgId/:sopId/getSOPTasks", adminController.getAllSOPTasks);

// - active api endpoints -
router.get("/:adminId/:orgId/getActiveSOPs", adminController.getAllActiveSOPs);
router.get("/:adminId/:orgId/:sopId/getActiveSOPTasks", adminController.getAllActiveSOPTasks);

// - projects endpoints -
router.get("/:adminId/:orgId/getProjects", adminController.getAllProjects);

// - inventory endpoints -
router.get("/:adminId/:orgId/getInventory", adminController.getAllInventory);
router.get("/:adminId/:orgId/:itemId/getInventoryRental", adminController.getItemInventoryRental);

export default router;