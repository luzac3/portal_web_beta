$(document).ready(function(){
    $("#edit_register").on("click",function(){
        // 入力内容取得関数
        const form_arr = get_form_val("input",false);

        // ストアドを起動
        call_stored("set_user_data",form_arr);
    });
});