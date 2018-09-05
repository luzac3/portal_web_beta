<?php
if(!empty($_POST["user_id"])){
    // 配列取得
    $arg_arr = array(
        "USR_ID"=>$_POST["user_id"]
        ,"USR_NAME"=>$_POST["user_name"]
    );
    if(!empty($_FILES["file"])){
        $file = $_FILES["file"];
    }

    // ファイル名を取得
    $file_name = $file['name'];

    // 仮にファイルがアップロードされている場所のパスを取得
    $tmp_path = $file['tmp_name'];

    // 保存先のパスを設定
    $upload_path = '/portal_web_beta/data/icon';

    if (is_uploaded_file($tmp_path)) {
        // 仮のアップロード場所から保存先にファイルを移動
        if (move_uploaded_file($tmp_path, $upload_path . $file_name)) {
            // ファイルが読出可能になるようにアクセス権限を変更
            // chmod($upload_path . $file_name, 0644);

            // テーブルに登録

            echo json_encode(1);
        }else{
            echo json_encode(2);
        }
    }else{
        echo json_encode(3);
    }
}else{
	echo json_encode(4);
}


?>

