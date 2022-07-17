import config from "config";
import logger from "./logger";
import sendGrid from "sendgrid";
const sgMail = require('@sendgrid/mail');

export function sendMail(password: String, email: String){
  const mailKey = process.env.mailKey || config.get<string>('mailKey');
  //console.log(mailKey);
  sgMail.setApiKey(mailKey);
  const msg = {
    to: `${email}`, 
    from: 'CTFLVertragsmanager@gmail.com', 
    subject: 'Forgot Password',
    text: `Das Passwort wurde auf "${password}" zurückgesetzt!`,
    html: `<p> Das Passwort wurde zurückgesetzt. Das neue Passwort lautet: </p>
    <p><b>${password}</b></p> 
    <p>Bitte ändern Sie das Passwort nach dem nächsten Login!</p>`,
  }
  console.log(msg.to);
  sgMail.send(msg).then(() => {
    logger.info('Email sent');
  }).catch((e: any) => {
    console.error(e);
  });
}
