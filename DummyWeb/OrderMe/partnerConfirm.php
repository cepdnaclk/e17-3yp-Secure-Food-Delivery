<?php 
    require_once("connection.php");

    $orderID = $_GET['orderID'];
    $ctelNo = $_GET['ctelNo'];

    $query1 = "update placeorder set placedorder = 1 where orderid = '$orderID' limit 1";
    //$query2 = "insert into confirmorder(orderID, ctelNo, deviceId) values('$orderID', '$ctelNo', '$deviceId')";
    //$execute1 = mysqli_query($connection,$query1);
    //$execute2 = mysqli_query($connection,$query2);

    
    /*if($execute1){
        header("Location:partner.php?confirmed_successfully1");
    }
    //if($execute2){
        //header("Location:partner.php?confirmed_successfully2");
    //}
    else{
        //header("Location:partner.php?confirmation_failed");
    }*/

?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    
    <title>Log-In | OrderMe</title>
    
    <!-- Styles -->
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:ital,wght@0,400;0,600;0,700;1,400;1,600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
    <link href="css/styles.css" rel="stylesheet">
    
    <!-- Favicon  -->
    <link rel="icon" href="images/orderMe.png">
</head>
<body data-spy="scroll" data-target=".fixed-top" style="background: url('images/header-background.png') center center no-repeat">
    
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg fixed-top navbar-light">
        <div class="container">

            <!-- Image Logo -->
            <a class="navbar-brand logo-image" href="index.html"><img src="images/orderMe.png" alt="alternative"></a> 
           
        </div> <!-- end of container -->
    </nav> <!-- end of navbar -->
    <!-- end of navigation -->


    <!-- Header -->
    <header class="ex-header">
        <div class="container">
            <div class="row">
                <div class="col-xl-10 offset-xl-1 text-center">
                    <h1 class="text-center">Hello there, Let's get-in</h1>
                    <p class="p-large">Good food makes you SMILE</p>
                </div> <!-- end of col -->
            </div> <!-- end of row -->
        </div> <!-- end of container -->
    </header> <!-- end of ex-header -->
    <!-- end of header -->
    
    
    <!-- Basic -->
    <div class="ex-form-1 pb-5">
        <div class="container">
            <div class="row">
                <div class="col-xl-6 offset-xl-3">
                    <div class="text-box mb-5 mt-5">
                        <!-- Log In Form -->
                        <form action="login.php" method="post" id="logInForm">
                            <p class="p-large">Sign-In to place and manage your orders</p>
                            <div class="form-group">
                                <input type="text" class="form-control-input" id="orderid" name="orderid" maxlength="10" required>
                                <label class="label-control" for="orderid">Order ID</label>
                            </div>
                            <div class="form-group">
                                <input type="text" class="form-control-input" id="details" name="details" maxlength="10" required>
                                <label class="label-control" for="details">Details</label>
                            </div>
                            <div class="form-group">
                                <input type="text" class="form-control-input" id="number" name="number" maxlength="10" required>
                                <label class="label-control" for="number">Mobile Number</label>
                            </div>
                            <div class="form-group">
                                <input type="text" class="form-control-input" id="password" name="password" maxlength="20" required>
                                <label class="label-control" for="password">Password</label>
                            </div>
                            <div class="form-group">
                                <button type="submit" class="form-control-submit-button" name="login-customer">Confirm Order</button>
                            </div>
                        </form>
                        <!-- end of log in form -->

                        <!--p class="mb-4">New to OderMe? sign-up <a class="blue" href="signUp.php">here</a></p-->

                    </div> <!-- end of text-box -->
                </div> <!-- end of col -->
            </div> <!-- end of row -->
        </div> <!-- end of container -->
    </div> <!-- end of ex-basic-1 -->
    <!-- end of basic -->

    <!-- Scripts -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns" crossorigin="anonymous"></script>
</body>
</html>

<?php mysqli_close($connection); ?>