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
var is_audio = false;
var img_files = [];
function readURL(input) {
  $(".galary").show();
  if (input.files && input.files[0]) {
    var filesAmount = input.files.length;
    var a = 0;
    for (i = 0; i < filesAmount; i++) {

      img_files.push(input.files[i]);
      (function (file, i) {
        var img_reader = new FileReader();

        img_reader.onload = function (event) {
          if (file.type.split('/')[0] == "image"){
          $('.galary').append('<div class="col-lg-5 pip pip' + i + '"><img class="imageThumb" src=' + event.target.result + ' title="image"/><br/><br/><span onclick="deletepic(' + i + ')" class="remove image' + i + '">Remove image</span></div>')
          } else if (file.type.split('/')[0] == "video") { 
              $('.galary').append('<div class="col-lg-5 pip pip' + i + '"><video class="imageThumb" controls><source src=' + event.target.result + ' title="video" type="'+file.type+'">/><br/><br/></video><span onclick="deletepic(' + i + ')" class="remove image' + i + '">Remove Video</span></div>')
          }  else if (file.type.split('/')[0] == "audio") {
               $('.galary').append('<div class="col-lg-5 pip pip' + i + '"><audio class="imageThumb" controls><source src=' + event.target.result + ' title="video" type="'+file.type+'">/><br/><br/></audio><span onclick="deletepic(' + i + ')" class="remove image' + i + '">Remove Audio</span></div>')
          }
        }
        img_reader.readAsDataURL(file);
      })(input.files[i], i);
    };
  }
}
function deletepic(id) {
  if (img_files.length <= 1) {
    $(".galary").hide();
  }
  img_files.splice(id, 1)
  $(".pip" + id).remove();


}
function post() {
  var formData = new FormData();
  content = document.getElementById("content").value;
  tags = document.getElementById("tags").value;
  loc = document.getElementById("location").value;
  let i = 0;
  img_files.map(res => {
    console.log(res);
    formData.append("media[]", res)
    i = i + 1;
  })

  formData.append("content", content)
  formData.append("tags", tags)
  formData.append("location", loc)
  $.ajax({
    type: 'POST',
    data: formData,
    processData: false,
    contentType: false,
    url: '/posts',
    success: function (res) {

    }
  });
}
var x = document.getElementById("location");
function getLocation() {
  $.ajax({
    type: 'POST',
    url: 'https://www.googleapis.com/geolocation/v1/geolocate?key=AIzaSyChEOROGegVKCpcVRKbV61T4gN1aBYGrZ4',
    success: function (res) {
      showPosition(res.location);
    }
  });
}
function showPosition(position) {
  $.ajax({
    type: 'POST',
    url: 'https://maps.googleapis.com/maps/api/geocode/json?latlng='+position.lat + ','+ position.lng +'&key=AIzaSyChEOROGegVKCpcVRKbV61T4gN1aBYGrZ4',
    success: function (res) {
      $("#location").val(res.plus_code.compound_code.split(" ")[1]);
    }
  });
}
function uploadFile(up_type){
  if(up_type == "image"){
    $("#image_upload").click()
  } else if(up_type == "video"){
    $("#video_upload").click()
  } else if( up_type == "audio") {
    $("#audio_upload").click()
  }
}