<?php
$root = $_SERVER["DOCUMENT_ROOT"];

if(!empty($_POST["arg_arr"])){
    $event_code = susbstr($_POST["arg_arr"]["EVNT_USR_CD"], 0, 4);
    $user_code = susbstr($_POST["arg_arr"]["EVNT_USR_CD"], -5);

    $arg_arr = array(
        "event_code"=>$event_code
        ,"user_code"=>$user_code
    );

    // コードの存在チェック
    require_once($root . "/portal_web_beta/common/php/stored.php");
    $result = call_stored("check_cd",$arg_arr);

    if(!$result["exit_cd"]){
        setcookie("EVNT_NUM", $event_code, time()+60*60*24*10);
        setcookie("USR_CD", $user_code, time()+60*60*24*10);
    }

    echo 0;
}else{
    echo 1;
}
?>