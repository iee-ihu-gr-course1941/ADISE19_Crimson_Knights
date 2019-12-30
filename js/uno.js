function draw_card(color, card_number, deck_number, element) {
    var card, color_css, card_id;
    switch (color) {
        case '+':
            card = '/images/+.png';
            break;
        case 'C':
            card = '/images/C.png';
            break;
        case 'K':
            card = '/images/K.png';
            break;
        default:
            card = '/images/R'+card_number+'.png';
            break;

    }
    switch (color) {
        case 'R':
            color_css = 'red';
            break;
        case 'G':
            color_css = 'green';
            break;
        case 'B':
            color_css = 'blue';
            break;
        case 'P':
            color_css = 'purple';
            break;
        default:
            color_css = 'special';

    }
    card_id = color + '/' + card_number + '/' + deck_number;
    $(element).append($('<img>', {
        id: card_id,
        class: color_css,
        src: card,
    }))
}

function ajax_request(request, method_parameter, function_parameter) {
    $.ajax({
        url: request,
        method: method_parameter,
        headers: {
            "X-Token": "36957abd1125613f4bbcbc859ab3c2a3"
        },
        success: function (data) {
            if (function_parameter === "draw_hand") {
                draw_hand(data);
            } else {

            }

            switch (function_parameter) {
                case 'draw_hand':
                    draw_hand(data, '#hand');
                    break;
                case 'draw_top_card':
                    draw_hand(data, '#top_card');
                    break;
                case 'update_players':
                    update_players(data);
                    break;
            }
        },
        error: function (data) {
            alert(data.responseJSON.error_mysqli + "\n" + data.responseJSON.error_statement);
        }
    });

}


function draw_hand(data, element) {
    for (var i = 0; i < data.length; i++) {
        draw_card(data[i].COLOR, data[i].NUMBER, data[i].DECK_NUM, element);
    }
}

function reset_board() {
    $('#hand').empty();
    $('#top_card').empty();
    $('.player_box .name').each(function () {
        $(this).empty();
    });
    $('.player_box .number_of_cards').each(function () {
        $(this).empty();
    });
}

function update_players(data){
    $('.player_box .name').each(function (index) {
        $(this).html(data[index].USER_NAME)
    });
    $('.player_box .number_of_cards').each(function (index) {
        $(this).html(data[index].TURN_NUMBER);
    });
}

function update_board() {
    reset_board();
    ajax_request('/uno.php/hand', 'GET', 'draw_hand');
    ajax_request('/uno.php/top_card', 'GET', 'draw_top_card');
    ajax_request('/uno.php/get_players', 'GET','update_players');
}
