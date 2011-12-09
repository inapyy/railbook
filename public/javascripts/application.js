$(function() {
  $('*')
    .ajaxStart   (function() { $('#progress').html('通信中...') })
    .ajaxComplete(function() { $('#progress').html('') });
});