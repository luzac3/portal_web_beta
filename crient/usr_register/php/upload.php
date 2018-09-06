<?php
    $root = $_SERVER["DOCUMENT_ROOT"];

    require_once($root . "/portal_web_beta/common/php/stored.php");

if(!empty($_POST["user_id"])){
    // 配列取得
    $arg_arr = array(
        "USR_ID"=>$_POST["user_id"]
        ,"USR_NAME"=>$_POST["user_name"]
        ,"HSH"=>null
    );
    if(!empty($_FILES["file"])){
        $file = $_FILES["file"];
    }

    // 仮にファイルがアップロードされている場所のパスを取得
    $tmp_path = $file['tmp_name'];

    // 拡張子を取得
    $ext_arr = explode('.',$file["name"]);
    $ext = end($ext_arr);

    // 保存先のパスを設定
    $upload_path = $_SERVER["DOCUMENT_ROOT"] . '/portal_web_beta/data/icon/';
    if (is_uploaded_file($tmp_path)) {
        // DBにアクセスしてユーザを作成、ユーザ通番を取得
        $result = stored("register_user",$arg_arr);

        $file_name = $result[0]["USR_CD"];

        $result = null;

        // 仮のアップロード場所から保存先にファイルを移動
        if (move_uploaded_file($tmp_path, $upload_path . $file_name . '.' . $ext)) {
            // ファイルが読出可能になるようにアクセス権限を変更
            chmod($upload_path . $file_name, 0644);

            $arg_arr2 = array(
                "usr_cd"=>$file_name
                ,"url"=>$upload_path . $file_name . '.' . $ext
            );

            // テーブルに登録
            $result = stored("register_user_icon",$arg_arr2);
            // echo json_encode(1);
        }else{
            echo json_encode(0);
        }
    }else{
        echo json_encode(1);
    }
}else{
	echo json_encode(1);
}
