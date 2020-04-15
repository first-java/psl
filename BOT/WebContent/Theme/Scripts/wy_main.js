window.art = new Object();
art.alert = function (text, callback) {
    var d = dialog({
        width: 360,
        fixed: true,
        title: '提示',
        content: text,
        okValue: '确定',
        ok: function () {
            d.close().remove();
            if (callback) callback();
        }
    });
    d.showModal();
}
art.confirm = function (text, ok, cancel) {
    var d = dialog({
        width: 360,
        fixed: true,
        title: '提示',
        content: text,
        okValue: '确定',
        ok: function () {
            if (ok) ok();
        },
        cancelValue: '取消',
        cancel: function () {
            if (cancel) cancel();
        }
    });
    d.showModal();
}

//注册密码等级判断
function setPasswordValidate(obj) {
    var regSuzi = /[0-9]+/;
    var regZimu = /[A-Za-z]+/;
    var regFuhao = /[^0-9a-zA-Z]+/;

    $("#" + obj).keyup(function () {
        var pwd = $(this).val();
        var cssElement = $(this).attr("id");

        if (regSuzi.test(pwd) && regZimu.test(pwd) && regFuhao.test(pwd)) {
            $("." + cssElement).attr("data-percent", "密码强度：较强").children().css("width", "100%").attr("class", "progress-bar progress-bar-success");
        } else if ((regSuzi.test(pwd) && regZimu.test(pwd)) || (regSuzi.test(pwd) && regFuhao.test(pwd)) || (regZimu.test(pwd) && regFuhao.test(pwd))) {
            $("." + cssElement).attr("data-percent", "密码强度：中等").children().css("width", "66%").attr("class", "progress-bar progress-bar-yellow");
        } else if (regSuzi.test(pwd) || regZimu.test(pwd) || regFuhao.test(pwd)) {
            $("." + cssElement).attr("data-percent", "密码强度：较弱").children().css("width", "33%").attr("class", "progress-bar progress-bar-danger");
        } else {
            $("." + cssElement).attr("data-percent", "密码强度：较弱").children().css("width", "0%").attr("class", "progress-bar progress-bar-danger");
        }
    });
}
//扩展JQuery显示消息
$.showMessage = function (msg) {
    var d = dialog({
        content: msg
    });
    d.showModal();
    setTimeout(function () {
        d.close().remove();
    }, 2000);
}

$.showTip=function (msg) {
    var d = dialog({
        content:'<span class="jbox-icon jbox-icon-loading" style="position:absolute;top:4px;left:4px; width:32px; height:32px;"></span>'+msg
    });
    d.showModal();
    setTimeout(function () {
        d.close().remove();
    }, 2000);
}

$.ShowNotifications = function (_title,_content) {
    $.gritter.add({        
        title: _title,
        text: _content,
        sticky: true,
        class_name: 'gritter-error'
    });
}
//检查系统运行错误消息
$(function () {
    //CheckErrorMsg();    
});
var t=null;
function CheckErrorMsg() {
    $.get("/Admin/CheckErrorMsg", function (msg) {
        if (msg) {
            eval(msg);
        } else {
            t = setTimeout("CheckErrorMsg()", 5000);
        }
    });
}
