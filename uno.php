<?php
require_once "php/dbconnect.php";
require_once "php/global_query.php";
require_once "php/game.php";
$method = $_SERVER['REQUEST_METHOD'];
$request = explode('/', trim($_SERVER['PATH_INFO'], '/'));
$input = json_decode(file_get_contents('php://input'), true);
if (isset($_SERVER['HTTP_X_TOKEN'])) {
	$input['token'] = $_SERVER['HTTP_X_TOKEN'];
}
$request_check = array_slice($request, 1);
if (isset($request_check[0])) {
	header('Location: https://users.iee.ihu.gr/~it174973/not_found.html');
	exit;
}
$parsed_request = array_shift($request);
if ($method == 'GET') {
	switch ($parsed_request) {
		case 'hand':
			query('CALL GET_HAND(?)', 's', array($input['token']), 'json');
		break;
		case 'top_card':
			query('CALL GET_HAND(?)', 's', array('TOP_CARD'), 'json');
		break;
		case 'get_players':
			query('CALL GET_PLAYERS(?)', 's', array('P'), 'json');
		break;
		case 'get_card':
			get_card($input['token']);
		break;
		case 'get_board_state':
			query('CALL GET_FROM_BOARD(?)', 's', array('BOARD_STATE'), 'json');
		break;
		case 'get_initial_board_state':
			check_game_state();
		break;
		case 'setup_board':
			setup_board();
		break;
		case 'reset_board':
			reset_board();
		break;
		case 'pass':
			pass();
		break;
		default:
			header('Location: https://users.iee.ihu.gr/~it174973/not_found.html');
	}
}
else if ($method == 'POST') {
	switch ($parsed_request) {
		case 'play_card':
			play_card($input['token'], $input['card']);
		break;
		case 'sign_up':
			query('CALL SIGN_UP(?)', 's', array($input['userName']), '');
		break;
		case 'sign_in':
			query('CALL SIGN_IN(?)', 's', array($input['userName']), 'json');
		break;
	}
}
?>
