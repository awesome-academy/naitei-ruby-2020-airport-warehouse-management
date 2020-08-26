const all_value = 1
const radar_value = 2
const ready_value = 3
$("#select").change(function(){
  $(".table-content").remove()
  if($("#select option:selected")[0].value == all_value){
    $("#table-content-body").html("<%= j render @locations %>");
  }else if($("#select option:selected")[0].value == radar_value){
    $("#table-content-body").html("<%= j render @radars %>");
  }else if($("#select option:selected")[0].value == ready_value){
    $("#table-content-body").html("<%= j render @readys %>");
  }
})
