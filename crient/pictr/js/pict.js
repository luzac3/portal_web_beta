// つけたり消した李に使う
// りんくもあっちやったりこっちやったりえ、枠のサイズもこちらで指定
// 企画用ページもこっちでやれるかな

$(document).ready(function(){
    $("button").on("click",function(){
        const button = this.value;

        // ONOFFをキャッチ
        const toggle = $(this).find("img").prop("class");

        // トグルを切り替え
        $(this).find("img").attr("class", (1 - parseInt($(this).find("img").prop("class"))));

        const num = praseInt($(this).next()[0].innerText);

        // プラスかマイナスかの設定
        let add = 0;

        // トグルに従って数値を増減
        if(toggle){
            add = -1;
        }else{
            add = 1;
        }

        $(this).next()[0].innerText = num + add;


        // 画像をディスエイブル⇔エイブル切り替え

        // ストアドコール
        if(button == "fav"){
            const arg_arr = {
                event_num:""
                ,user_num:""
                ,add:add
            };

            call_stored_session("fav",arg_arr);
        }else{
            const arg_arr = {
                event_num:""
                ,user_num:""
                ,dl_sns_cd:1
                ,add:add
            };
            if(button = "dl"){
                arg_arr["dl_sns"] = 1;
            }else{
                arg_arr["dl_sns"] = 2
            }

            call_stored_session("dl_sns",arg_arr);
        }
    });

    $("#pict").find("a").on("click",function(){
        // クローズ押されたときの設定を適応

        // pict側のクラス値を反映

        // コメントを取得して反映

        // detailを表示に
    });
});

