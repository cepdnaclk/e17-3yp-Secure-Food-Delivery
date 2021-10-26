<?php
    session_start();

    $Users = "";
    echo $_SESSION['token'];

    if (isset($_SESSION['token'])) {

        $url = 'https://35.171.26.170/api/admin/list/riders';
        $curl = curl_init($url);

        curl_setopt($curl, CURLOPT_URL, $url);
        curl_setopt($curl, CURLOPT_HTTPHEADER, array('x-authtoken: '.$_SESSION['token']));
        curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($curl, CURLOPT_SSL_VERIFYHOST, FALSE);

        $response = curl_exec($curl);
        $httpcode = curl_getinfo($curl, CURLINFO_HTTP_CODE);

        if($err = curl_error($curl)){
            echo $err;
        }
        else{
            $decode = json_decode($response);
        }
        curl_close($curl);

        $data = json_decode($response);

        $obj = json_decode($response,true);

        if($httpcode == 200){
            $temp = "";
            for($i = 0; $i < sizeof($obj); $i++){
                $temp .= "<tr>";
                $temp .= "<td class='details'>" . $obj[$i]["rName"] ."</td>";
                $temp .= "<td>". $obj[$i]["mobNo"] ."</td>";
                $temp .= "<td>". $obj[$i]["deviceID"] ."</td>";
                $temp .= "</tr>";
            }
        }
    }
    else{
        header("Location:index.html");
    }

    
?>

<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <title>SFD | Show Riders</title>
    <link href="css/styles.css" rel="stylesheet">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
        crossorigin="anonymous"></script>
</head>

<body style="background-color: aliceblue;">


    <div class="container-fluid">
        <nav class="navbar navbar-light bg-light fixed-top">
            <div class="container-fluid" style="background: -webkit-linear-gradient(#e0e7e4, #e0e7e4); height: 80px;">
                <a class="navbar-brand" href="#" style="margin-left: 7rem;">
                    <h3>Dashboard - SFD</h3>
                </a>
                <button class="navbar-toggler" type="button" data-bs-toggle="offcanvas"
                    data-bs-target="#offcanvasNavbar" aria-controls="offcanvasNavbar" style="margin-right: 7rem;">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasNavbar"
                    aria-labelledby="offcanvasNavbarLabel">
                    <div class="offcanvas-header">
                        <h5 class="offcanvas-title" id="offcanvasNavbarLabel">
                            <h4>Dashboard - SFD</h4>
                        </h5>
                        <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas"
                            aria-label="Close"></button>
                    </div>
                    <div class="offcanvas-body">
                        <ul class="navbar-nav justify-content-end flex-grow-1 pe-3" style="font-size: 20px;">
                            <li class="nav-item">
                                <a class="nav-link" aria-current="page" href="user_show.php">Home</a>
                            </li>
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" id="offcanvasNavbarDropdown" role="button"
                                    data-bs-toggle="dropdown" aria-expanded="false">
                                    Riders
                                </a>
                                <ul class="dropdown-menu" aria-labelledby="offcanvasNavbarDropdown">
                                    <li><a class="dropdown-item" href="rider_remove.html">Remove Rider</a></li>
                                    <li><a class="dropdown-item" href="rider_show.php">Show Riders</a></li>
                                </ul>
                            </li>
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" id="offcanvasNavbarDropdown" role="button"
                                    data-bs-toggle="dropdown" aria-expanded="false">
                                    Devices - Delivery Boxes
                                </a>
                                <ul class="dropdown-menu" aria-labelledby="offcanvasNavbarDropdown">
                                    <li><a class="dropdown-item" href="device_add.html">Add Device</a></li>
                                    <li><a class="dropdown-item" href="device_remove.html">Remove Device</a></li>
                                </ul>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" aria-current="page" href="php/handle.php?id=100" style="margin-top: 2rem;">Log Out</a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </nav>
    </div>


    <div class="container">

        <table class="table" style="margin-top: 10rem;">

            <thead style="background-color: gray;">
                <th class="details" style="color:white">Name of the Rider</th>
                <th style="color:white">Contact Number</th>
                <th style="color: white;">Device ID</th>
            </thead>

            <tbody>
                <?php echo $temp; ?>
                
            </tbody>

        </table>
    </div>    

</body>

</html>