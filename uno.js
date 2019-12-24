function draw_card(color, number) {
    var card;
    var color_css;
    if (color === '+') {
        card = '/images/+.png';

    } else if (color === 'C') {
        card = '/images/C.png';

    } else if (color === 'K') {
        card = '/images/K.png';
    } else {
        card = '/images/R' + number + '.png';
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
        default :
            color_css = 'special';
        
    }
    $('#hand').append($('<img>', {
        class: color_css,
        src: card
    }))
}
