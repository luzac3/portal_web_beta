/*
 *
 * @get_disabled_flg:trueの場合、Disabledの要素も取得する
 */
function get_form_val(class_name,get_disabled_flg = false){
    // idは取得するHTMLタグのID
    const obj_list = document.getElementsByClassName(class_name);

    // 取得したフォームの値を格納する配列
    const val_arr = {};

    Array.prototype.forEach.call(obj_list,function(obj){
        // IDの取得
        const id = obj.id;

        const disabled = obj.disabled;

        if(document.getElementById(id).value === undefined){
            // 値がない場合はラッパー(チェックボックスとラジオ)
            val_arr[id] = get_selected_box(id,get_disabled_flg);
        }else{
            // disabled_flgがOFFかつ要素が非活性の場合、要素を取得しない
            if(!get_disabled_flg && disabled){
                return;
            }
            val_arr[id] = document.getElementById(id).value;
        }
    });

    return val_arr;
}

function get_form_val_by_name(class_name,get_disabled_flg = false){
    // idは取得するHTMLタグのID
    const obj_list = document.getElementsByClassName(class_name);

    // 取得したフォームの値を格納する配列
    const val_arr = {};

    Array.prototype.forEach.call(obj_list,function(obj){
        // IDの取得
        const name = obj.name[0];

        const disabled = obj.disabled;

        if(document.getElementByName(name)[0].value === undefined){
            // 値がない場合はラッパー(チェックボックスとラジオ)
            val_arr[name] = get_selected_box(name,get_disabled_flg);
        }else{
            // disabled_flgがOFFかつ要素が非活性の場合、要素を取得しない
            if(!get_disabled_flg && disabled){
                return;
            }
            val_arr[name] = document.getElementById(name).value;
        }
    });

    return val_arr;
}


function get_selected_box(name,get_disabled_flg = false){
    let result = [];

    const elements_list = document.getElementsByName(name);

    // ノードリストを配列に変換
    const elements = Array.prototype.slice.call(elements_list,0);

    elements.forEach(function(element){

        const disabled = element.disabled;

        // disabled_flgがOFFかつ要素が非活性の場合、要素を取得しない
        if(!get_disabled_flg && disabled){
            return;
        }

        if(element.checked){
            result.push(element.value);
        }
    });
    return result;
}
