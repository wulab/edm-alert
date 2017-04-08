$(document).ready(function() {
  $("#user_postal_code").keyup(_.debounce(checkValidLocation, 1000));
});

function checkValidLocation() {
  var element = $(this);
  var container = element.parent(".form-group");
  var url = "http://www.safetyalert.me/api/v1/locations/" + element.val();
  var req = $.ajax({
    url : url,
      dataType : "json",
      success : function(response) {
        if(response.data.message == "Not Found") {
          $(".help-block").remove();
          container.addClass("has-error").removeClass("has-success");
          container.append('<div class="help-block">รหัสไปรษณีย์ไม่ถูกต้อง</div>');
        } else {
          $(".help-block").remove();
          container.removeClass("has-error").addClass("has-success");
          container.append('<div class="help-block">คุณอยู่ในพื้นที่ ' +
            response.data.location.district +
            ', ' +
            response.data.location.province +
            '</div>');
        }
      }
  });
}
