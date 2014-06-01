// IIFE
(function($) {
    $.organicTabs = function(el, options) {
        var base = this;
        base.$el = $(el);
        base.$nav = base.$el.find(".nav");
        base.init = function() {
           base.options = $.extend({},$.organicTabs.defaultOptions, options);
            $(".hide").css({
                "position": "relative",
                "top": 0,
                "left": 0,
                "display": "none"
            }); 
            base.$nav.delegate("a", "click", function(e) {
            		e.preventDefault();
                var curList = base.$el.find("a.current").attr("href").substring(1),
                    $newList = $(this),
                    listID = $newList.attr("href").substring(1),
                    $allListWrap = base.$el.find(".list-wrap"),
                    curListHeight = $allListWrap.height();
                		$allListWrap.height(curListHeight);
                if ((listID != curList) && ( base.$el.find(":animated").length == 0)) {
                    base.$el.find("#"+curList).fadeOut(base.options.speed, function() {
                        base.$el.find("#"+listID).fadeIn(base.options.speed);
                        var newHeight = base.$el.find("#"+listID).height();
                        $allListWrap.animate({
                            height: newHeight
                        }, base.options.speed);
                        base.$el.find(".nav li a").removeClass("current");
                        $newList.addClass("current");
						if (window.history && history.pushState) {
							history.replaceState("", "", "?" + base.options.param + "=" + listID);
						}    
                    });
                    
                }   

            });
            
            var queryString = {};
			window.location.href.replace(
			    new RegExp("([^?=&]+)(=([^&]*))?", "g"),
			    function($0, $1, $2, $3) { queryString[$1] = $3; }
			);
            
            if (queryString[base.options.param]) {
            	var tab = $("a[href='#" + queryString[base.options.param] + "']");
            	tab.closest(".nav")
								.find("a")
								.removeClass("current")
								.end()
								.next(".list-wrap")
								.find("ul")
								.hide();
							tab.addClass("current");
							$("#" + queryString[base.options.param]).show();
			            
			        };            
            
        };
        base.init();
    };
    
		$.organicTabs.defaultOptions = {
		    "speed": 300,
		    "param": "tab"
		};
    
    $.fn.organicTabs = function(options) {
        return this.each(function() {
            (new $.organicTabs(this, options));
        });
    };
    
})(jQuery);