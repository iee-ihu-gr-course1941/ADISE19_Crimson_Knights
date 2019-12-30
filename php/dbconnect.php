<?php
require_once "config_local.php";

$host='localhost';
$user=$DB_USER;
$pass=$DB_PASS;
$db = 'UNO';

if(gethostname()=='users.iee.ihu.gr') {
	$mysqli = new mysqli($host, $user, $pass, $db,null,'/home/staff/asidirop/mysql/run/mysql.sock');
} else {
        $mysqli = new mysqli($host, $user, $pass, $db);
}
if ($mysqli->connect_errno) {
    echo "Failed to connect to MySQL: (" . 
    $mysqli->connect_errno . ") " . $mysqli->connect_error;
}
?>
