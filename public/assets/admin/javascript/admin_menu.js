/**
 * 参考h-ui-admin的实现，方法名称没改。
 * http://www.h-ui.net/
 */

/*菜单导航*/
function Hui_admin_tab(obj) {
    var bStop = false,
        bStopIndex = 0,
        href = $(obj).attr('data-href'),
        title = $(obj).attr("data-title"),
        topWindow = $(window.parent.document),
        show_navLi = topWindow.find("#min_title_list li"),
        iframe_box = topWindow.find("#iframe_box");

    if (!href || href == "" || !title || title == "") {
        return false;
    }
    show_navLi.each(function() {
        if ($(this).attr("data-href") == href) {
            bStop = true;
            bStopIndex = show_navLi.index($(this));
            return false;
        }
    });
    if (!bStop) {
        creatIframe(href, title);
    } else {
        show_navLi.removeClass("active").eq(bStopIndex).addClass("active");
        iframe_box.find(".show_iframe").hide().eq(bStopIndex).show().find("iframe").attr("src", href);
    }
}

/*创建iframe*/
function creatIframe(href, titleName) {
    var topWindow = $(window.parent.document),
        show_nav = topWindow.find('#min_title_list'),
        iframe_box = topWindow.find('#iframe_box'),
        iframs = iframe_box.find('.show_iframe');

    // refresh show_nv
    show_nav.find('li').removeClass("active");
    show_nav.append('<li class="active" data-href="' + href + '"><a href="javascript:void(0)">' + titleName + '<i class="glyphicon glyphicon-remove-sign"></i></a></li>');

    // hide old iframes, create iframe
    iframs.hide();
    iframe_box.append('<div class="show_iframe"><div class="loading"></div><iframe frameborder="0" scrolling="no" src=' + href + '></iframe></div>');
    var showBox = iframe_box.find('.show_iframe:visible');
    showBox.find('iframe').on('load', function() {
        showBox.find('.loading').hide();

        // iframe宽高自适应引入的页面
        var iframeHeight = $(this).contents().height();
        var iframeWidth = $(this).contents().width();
        $(this).height(iframeHeight + 'px');
        $(this).width(iframeWidth + 'px');
    });
}

/*关闭iframe*/
function removeIframe() {
    var topWindow = $(window.parent.document),
        iframe = topWindow.find('#iframe_box .show_iframe'),
        tab = topWindow.find("#min_title_list li"),
        showTab = topWindow.find("#min_title_list li.active"),
        showBox = topWindow.find('.show_iframe:visible'),
        i = showTab.index();
    tab.eq(i - 1).addClass("active");
    tab.eq(i).remove();
    iframe.eq(i - 1).show();
    iframe.eq(i).remove();
}

/*关闭所有iframe*/
function removeIframeAll() {
    var topWindow = $(window.parent.document),
        iframe = topWindow.find('#iframe_box .show_iframe'),
        tab = topWindow.find("#min_title_list li");

    tab.remove();
    iframe.remove();
}

$(function() {
    $("#adminMenu").on("click", "a", function() {
        Hui_admin_tab(this);
    });

    $("#min_title_list").on("click", "li", function() {
        // 这里拿到的index为-1，所以下面的代码找的的倒数第一个，即最后一个iframe
        var bStopIndex = $(this).index();
        var iframe_box = $("#iframe_box");
        $("#min_title_list li").removeClass("active").eq(bStopIndex).addClass("active");
        iframe_box.find(".show_iframe").hide().eq(bStopIndex).show();
        return false;
    });

    $("#min_title_list").on("click", "li i", function() {
        var aCloseIndex = $(this).parents("li").index();
        $(this).parent().parent().remove();
        $('#iframe_box').find('.show_iframe').eq(aCloseIndex).remove();

        // 因为点击删除图表"li i"的时候，会网上冒泡，执行"li"绑定的函数，
        // 所以此处，不需要处理高亮最后一个选项卡的逻辑，冒泡到的函数会执行这个逻辑。
        if ($("#min_title_list").find('li.active').length === 1) {
            return false;
        }
    });

    // close all the iframes.
    $('#closeallIframe').on('click', function() {
        removeIframeAll();
        $('#min_title_list').css('left', 0);
    });

    // refresh the current iframe.
    $('#refreshShowIframe').on('click', function() {
        var iframe = $(window.parent.document).find("#iframe_box").find(".show_iframe:visible").find("iframe");
        iframe.attr('src', iframe.attr('src'));
    });

    // 左移菜单选项卡
    $('#tabNavLeft').click(function() {
        var nav = $('#min_title_list');
        if(nav.width() + nav.position().left > 200) {
            moveNav(-1);
        }
    });

    // 右移菜单选项卡
    $('#tabNavRight').click(function() {
        if($('#min_title_list').position().left < 0) {
            moveNav(1);
        }
    });

    function moveNav(direction) {
        var nav = $('#min_title_list');
        var oldLeft = nav.position().left;
        nav.stop().animate({
            'left': oldLeft + direction * 100
        }, 100);
    }
});