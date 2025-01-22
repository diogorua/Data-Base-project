<?php

include('connectDB.php');

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $colheita_id = $_POST["colheita_id"];
    $data_fim = $_POST["data_fim"];
    $quantidade = $_POST["quantidade"];

    $sql = "UPDATE colheita SET data_fim = '$data_fim', quantidade = '$quantidade' WHERE COLHEITA_ID = '$colheita_id'";

    if(mysqli_query($conn, $sql)) {
        echo "Colheita '$colheita_id' atualizada com sucesso";
    } else {
        echo "Erro ao atualizar: " . mysqli_error($conn);
    }
}

mysqli_close($conn);
exit;

?>