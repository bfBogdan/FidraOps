import { Pool } from 'pg';
import dotenv from 'dotenv';

// load env data
dotenv.config();

// configure your PostgreSQL connection
const pool = new Pool({
  user: 'postgres',                           // DB username
  host: 'switchyard.proxy.rlwy.net',         // DB host
  database: 'railway',                        // DB name
  password: 'scBrRUsRaykSnmGaaOgyAJyrtmaeJYHo', // DB password
  port: 50684,                                // DB port
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
