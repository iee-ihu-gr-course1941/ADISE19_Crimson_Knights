<?php
/**
* Class and Function List:
* Function list:
* - query_db()
* - query_db_no_param()
* - query_prepare()
* - query_db_param_list()
* Classes list:
*/
function query_prepare($query) {
	global $mysqli;
	$query = $mysqli->real_escape_string($query);
	$query = htmlspecialchars($query);
	$statement = $mysqli->prepare($query);
	return $statement;
}

function query($query, $bind_list, $param_array, $data_type) {
	global $mysqli;
	$statement = query_prepare($query);
    switch ($bind_list){
        case 's':
             $statement->bind_param($bind_list,$param_array[0]);
            break;
        case 'si':
            $statement->bind_param($bind_list,$param_array[0],$param_array[1]);
            break;
        case 'ssii':
            $statement->bind_param($bind_list,$param_array[0],$param_array[1],$param_array[2],$param_array[3]);
            break;
        default:
            break;
    }
   
        
	if ($statement && $statement->execute()) {
		$result = $statement->get_result();
        if(!is_object($result)){
            print json_encode(['warning_mysqli' => 'Empty result-set'], JSON_PRETTY_PRINT);
            return;
        }
        if($result->num_rows == 0){
            print json_encode(['warning_mysqli' => 'Empty result-set'], JSON_PRETTY_PRINT);
            exit;
        }
        if ($data_type == 'json') {
			header('Content-type: application/json');
			print json_encode($result->fetch_all(MYSQLI_ASSOC) , JSON_PRETTY_PRINT);
		}
		else if ($data_type == 'php') {
			return $result->fetch_all(MYSQLI_ASSOC);
		}
		$statement->close();
	}
	else {
		print json_encode(['error_mysqli' => $mysqli->error, 'error_statement' => $statement->error], JSON_PRETTY_PRINT);
		$statement->close();
	}
}
                               
?>


 