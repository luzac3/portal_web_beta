<?php
if(!empty($_POST["EVNT_USR_NUM"])){
    $event_code = susbstr($_POST["EVNT_USR_NUM"], 0, 4);
    $user_code = susbstr($_POST["EVNT_USR_NUM"], -5);

    setcookie("EVNT_NUM", $event_code, time()+60*60*24*10);
    setcookie("USR_CD", $user_code, time()+60*60*24*10);

    echo 1;
}else{
    echo 0;
}
?>