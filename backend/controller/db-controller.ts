const dburl = 'mongodb://localhost:27017/CTFL'

const mongoose = require('mongoose');

mongoose.connect(dburl, { useNewUrlParser: true, useUnifiedTopology: true });

const userSchema = new mongoose.Schema({
  username: String,
  email: String,
  password: String,
});

const user = mongoose.model('user', userSchema);

const tobias = new user({ username: 'Tobias Hoffmann', email: "thoffmann2001@yahoo.de", password: "testpw"});

//tobias.save().then(() => console.log('Inserted User'));

user.find({ username: "Tobias Hoffmann"}).then((data) => console.log(data));