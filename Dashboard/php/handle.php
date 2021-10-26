<?php 
    session_start();

    if(isset($_GET['id'])){
        if ($_GET['id'] == 100) {
            $_SESSION = array();
            header("Location:../index.html");
        }
    }

	if(isset($_POST['adminLogin'])){
        $adminName = strip_tags(trim($_POST["adminName"]));
        $adminPassword = strip_tags(trim($_POST["adminPassword"]));

        $url = 'https://35.171.26.170/api/admin/login';
        $curl = curl_init($url);

        $data_array = array(
            'username' => $adminName,
            'password' => $adminPassword
        );
        $data = json_encode($data_array);


        curl_setopt($curl, CURLOPT_URL, $url);
        curl_setopt($curl, CURLOPT_POST, true);
        curl_setopt($curl, CURLOPT_POSTFIELDS,  $data);
        curl_setopt($curl, CURLOPT_HTTPHEADER, array('Content-Type: application/json','Connection: keep-alive'));
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
            echo $response;
            echo $httpcode;
        }
        curl_close($curl);

        if($httpcode == 200){
            $_SESSION['token'] = $response;
            header("Location:../user_show.php");
        }
        else{
            header("Location:../index.html?LoginError");
        }
    
    }

    if(isset($_POST['device_add'])){
        if(isset($_SESSION['token'])){
            $device_add_id = strip_tags(trim($_POST["device_add_id"]));
            $device_add_mqtt = strip_tags(trim($_POST["device_add_mqtt"]));

            $url = 'https://35.171.26.170/api/admin/add';
            $curl = curl_init($url);

            $data_array = array(
                'deviceid' => $device_add_id,
                'mqttid' => $device_add_mqtt
            );
            $data = json_encode($data_array);


            curl_setopt($curl, CURLOPT_URL, $url);
            curl_setopt($curl, CURLOPT_POST, true);
            curl_setopt($curl, CURLOPT_POSTFIELDS,  $data);
            curl_setopt($curl, CURLOPT_HTTPHEADER, array('Content-Type: application/json','Connection: keep-alive','x-authtoken: '.$_SESSION['token']));
            curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
            curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, false);
            curl_setopt($curl, CURLOPT_SSL_VERIFYHOST, FALSE);

            $response = curl_exec($curl);
            $httpcode = curl_getinfo($curl, CURLINFO_HTTP_CODE);

            if($err = curl_error($curl)){
                echo $err;
            }
            else{
                echo $response;
                echo $httpcode;
            }
            curl_close($curl);

            if($httpcode == 200){
                header("Location:../device_add.html?Successful");
            }
            else{
                header("Location:../device_add.html");
            }
        }
        else{
            header("Location:../index.html");
        }
    }

    if(isset($_POST['device_remove'])){
        if (isset($_SESSION['token'])) {
            $device_remove_id = strip_tags(trim($_POST["device_remove_id"]));

            $url = 'https://35.171.26.170/api/admin/remove/device';
            $curl = curl_init($url);

            $data_array = array('deviceid' => $device_remove_id);
            $data = json_encode($data_array);


            curl_setopt($curl, CURLOPT_URL, $url);
            curl_setopt($curl, CURLOPT_POST, true);
            curl_setopt($curl, CURLOPT_POSTFIELDS,  $data);
            curl_setopt($curl, CURLOPT_HTTPHEADER, array('Content-Type: application/json','Connection: keep-alive','x-authtoken: '.$_SESSION['token']));
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
                echo $response;
                echo $httpcode;
            }
            curl_close($curl);

            if($httpcode == 200){
                header("Location:../device_remove.html?Successful");
            }
            else{
                header("Location:../device_remove.html");
            }
        }
        else{
            header("Location:../index.html");
        }
    }

    if(isset($_POST['rider_remove'])){
        if (isset($_SESSION['token'])) {
            $rider_remove_mobno = strip_tags(trim($_POST["rider_remove_mobno"]));

            $url = 'https://35.171.26.170/api/admin/remove/rider';
            $curl = curl_init($url);

            $data_array = array('mobno' => $rider_remove_mobno);
            $data = json_encode($data_array);


            curl_setopt($curl, CURLOPT_URL, $url);
            curl_setopt($curl, CURLOPT_POST, true);
            curl_setopt($curl, CURLOPT_POSTFIELDS,  $data);
            curl_setopt($curl, CURLOPT_HTTPHEADER, array('Content-Type: application/json','Connection: keep-alive','x-authtoken: '.$_SESSION['token']));
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
                echo $response;
                echo $httpcode;
            }
            curl_close($curl);

            if($httpcode == 200){
                header("Location:../rider_remove.html?Successful");
            }
            else{
                header("Location:../rider_remove.html");
            }
        }
        else{
            header("Location:../index.html");
        }
    }


    if(isset($_POST['assign_RFID'])){
        if(isset($_SESSION['token'])){
            $assign_RFID_mobno = strip_tags(trim($_POST["assign_RFID_mobno"]));
            $assign_RFID_RFID = strip_tags(trim($_POST["assign_RFID_RFID"]));

            $url = 'https://35.171.26.170/api/admin/rfid';
            $curl = curl_init($url);

            $data_array = array(
                'mobno' => $assign_RFID_mobno,
                'rfid' => $assign_RFID_RFID
            );
            $data = json_encode($data_array);


            curl_setopt($curl, CURLOPT_URL, $url);
            curl_setopt($curl, CURLOPT_POST, true);
            curl_setopt($curl, CURLOPT_POSTFIELDS,  $data);
            curl_setopt($curl, CURLOPT_HTTPHEADER, array('Content-Type: application/json','Connection: keep-alive','x-authtoken: '.$_SESSION['token']));
            curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
            curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, false);
            curl_setopt($curl, CURLOPT_SSL_VERIFYHOST, FALSE);

            $response = curl_exec($curl);
            $httpcode = curl_getinfo($curl, CURLINFO_HTTP_CODE);

            if($err = curl_error($curl)){
                echo $err;
            }
            else{
                echo $response;
                echo $httpcode;
            }
            curl_close($curl);

            if($httpcode == 200){
                header("Location:../assign_RFID.html?Successful");
            }
            else{
                header("Location:../assign_RFID.html");
            }
        }
        else{
            header("Location:../index.html");
        }
    }

    
 ?>
