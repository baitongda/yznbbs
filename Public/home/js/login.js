$(function(){
    $("input[type='submit']").click(function(){
     var self = $("#login");
      $.post(self.attr("action"), self.serialize(), success, "json");
      return false;
      function success(data){
          if(!data.status){
             alert(data.info);
          }else{
             window.location.href = data.url;
          }

      }
    });
});
