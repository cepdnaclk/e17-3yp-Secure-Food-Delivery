<?php 
    require_once("connection.php");
    session_start();

    $id = $_SESSION['id'];
    $name = $_SESSION['Name'];

    if (isset($_POST['confirm'])) {
        header("Location:shops.php");
    }
    
 ?>



<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    
    <title>Order ID | OrderMe</title>
    
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
                    <br><br><br>
                    <h1 class="text-center">Hello <?php echo $name; ?><br> Your Order ID is <?php echo $id; ?></h1>
                    <br><br><br>
                    <p></p>
                    <!-- <p class="p-large">Good food makes you SMILE</p> -->
                </div> <!-- end of col -->
            </div> <!-- end of row -->
        </div> <!-- end of container -->
    </header> <!-- end of ex-header -->
    <!-- end of header -->
    
    <!-- Basic -->
    <!-- <div class="ex-form-1"> -->
        <div class="container">
            <div class="row">
                <div class="col-xl-6 offset-xl-3">
                    <div class="tab-content" id="myTabContent">
                        <div class="tab-pane fade show active" id="customer" role="tabpanel" aria-labelledby="home-tab">
                            <div class="text-box mt-3 mb-3">
                                <!-- Sign Up Form -->
                                <form action="showId.php" method="post" id="signUpFormCustomer">
                                    <!-- <p class="p-large">Your Order ID is <?php echo $id; ?></p> -->
                                    
                                    <div class="form-group">
                                        <button type="submit" class="form-control-submit-button" name="confirm">Discover Foods</button>
                                    </div>
                                </form>
                                <!-- end of login form -->
                            </div> <!-- end of text-box -->
                        <!-- </div> -->
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