// 呼び出してリターンを待ち、帰ってきた結果を返却する処理
function ajax_set(php_name,arg_arr){
    return new Promise(function(resolve, reject){
        $.ajax({
            url: php_name,
            cache: false,
            timeout: 30*60*1000,
            type:'POST',
            dataType: 'json',
            data: {
                arg_arr:arg_arr
            }
        }).then(
            function(data){
                console.log(data);
                const ret = parseInt(data);

                console.log(data);

                if(data){
                    reject(data);
                }
                resolve(data);
            },
            function(XMLHttpRequest, textStatus, errorThrown){
                console.log("更新処理に失敗しました");
                console.log("XMLHttpRequest : " + XMLHttpRequest.status);
                console.log("textStatus     : " + textStatus);
                console.log("errorThrown    : " + errorThrown.message);
                reject(0);
            }
        );
    });
}