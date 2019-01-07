$(document).ready(function(){
    $("button").on("click",function(){
        switch(this.value){
          case "add":
            // 現在の最大値を取得
            let itm_no = $(".ITM_NO:last").text();

            const tr = $("tr:last").clone();
            tr.find("ITM_NO").text(itm_no+1);
            tr.appendTo("table")[1];
            break;
          case "register":
            const itm_no_list = getElementsByClassName("ITM_NO");
            const itm_list = [];

            const len = itm_no_list.length;

            for(let i = 0; i < len; i++){
                itm_list[i] = get_form_val("anquate",true);
                itm_list[i]["ITM_NO"] = itm_no_list[i].text();
            }
            break;
        }
    })
})

