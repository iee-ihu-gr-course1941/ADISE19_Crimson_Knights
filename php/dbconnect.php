<?php
require_once "config_local.php";
$host = 'localhost';
$user = $DB_USER;
$db = 'UNO';
if (gethostname() == 'users.iee.ihu.gr') {
	$mysqli = new mysqli($host, $user, null, $db, null, '/home/student/it/2017/it174973/mysql/run/mysql.sock');
}
else {
	$mysqli = new mysqli($host, $user, $pass, $db);
}
if ($mysqli->connect_errno) {
	echo "Failed to connect to MySQL: (" . $mysqli->connect_errno . ") " . $mysqli->connect_error;
}
?>