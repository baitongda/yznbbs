$(function(){
    $("input[type='submit']").click(function(){
     var self = $("#login");
      $.post(self.attr("action"), self.serialize(), success, "json");
      return false;
      function success(data){
          if(!data.status){
             $('.problem').replaceWith('<div class="problem">请解决以下问题然后再提交：<ul><li>'+data.info+'</li></ul></div>');
          }else{
             window.location.href = data.url;
          }

      }
    });
});
