<?php
function query($query, $bind_list, $param_array, $data_type) {
	global $mysqli;
	$query = $mysqli->real_escape_string($query);
	$query = htmlspecialchars($query);
	$statement = $mysqli->prepare($query);
	switch ($bind_list) {
		case 's':
			$statement->bind_param($bind_list, $param_array[0]);
		break;
		case 'si':
			$statement->bind_param($bind_list, $param_array[0], $param_array[1]);
		break;
		case 'ss':
			$statement->bind_param($bind_list, $param_array[0], $param_array[1]);
		break;
		case 'ssii':
			$statement->bind_param($bind_list, $param_array[0], $param_array[1], $param_array[2], $param_array[3]);
		break;
		case 'ssiis':
			$statement->bind_param($bind_list, $param_array[0], $param_array[1], $param_array[2], $param_array[3], $param_array[4]);
		break;
		default:
		break;
	}
	if ($statement && $statement->execute()) {
		$result = $statement->get_result();
		$statement->close();
		if (!is_object($result)) {
            print json_encode(['notice' => 'Not an object'], JSON_PRETTY_PRINT);
			return;
		}
		if ($result->num_rows == 0) {
			print json_encode(['warning_mysqli' => 'Empty result-set'], JSON_PRETTY_PRINT);
            return;
		}
		if ($data_type == 'json') {
			header('Content-type: application/json');
			print json_encode($result->fetch_all(MYSQLI_ASSOC), JSON_PRETTY_PRINT);
		}
		else if ($data_type == 'php') {
			return $result->fetch_all(MYSQLI_ASSOC);
		}
		else {
			return;
		}
	}
	else {
		print json_encode(['mysqli_error' => $mysqli->error, 'statement_error' => $statement->error], JSON_PRETTY_PRINT);
	}
}
?>
