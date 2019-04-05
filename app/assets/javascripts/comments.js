function delCmd(id, post_id) {
    var x = confirm("Are you sure you want to delete?");
    if (x) {
      $.ajax({
        type: 'DELETE',
        url: '/comments/' + id,
        success: function () {
          $(".comment" + id).addClass("disable_media_vid")
          commantcount(post_id)
        }
      });
    }
    
  }
  function commantcount(post_id){
    $.ajax({
      type: 'GET',
      url: '/comments/comments_count?id='+ post_id,
      success: function (res) {
        document.getElementById('cmd_count'+ post_id).innerHTML= res;
      }
    });
  }