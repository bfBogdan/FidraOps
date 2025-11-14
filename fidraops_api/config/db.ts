import { Pool } from 'pg';
import dotenv from 'dotenv';

// load env data
dotenv.config();

// configure your PostgreSQL connection
const pool = new Pool({
  host: process.env.DB_HOST,
  port: Number(process.env.DB_PORT),
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
});


// check connection
pool.connect()
  .then(client => {
    console.log('Connected to PostgreSQL');
    client.release();
  })
  .catch(err => {
    console.error('PostgreSQL connection error', err.stack);
  });


export default pool;
