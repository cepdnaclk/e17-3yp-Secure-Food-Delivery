<?php 
    require_once("connection.php");
    session_start();

    $query_err = "";
    $contact = $_SESSION['TelNo'];
    $name = $_SESSION['Name'];
    $restaurent = $_SESSION['restaurent'];
    $code = $_SESSION['code'];
    $details = $_SESSION['details'];
    $address = $_SESSION['address'];
    $SFD = $_POST['SFD'];
    $date = date("Ymd");
    $id = "";

    if (isset($_POST['confirm'])) {
        $query1 = "select * from placeorder";
        $excecute1 = mysqli_query($connection,$query1);
        $id = $code.mysqli_num_rows($excecute1);
        $_SESSION['id'] = $id;
        $query2 = "insert into placeorder (OrderId,CTelNo,Details,address,_date,SFD,placedorder,restaurent) values('{$id}','{$contact}','{$details}','{$address}','{$date}','{$SFD}',0,'{$restaurent}')";
        $excecute2 = mysqli_query($connection,$query2);

        if ($excecute2) {
            if($_POST['SFD'] == "Yes"){
                header("Location:showId.php");
            }
            else{
                header("Location:shops.php");
            }
        }
        else{$query_err = "*Database query failed";}
    }
    
 ?>

<?php mysqli_close($connection); ?>

