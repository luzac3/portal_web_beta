// データを取得し、PHPにデータを投げる。
$(document).ready(function(){
    $("button").on("click",function(){
        if(!(window.FormData)) return;
        const user_id = $("#user_id").val();
        const user_name = $("#user_name").val();

        const file = document.getElementById("file").files[0];

        let fd = null;


        if(file){
            const form = document.getElementById("form");
            fd = new FormData(form);
            fd.append("file",file);

            for(let[key,val] of fd.entries()){
                console.log(key,val);
            }
        }

        const php = "/portal_web_beta/crient/usr_register/php/upload.php";

        ajax_form_set(php,fd).then(function(data){
            console.log(data);
        },function(data){
            console.log(data);
        });
    });
});