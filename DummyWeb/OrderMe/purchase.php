<?php 
    require_once("connection.php");
    session_start();

    $result_err = $query_err = "";
    $contact = $_SESSION['TelNo'];
    $name = $_SESSION['Name'];
    $price = $order = $restaurent = $details = "";

    if($_GET['id'] == "1.1"){
        $order = "Chicken Rice";
        $price = "450";
        $_SESSION['restaurent'] = "Food Paradise";
        $_SESSION['code'] = "0000";
        $_SESSION['details'] = "Chicken Rice 450";
    }
    else if($_GET['id'] == "1.2"){
        $order = "Chicken Kottu";
        $price = "600";
        $_SESSION['restaurent'] = "Food Paradise";
        $_SESSION['code'] = "0000";
        $_SESSION['details'] = "Chicken Kottu 600";
    }
    else if($_GET['id'] == "1.3"){
        $order = "Chicken Pasta with Cheese";
        $price = "800";
        $_SESSION['restaurent'] = "Food Paradise";
        $_SESSION['code'] = "0000";
        $_SESSION['details'] = "Chicken Pasta with Cheese 800";
    }
    else if($_GET['id'] == "2.1"){
        $order = "Chicken Pizza";
        $price = "1450";
        $_SESSION['code'] = "1000";
        $_SESSION['restaurent'] = "Hotel Peradeniya";
        $_SESSION['details'] = "Chicken Pizza 1450";
    }
    else if($_GET['id'] == "2.2"){
        $order = "Cheese Pizza";
        $price = "1600";
        $_SESSION['restaurent'] = "Hotel Peradeniya";
        $_SESSION['code'] = "1000";
        $_SESSION['details'] = "Cheese Pizza 1600";
    }
    else if($_GET['id'] == "2.3"){
        $order = "Sausage Pizza";
        $price = "1800";
        $_SESSION['restaurent'] = "Hotel Peradeniya";
        $_SESSION['code'] = "1000";
        $_SESSION['details'] = "Sausage Pizza 1800";
    }
    else if($_GET['id'] == "3.1"){
        $order = "Chicken Rice";
        $price = "750";
        $_SESSION['restaurent'] = "Kandyan Foods";
        $_SESSION['code'] = "2000";
        $_SESSION['details'] = "Chicken Rice 750";
    }
    else if($_GET['id'] == "3.2"){
        $order = "Mix Rice";
        $price = "900";
        $_SESSION['restaurent'] = "Kandyan Foods";
        $_SESSION['code'] = "2000";
        $_SESSION['details'] = "Mix Rice 900";
    }
    else if($_GET['id'] == "3.3"){
        $order = "Seafood Fried Rice";
        $price = "1200";
        $_SESSION['restaurent'] = "Kandyan Foods";
        $_SESSION['code'] = "2000";
        $_SESSION['details'] = "Seafood Fried Rice 1200";
    }
    
 ?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    
    <title>Purchase | OrderMe</title>
    
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
                <ul class="navbar-nav1 ml-auto">
                    <li>
                        <span class="nav-item">
                            <a class="btn-solid-sm page-scroll" href="purchasenext.php?id=100">Log-out</a>
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
                    <h1 class="text-center">Hello there, Let's Order</h1>
                    <p></p>
                    <!-- <p class="p-large">Good food makes you SMILE</p> -->
                </div> <!-- end of col -->
            </div> <!-- end of row -->
        </div> <!-- end of container -->
    </header> <!-- end of ex-header -->
    <!-- end of header -->
    
    <!-- Basic -->
    <div class="ex-form-1">
        <div class="container">
            <div class="row">
                <div class="col-xl-6 offset-xl-3">
                    <div class="tab-content" id="myTabContent">
                        <div class="tab-pane fade show active" id="customer" role="tabpanel" aria-labelledby="home-tab">
                            <div class="text-box mt-3 mb-3">
                                <!-- Sign Up Form -->
                                <form action="purchasenext.php" method="post" id="signUpFormCustomer">
                                    <p class="p-large">Place Your Order</p>
                                    <?php echo "<div style=\"color: red;\"><b>". $query_err . "</b></div>"; ?>
                                    <?php echo "<div style=\"color: red;\"><b>". $result_err . "</b></div>"; ?>
                                    <div class="form-group">
                                        <hr style="height:0px; visibility:hidden;" />
                                        <input type="tel" class="form-control-input" id="number" name="number"  <?php echo 'value="'.$contact.'"';?> readonly>
                                        <label class="label-control" for="number">Mobile Number</label>
                                    </div>
                                    <div class="form-group">
                                        <hr style="height:0px; visibility:hidden;" />
                                        <input type="text" class="form-control-input" id="order" name="order"  <?php echo 'value="'.$order.'"';?> readonly>
                                        <label class="label-control" for="order">Description</label>
                                    </div>
                                    <div class="form-group">
                                        <hr style="height:0px; visibility:hidden;" />
                                        <input type="text" class="form-control-input" id="price" name="price"  <?php echo 'value="'.$price.'"';?> readonly>
                                        <label class="label-control" for="price">Price</label>
                                    </div>
                                    <div class="form-group">
                                        <hr style="height:0px; visibility:hidden;" />
                                        <select name="SFD" id="SFD"  class="form-control-input" required>
                                            <option></option>
                                            <option>Yes</option>
                                            <option>No</option>
                                        </select>
                                        <label class="label-control" for="SFD">Do You Want Secure Food Delivery Service?</label>
                                    </div>
                                    <div class="form-group">
                                        <button type="submit" class="form-control-submit-button" name="confirm">Place Order</button>
                                    </div>
                                </form>
                                <!-- end of login form -->
                            </div> <!-- end of text-box -->
                        </div>
                    </div>
                </div> <!-- end of col -->
            </div> <!-- end of row -->
        </div> <!-- end of container -->
    </div> <!-- end of ex-basic-1 -->
    <!-- end of basic -->

    <!-- Scripts -->
    <<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns" crossorigin="anonymous"></script>
</body>
</html>

<?php mysqli_close($connection); ?>