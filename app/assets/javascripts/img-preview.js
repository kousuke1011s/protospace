$(document).on('turbolinks:load', function() {
  $('.js-imgfile-uploader').change(function() {
    var input = $(this);
    var fr = new FileReader();
    fr.onload = function() {
      input.parent('.js-img-preview').css("background-image", "url("+fr.result+")");
    };
    fr.readAsDataURL(this.files[0]);
  });
})
