 
	function  messageshowfunction(showOutTime,theme,msgText,textVisible,textonly,html){
		$.mobile.loading( "show", {
				text: msgText,
				textVisible: textVisible,
				theme: theme,
				textonly: textonly,
				html: html
		});
		 var st = setTimeout(function (){
			$.mobile.loading( "hide" );
			clearTimeout(st);
		},showOutTime); 
	}
 