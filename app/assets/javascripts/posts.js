function delPost(id) {
  var x = confirm("Are you sure you want to delete?");
  if (x) {
    $.ajax({
      type: 'DELETE',
      url: '/posts/' + id,
      success: function () {
        $(".post" + id).addClass("disable_media_vid")
      }
    });
  }
}
function openComment(id) {
  var class_name = $("#cmd_sec"+ id).attr('class');
  if (class_name.split(" ")[1] == "disabled-comments") {
    $("#cmd_sec" + id).removeClass("disabled-comments");
    $("#cmd_sec" + id).addClass("enable_comments  ");
  } else {
    $("#cmd_sec" + id).addClass("disabled-comments");
    $("#cmd_sec" + id).removeClass("enable_comments  ");
  }

}

function postComment(id) {
  comment = document.getElementById('comment' + id).value;
  post_id = id;
  data = { comment: comment, post_id: post_id }
  $.ajax({
    type: 'POST',
    data, data,
    url: '/comments',
    success: function (res) {
      $("#cmd_sec" + id).prepend(res);
      document.getElementById('comment' + id).value = '';
      commantcount(post_id);
    }
  });

}
function commantcount(post_id) {
  $.ajax({
    type: 'GET',
    url: '/comments/comments_count?id=' + post_id,
    success: function (res) {
      document.getElementById('cmd_count' + post_id).innerHTML = res;
    }
  });
}

// function delCmd(id, post_id) {
//   var x = confirm("Are you sure you want to delete?");
//   if (x) {
//     $.ajax({
//       type: 'DELETE',
//       url: '/comments/' + id,
//       success: function () {
//         $(".comment" + id).addClass("disable_media_vid")
//         commantcount(post_id)
//       }
//     });
//   }

// }
function likePost(post_id, user_id) {
  data = { user_id: user_id, post_id: post_id }
  $.ajax({
    type: 'POST',
    data, data,
    url: '/posts/like',
    success: function (res) {
      console.log(res)
      if (res.is_like) {
        $("#like" + post_id).addClass("active");
        document.getElementById('like_count' + post_id).innerHTML = res.like_count;
      } else {
        $("#like" + post_id).removeClass("active");
        document.getElementById('like_count' + post_id).innerHTML = res.like_count;
      }
    }
  });
}
