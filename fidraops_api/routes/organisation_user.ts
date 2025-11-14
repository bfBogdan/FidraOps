import { Router } from 'express';
import * as usersController from '../controllers/user_controller';

const router = Router({ mergeParams: true });

// - users endpoints -
router.get("/:userId/:orgId/getUser", usersController.getUser);

// - sop endpoints -
router.get("/:userId/:orgId/getAllActiveAssignedSOPs", usersController.getAllActiveAssignedSOPs);
router.get("/:userId/:orgId/:sopId/getActiveAssignedSOPTasks", usersController.getActiveAssignedSOPTasks);

router.post("/:userId/:orgId/:sopId/:startTimestamp/:usersIdArray/activateSOP", usersController.activateSOP);

// - inventory endpoints -
router.get("/:userId/:orgId/:itemsIdArray/getInventoryOfAssignedActiveSOP", usersController.getInventoryOfAssignedActiveSOP);

export default router;