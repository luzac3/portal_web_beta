<?php
session_start();

if(!empty($_POST["arg_arr"])){
    $arg_arr = $_POST["arg_arr"];
    $stored_name = $_POST["stored_name"];

    $arg_arr["user_name"] = $_SESSION["user_name"];
    $arg_arr["event_num"] = $_SESSION["event_num"];

    require_once '/portal_web_beta/common/php/call_stored.php';

    $result = call_stored($stored_name,$arg_arr);

    echo json_encode($result);
}
?>