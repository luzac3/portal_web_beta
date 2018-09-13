<?php
$root = $_SERVER["DOCUMENT_ROOT"];

if(!empty($_POST["arg_arr"])){

$evnt_usr_cd = $_POST["arg_arr"]["EVNT_USR_CD"];


    $arg_arr = array(
        "event_code"=>substr($_POST["arg_arr"]["EVNT_USR_CD"], 0, 5)
        ,"user_code"=>substr($_POST["arg_arr"]["EVNT_USR_CD"], -5)
    );
    // コードの存在チェック
    require_once($root . "/portal_web_beta/common/php/stored.php");
    $result = stored("check_cd",$arg_arr);

    echo json_encode($arg_arr["event_code"]);

    if(!$result["exit_cd"]){
        setcookie("EVNT_NUM", $event_code, time()+60*60*24*10);
        setcookie("USR_CD", $user_code, time()+60*60*24*10);
    }

    echo json_encode(0);

}else{
	echo json_encode(1);
}
?>