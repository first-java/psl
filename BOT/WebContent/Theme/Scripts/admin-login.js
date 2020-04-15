$(function () {
    $("#WorkID").focus();

    $("#login-form").validate({
        errorElement: 'div',
        errorClass: 'error-msg',
        focusInvalid: true,
        rules: {
            WorkID: {
                required: true
            }
        },
        messages: {
            WorkID: {
                required: "用户名不能为空！"
            }
        }
    });

    $("#login-form").ajaxForm({
        beforeSubmit: function () {
            layer.load();
        },
        success: function (json) {
            if (json.Status == "success") {
                window.location = "/User/Index";
            } else if (json.Status == "warning") {
                layer.closeAll();
                $("#forgot-workid").val($("#WorkID").val());
                $("#forgot-password").val('');
                $("#forgot-password1").val('');
                show_box('forgot-box');
            } else {
                layer.closeAll();
                layer.msg(json.Message, { icon: 2 });
                $("#PassWord").select();
            }
        }, error: function (data) { document.write(data.responseText);}
    });

    $("#forgot-from").validate({
        errorElement: 'div',
        errorClass: 'error-msg',
        focusInvalid: true,
        rules: {
            Password: {
                required: true,
                myPassword: true
            },
            Password1: {
                equalTo: "#forgot-password"
            }
        },
        messages: {
            Password: {
                required: "密码不能为空！"
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
        },
        success: function (json) {
            if (json.Status == "success") {
                window.location = "/User/Index";
            } else {
                layer.closeAll();
                layer.msg(json.Message, { icon: 2 });
            }
        }, error: function (data) { document.write(data.responseText); }
    });

    $.backstretch([
        "/Theme/images/login_img/admin_back.jpg"
    ], {
        fade: 1000,
        duration: 8000
    });

    setPasswordValidate("forgot-password");
    setPasswordValidate("forgot-password1");
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