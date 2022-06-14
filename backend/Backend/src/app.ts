import express, { Request, Response } from "express";
import dotenv from "dotenv";
dotenv.config();
import config from "config";
import connect from "./utils/connect";
import logger from "./utils/logger";
import routes from "./routes";
import deserializeUser from "./middleware/deserializeUser";
import { sendMail } from "./utils/mailer";

const port = config.get<number>("port");
const cors = require('cors');

const app = express();

app.use(express.json());
app.use(deserializeUser);
app.use(cors());
//sendMail();
app.listen(port, async () => {
  logger.info(`App is running at http://localhost:${port}`);
  await connect();
  routes(app);
});
