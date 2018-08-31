$(document).ready(function(){
    // PHP呼び出し SEND
    set_cookie($("#EVNT_USR_CD").val()).then(function(){
        // とりあえずこちらで実装。最終的にはeditを引っ張ってくる
        location.href = "/portal_web_beta/crient/mypage/html/edit.html";
    },function(){
        // 発生はほぼないエラー
        // エラーログを取得
    });
});