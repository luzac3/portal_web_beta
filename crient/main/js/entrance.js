$(document).ready(function(){
    $("#register_usercd").on("click",function(){
    	const url = "/portal_web_beta/crient/main/php/entrance.php";

        const arg_arr = {
            EVNT_USR_CD:$("#EVNT_USR_CD").val()
        }

        ajax_set(url,arg_arr).then(function(){
            // とりあえずこちらで実装。最終的にはeditを引っ張ってくる
            location.href = "/portal_web_beta/crient/mypage/html/edit.html";
        },function(){
            // 発生はほぼないエラー
            // エラーログを取得
        });
    });
});