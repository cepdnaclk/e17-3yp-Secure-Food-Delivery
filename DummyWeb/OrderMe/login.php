<?php 
    require_once("connection.php");
    session_start();

    $result_err = $query_err = "";

    if (isset($_POST['login-customer'])) {
        $TelNo = mysqli_real_escape_string($connection,$_POST['number']);
        $CPassword = mysqli_real_escape_string($connection,$_POST['password']);

        $query = "select TelNo, CName, CPassword from customer where TelNo='{$TelNo}' and CPassword='{$CPassword}'";
        $excecute = mysqli_query($connection,$query);
        $result = mysqli_fetch_assoc($excecute);

        if ($excecute) {
            if (mysqli_num_rows($excecute)==1) {
                $_SESSION['Name'] = $result['CName'];
                header("Location:index.html");
            }
            else{$result_err = "*Invalid User ID or Password";}
        }
        else{$query_err = "*Database query failed";}
    }

    if (isset($_POST['login-partner'])) {
        $Email = mysqli_real_escape_string($connection,$_POST['email']);
        $PPassword = mysqli_real_escape_string($connection,$_POST['password']);
        
        $query = "select Email, RestName, PPassword from partner where Email='{$Email}' and PPassword='{$PPassword}'";
        $excecute = mysqli_query($connection,$query);
        $result = mysqli_fetch_assoc($excecute);

        if ($excecute) {
            if (mysqli_num_rows($excecute)==1) {
                $_SESSION['Name'] = $result['RestName'];
                header("Location:partner.php");
            }
            else{$result_err = "*Invalid User ID or Password";}
        }
        else{$query_err = "*Database query failed";}
    }
    
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
    <div class="ex-form-1">
        <div class="container">
            <div class="row">
                <div class="col-xl-6 offset-xl-3">
                    <ul class="nav nav-tabs" id="myTab" role="tablist">
                        <li class="nav-item">
                            <a class="nav-link active" id="home-tab" data-toggle="tab" href="#customer" role="tab" aria-controls="home" aria-selected="true"><button type="button" class="btn btn-light">Customer Login</button></a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" id="profile-tab" data-toggle="tab" href="#partner" role="tab" aria-controls="profile" aria-selected="false"><button type="button" class="btn btn-light">Partner Login</button></a>
                        </li>
                    </ul>
                    <div class="tab-content" id="myTabContent">
                        <div class="tab-pane fade show active" id="customer" role="tabpanel" aria-labelledby="home-tab">
                            <div class="text-box mt-3 mb-3">
                                <!-- Sign Up Form -->
                                <form action="login.php" method="post" id="signUpFormCustomer">
                                    <p class="p-large">Sign-In to place your orders</p>
                                    <?php echo "<div style=\"color: red;\"><b>". $query_err . "</b></div>"; ?>
                                    <?php echo "<div style=\"color: red;\"><b>". $result_err . "</b></div>"; ?>
                                    <div class="form-group">
                                        <input type="tel" class="form-control-input" id="number" name="number" maxlength="10" required>
                                        <label class="label-control" for="number">Mobile Number</label>
                                    </div>
                                    <div class="form-group">
                                        <input type="password" class="form-control-input" id="password" name="password" maxlength="20" required>
                                        <label class="label-control" for="password">Password</label>
                                    </div>
                                    <div class="form-group">
                                        <button type="submit" class="form-control-submit-button" name="login-customer">Log In</button>
                                    </div>
                                </form>
                                <!-- end of login form -->
                                <p class="mb-4">New to OderMe? sign-up <a class="blue" href="signUp.php">here</a></p>
                            </div> <!-- end of text-box -->
                        </div>
                        <div class="tab-pane fade" id="partner" role="tabpanel" aria-labelledby="profile-tab">
                            <div class="text-box mt-3 mb-3">
                                <!-- Sign Up Form -->
                                <form action="login.php" method="post" id="signUpFormPartner">
                                    <p class="p-large">Sign-In to manage orders</p>
                                    <?php echo "<div style=\"color: red;\"><b>". $query_err . "</b></div>"; ?>
                                    <?php echo "<div style=\"color: red;\"><b>". $result_err . "</b></div>"; ?>
                                    <div class="form-group">
                                        <input type="email" class="form-control-input" id="email" name="email" maxlength="30" required>
                                        <label class="label-control" for="email">E-Mail</label>
                                    </div>
                                    <div class="form-group">
                                        <input type="password" class="form-control-input" id="password" name="password" maxlength="20" required>
                                        <label class="label-control" for="password">Password</label>
                                    </div>
                                    <div class="form-group">
                                        <button type="submit" class="form-control-submit-button" name="login-partner">Log In</button>
                                    </div>
                                </form>
                                <!-- end of login form -->
                                <p class="mb-4">New to OderMe? sign-up <a class="blue" href="signUp.php">here</a></p>
                            </div> <!-- end of text-box --></div>
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