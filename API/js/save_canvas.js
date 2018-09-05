function save_canvas(ext,file_name,canvas_id){
    let image_type = "image/" + ext;

    const canvas = document.getElementbyId(canvas_id);

    // base64コンバータ
    const base64 = canvas.toDataURL(image_type);

    // base64をblob変換
    const blob = Base64Blob(base64,image_type);

    const arg_arr = {
        blob:blob
        ,file_name:file_name
    }

    const arg_arr = {
        event_num:""
        ,user_num:""
        ,blob:blob
    }

    // DB保存
    call_stored_session("save_blob",arg_arr);

}

// イメージファイルの場合
function save_image(ext,file_name,image_id){
    const obj = document.getElementById(image_id);

    // canvas要素を生成してimg要素を反映
    const cvs = document.createElement('canvas');
    cvs.width = obj.width;
    cvs.height = obj.height;
    cvs.id = "canvas_" + image_id;
    const ctx = cvs.getContext('2d');
    ctx.drawImage(obj,0,0);

    // canvas要素をBase64に
    save_canvas(ext,file_name,"canvas_" + image_id);
}