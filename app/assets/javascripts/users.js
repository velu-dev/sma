function notifyStatus(notify) {
    
    notification_id = notify;
    data = { is_read: true}
    $.ajax({
      type: 'POST',
      data, data,
      url: '/users/notification_status?id='+ notification_id,
      success: function (res) {
        if (res.status){
            
        }
      }
    });
  
  }