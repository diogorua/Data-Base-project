<?php

include('connectDB.php');

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $colheita_id = $_POST["colheita_id"];
    $ano = $_POST["ano"];
    $data_inicio = $_POST["data_inicio"];
    $regiao = $_POST["regiao"];
    $produtor = $_POST["produtor"];

    $sql = "INSERT INTO colheita (COLHEITA_ID, ano, data_inicio, REGIAO_ID, PRODUTOR_ID) VALUES ('$colheita_id', '$ano', '$data_inicio', '$regiao', '$produtor')";

    if (mysqli_query($conn, $sql)) {
        echo "Nova colheita registada com sucesso";
    } else {
        echo "Error: " . $sql . "<br>" . mysqli_error($conn);
    }
}

mysqli_close($conn);
    exit;

?>