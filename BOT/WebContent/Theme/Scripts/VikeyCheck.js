$(function () {
    if ($("body embed").length<=0) {
        $("body").append("<embed id='ViKeyInterface' type='application/npViKeyInterface-plugin' width='0' height='0' />");
        if (LoadViKeyInterface()) {
            CheckHasVikey();
        }
    }
});

var ViKeyInterface;

//循环调用
function CheckHasVikey() {
    ViKeyInterface.IVikeyFind();
    if (ViKeyInterface.IViKeyGetError() != 0) {
        $.post("/SafeDog/RemoveDog");
        try{
            closePage();
        } catch (e) {

        }        
    } else {
        setTimeout("CheckHasVikey();", 1000);
    }    
}


function LoadViKeyInterface() {
    var ViKeyCount;
    try {
        //创建ViKey加密狗控件
        if (document.implementation && document.implementation.createDocument && typeof XSLTProcessor != 'undefined') {            
            ViKeyInterface = document.getElementById('ViKeyInterface');// chrome, firefox etc
        }
        else {            
            ViKeyInterface = new ActiveXObject("ViKeyActiveX.ViKeyInterface.1");// IE
        }

        var ViKeyCount;
        ViKeyCount = ViKeyInterface.IVikeyFind();
    }

    catch (e) {
        return false;
    }

    return true;
}
