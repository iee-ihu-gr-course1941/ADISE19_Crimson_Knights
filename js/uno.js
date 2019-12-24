var request_data;
var hand;

function draw_card(color, number) {
    var card;
    var color_css;
    if (color === '+') {
        card = '/MyProject/images/+.png';

    } else if (color === 'C') {
        card = '/MyProject/images/C.png';

    } else if (color === 'K') {
        card = '/MyProject/images/K.png';
    } else {
        card = '/MyProject/images/R' + number + '.png';
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
    $('#hand').append($('<img>', {
        class: color_css,
        src: card,
    }))
}

function ajax_request(request, method_parameter, function_parameter) {
    $.ajax({
        url: request,
        method: method_parameter,
        success: function (data) {
            if (function_parameter == "draw_hand") {
                draw_hand(data);
            } else {
                fetch(data);
            }

        }
    });

}

function draw_hand(data) {
    hand = data;
    
    for(var i=0;i<data.length;i++){
        var card = data[i];
        draw_card(card.COLOR,card.NUMBER);
    }
}

function fetch(data) {
    request_data = data;
}
