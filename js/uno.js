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
