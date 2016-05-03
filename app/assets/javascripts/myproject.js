

 $(document).ready(function () {
  $(".dialog_link").bind("click",function(event){
    var title = $(this).attr("title");
	  var url = $(this).attr("href");
	  $('#grp_members').load(url,function(){
      init_typehead();
    });
	  return false;
  });


});

function hideMessage(element) {
	 window.setTimeout(
    function() {
        $(element).hide();
    }, 4000);

}

function init_typehead(){
  $('#typeahead-input').typeahead({
    source: function (query, process) {
      $.ajax({
        url:' /users/search',
        type: 'POST',
        dataType: 'JSON',
        data: 'query=' + query,
        success: function(data) {
          //console.log(data);
          process(data);
        }
      });
    },
    updater: function(item) {
      $('#typeahead-input').val(item.name);
      $('#typeahead-input').closest('form').find("#group_member_user_id").val(item.id);
    },
  });
}