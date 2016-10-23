function timer()
{
  $secondes--;
  if ($secondes < 0)
    {
      if ($minutes == 0){
        clearInterval($counter);
        $("form").submit();
      }
      $secondes = 59;
      $minutes--;
    }
 $("#timer").html($minutes + ":" + $secondes);
}

var readyDocument = function(){
   $("#button-checkbox").click(function(){
    $value = $(this).attr("value");
    if($value == "0"){
      $(this).next().next().prop("checked", true);
      $(this).attr("value","1");
      $(this).attr("class","btn btn-info");
      $("#button-checkbox i").attr("class",
        "state-icon glyphicon glyphicon-check");
    }
    else if($value == "1"){
      $(this).next().next().prop("checked", false);
      $(this).attr("value","0");
      $(this).attr("class","btn btn-default");
      $("#button-checkbox i").attr("class",
        "state-icon glyphicon glyphicon-unchecked");
    }
  });
  $counter = setInterval(timer, 1000);
};

var readyJs = function(){
  $duration = parseInt($("#lesson_duration").attr("value"));
  $minutes = Math.floor($duration/60);
  $secondes = $duration - ($minutes * 60);
}

$(document).on("turbolinks:load", readyJs);
$(document).on("ready", readyDocument);
