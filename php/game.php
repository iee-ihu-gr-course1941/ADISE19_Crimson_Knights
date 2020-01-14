<?php     
function get_card($token) {
	$card = query('CALL GET_RANDOM_CARD()', '', array() , 'php');
	query('CALL SET_CARD(?,?,?,?)', 'ssii', array($token,$card[0]['COLOR'],$card[0]['NUMBER'],
                                                  $card[0]['DECK_NUM']), 'php');
}

function set_board(){
    query('CALL RESET_HANDS()','',array(),'php');
	get_card('TOP_CARD');
    $players = query('CALL GET_PLAYERS()', '', array() , 'php');
	$num_of_players = count($players);
	for ($i = 0;$i < $num_of_players;$i++){
		for ($j = 0;$j < 7;$j++) {
			get_card($players[$i]['USER_TOKEN']);
		}
	}
}

function play_card($token,$card){
    print_r($card);
    print json_encode([$card['COLOR'],$token], JSON_PRETTY_PRINT);
}

function next_player($card){
    $rotation = query('CALL GET_ROTATION()', '', array(), 'php');
    $players = query('CALL GET_PLAYERS(?)','s',array($rotation[0]['ROTATION']),'php');
    $last_player = end($players);
    $flag_second_to_last = false;
    $flag_last = false;
    reset($players);
    
    if(count($players) == 2){
        $flag_second_to_last = true;
    }
    for($i =0;$i < 10;$i++){
        if(current($players)['ALLOWED'] == 'YES'){
            if(current($players) == $last_player){
                $flag_last = true;
                break;
            }
            if(next($players) == $last_player){
                $flag_second_to_last = true;
                prev($players);    
                break;   
            }
            prev($players);
            break;
        }else {
            next($players);
        }
    }

    query('CALL SET_PLAYER_ALLOWED(?,?)','ss',array(current($players)['USER_TOKEN'],'NO'),'');
    
    if($card['NUMBER'] == 12){
       if($flag_last){
        reset($players);
        return next($players);
        }else if($flag_second_to_last){
           reset($players);
           return current($players);
       }else{
           next($players);
           return next($players);
       }
    }else if($card['NUMBER'] == 10){
       if($flag_last){
            reset($players);
            get_card(current($players)['USER_TOKEN']);
            get_card(current($players)['USER_TOKEN']);
            return next($players);
        }else if($flag_second_to_last){
           $next_player = next($players);
           get_card($next_player['USER_TOKEN']);
           get_card($next_player['USER_TOKEN']);
           reset($players);
           return current($players);
       }else{
           $next_player = next($players);
           get_card($next_player['USER_TOKEN']);
           get_card($next_player['USER_TOKEN']);
           return next($players);
       } 
    }else if($card['COLOR'] == '+'){
        if($flag_last){
            reset($players);
            get_card(current($players)['USER_TOKEN']);
            get_card(current($players)['USER_TOKEN']);
            get_card(current($players)['USER_TOKEN']);
            get_card(current($players)['USER_TOKEN']);
            return next($players);
        }else if($flag_second_to_last){
           $next_player = next($players);
           get_card($next_player['USER_TOKEN']);
           get_card($next_player['USER_TOKEN']);
           get_card($next_player['USER_TOKEN']);
           get_card($next_player['USER_TOKEN']);
           reset($players);
           return current($players);
       }else{
           $next_player = next($players);
           get_card($next_player['USER_TOKEN']);
           get_card($next_player['USER_TOKEN']);
           get_card($next_player['USER_TOKEN']);
           get_card($next_player['USER_TOKEN']);
           return next($players);
       } 
    }else{
        if($flag_last){
            reset($players);
            return current($players);
        }else return next($players);
    }
}

function validate_hand($token)
{
    $valid = 'NO';
    $top_card = query('CALL GET_HAND(?)', 's', array('TOP_CARD'), 'php');
    $player_hand = query('CALL GET_HAND(?)', 's', array($token), 'php');
    $num_of_cards = count($player_hand);
    for ($i = 0;$i < $num_of_cards;$i++)
    {
        if ($top_card[0]['COLOR'] == $player_hand[$i]['COLOR'])
        {
            if ($player_hand[$i]['COLOR'] == '+' or $player_hand[$i]['COLOR'] == 'C')
            {
                $valid = 'NO';  
            } 
            $valid = 'YES';
        }
        else if ($top_card[0]['NUMBER'] == $player_hand[$i]['NUMBER'])
        {
            $valid = 'YES';  
        }
        else
        {
            $valid = 'NO';
        }
        query('CALL SET_CARD_VALID(?,?,?,?,?)', 'ssiis', array($token, $player_hand[$i]['COLOR'],
        $player_hand[$i]['NUMBER'], $player_hand[$i]['DECK_NUM'], $valid), 'php');
    }
}
?>