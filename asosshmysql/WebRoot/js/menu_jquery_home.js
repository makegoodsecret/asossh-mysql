$( document ).ready(function() {
$('#cssmenu_home ul ul li:odd').addClass('odd');
$('#cssmenu_home ul ul li:even').addClass('even');
$('#cssmenu_home > ul > li > a').click(function() {
  $('#cssmenu_home li').removeClass('active');
  $(this).closest('li').addClass('active');	
  var checkElement = $(this).next();
  if((checkElement.is('ul')) && (checkElement.is(':visible'))) {
    $(this).closest('li').removeClass('active');
    checkElement.slideUp('normal');
  }
  if((checkElement.is('ul')) && (!checkElement.is(':visible'))) {
    $('#cssmenu_home ul ul:visible').slideUp('normal');
    checkElement.slideDown('normal');
  }
  if($(this).closest('li').find('ul').children().length == 0) {
    return true;
  } else {
    return false;	
  }		
});
});