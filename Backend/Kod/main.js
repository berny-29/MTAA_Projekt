const express = require('express');
const cors = require('cors');       // napojenie na react-native frontend
const app = express();
const pool = require("./database"); // pripojenie databaza

app.use(cors());
app.use(express.json());



app.delete("/api/deleteEvent/:id", async (req, res) => {   // vymazem event
    try {
        const { id } = req.params;
        const deleteEvent = await pool.query("DELETE FROM events WHERE id = $1;", [id]);
        res.status(200).send("0K DONE");
    } catch (err) {
        res.status(404).send("404 OOPS");
        console.log(err.message);
    }
})

app.delete("/api/deleteUser/:id", async (req, res) => {    // vymazem usera
    try {
        const { id } = req.params;
        const deleteUser = await pool.query("DELETE FROM users WHERE id = $1;", [id]);
        res.status(200).send("0K DONE");
    } catch (err) {
        res.status(404).send("404 OOPS");
        console.log(err.message);
    }
})

app.post("/api/register/check", async (req, res) => {      // skontrolujem ci uz pouzivatelsky nick existuje v databaze
    try{
        const { nick_name } = req.body;
        const nickCheck = await pool.query("SELECT nick_name FROM users WHERE nick_name = $1;", [nick_name]);
        if (nick_name == nickCheck.rows[0].nick_name) {
            res.status(400).send("Nick name already exists");
            return;
        }
    } catch (err) {
        res.status(404).send("404 OOPS");
        console.log(err.message);
    }
})


app.post("/api/register", async (req, res) => {          // vytvorim noveho pouzivatela 
    try {
        const { nick_name } = req.body;
        const { password } = req.body;
        const { name } = req.body;
        const { gender } = req.body;
        const { age } = req.body;
        const { city } = req.body;

        const createUser = pool.query("INSERT INTO users(nick_name, password, name, gender, age, city) VALUES ($1, $2, $3, $4, $5, $6) RETURNING*;", [nick_name, password, name, gender, age, city]);
        res.status(200).send("OK DONE");
    
    } catch (err) {
        res.status(404).send("404 OOPS");
        console.log(err.message);
    }
})

app.post("/api/createEvent", async (req, res) => {         // vytvorim novy event
    try {
        const { name } = req.body;
        const { image } = req.body;
        const { category } = req.body;
        const { created_on } = req.body;
        const { date } = req.body;
        const { capacity } = req.body;
        const { city } = req.body;
        const { additional_info } = req.body;
        const { owner } = req.body;
        const { status } = req.body;
        const createEvent = await pool.query("INSERT INTO events(name, image, category, created_on, date, capacity, city, additional_info, owner, status) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10) RETURNING*;", [name, image, category, created_on, date, capacity, city, additional_info, owner, status]);
        res.status(200).send("0K DONE");
    } catch (err) {
        res.status(404).send("404 OOPS");
        console.log(err.message);
    }
})

app.get("/api/user/:id", async (req, res) => {                  // vypisem si informacie o userovi
    try {
        const { id } = req.params;
        const user = await pool.query("SELECT * FROM users WHERE id = $1;", [id]);
        res.status(200).json(user.rows[0]);
    } catch (err) {
        res.status(404).send("404 OOPS");
        console.log(err.message);
    }
})

app.get("/api/Event/:id", async (req, res) => {                 // vypisem si informacie o evente
    try {
        const { id } = req.params;
        const event = await pool.query("SELECT * FROM events WHERE id = $1;", [id]);
        res.status(200).json(event.rows[0]);
    } catch (err) {
        res.status(404).send("404 OOPS");
        console.log(err.message);
    }
})

app.get("/api/myEvents/:id", async (req, res) => {              // vypisem si eventy, na ktore je user prihlaseny
    try {
        const { id } = req.params;
        const events = await pool.query("SELECT events.id, events.name, events.image FROM users_events JOIN events ON users_events.event_id = events.id WHERE users_events.user_id = $1 AND events.status = true;", [id]);
        res.status(200).json(events.rows);
    } catch (err) {
        res.status(404).send("404 OOPS");
        console.log(err.message);
    }
})

app.get("/api/Event/Attendants/:id", async (req, res) => {      // vypisem si userov, ktori su prihlaseni na event
    try {
        const { id } = req.params;
        const users = await pool.query("SELECT users.name FROM users_events JOIN users ON users_events.user_id = users.id WHERE users_events.event_id = $1;", [id]);
        res.status(200).json(users.rows);
    } catch (err) {
        res.status(404).send("404 OOPS");
        console.log(err.message);
    }
})

app.get("/api/swipeEvents/:id", async (req, res) => {    // vypisem si eventy, ktore mozem pozerat a prihlasit sa na ne 
    try {
        const { id } = req.params;
        const browseEvents = await pool.query("SELECT DISTINCT ON (1)* FROM events JOIN users_events ON users_events.event_id = events.id WHERE users_events.user_id != $1 AND events.name NOT IN (SELECT events.name FROM users_events JOIN events ON users_events.event_id = events.id WHERE users_events.user_id = $1);", [id]);
        res.status(200).json(browseEvents.rows);
    } catch (err) {
        res.status(404).send("404 OOPS");
        console.log(err.message);
    }
})




app.put("/api/updateUser/:id", async (req, res) => {            // updatenem info o userovi
    try {
        const { id } = req.params;
        const { name } = req.body;
        const { password } = req.body;
        const { age } = req.body;
        const { city } = req.body;
        const editUser = await pool.query("UPDATE users SET name = $2, age = $3, password = $4, city = $5 WHERE users.id = $1", [id, name, age, password, city]);
        res.status(200).send("0K DONE");
    } catch (err) {
        res.status(404).send("404 OOPS");
        console.log(err.message);
    }
})

app.put("/api/uprav/event/:id", async (req, res) => {           // updatenme info o evente
    try {
        const { id } = req.params;
        const { name } = req.body;
        const { image } = req.body;
        const { category } = req.body;
        const { capacity } = req.body;
        const { city } = req.body;
        const { status } = req.body;
        const editEvent = await pool.query("UPDATE events SET name = $2, image = $3, category = $4, capacity = $5, city = $6, status = $7 WHERE events.id = $1", [id, name, image, category, capacity, city, status]);
        res.status(200).send("0K DONE");
    } catch (err) {
        res.status(404).send("404 OOPS");
        console.log(err.message);
    }
})


app.post("/api/login", async (req, res) => {                    // overenie loginu pouzivatela pri zadani nicku, hesla do gui
    try {
        const { nick_name } = req.body;
        const { password } = req.body;

        const pswd = await pool.query("SELECT password FROM users WHERE nick_name = $1;", [nick_name]);

        if (pswd["rowCount"] == 0 || pswd["rowCount"] == 0) {
            res.status(400).send("BAD REQ");
            return;
        }

        db_pass = pswd.rows[0].password;
        if (password != db_pass) {
            res.status(401).send("Wrong password");
            return;
        }
        else {
            res.status(200).send("OK DONE");
        }
    } catch (err) {
        res.status(404).send("404 OOPS");
    }
})




app.get("/api/login/:nick_name", async (req, res) => {                    // po uspesnom zalogovani zistim id uzivatela z jeho nicku
    try {
        const { nick_name } = req.params;

        const user_id_check = await pool.query("SELECT id FROM users WHERE nick_name = $1;", [nick_name]);
        console.log (user_id_check);
        res.status(200).json(user_id_check.rows[0]);

    } catch (err) {
        res.status(404).send("404 OOPS");
    }
})




app.post("/api/signEvent", async (req, res) => {         // pridam novovytvoreny event do tabulky users_events (id ownera a eventu) 
    try {
        const { user_id } = req.body;
        const { event_id } = req.body;

        const createEvent = await pool.query("INSERT INTO users_events(user_id, event_id) VALUES ($1, $2) RETURNING*;", [user_id, event_id]);
        res.status(200).send("0K DONE");
    } catch (err) {
        res.status(404).send("404 OOPS");
        console.log(err.message);
    }
})




app.listen(3000);       // port