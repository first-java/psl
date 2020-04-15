$(function () {
    $("#WorkID").focus();

    $("#login-form").validate({
        errorElement: 'div',
        errorClass: 'error-msg',
        focusInvalid: true,
        rules: {
            WorkID: {
                required: true
            },
            SystemType: {
                required:true
            }
        },
        messages: {
            WorkID: {
                required: "用户名不能为空！"
            },
            SystemType: {
                required: "请选择系统！"
            }
        }
    });

    $("#login-form").ajaxForm({
        beforeSubmit: function () {
            //跨域请求
            var $option = $("#SystemType").find("option:selected");
            var status = $option.attr("status");
            if (status) {
                if (status == "0") {
                    $("#serverMsg").text($option.attr("message"));
                    return false;
                }
            }
            $("#serverMsg").text("");

            layer.load();

            var workid = $("#WorkID").val();
            var password =  $("#PassWord").val();
            var action = $("#SystemType").val();
            var url = action + "/User/Login?WorkID=" + workid + "&Password=" + password;

            $("head").append('<script src="' + url + '" ></script>');
            return false;
        }
    });

    $("#forgot-from").validate({
        errorElement: 'div',
        errorClass: 'error-msg',
        focusInvalid: true,
        rules: {
            Password: {
                required: true,
                myPassword: true,
                minlength:8,                
            },
            Password1: {
                equalTo: "#forgot-password",
            }
        },
        messages: {
            Password: {
                required: "密码不能为空！",
                minlength:"密码长度不能少于8位！"
            },
            Password1: {
                equalTo: "再次密码输入不一致，请重新输入！"
            }
        },
        errorPlacement: function (error, element) {
            error.appendTo(element.parent().parent());
        }
    });

    $("#forgot-from").ajaxForm({
        beforeSubmit: function () {
            layer.load();
            var workid = $("#forgot-workid").val();
            var password = $("#forgot-password").val();
            var action = $("#SystemType").val();
            var url = action + "/User/Forgot?WORKID=" + workid + "&Password=" + password;

            $("head").append('<script src="' + url + '" ></script>');
            return false;
        }
    });

    $.backstretch([
        "/Theme/images/login_img/user_back.jpg"
    ], {
        fade: 1000,
        duration: 8000
    });

    setPasswordValidate("forgot-password");
    setPasswordValidate("forgot-password1");

    $.post("/User/GetSystemOption", function (msg) {
        $("#SystemOption").html(msg);
        $("#btnSubmit").removeClass("disabled");
        //选择系统
        $("#SystemType").change(function () {
            var action = $(this).val();
            $("#login-form").attr("action", action);

            var $option = $(this).find("option:selected");
            var status = $option.attr("status");
            if (status) {
                if (status == "0") {
                    $("#serverMsg").text($option.attr("message"));
                    return false;
                }
            }
            $("#serverMsg").text("");
        });
        try{
            if ($("#rember").attr("checked") == "checked") {
                var href = $.cookie("SystemType");
                if (href) {
                    $("#SystemType").val(href);
                }
            }
        } catch (e) {
            console.log(e);
        }
    }).error(function (data) {
	    document.write(data.responseText);
    });    
});
function show_box(id) {
    jQuery('.widget-box.visible').removeClass('visible');
    jQuery('#' + id).addClass('visible');
    $("#forgot-password").keyup();
    $("#forgot-password1").keyup();
}

function resetForm() {
    $(".myPassword").attr("data-percent", "密码强度：较弱").children().css("width", "0%");
    $("#forgot-password").focus();
}
//登录跨域请求结果
function loginResult(status, message) {
    if (status == "success") {
        var href = $("#SystemType").val();
        try {
            var value = href;
            if ($("#rember").attr("checked") != "checked") {
                value = "";
            }
            $.cookie('SystemType', value, { expires: 365 });
        } catch (e) {
            console.log(e)
        }
        window.location = href;
    } else if (status == "warning") {
        layer.closeAll();
        $("#forgot-workid").val($("#WorkID").val());                
        $("#forgot-password").val('');
        $("#forgot-password1").val('');
        show_box('forgot-box');
    } else {
        layer.closeAll();
        layer.msg(message, { icon: 2 });
        $("#PassWord").select();
    }
}
//重设密码跨域请求
function forgotResult(status, message) {
    if (status == "success") {
        window.location = $("#SystemType").val();
    } else {
        layer.closeAll();
        layer.msg(message, { icon: 2 });        
    }
}