import { Router } from 'express';
import * as usersController from '../controllers/user_controller';

const router = Router({ mergeParams: true });

// - users endpoints -
router.get("/:orgId/:userId/getUser", usersController.getUser);

// - sop endpoints -
router.get("/:orgId/:userId/getAllActiveAssignedSOPs", usersController.getAllActiveAssignedSOPs);
router.get("/:orgId/:userId/:sopId/getActiveAssignedSOPTasks", usersController.getActiveAssignedSOPTasks);

// - inventory endpoints -
router.get("/:orgId/:userId/:itemsIdArray/getInventoryOfAssignedActiveSOP", usersController.getInventoryOfAssignedActiveSOP);

export default router;