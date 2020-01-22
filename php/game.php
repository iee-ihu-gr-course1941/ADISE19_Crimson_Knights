<?php
/**
* Function list:
* - pass()
* - get_random_card()
* - get_card()
* - give_cards()
* - setup_board()
* - play_card()
* - next_player()
* - validate_hand()
* - check_game_state()
* - reset_board()
*/
function pass() {
	query('CALL INVALIDATE_ALL(?)', 's', array('HANDS'), '');
	$next_player = next_player($card);
	query('CALL SET_PLAYER_ALLOWED(?,?)', 'ss', array($next_player['USER_TOKEN'], 'YES'), '');
	validate_hand($next_player['USER_TOKEN']);
}
function get_random_card() {
	$card = query('CALL GET_RANDOM_CARD()', '', array(), 'php');
	return $card;
}
function get_card($token) {
	$card = get_random_card();
	query('CALL SET_CARD(?,?,?,?)', 'ssii', array($token, $card[0]['COLOR'], $card[0]['NUMBER'], $card[0]['DECK_NUM']), '');
	validate_hand($token);
}
function give_cards($num_of_cards, $token) {
	for ($i = 0;$i < $num_of_cards;$i++) {
		$card = get_random_card();
		query('CALL SET_CARD(?,?,?,?)', 'ssii', array($token, $card[0]['COLOR'], $card[0]['NUMBER'], $card[0]['DECK_NUM']), '');
	}
}
function setup_board() {
	query('CALL RESET_HANDS()', '', array(), '');
	give_cards(1, 'TOP_CARD');
	$players = query('CALL GET_PLAYERS(?)', 's', array('C'), 'php');
	$num_of_players = count($players);
	$colors = array('R', 'G', 'B', 'P');
	$random_key = array_rand($colors, 2);
	$skip = false;
	for ($i = 0;$i < $num_of_players;$i++) {
		give_cards(7, $players[$i]['USER_TOKEN']);
	}
	query('CALL SET_BOARD(?,?)', 'ss', array('ROTATION', 'C'), '');
	query('CALL INVALIDATE_ALL(?)', 's', array('TURNS'), '');
	$top_card = query('CALL GET_HAND(?)', 's', array('TOP_CARD'), 'php');
	if ($top_card[0]['COLOR'] == 'C') {
		query('CALL SET_BOARD(?,?)', 'ss', array('ACTIVE_COLOR', $colors[$random_key[0]]), '');
	}
	else if ($top_card[0]['COLOR'] == '+') {
		query('CALL SET_BOARD(?,?)', 'ss', array('ACTIVE_COLOR', $colors[$random_key[0]]), '');
		give_cards(4, $players[0]['USER_TOKEN']);
		$skip = true;
	}
	else if ($top_card[0]['NUMBER'] == 10) {
		give_cards(2, $players[0]['USER_TOKEN']);
		$skip = true;
	}
	else if ($top_card[0]['NUMBER'] == 11) {
		query('CALL SET_BOARD(?,?)', 'ss', array('ROTATION', ''), '');
	}
	else if ($top_card[0]['NUMBER'] == 12) {
		$skip = true;
	}
	if ($skip) {
		query('CALL SET_PLAYER_ALLOWED(?,?)', 'ss', array($players[1]['USER_TOKEN'], 'YES'), '');
		validate_hand($players[1]['USER_TOKEN']);
	}
	else {
		query('CALL SET_PLAYER_ALLOWED(?,?)', 'ss', array($players[0]['USER_TOKEN'], 'YES'), '');
		validate_hand($players[0]['USER_TOKEN']);
	}
	query('CALL SET_BOARD(?,?)', 'ss', array('BOARD_STATE', 'STARTED'), '');
}
function play_card($token, $card) {
	if ($card['COLOR'] == '+' or $card['COLOR'] == 'C') {
		query('CALL SET_BOARD(?,?)', 'ss', array('ACTIVE_COLOR', $card['ACTIVE_COLOR']), '');
	}
	if ($card['NUMBER'] == 11) {
		query('CALL SET_BOARD(?,?)', 'ss', array('ROTATION', ''), '');
	}
	$top_card = query('CALL GET_HAND(?)', 's', array('TOP_CARD'), 'php');
	query('CALL SET_CARD(?,?,?,?)', 'ssii', array('NA', $top_card[0]['COLOR'], $top_card[0]['NUMBER'], $top_card[0]['DECK_NUM']), '');
	query('CALL SET_CARD(?,?,?,?)', 'ssii', array('TOP_CARD', $card['COLOR'], $card['NUMBER'], $card['DECK_NUM']), '');
	query('CALL UPDATE_USER(?)', 's', array($token), '');
	query('CALL INVALIDATE_ALL(?)', 's', array('HANDS'), '');
	$next_player = next_player($card);
	query('CALL SET_PLAYER_ALLOWED(?,?)', 'ss', array($next_player['USER_TOKEN'], 'YES'), '');
	validate_hand($next_player['USER_TOKEN']);
	$players = query('CALL GET_PLAYERS(?)', 's', array('P'), 'php');
	$num_of_players = count($players);
	if ($num_of_players == 3) {
		query('CALL SET_BOARD(?,?)', 'ss', array('BOARD_STATE', 'ENDED'), '');
		return;
	}
}
function next_player($card) {
	$rotation = query('CALL GET_FROM_BOARD(?)', 's', array('ROTATION'), 'php');
	$players = query('CALL GET_PLAYERS(?)', 's', array($rotation[0]['ROTATION']), 'php');
	$last_player = end($players);
	$flag_second_to_last = false;
	$flag_last = false;
	reset($players);
	if (count($players) == 2) {
		$flag_second_to_last = true;
	}
	for ($i = 0;$i < 10;$i++) {
		if (current($players) ['ALLOWED'] == 'YES') {
			if (current($players) == $last_player) {
				$flag_last = true;
				break;
			}
			if (next($players) == $last_player) {
				$flag_second_to_last = true;
				prev($players);
				break;
			}
			prev($players);
			break;
		}
		else {
			next($players);
		}
	}
	query('CALL SET_PLAYER_ALLOWED(?,?)', 'ss', array(current($players) ['USER_TOKEN'], 'NO'), '');
	if ($card['NUMBER'] == 12) {
		if ($flag_last) {
			reset($players);
			return next($players);
		}
		else if ($flag_second_to_last) {
			reset($players);
			return current($players);
		}
		else {
			next($players);
			return next($players);
		}
	}
	else if ($card['NUMBER'] == 10) {
		if ($flag_last) {
			reset($players);
			give_cards(2, current($players) ['USER_TOKEN']);
			return next($players);
		}
		else if ($flag_second_to_last) {
			$next_player = next($players);
			give_cards(2, $next_player['USER_TOKEN']);
			reset($players);
			return current($players);
		}
		else {
			$next_player = next($players);
			give_cards(2, $next_player['USER_TOKEN']);
			return next($players);
		}
	}
	else if ($card['COLOR'] == '+') {
		if ($flag_last) {
			reset($players);
			give_cards(4, current($players) ['USER_TOKEN']);
			return next($players);
		}
		else if ($flag_second_to_last) {
			$next_player = next($players);
			give_cards(4, $next_player['USER_TOKEN']);
			reset($players);
			return current($players);
		}
		else {
			$next_player = next($players);
			give_cards(4, $next_player['USER_TOKEN']);
			return next($players);
		}
	}
	else {
		if ($flag_last) {
			reset($players);
			return current($players);
		}
		else return next($players);
	}
}
function validate_hand($token) {
	$valid = 'NO';
	$top_card = query('CALL GET_HAND(?)', 's', array('TOP_CARD'), 'php');
	$player_hand = query('CALL GET_HAND(?)', 's', array($token), 'php');
	$active_color = query('CALL GET_FROM_BOARD(?)', 's', array('ACTIVE_COLOR'), 'php');
	$num_of_cards = count($player_hand);
	for ($i = 0;$i < $num_of_cards;$i++) {
		if ($top_card[0]['COLOR'] != '+' and $top_card[0]['COLOR'] != 'C') {
			if ($top_card[0]['COLOR'] == $player_hand[$i]['COLOR']) {
				$valid = 'YES';
			}
			else if ($top_card[0]['NUMBER'] == $player_hand[$i]['NUMBER']) {
				$valid = 'YES';
			}
			else if ($player_hand[$i]['COLOR'] == '+' or $player_hand[$i]['COLOR'] == 'C') {
				$valid = 'YES';
			}
			else $valid = 'NO';
		}
		else {
			if ($active_color[0]['ACTIVE_COLOR'] == $player_hand[$i]['COLOR']) {
				$valid = 'YES';
			}
			else if ($player_hand[$i]['COLOR'] == '+' or $player_hand[$i]['COLOR'] == 'C') {
				$valid = 'NO';
			}
			else $valid = 'NO';
		}
		query('CALL SET_CARD_VALID(?,?,?,?,?)', 'ssiis', array($token, $player_hand[$i]['COLOR'], $player_hand[$i]['NUMBER'], $player_hand[$i]['DECK_NUM'], $valid), '');
	}
}
function check_game_state() {
	$players = query('CALL GET_PLAYERS(?)', 's', array('C'), 'php');
	$state = query('CALL GET_FROM_BOARD(?)', 's', array('BOARD_STATE'), 'php');
	$num_of_players = count($players);
	if ($num_of_players == 4 and $state[0]['BOARD_STATE'] == 'WAITING FOR PLAYERS') {
		setup_board();
	}
	else {
		header('Content-type: application/json');
		print json_encode($state);
	}
}
function reset_board() {
	query('CALL RESET_TURNS()', '', array(), '');
	query('CALL RESET_HANDS()', '', array(), '');
	query('CALL RESET_BOARDS()', '', array(), '');
}
?>