<?php
    require_once "php/dbconnect.php";
    require_once "php/queries.php";
    
    //ini_set('display_errors','on' );

    $method = $_SERVER['REQUEST_METHOD'];
    $request = explode('/', trim($_SERVER['PATH_INFO'],'/'));
    $input = json_decode(file_get_contents('php://input'),true);
    if(isset($_SERVER['HTTP_X_TOKEN'])) {
	$input['token']=$_SERVER['HTTP_X_TOKEN'];
    }

    $test = "test";





    switch($r=array_shift($request)){
        case 'users' :
            query_db_no_param('SELECT * FROM USERSt');
            break;
        case 'deck' :
            query_db_no_param('SELECT * FROM DECK');
            break;
        case 'hand' :
            switch($b=array_shift($request)){
                case '':
                case null:
                    header("HTTP/1.1 404 Not Found");
                    break;
                default: query_db('SELECT * FROM HANDS WHERE USER_TOKEN = ?',$b); 
                    break;
                       
            }
            break;
        default : 
            header("X-Lick: lick it");
            header("Location: http://localhost/Not_found.html");
    }
    //mysqliquery('CALL ADD_USER(?);',$_POST['userName']);
    //query_db('SELECT * FROM USERS WHERE USER_NAME = ?',$_POST['userName']);
    //query_db('SELECT * FROM MASTER_DECK WHERE COLOR = ?',$_POST['userName']);
    exit;
?>
