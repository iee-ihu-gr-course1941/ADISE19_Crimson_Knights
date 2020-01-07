 var me = {
     token: null
 };

 var enabled = false;

 function draw_card(color, card_number, deck_number, validity, element) {
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
             card = '/images/R' + card_number + '.png';
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

     card_id = color + '/' + card_number + '/' + deck_number + '/' + validity;
     $(element).append($('<img>', {
         id: card_id,
         class: color_css + ' disabled',
         src: card,
     }));
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
     if (data.warning_mysqli == "Empty result-set") {
         alert("The username you entered is not in the database\nPlease enter a valid username");
         return;
     }
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
             alert(data.responseJSON.error_mysqli + '\n' + data.responseJSON.error_statement);
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
         }
     });
     $('.player_box .name').each(function (index) {
         $(this).html(data[index].USER_NAME);
     });
     $('.player_box .number_of_cards').each(function (index) {
         $(this).html(data[index].NUM_OF_CARDS);
     });

     $('#hand').children().each(function () {
         id = $(this).attr('id').split('/');
         if (id[3] == 'YES') {
             $(this).removeClass('disabled');
             $(this).click(function () {
                 play_card(this);
             });
         }

     });
     $('#top_card').children().each(function () {
         $(this).removeClass('disabled');
     })
 }

 function update_board() {
     reset_board();
     ajax_request('/uno.php/hand', 'GET', 'draw_hand');
     ajax_request('/uno.php/top_card', 'GET', 'draw_top_card');
     ajax_request('/uno.php/get_players', 'GET', 'update_players');


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
     if(data.error_mysqli){
         alert('This user is already signed up');
     }else{
         window.location.href = 'http://localhost/uno.html';
     }
 }









 //setInterval(update_board,3000);
