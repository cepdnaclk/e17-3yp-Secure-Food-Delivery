<?php 
	$connection = mysqli_connect('localhost','root','nadiw9811','orderme', '3307');
	if (mysqli_connect_errno()) {
		die("Database connection failed. " . mysqli_connect_error());
	}

	if (isset($_POST['sign-up-customer'])) {
		$TelNo =$_POST['number'];
		$CName =$_POST['name'];
		$CPassword =$_POST['password'];

		$query = "insert into customer(TelNo, CName, CPassword) values('$TelNo', '$CName', '$CPassword')";
		$excecute = mysqli_query($connection,$query);

		if($excecute){
			header("Location:../index.html");
		}
	}

	if (isset($_POST['sign-up-partner'])) {
		$Email =$_POST['email'];
		$RestName =$_POST['name'];
		$PPassword =$_POST['password'];
		
		$query = "insert into partner(Email, RestName, PPassword) values('$Email', '$RestName', '$PPassword')";
		$excecute = mysqli_query($connection,$query);

		if($excecute){
			header("Location:../index.html");
		}
	}
	
 ?>