<?php 
    require_once("connection.php");
    session_start();
    
    $deviceId = "";

    if(isset($_GET['orderID'])){
        $_SESSION['orderID'] = $_GET['orderID'];
        $_SESSION['ctelNo'] = $_GET['ctelNo'];
        $_SESSION['details'] = $_GET['details'];
        $orderID = $_SESSION['orderID'];
        $ctelNo = $_SESSION['ctelNo'];
        $details = $_SESSION['details'];

        //next example will recieve all messages for specific conversation
        $service_url = 'https://35.171.26.170/api/restaurant/order-state/'.$orderID;
        $curl = curl_init($service_url);
        curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($curl, CURLOPT_SSL_VERIFYHOST, FALSE);

        $response = curl_exec($curl);
        $httpcode = curl_getinfo($curl, CURLINFO_HTTP_CODE);

        if($err = curl_error($curl)){
            echo $err;
        }
        curl_close($curl);
        

    }
    if(isset($_POST['back'])){
        header("Location:orderState.php");
    }

?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    
    <title>State | OrderMe</title>
    
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

            <div class="navbar-collapse offcanvas-collapse" id="navbarsExampleDefault">
                <ul class="navbar-nav ml-auto">
                    <li class="nav-item" id="rest_name">
                            <p class="p-large"> <?php echo $_SESSION['Name']; ?></p>
                    </li>
                    <li>
                        <span class="nav-item">
                            <img src="images/shop.png" width="75px" height="40px" style="padding-left: 10px;">
                            <!--a class="btn-solid-sm page-scroll" href="log-in.html">Sign-In</a-->
                        </span>
                    </li>
                    <li>
                        <span class="nav-item">
                            <a class="btn-solid-sm page-scroll" href="logout.php?id=100">Log-out</a>
                        </span>
                    </li>
                </ul>
                
            </div> <!-- end of navbar-collapse -->
           
        </div> <!-- end of container -->
    </nav> <!-- end of navbar -->
    <!-- end of navigation -->


    <!-- Header -->
    <header class="ex-header">
        <div class="container">
            <div class="row">
                <div class="col-xl-10 offset-xl-1 text-center">
                    <h1 class="text-center">Check State</h1>
                    <!-- <p class="p-large">Good food makes you SMILE</p> -->
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
                        <form action="partnerState.php" method="post" id="logInForm">
                            <!-- <p class="p-large">Confirm orders</p> -->
                            <div class="form-group">
                                        <hr style="height:0px; visibility:hidden;" />
                                <input type="text" class="form-control-input" id="orderid" name="orderid" <?php echo 'value="'.$orderID.'"';?> readonly>
                                <label class="label-control" for="orderid">Order ID</label>
                            </div>
                            <div class="form-group">
                                        <hr style="height:0px; visibility:hidden;" />
                                <input type="text" class="form-control-input" id="number" name="number" <?php echo 'value="'.$ctelNo.'"';?> readonly>
                                <label class="label-control" for="number">Mobile Number</label>
                            </div>
                            <div class="form-group">
                                        <hr style="height:0px; visibility:hidden;" />
                                <input type="text" class="form-control-input" id="details" name="details" <?php echo 'value="'.$details.'"';?> readonly>
                                <label class="label-control" for="details">Details</label>
                            </div>
                            <div class="form-group">
                                        <hr style="height:0px; visibility:hidden;" />
                                <input type="text" class="form-control-input" id="state" name="state" <?php echo 'value="'.$response.'"';?> readonly>
                                <label class="label-control" for="state">Current State</label>
                            </div>
                            <div class="form-group">
                                <button type="submit" class="form-control-submit-button" name="back">Go Back</button>
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