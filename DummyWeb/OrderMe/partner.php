<?php 
    require_once("connection.php");
    session_start();

    $orders = "";
    $restaurent = $_SESSION['Name'];
    $date = date("Ymd");

    $query = "select orderid,CTelNo,details,sfd from placeorder where placedorder=0 and restaurent='{$restaurent}' and _date='{$date}'"; 
    $execute = mysqli_query($connection,$query);

    if($execute){
        while($order = mysqli_fetch_assoc($execute)){  
            $orders .= "<div class=\"e\"><div class=\"row\">";
            $orders .= "<div class=\"col-sm text-center\"><div class=\"e\"><p class=\"p-large\">{$order['details']}</p></div></div>";
            $orders .= "<div class=\"col-sm text-center\"><p class=\"p-large\">{$order['orderid']}</p></div>";
            $orders .= "<div class=\"col-sm text-center\"><p class=\"p-large\">{$order['sfd']}</p></div>";
            $orders .= "<div class=\"col-sm text-center\"><button type=\"submit\" class=\"form-control-submit-button\" name=\"confirmOrder\" formaction=\"partnerConfirm.php?orderID={$order['orderid']}&ctelNo={$order['CTelNo']}&sfd={$order['sfd']}&details={$order['details']}\">Confirm</button></div>";
            $orders .= "</div></div><br>";
        }
    }

 ?>

 <!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <title>Console | OrderMe</title>
    
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
    <nav class="navbar navbar-expand-lg fixed-top navbar-light" style="background-color: aliceblue;">
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
                            <a class="btn-solid-sm page-scroll" href="orderState.php">Check Status</a>
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
                    <br>
                    <h1 class="text-center">Check out all the available orders</h1>
                </div> <!-- end of col -->
            </div> <!-- end of row -->
        </div> <!-- end of container -->
    </header> <!-- end of ex-header -->
    <!-- end of header -->

     <div id="features" class="cards-1 pt-1">
        <form action="partner.php" method="post"> 
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="row" style="background-color:#80dfff; border-radius: 20px;">
                            <div class="col-sm text-center"><p class="p-large">Details</p></div>
                            <div class="col-sm text-center"><p class="p-large">Order Id</p></div>
                            <div class="col-sm text-center"><p class="p-large">SFD</p></div>
                            <div class="col-sm text-center"><p class="p-large">Confirm</p></div>
                        </div>
                        <br>
                        <?php echo $orders; ?>
                    </div> <!-- end of col -->
                </div> <!-- end of row -->
            </div> <!-- end of container -->
        </form>
    </div> <!-- end of cards-1 -->
    <!-- end of features -->

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns" crossorigin="anonymous"></script>
</body>
</html>

<?php mysqli_close($connection); ?>