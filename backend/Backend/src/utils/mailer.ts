import nodemailer, { SendMailOptions } from "nodemailer";
import config from "config";
import log from "./logger";
import sendGrid from "sendgrid";
const sgMail = require('@sendgrid/mail');

export function sendMail(password: String, email: String){
  const mailKey = process.env.mailKey || config.get<string>('mailKey');
  console.log(mailKey);
  
  sgMail.setApiKey(mailKey);
  const msg = {
    to: `${email}`, // Change to your recipient
    from: 'CTFLVertragsmanager@gmail.com', // Change to your verified sender
    subject: 'Forgot Password',
    text: `Das Passwort wurde auf "${password}" zurückgesetzt!`,
    html: `Das Passwort wurde auf "${password}" zurückgesetzt!`,
  }
  console.log(msg.to);
  console.log(msg.text);
  console.log(msg.html);
  sgMail.send(msg).then(() => {
    console.log('Email sent')
  })
  .catch((e: any) => {
    console.error(e);
  })

}
