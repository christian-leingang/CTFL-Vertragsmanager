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
    to: `${email}`, 
    from: 'CTFLVertragsmanager@gmail.com', 
    subject: 'Forgot Password',
    text: `Das Passwort wurde auf "${password}" zurückgesetzt!`,
    html: `Das Passwort wurde zurückgesetzt. Das neue Passwort lautet "${password}". Bitte ändern Sie das Passwort nach dem nächsten Login.`,
  }
  console.log(msg.to);
  sgMail.send(msg).then(() => {
    console.log('Email sent');
  }).catch((e: any) => {
    console.error(e);
  });
}
