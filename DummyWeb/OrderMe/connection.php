<?php
	$connection = mysqli_connect('localhost','root','946527003','orderme');	//put your username and password here
	if (mysqli_connect_errno()) {
		die("Database connection failed. " . mysqli_connect_error());
	}
?>