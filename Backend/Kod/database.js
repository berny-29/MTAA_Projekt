const Pool = require("pg").Pool;
const getenv = require("getenv");

//const passwrd = getenv.string("heslo"); // premenna heslo zmenit


const pool = new Pool({
    user: "meno",
    password: "heslo",
    database: "mtaa",
    host: "localhost",
    port: 5432
})

module.exports = pool;
