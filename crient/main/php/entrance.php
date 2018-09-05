<?php
if(!empty($_POST["EVNT_USR_NUM"])){
    $event_code = susbstr($_POST["EVNT_USR_NUM"], 0, 4);
    $user_code = susbstr($_POST["EVNT_USR_NUM"], -5);

    $arg_arr = array(
        "event_code"=>$event_code
        ,"user_code"=>$user_code
    );

    // コードの存在チェック
    require_once("/portal_web_beta/common/php/stored.php");
    call_stored("check_cd",$arg_arr);

    setcookie("EVNT_NUM", $event_code, time()+60*60*24*10);
    setcookie("USR_CD", $user_code, time()+60*60*24*10);

    echo 1;
}else{
    echo 0;
}
?>