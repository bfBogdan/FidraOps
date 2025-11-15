import { Router } from 'express';
import * as authController from '../controllers/auth_controller';

const router = Router({ mergeParams: true });

// - users endpoints -
router.get("/getToken", authController.getToken);

export default router;