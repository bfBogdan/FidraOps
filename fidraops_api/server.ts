import express, { Request, Response } from "express";
import dotenv from "dotenv";
//import userAuthRoute from "./routes/userAuth";
import organisationAdminInfo from "./routes/organisation_admin"
import organisationUserInfo from "./routes/organisation_user"
import userAuthRoute from "./routes/userAuth"

dotenv.config();

const app = express();
const PORT = 3000;

// JSON parsing
app.use(express.json());

// -- API ROUTES --
// for authentification of the user
app.use("/auth", userAuthRoute);

// for all operations inside an organisation
app.use("/adminOrg", organisationAdminInfo);
app.use("/userOrg", organisationUserInfo);

// 404 handler
app.use((req: Request, res: Response) => {
  res.status(404).json({
    success: false,
    error: "Not Found",
    path: req.originalUrl,
  });
});

app.listen(PORT, () => {
  console.log(`Server running at http://localhost:${PORT}`);
});
