import { Router } from 'express';
import * as usersController from '../controllers/users_controller';

const router = Router({ mergeParams: true });

router.get("/:orgId/getUsers", usersController.getAllUsers); // admin only
router.get("/:orgId/getSOPs", usersController.getAllSOPs); // admin only
router.get("/:orgId/getProjects", usersController.getAllProjects); // admin only
router.get("/:orgId/getWorkFlows", usersController.getAllWorkFlows); // admin only
router.get("/:orgId/getInventory", usersController.getAllInventory); // admin only

export default router;