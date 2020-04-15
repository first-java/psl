function checkJatoolsPrinterInstalled(){
    var support = false, err = null, bs = ["MSIE", "Trident"];//,"Firefox","Chrome"];
	for(var i=0;i<bs.length;i++){
		if(navigator.userAgent.indexOf(bs[i])>-1){
			support=true;
			break;
		}
	}
	if(!support){
	    err = "警告:打印控件只能在IE浏览器下运行,请使用IE浏览器进行打印!";
	    $("body").before("<div class='browserInfo'>" + err + "</div>");
	    $("#printView").attr("disabled", true)
	    $("#print").attr("disabled", true)
	}
}