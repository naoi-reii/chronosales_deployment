<?php

declare(strict_types=1);

const DB_HOST = 'localhost';
const DB_NAME = 'chrono_sales_db';
const DB_USER = 'root';
const DB_PASS = '';
const DB_CHARSET = 'utf8mb4';

function getDbConnection(): PDO
{
    static $pdo = null;

    if ($pdo instanceof PDO) {
        return $pdo;
    }

    $host    = getenv('DB_HOST') ?: 'localhost';
    $port    = getenv('DB_PORT') ?: '3306';
    $dbname  = getenv('DB_NAME') ?: 'chrono_sales_db';
    $user    = getenv('DB_USER') ?: 'root';
    $pass    = getenv('DB_PASSWORD') !== false ? getenv('DB_PASSWORD') : (getenv('DB_PASS') !== false ? getenv('DB_PASS') : '');
    $charset = getenv('DB_CHARSET') ?: 'utf8mb4';

    $dsn = sprintf(
        'mysql:host=%s;port=%s;dbname=%s;charset=%s',
        $host,
        $port,
        $dbname,
        $charset
    );

    $pdo = new PDO($dsn, $user, $pass, [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
        PDO::ATTR_EMULATE_PREPARES => false,
    ]);

    return $pdo;
}
