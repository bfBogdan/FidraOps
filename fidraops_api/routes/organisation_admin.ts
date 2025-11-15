import { Router } from 'express';
import * as adminController from '../controllers/admin_controller';

const router = Router({ mergeParams: true });

// - admin endpoints -
router.get("/:orgId/:adminId/getAdmin", adminController.getOrganisationAdmin);
router.get("/:orgId/:adminId/getOrganisationDetails", adminController.getOrganisationDetails);

// - users endpoints -
router.get("/:orgId/:adminId/getUsers", adminController.getAllUsers);
router.post("/:orgId/:adminId/createUser", adminController.createUser);

// - sop library endpoints -
router.get("/:orgId/:adminId/getSOPs", adminController.getAllSOPs);
router.get("/:orgId/:adminId/getProjectSOPs", adminController.getProjectSOPs);
router.get("/:orgId/:adminId/:sopId/getSOPTasks", adminController.getAllSOPTasks);

// - active api endpoints -
router.get("/:orgId/:adminId/getActiveSOPs", adminController.getAllActiveSOPs);
router.get("/:orgId/:adminId/:sopId/getActiveSOPTasks", adminController.getAllActiveSOPTasks);

// - projects endpoints -
router.get("/:orgId/:adminId/getProjects", adminController.getAllProjects);
router.post("/:orgId/:adminId/createProject", adminController.createProject);
router.delete("/:orgId/:projectId/deleteProject", adminController.deleteProject);

// - inventory endpoints -
router.get("/:orgId/:adminId/getInventory", adminController.getAllInventory);
router.post("/:orgId/:adminId/createInventoryProduct", adminController.createInventoryProduct);
router.put("/:orgId/:adminId/:productId/updateInventoryProduct", adminController.updateInventoryProduct);
router.delete("/:orgId/:adminId/:productId/deleteInventoryProduct", adminController.deleteInventoryProduct);

router.get("/:orgId/:adminId/:itemId/getInventoryRental", adminController.getItemInventoryRental);

export default router;