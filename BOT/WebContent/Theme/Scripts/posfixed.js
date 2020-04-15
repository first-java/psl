(function ($) {
    $.extend($.fn, {
		posfixed: function(configSettings){
            var settings = {
            	direction:"top",
            	type:"while",
            	hide:false,
				distance:0
			};			
			$.extend(settings, configSettings);

			//initial
			if($.browser.msie&&$.browser.version==6.0){
				$("html").css("overflow","hidden");
				$("body").css({
					height:"100%",
					overflow:"auto"
				});
			}
			
			var obj = this;
			var initPos = $(obj).offset().top;
			var initPosLeft = $(obj).offset().left;
			var anchoredPos = settings.distance;

			var currentWidth = 0;

			if(settings.type=="while"){
				if($.browser.msie&&$.browser.version==6.0){
					$("body").scroll(function(event) {
						var objTop = $(obj).offset().top - $("body").scrollTop();
						if(objTop<=settings.distance){
							$(obj).css("position","absolute");
							$(obj).css("top",settings.distance+"px");
							$(obj).css("left",initPosLeft+"px");
						}
						if($(obj).offset().top<=initPos){						
							$(obj).css("position","static");
						}

						initTableWidth();
					});

					
				}else{
					$(window).scroll(function(event) {

						if(settings.direction == "top"){
							var objTop = $(obj).offset().top - $(window).scrollTop();
						
							if(objTop<=settings.distance){
								$(obj).css("position","fixed");
								$(obj).css(settings.direction,settings.distance+"px");
								
							}
							if($(obj).offset().top<=initPos){
								$(obj).css("position","static");
							}
						}else{
							var objBottom = $(window).height() - $(obj).offset().top + $(window).scrollTop() - $(obj).outerHeight() ;
							
							if(objBottom<=settings.distance){
								
								$(obj).css("position","fixed");
								$(obj).css(settings.direction,settings.distance+"px");
								
							}
							if($(obj).offset().top>=initPos){
								$(obj).css("position","static");
							}
						}

						initTableWidth();
					});
				}
			}

			function initTableWidth() {
			    var tdArray = $(".fixed-table tbody tr:first").find("td");
			    if (currentWidth != $(tdArray[tdArray.length - 1]).width()) {
			        for (var i = 0; i < tdArray.length; i++) {
			            var width = $(tdArray[i]).width();
			            $(".fixed-table thead th").eq(i).width(width);
			        }
			        currentWidth = 0;
			    }
			    if (currentWidth == 0) {
			        currentWidth = $(tdArray[tdArray.length - 1]).width();
			    }
			}
			
			if(settings.type=="always"){
				if($.browser.msie&&$.browser.version==6.0){
					if(settings.hide){
						$(obj).hide();
					}
					$("body").scroll(function(event) {
						if($("body").scrollTop()>300){
							$(obj).fadeIn(200);
						}else{
							$(obj).fadeOut(200);
						}
					});
					$(obj).css("position","absolute");
					$(obj).css(settings.direction,settings.distance+"px");
					if(settings.tag!=null){
						if(settings.tag.obj!=null){
							if(settings.tag.direction=="right"){
								$(obj).css("left",(settings.tag.obj.offset().left+settings.tag.obj.width()+settings.tag.distance)+"px");
								$(window).resize(function(){
									$(obj).css("left",(settings.obj.tag.offset().left+settings.tag.obj.width()+settings.tag.distance)+"px");
								});
							}else{
								console.log(settings.tag.obj.offset().left-settings.tag.obj.width()-settings.tag.distance);
								$(obj).css("left",(settings.tag.obj.offset().left-$(obj).outerWidth()-settings.tag.distance)+"px");
								$(window).resize(function(){
									$(obj).css("left",(settings.tag.obj.offset().left-$(obj).outerWidth()-settings.tag.distance)+"px");
								});
							}
							
						}else{
							$(obj).css(settings.tag.direction,settings.tag.distance+"px");
						}
					}

				}else{
					if(settings.hide){
						$(obj).hide();
					}
					$(window).scroll(function(event) {
						if($(window).scrollTop()>300){
							$(obj).fadeIn(200);
						}else{
							$(obj).fadeOut(200);
						}
					});
					var objLeft = $(obj).offset().left;

					$(obj).css("position","fixed");
					$(obj).css(settings.direction,settings.distance+"px");
					if(settings.tag!=null){
						if(settings.tag.obj!=null){
							if(settings.tag.direction=="right"){
								$(obj).css("left",(settings.tag.obj.offset().left+settings.tag.obj.width()+settings.tag.distance)+"px");
								$(window).resize(function(){
									$(obj).css("left",(settings.obj.tag.offset().left+settings.tag.obj.width()+settings.tag.distance)+"px");
								});
							}else{
								console.log(settings.tag.obj.offset().left-settings.tag.obj.width()-settings.tag.distance);
								$(obj).css("left",(settings.tag.obj.offset().left-$(obj).outerWidth()-settings.tag.distance)+"px");
								$(window).resize(function(){
									$(obj).css("left",(settings.tag.obj.offset().left-$(obj).outerWidth()-settings.tag.distance)+"px");
								});
							}
							
						}else{
							$(obj).css(settings.tag.direction,settings.tag.distance+"px");
						}
					}
				}
				
				
				
			}
			
			
		}
	});
	
	
})(jQuery);
