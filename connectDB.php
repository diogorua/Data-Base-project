<?php

$servername = "localhost";
$username = "root";
$password = "";
$dbname = "vinisys";

$conn = mysqli_connect($servername, $username, $password, $dbname);

if (!$conn) {
    die("Connection failed: " . mysqli_connect_error() . "<br>");
}
echo "Connected successfully<br><br>";


?>