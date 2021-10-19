<?php 
    require_once("connection.php");
    session_start();

    if(!isset( $_SESSION['Name'])){
        header("Location:login.php");
    }
?>


<!doctype html>
   <html lang="en">
   <head>
       <meta charset="utf-8">
       <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
       
       <title>Kandyan Foods | OrderMe</title>
       
       <!-- Styles -->
       <link rel="preconnect" href="https://fonts.gstatic.com">
       <link href="https://fonts.googleapis.com/css2?family=Open+Sans:ital,wght@0,400;0,600;0,700;1,400;1,600&display=swap" rel="stylesheet">
       <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
       <link href="css/styles.css" rel="stylesheet">
       
       <!-- Favicon  -->
       <link rel="icon" href="images/orderMe.png">

       <link rel="stylesheet" href="../../docs/assets/css/LineIcons.css">
       <link rel="stylesheet" href="../../docs/assets/css/font-awesome.min.css">
       <link rel="stylesheet" href="../../docs/assets/css/style.css">

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
       <header class="ex-header1">
           <div class="container">
               <div class="row">
                   <div class="col-xl-10 offset-xl-1 text-center">
                       <h1 class="text-center">Kandyan Foods</h1>
                   </div> <!-- end of col -->
               </div> <!-- end of row -->
           </div> <!-- end of container -->
       </header> <!-- end of ex-header -->
       <!-- end of header -->
       
       <!-- Basic -->
       <div class="ex-form-1">
           <div class="container">
            <br><br>
            <div class="row justify-content-center">
                <div class="col-lg-4 col-md-7 col-sm-8">
                    <div class="single-team text-center mt-30 wow fadeIn" data-wow-duration="1s" data-wow-delay="0.2s">
                        <div class="team-image">
                            <a href="purchase.php?id=3.1"><img src="images/shop3/chickenrice.png" alt="Team"></a>
                        </div>
                        <div class="team-content">
                            <h5 class="holder-name">Chicken Rice</h5>
                            <p class="text">Rs.750</p>
                        </div>
                    </div> <!-- single member -->
                </div>
                <div class="col-lg-4 col-md-7 col-sm-8">
                    <div class="single-team text-center mt-30 wow fadeIn" data-wow-duration="1s" data-wow-delay="0.5s">
                        <div class="team-image">
                            <a href="purchase.php?id=3.2"><img src="images/shop3/mixrice.png" alt="Team"></a>
                        </div>
                        <div class="team-content">
                            <h5 class="holder-name">Mix Rice</h5>
                            <p class="text">Rs.900</p>
                        </div>
                    </div> <!-- single member -->
                </div>
                <div class="col-lg-4 col-md-7 col-sm-8">
                    <div class="single-team text-center mt-30 wow fadeIn" data-wow-duration="1s" data-wow-delay="0.8s">
                        <div class="team-image">
                            <a href="purchase.php?id=3.3"><img src="images/shop3/seafoodrice.png" alt="Team"></a>
                        </div>
                        <div class="team-content">
                            <h5 class="holder-name">Seafood Fried Rice</h5>
                            <p class="text">Rs.1200</p>
                        </div>
                    </div> <!-- single member -->
                </div>
            </div> <!-- row -->
        </div> <!-- container -->
       </div> <!-- end of ex-basic-1 -->
       <!-- end of basic -->

       <!-- Scripts -->
       <<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
       <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns" crossorigin="anonymous"></script>
   </body>
   </html>

   <?php mysqli_close($connection); ?>

