<?php
if(!empty($_GET["blob"])){
    $blob = $_GET["blob"];

    // DB取得


    header("Content-type:image/" . $result["ext"]);

    echo $result["blob"];
}