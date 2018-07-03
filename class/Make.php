<?php
    // if(rand(1,3) == 1){
    //     /* Fake an error */
    //     header("HTTP/1.0 404 Not Found");
    //     die();
    // }

    /* Send a string after a random number of seconds (2-10) */
    //sleep(rand(2,10));
    if(isset($_POST['id'])){
        $id= $_POST["id"];
        $orden= $_POST["orden"];

        echo(json_encode(array(
            'id' => $id ,
            'orden' => $orden))
        );
    }
    else echo(json_encode(array(
        'id' => '0018' ,
        'orden' => 'Tamaño: Sabor1 - Sabor2 - Topping'))
        );
?>