<!DOCTYPE html>
<html lang="pt">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Apagar Clientes</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
            color: #333;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
            margin: 0;
        }

        h1 {
            color: #d9534f;
            margin-bottom: 20px;
        }

        .message {
            font-size: 18px;
            padding: 15px;
            margin: 10px 0;
            border-radius: 5px;
            text-align: center;
            width: 80%;
            max-width: 600px;
        }

        .success {
            background-color: #dff0d8;
            color: #3c763d;
            border: 1px solid #d6e9c6;
        }

        .error {
            background-color: #f2dede;
            color: #a94442;
            border: 1px solid #ebccd1;
        }

        .info {
            background-color: #d9edf7;
            color: #31708f;
            border: 1px solid #bce8f1;
        }

        a {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #007acc;
            color: white;
            text-decoration: none;
            border-radius: 4px;
        }

        a:hover {
            background-color: #005f99;
        }
    </style>
</head>
<body>

<?php
include('connectDB.php');

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $sql = "DELETE FROM cliente 
            WHERE numero_cliente NOT IN (
                SELECT DISTINCT CLIENTE_numero_cliente FROM fatura   
            )";

    if (mysqli_query($conn, $sql)) {
        $deleted_rows = mysqli_affected_rows($conn);
        
        if ($deleted_rows > 0) {
            echo "<div class='message success'>$deleted_rows cliente(s) apagado(s) com sucesso.</div>";
        } else {
            echo "<div class='message info'>Nenhum cliente foi apagado.</div>";
        }
    } else {
        echo "<div class='message error'>Erro ao apagar clientes: " . mysqli_error($conn) . "</div>";
    }
}

mysqli_close($conn);
?>

<a href="listar_clientes.php">Voltar à Lista de Clientes</a>

</body>
</html>