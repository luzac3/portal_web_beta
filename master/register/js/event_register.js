$(document).ready(function(){
    $("#event_register_button").on("click",function(){
        const form_arr = get_form_val("event_register",true);

        const arg_arr = {
            event_name:form_arr["event_name"]
            ,start_year:form_arr["start_day"].split("-")[0]
            ,end_year:form_arr["end_day"].split("-")[0]
            ,start_month:form_arr["start_day"].split("-")[1]
            ,end_month:form_arr["end_day"].split("-")[1]
            ,start_day:form_arr["start_day"].split("-")[2]
            ,end_day:form_arr["end_day"].split("-")[2]
            ,start_hour:form_arr["start_time"].split(":")[0]
            ,end_hour:form_arr["end_time"].split(":")[0]
            ,start_minute:form_arr["start_time"].split(":")[1]
            ,end_minute:form_arr["end_time"].split(":")[1]
            ,start_second:"00"
            ,end_second:"00"
        }

        call_stored("register_event",arg_arr).then(function(data){
            console.log(data);
        },function(data){
            console.log(data);
        });
    });
});