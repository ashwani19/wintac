/**
 * Created by Inveera PC10 on 6/27/2014.
 */

 



function find_Type()
{
    if($("#role").val()=='employee')
    {
        $("#emp").show();
        $("#cust").hide();
    }
    else if($("#role").val()=='customer'){
        $("#emp").hide();
        $("#cust").show();
    }
}
function active_user(id)
{
    Em.$.ajax({
     url: '/user_data/active_user',
     type: 'post',
     data :{'user_id' : id},
     success: function(data){
        var change_active="#a_"+id;
     if (data.active==1){

    $(change_active).removeClass('btn-primary');
    $(change_active).addClass('btn-warning');
    

    $(change_active).text("Inactive");
}
    else
    {
    $(change_active).removeClass('btn-warning');
    $(change_active).addClass('btn-primary');
    $(change_active).text("Active"); 
    }
     }
    });
}
