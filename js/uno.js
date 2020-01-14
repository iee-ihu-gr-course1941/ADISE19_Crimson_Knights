 var me = {
     token: null
 };

 var enabled = false;
 var special_card_id;

 function draw_card(color, card_number, deck_number, validity, element) {
     var card, card_id;
     if (color == '+' || color == 'C') {
         card = '/images/' + color + '.png';
     } else {
         card = '/images/R' + card_number + '.png';
     }
     card_id = color + '/' + card_number + '/' + deck_number + '/' + validity;
     $(element).append($('<img>', {
         id: card_id,
         class: color + ' disabled',
         src: card,
     }));
 }

 function pass() {
     ajax_request('/uno.php/pass', 'GET','');
 }

 function play_card(obj) {
     id = obj.attributes[0].nodeValue.split('/');
     json_data = JSON.stringify({
         USER_NAME: me.token,
         card: {
             COLOR: id[0],
             NUMBER: id[1],
             DECK_NUM: id[2]
         }
     });
     ajax_send('/uno.php/play_card', 'POST', json_data, '');

 }

 function assign_special_card_id(obj) {
     special_card_id = obj.attributes[0].nodeValue.split('/');
     $('#color_select').show(1000);
     $('#assign_color').show(1000);
 }

 function play_special_card() {
     active_color = $('#color_select').val();
     id = special_card_id;
     json_data = JSON.stringify({
         USER_NAME: me.token,
         card: {
             COLOR: id[0],
             NUMBER: id[1],
             DECK_NUM: id[2],
             ACTIVE_COLOR: active_color
         }
     });
     $('#color_select').hide(1000);
     $('#assign_color').hide(1000);
     ajax_send('/uno.php/play_card', 'POST', json_data, '');
 }

 function test() {
     ajax_request('/uno.php/', 'GET', '');
 }

 function get_card() {
     ajax_request('/uno.php/get_card', 'GET', '');
 }

 function sign_in() {
     if ($('#sign_in').val() == '') {
         alert("You need to enter a username");
         return;
     }
     json_data = JSON.stringify({
         userName: $('#sign_in').val()
     });

     ajax_send('/uno.php/sign_in', 'POST', json_data, 'assign_token');
 }

 function assign_token(data) {
     if (data.error_mysqli == "Column 'USER_TOKEN' cannot be null") {
         alert("The username you entered is not in the database\nPlease enter a valid username");
         return;
     }
     //     else{
     //         alert('The username you entered is already signed in');
     //         return;
     //     }
     me.token = data[0].USER_TOKEN;
     $('#sign_in').hide(1000);
 }


 function ajax_request(request, method_parameter, function_parameter) {
     $.ajax({
         url: request,
         method: method_parameter,
         headers: {
             "X-Token": me.token
         },
         success: function (data) {
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
                 default:
                     break;
             }
         },
         error: function (data) {
             alert(data.responseText);
         }
     });

 }

 function ajax_send(request, method_parameter, data, function_parameter) {
     $.ajax({
         url: request,
         method: method_parameter,
         headers: {
             "X-Token": me.token
         },
         dataType: 'json',
         data: data,
         contentType: 'application/json',
         success: function (data) {
             switch (function_parameter) {
                 case 'assign_token':
                     assign_token(data);
                     break;
                 case 'assign_user':
                     assign_user(data);
                 default:
                     break;
             }
         },
         error: function (data) {
             alert(data.responseJSON.error_mysqli + '\n' + data.responseJSON.error_statement);
         }
     });
 }

 function draw_hand(data, element) {
     for (var i = 0; i < data.length; i++) {
         draw_card(data[i].COLOR, data[i].NUMBER, data[i].DECK_NUM, data[i].VALID, element);
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

 function update_players(data) {
     $('.player_box').each(function (index) {
         if (data[index].ALLOWED == 'YES') {
             $(this).addClass('enabled');
             if (data[index].USER_TOKEN == me.token) {
                 enabled = true;
             }
         }

     });
     $('.player_box .name').each(function (index) {
         $(this).html(data[index].USER_NAME);
     });
     $('.player_box .number_of_cards').each(function (index) {
         $(this).html(data[index].NUM_OF_CARDS);
     });

     if (enabled) {
         $('#hand').children().each(function () {
             id = $(this).attr('id').split('/');
             if (id[3] == 'YES' && (id[0] != '+' && id[0] != 'C')) {
                 $(this).removeClass('disabled');
                 $(this).click(function () {
                     play_card(this);
                 });
             } else if (id[3] == 'YES') {
                 $(this).removeClass('disabled');
                 $(this).click(function () {
                     assign_special_card_id(this);
                 });
             }
         });
         $('#draw_pile').children().each(function () {
             $(this).click(function () {
                 get_card();
             });
         });
     }
     $('#top_card').children().each(function () {
         $(this).removeClass('disabled');
     });
 }

 function update_board() {
     if (me.token) {
         reset_board();
         ajax_request('/uno.php/hand', 'GET', 'draw_hand');
         ajax_request('/uno.php/top_card', 'GET', 'draw_top_card');
         ajax_request('/uno.php/get_players', 'GET', 'update_players');
     }
 }

 function sign_up() {
     if ($('#sign_up').val() == '') {
         alert("You need to enter a username");
         return;
     }
     json_data = JSON.stringify({
         userName: $('#sign_up').val()
     });

     ajax_send('/uno.php/sign_up', 'POST', json_data, 'assign_user');
 }

 function assign_user(data) {
     if (data.error_mysqli) {
         alert('This user is already signed up');
     } else {
         window.location.href = 'http://localhost/uno.html';
     }
 }


 //setInterval(update_board,1000);
