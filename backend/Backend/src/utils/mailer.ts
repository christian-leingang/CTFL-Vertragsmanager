import nodemailer, { SendMailOptions } from "nodemailer";
import config from "config";
import log from "./logger";

const smtp = config.get<{
    user: string;
    pass: string;
    host: string;
    port: number;
    secure: boolean;
  }>("smtp");
  
