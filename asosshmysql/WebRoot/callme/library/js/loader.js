$(document).ready(function() {
	initBase();
	//initSliders();
	initKutaRedactor();  //文本编辑
	initMyMaps();     //加载百度地图
	initFormAddOns();
	startServer() ;   //加载websocket
	isCallHotelAdmin(); //与餐厅管理员聊天
});
function initBase(){
	$('.bottom_tooltip').tooltip({
		placement: 'bottom'
	});
	$('.left_tooltip').tooltip({
		placement: 'left'
	});
	$('.right_tooltip').tooltip({
		placement: 'right'
	});
	$('.top_tooltip').tooltip();
	
	$('.alert-message a.close').live('click', function(){
		$(this).parent().parent('.c-alert').slideUp('slow');
	});
	$('.dropdown-menu').click(function(event){
		event.stopPropagation();
	});
	$('a.dropdown-toggle, .dropdown-menu a').on('touchstart', function(event) {
		event.stopPropagation();
	});
	$('.carousel').carousel();
	$('.accordion-body.collapse.in').prev('.accordion-heading').addClass('acc-active');
	$('.accordion-heading').live('click', function(){
		$('.accordion-heading').removeClass('acc-active');
		$(this).addClass('acc-active');
	});
	$(".fancy").uniform();
}
 
 
 
 
 
 
function initSliders(){
	$( "#eq1 > div" ).each(function() {
		var value = parseInt( $(this).attr('rel'), 10 );
		$( this ).slider({
			value: value,
			range: "min",
			animate: true,
			orientation: "horizontal"
		});
	});
	
	$( "#eq2 > span" ).each(function() {
		// read initial values from markup and remove that
		var value = parseInt( $( this ).text(), 10 );
		$( this ).empty().slider({
			value: value,
			range: "min",
			animate: true,
			orientation: "vertical"
		});
	});
	if (document.getElementById('slider-range')) {
		$( "#slider-range" ).slider({
			range: true,
			min: 0,
			max: 500,
			values: [ 75, 300 ],
			slide: function( event, ui ) {
				$( "#amount" ).val( "$" + ui.values[ 0 ] + " - $" + ui.values[ 1 ] );
			}
		});
		
		$( "#amount" ).val( "$" + $( "#slider-range" ).slider( "values", 0 ) +
			" - $" + $( "#slider-range" ).slider( "values", 1 ) );
	}
}
function initKutaRedactor(){
	$( ".fullRedactor" ).each(function(){
		$(this).redactor();
	});
	$( ".statusRedactor" ).each(function(){
		$(this).redactor({
			buttons: ['image', 'video', 'file', 'link']
		});
	});
	$( ".commentRedactor" ).each(function(){
		$(this).redactor({
			buttons: ['bold', 'italic']
		});
	});
}
function initMyMaps(){
 
}

function initFormAddOns(){
	$( ".cselect" ).each(function(){
		$(this).chosen();
	});
	$( ".chzn-select-deselect" ).each(function(){
		$(this).chosen({allow_single_deselect:true});
	});
	
	$( ".datePicker" ).each(function(){
		$(this).datepicker({
			format: 'mm-dd-yyyy'
		});
	});
	$('.timePicker').each(function(){
		$(this).timePicker({
		show24Hours: false,
		separator:'.',
		step: 5});
		$('.time-picker').width($(this).width()+12);
	});	
}