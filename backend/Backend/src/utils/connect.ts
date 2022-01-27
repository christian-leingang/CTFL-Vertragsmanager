import mongoose from "mongoose";
import config from "config";
import logger from "./logger";

//PW: DBPW123
async function connect() {
  //const dbUri = config.get<string>("dbUri");
  const dbUriDeploy = "mongodb+srv://CTFLDB:DBPW123@cluster0.nopyw.mongodb.net/CTFL?retryWrites=true&w=majority"
  try {
    await mongoose.connect(dbUriDeploy);
    logger.info("DB connected");
  } catch (error) {
    logger.error("Could not connect to db");
    process.exit(1);
  }
}

export default connect;
