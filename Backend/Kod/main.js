const express = require('express');
const app = express();
const pool = require("./database"); // pripojenie databaza


app.use(express.json());



app.delete("/api/delete/event/:id", async (req, res) => {
    try {
        const { id } = req.params;
        const deleteEvent = await pool.query("DELETE FROM events WHERE id = $1;", [id]);
        res.status(200).send("0K DONE");
    } catch (err) {
        res.status(404).send("404 OOPS");
        console.log(err.message);
    }
})

app.delete("/api/delete/user/:id", async (req, res) => {
    try {
        const { id } = req.params;
        const deleteUser = await pool.query("DELETE FROM users WHERE id = $1;", [id]);
        res.status(200).send("0K DONE");
    } catch (err) {
        res.status(404).send("404 OOPS");
        console.log(err.message);
    }
})

app.post("/api/create/user", async (req, res) => {      // vytvorim noveho pouzivatela 
    try {
        const { id } = req.body;
        const { nick_name } = req.body;
        const { password } = req.body;
        const { name } = req.body;
        const { gender } = req.body;
        const { age } = req.body;
        const { city } = req.body;
        const createUser = await pool.query("INSERT INTO users(id, nick_name, password, name, gender, age, city) VALUES ($1, $2, $3, $4, $5, $6, $7) RETURNING*;", [id, nick_name, password, name, gender, age, city]);
        res.status(200).send("0K DONE");
    } catch (err) {
        res.status(404).send("404 OOPS");
        console.log(err.message);
    }
})

app.post("/api/create/event", async (req, res) => {     // vytvorim noveho pouzivatela 
    try {
        const { id } = req.body;
        const { name } = req.body;
        const { image } = req.body;
        const { category } = req.body;
        const { capacity } = req.body;
        const { city } = req.body;
        const { additional_info } = req.body;
        const { owner } = req.body;
        const { status } = req.body;
        const createEvent = await pool.query("INSERT INTO events(id, name, image, category, capacity, city, additional_info, owner, status) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9) RETURNING*;", [id, name, image, category, capacity, city, additional_info, owner, status]);
        res.status(200).send("0K DONE");
    } catch (err) {
        res.status(404).send("404 OOPS");
        console.log(err.message);
    }
})

app.get("/api/User/:id", async (req, res) => {          // vypisem si informacie o userovi
    try {
        const { id } = req.params;
        const user = await pool.query("SELECT * FROM users WHERE id = $1;", [id]);
        res.status(200).json(user.rows[0]);
    } catch (err) {
        res.status(404).send("404 OOPS");
        console.log(err.message);
    }
})

app.get("/api/Event/:id", async (req, res) => {         // vypisem si informacie o evente
    try {
        const { id } = req.params;
        const event = await pool.query("SELECT * FROM events WHERE id = $1;", [id]);
        res.status(200).json("200 0K DONE" + event.rows[0]);
    } catch (err) {
        res.status(404).send("404 OOPS");
        console.log(err.message);
    }
})

app.get("/api/MojeEventy/Event/:id", async (req, res) => {  // vypisem si eventy, na ktore je user prihlaseny
    try {
        const { id } = req.params;
        const events = await pool.query("SELECT events.name FROM users_events JOIN events ON users_events.event_id = events.id WHERE users_events.user_id = $1;", [id]);
        res.status(200).json("200 0K DONE" + events.rows);
    } catch (err) {
        res.status(404).send("404 OOPS");
        console.log(err.message);
    }
})

app.get("/api/Event/Attendants/:id", async (req, res) => {  // vypisem si userov, ktori su prihlaseni na event
    try {
        const { id } = req.params;
        const users = await pool.query("SELECT users.name FROM users_events JOIN users ON users_events.user_id = users.id WHERE users_events.event_id = $1;", [id]);
        res.status(200).json("200 0K DONE" + users.rows);
    } catch (err) {
        res.status(404).send("404 OOPS");
        console.log(err.message);
    }
})

app.get("/api/Prehladavaj/Eventy/:id", async (req, res) => {  // vypisem si eventy, ktore mozem pozerat a prihlasit sa na ne 
    try {
        const { id } = req.params;
        const browseEvents = await pool.query("SELECT DISTINCT ON (1)* FROM events JOIN users_events ON users_events.event_id = events.id WHERE users_events.user_id != $1 AND events.name NOT IN (SELECT events.name FROM users_events JOIN events ON users_events.event_id = events.id WHERE users_events.user_id = $1);", [id]);
        res.status(200).json(browseEvents.rows);
    } catch (err) {
        res.status(404).send("404 OOPS");
        console.log(err.message);
    }
})

app.put("/api/uprav/user/:id", async (req, res) => {
    try {
        const { id } = req.params;
        const { name } = req.body;
        const { nick_name } = req.body;
        const { password } = req.body;
        const { city } = req.body;
        const editUser = await pool.query("UPDATE users SET name = $2, nick_name = $3, password = $4, city = $5 WHERE users.id = $1", [id, name, nick_name, password, city]);
        res.status(200).send("0K DONE");
    } catch (err) {
        res.status(404).send("404 OOPS");
        console.log(err.message);
    }
})

app.put("/api/uprav/event/:id", async (req, res) => {
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



app.listen(3000); // port
