var submitting= false;

function init(chat_url) {
    $('#post-form').attr("action","javascript:ajax_form_submit('"+chat_url+"')");
    $('#submit-button').hide(); // FF won't submit if we remove it'
    start_poll_timer(chat_url);
}

function ajax_form_submit(chat_url) {
    submitting= true;
    ajax_update(
        chat_url,
        {
            after: last_post_id(),
            author: $("#author").attr("value"),
            msg: $("#msg").attr("value")
        });
    $("#msg").val("");
    submitting= false;
}

function ajax_poll_request(chat_url) {
    if (!submitting) {
        ajax_update(chat_url, {
            after: last_post_id()
        });
    }
    start_poll_timer(chat_url)
}

function last_post_id() {
    return $("tr:eq(0) td:eq(1)").attr("id");
}

function ajax_update(chat_url, params) {
    $.ajax({
        url: chat_url,
        type: "get",
        data: params,
        success: function(row_html){
            $("#posts tr:first").before(row_html);
        }
    });
}

function start_poll_timer(chat_url) {
    setTimeout("ajax_poll_request('"+chat_url+"')", 50000);
}


