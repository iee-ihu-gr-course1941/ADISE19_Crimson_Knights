$(document).ready(function() {
	$('#sign_in_button').click(function() {
		sign_in();
	});
	$('#assign_color').click(function() {
		play_special_card();
	});
});
var initial_board_state;
var me = {
	token: null,
	enabled: false,
	getCard: false
};
var special_card_id;

function draw_card(color, card_number, deck_number, validity, element) {
	var card, card_id, card_class;
	if (color == '+' || color == 'C') {
		card = 'https://users.iee.ihu.gr/~it174973/images/' + color + '.png';
	} else {
		card = 'https://users.iee.ihu.gr/~it174973/images/R' + card_number + '.png';
	}
	card_id = color + '_' + card_number + '_' + deck_number + '_' + validity;
	if (element == '#top_card') {
		card_class = color;
	} else {
		card_class = color + ' disabled';
	}
	$(element).append($('<img>', {
		id: card_id,
		class: card_class,
		src: card,
	}));
}

function pass() {
	me.getCard = false;
	$('#pass').off();
	ajax_request('https://users.iee.ihu.gr/~it174973/uno.php/pass', 'GET', '');
}

function play_card(obj) {
	id = obj.attributes[0].nodeValue;
	id_array = id.split('_');
	$('#' + id).remove();
	$('#top_card').empty();
	draw_card(id_array[0], id_array[1], id_array[2], id_array[3], '#top_card');
	json_data = JSON.stringify({
		USER_TOKEN: me.token,
		card: {
			COLOR: id_array[0],
			NUMBER: id_array[1],
			DECK_NUM: id_array[2]
		}
	});
	ajax_send('https://users.iee.ihu.gr/~it174973/uno.php/play_card', 'POST',
		json_data, '');
}

function assign_special_card_id(obj) {
	special_card_id = obj.attributes[0].nodeValue.split('_');
	$('#color_select').show(1000);
	$('#assign_color').show(1000);
}

function play_special_card() {
	active_color = $('#color_select').val();
	id = special_card_id.join('_');
	$('#top_card').empty();
	draw_card(special_card_id[0], special_card_id[1], special_card_id[2],
		special_card_id[3], '#top_card');
	json_data = JSON.stringify({
		USER_TOKEN: me.token,
		card: {
			COLOR: special_card_id[0],
			NUMBER: special_card_id[1],
			DECK_NUM: special_card_id[2],
			ACTIVE_COLOR: active_color
		}
	});
	$('#color_select').hide(1000);
	$('#assign_color').hide(1000);
	ajax_send('https://users.iee.ihu.gr/~it174973/uno.php/play_card', 'POST',
		json_data, '');
}

function get_card() {
	me.getCard = true;
	$('#pass').off().click(function() {
		pass();
	});
	$('#draw_pile').off();
	ajax_request('https://users.iee.ihu.gr/~it174973/uno.php/get_card', 'GET', '');
}

function sign_in() {
	if ($('#sign_in').val() == '') {
		alert("You need to enter a username");
		return;
	}
	json_data = JSON.stringify({
		userName: $('#sign_in').val()
	});
	ajax_send('https://users.iee.ihu.gr/~it174973/uno.php/sign_in', 'POST',
		json_data, 'assign_token');
}

function assign_token(data) {
	if (data.warning_mysqli == 'Empty result-set') {
		alert(
			"The username you entered is not in the database\nPlease enter a valid username"
		);
		$('#sign_in').val('');
		return;
	}
	me.token = data[0].USER_TOKEN;
	$('#game_state').show(1000);
	$('.sign_in_box').hide(1000);
	initial_board_state = setInterval(get_initial_board_state, 2000);
}

function sign_up() {
	if ($('#sign_up').val() == '') {
		alert("You need to enter a username");
		return;
	}
	json_data = JSON.stringify({
		userName: $('#sign_up').val()
	});
	ajax_send('https://users.iee.ihu.gr/~it174973/uno.php/sign_up', 'POST',
		json_data, 'assign_user');
}

function assign_user(data) {
	if (data.mysqli_error) {
		alert('This username is used by another user');
		$('#sign_up').val('');
	} else {
		window.location.href = 'https://users.iee.ihu.gr/~it174973/uno.html';
	}
}

function get_initial_board_state() {
	ajax_request(
		'https://users.iee.ihu.gr/~it174973/uno.php/get_initial_board_state', 'GET',
		'check_initial_board_state');
}

function check_initial_board_state(data) {
	if (data[0].BOARD_STATE == 'STARTED') {
		$(document).attr("title", "Game Started");
		$('#game_state').hide(1000);
		$('#board').show(1000);
		$('#hand').show(1000);
		clearInterval(initial_board_state);
		setInterval(update_board, 1500);
	}
}

function check_board_state(data) {
	if (data[0].BOARD_STATE == 'ENDED') {
		window.location.replace("https://users.iee.ihu.gr/~it174973/game_over.html");
	}
}

function ajax_request(request, method_parameter, function_parameter) {
	$.ajax({
		url: request,
		method: method_parameter,
		headers: {
			"X-Token": me.token
		},
		success: function(data) {
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
				case 'check_initial_board_state':
					check_initial_board_state(data);
					break;
				case 'check_board_state':
					check_board_state(data);
					break;
				default:
					break;
			}
		},
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
		success: function(data) {
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
	});
}

function draw_hand(data, element) {
	if (data.warning_mysqli == 'Empty result-set') {
		return;
	}
	for (var i = 0; i < data.length; i++) {
		draw_card(data[i].COLOR, data[i].NUMBER, data[i].DECK_NUM, data[i].VALID,
			element);
	}
}

function update_players(data) {
	me.enabled = false;
	$('.player_box').each(function(index) {
		$(this).removeClass('current_player');
		if (data[index].ALLOWED == 'YES') {
			$(this).addClass('enabled');
			if (data[index].USER_TOKEN == me.token) {
				me.enabled = true;
			}
		} else if (data[index].USER_TOKEN == me.token) {
			$(this).addClass('current_player');
		}
	});
	$('.player_box .name').each(function(index) {
		$(this).html(data[index].USER_NAME);
	});
	$('.player_box .number_of_cards').each(function(index) {
		$(this).html(data[index].NUM_OF_CARDS);
	});
	if (me.enabled) {
		$('#hand').children().each(function() {
			id = $(this).attr('id').split('_');
			if (id[3] == 'YES' && (id[0] != '+' && id[0] != 'C')) {
				$(this).removeClass('disabled');
				$(this).click(function() {
					play_card(this);
				});
			} else if (id[3] == 'YES') {
				$(this).removeClass('disabled');
				$(this).click(function() {
					assign_special_card_id(this);
				});
			}
		});
		if (me.getCard) {} else {
			$('#draw_pile').off().click(function() {
				get_card();
			});
		}
	}
}

function update_board() {
	$('#hand').empty();
	$('#top_card').empty();
	ajax_request('https://users.iee.ihu.gr/~it174973/uno.php/hand', 'GET',
		'draw_hand');
	ajax_request('https://users.iee.ihu.gr/~it174973/uno.php/top_card', 'GET',
		'draw_top_card');
	ajax_request('https://users.iee.ihu.gr/~it174973/uno.php/get_players', 'GET',
		'update_players');
	ajax_request('https://users.iee.ihu.gr/~it174973/uno.php/get_board_state',
		'GET', 'check_board_state');
}
