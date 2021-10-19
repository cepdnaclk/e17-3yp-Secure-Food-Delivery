<?php 

    session_start();

    if(isset($_GET['id'])){
        if($_GET['id'] == 100){
            $_SESSION = array();
            header("Location:index.html");
        }
    }

?>