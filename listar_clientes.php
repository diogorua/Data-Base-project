<!DOCTYPE html>
<html lang="pt">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lista de Clientes</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
            color: #333;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            align-items: center;
            min-height: 100vh;
        }

        h1 {
            color: #0056b3;
            margin: 20px 0;
        }

        table {
            width: 90%;
            border-collapse: collapse;
            margin: 20px 0;
            background-color: #fff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        table th, table td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: center;
        }

        table th {
            background-color: #007acc;
            color: white;
        }

        table tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        table tr:hover {
            background-color: #f1f1f1;
        }

        .button-container {
            margin: 20px 0;
        }

        input[type="submit"] {
            background-color: #d9534f;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #c9302c;
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

    $sql_clientes = "SELECT c.nome_cliente, c.tipo, c.nif, c.morada, IFNULL(SUM(i.quantidade), 0) AS total_vinhos, 
                        IFNULL(SUM(i.quantidade * i.preco), 0) AS total_gasto
                     FROM cliente c                    
                     LEFT JOIN fatura f ON c.numero_cliente = f.CLIENTE_numero_cliente
                     LEFT JOIN item i ON f.num_fatura = i.FATURA_num_fatura
                     GROUP BY c.numero_cliente";
    $result_clientes = mysqli_query($conn, $sql_clientes);

    mysqli_close($conn);
    ?>

    <h1>Gestão dos Clientes</h1>

    <table>
        <tr>
            <th>Nome</th>
            <th>Tipo</th>
            <th>NIF</th>
            <th>Morada</th>
            <th>Total de Vinhos Comprados</th>
            <th>Valor Total Gasto (€)</th>
        </tr>

        <?php if (mysqli_num_rows($result_clientes) > 0): ?>
            <?php while ($row = mysqli_fetch_assoc($result_clientes)): ?>
                <tr>
                    <td><?php echo $row['nome_cliente']; ?></td>
                    <td><?php echo $row['tipo']; ?></td>
                    <td><?php echo $row['nif']; ?></td>
                    <td><?php echo $row['morada']; ?></td>
                    <td><?php echo $row['total_vinhos']; ?></td>
                    <td><?= number_format($row['total_gasto'], 2, ',', '.'); ?></td>
                </tr>
            <?php endwhile; ?>
        <?php else: ?>
            <tr>
                <td colspan="6">Nenhum resultado encontrado</td>
            </tr>
        <?php endif; ?>
    </table>

    <div class="button-container">
        <form method="post" action="delete_cliente.php">
            <input type="submit" value="Apagar Cliente(s) sem Compras Efetuadas">
        </form>
    </div>

    <a href="menu.html">Voltar ao menu</a>

</body>
</html>