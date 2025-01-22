<!DOCTYPE html>
<html lang="pt">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Listagem de Vinhos</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f8ff; /* Azul claro */
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            align-items: center;
            min-height: 100vh;
        }

        h2 {
            color: #007acc;
            margin-top: 20px;
        }

        table {
            border-collapse: collapse;
            width: 80%;
            margin-top: 20px;
            background-color: #ffffff;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        th, td {
            border: 1px solid #ccc;
            text-align: left;
            padding: 12px;
        }

        th {
            background-color: #007acc;
            color: white;
        }

        td {
            background-color: #f9f9f9;
        }

        td a {
            color: #007acc;
            text-decoration: none;
            font-weight: bold;
        }

        td a:hover {
            text-decoration: underline;
        }

        .message {
            margin-top: 20px;
            font-size: 16px;
            color: #555;
        }

        a{
            color: #007acc;
            text-decoration: none;
            font-weight: bold;
            margin-top: 100px;
        }

        a:hover {
            text-decoration: underline; 
        }
    </style>
</head>
<body>

<?php

include('connectDB.php');

if ($_SERVER["REQUEST_METHOD"] == "GET") {
    $sql = "SELECT v.VINHO_ID, v.nome, r.denominacao AS REGIAO, v.tipo 
            FROM vinho v
            JOIN regiao r ON v.REGIAO_ID = r.REGIAO_ID
            WHERE 1=1";

    // Filtro de pesquisa
    if (!empty($_GET["vinho_id"])) {
        $sql .= " AND v.VINHO_ID = " . intval($_GET['vinho_id']);
    }

    if (!empty($_GET["regiao"])) {
        $sql .= " AND v.REGIAO_ID = " . intval($_GET['regiao']);
    }

    if (!empty($_GET["tipo"])) {
        $sql .= " AND v.tipo LIKE '%" . mysqli_real_escape_string($conn, $_GET['tipo']) . "%'";
    }
        
    $result = mysqli_query($conn, $sql); 
}

mysqli_close($conn);
?>

<h2>Resultados da Pesquisa</h2>
<table>
    <tr>
        <th>Nome</th>
        <th>Região</th>
        <th>Tipo de Vinho</th>
        <th>Detalhes</th>
    </tr>

    <?php if (mysqli_num_rows($result) > 0): ?>
        <?php while ($row = mysqli_fetch_assoc($result)): ?>
            <tr>
                <td><?php echo $row['nome']; ?></td>
                <td><?php echo $row['REGIAO']; ?></td>
                <td><?php echo $row['tipo']; ?></td>
                <td><a href="detalhes_vinho.php?vinho_id=<?php echo $row['VINHO_ID']; ?>">Ver detalhes</a></td>
            </tr>
        <?php endwhile; ?>   
    <?php else: ?>
        <tr>
            <td colspan="4" class="message">Nenhum resultado encontrado</td>
        </tr>
    <?php endif; ?>
</table>
<a href="listar_vinhos.html">Voltar</a>

</body>
</html>