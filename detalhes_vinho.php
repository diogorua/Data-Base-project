<!DOCTYPE html>
<html lang="pt">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Detalhes do Vinho</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f8ff; /* Azul claro */
            color: #333;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            align-items: center;
            min-height: 100vh;
        }

        h1, h2 {
            color: #007acc;
        }

        h1 {
            margin-top: 20px;
        }

        ul {
            list-style-type: disc;
            padding-left: 20px;
        }

        ul li {
            margin: 5px 0;
        }

        .container {
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 20px;
            margin: 20px;
            width: 80%;
        }

        .section {
            margin-bottom: 20px;
        }

        .section:last-child {
            margin-bottom: 0;
        }

        .section ul li {
            margin: 8px 0;
        }
    </style>
</head>
<body>

    <?php 
    include('connectDB.php');

    if (!empty($_GET['vinho_id'])) {
        $vinho_id = intval($_GET['vinho_id']);

        $sql_vinho = "SELECT * FROM vinho WHERE VINHO_ID = $vinho_id";
        $vinho_result = mysqli_query($conn, $sql_vinho);
        $vinho = mysqli_fetch_assoc($vinho_result);

        $sql_regiao = "SELECT * FROM regiao WHERE REGIAO_ID = " . $vinho['REGIAO_ID'];
        $regiao_result = mysqli_query($conn, $sql_regiao);
        $regiao = mysqli_fetch_assoc($regiao_result);

        $sql_produtor = "SELECT * FROM produtor WHERE PRODUTOR_ID = " . $vinho['PRODUTOR_ID'];
        $produtor_result = mysqli_query($conn, $sql_produtor);
        $produtor = mysqli_fetch_assoc($produtor_result);

        $sql_premio = "SELECT * FROM premio p 
                        JOIN ganha g ON p.PREMIO_ID = g.PREMIO_ID
                        JOIN edicao e ON g.EDICAO_ID = e.EDICAO_ID
                        WHERE e.VINHO_ID = " . $vinho['VINHO_ID'];
        $premio_result = mysqli_query($conn, $sql_premio);
        $premio = mysqli_fetch_assoc($premio_result);
    }
    ?>

    <div class="container">
        <h1>Detalhes do Vinho</h1>

        <div class="section">
            <h2>Características</h2>
            <ul>
                <li>Nome: <?php echo $vinho['nome']; ?></li>
                <li>Data de Engarrafamento: <?php echo $vinho['data_engarraf']; ?></li>
                <li>Teor Alcoólico: <?php echo $vinho['teor_alcoolico']; ?></li>
                <li>Tipo: <?php echo $vinho['tipo']; ?></li>
                <li>Classificação: <?php echo $vinho['classificacao']; ?></li>
                <li>Cor: <?php echo $vinho['cor']; ?></li>
                <li>Aroma: <?php echo $vinho['aroma']; ?></li>
                <li>Sabor: <?php echo $vinho['sabor']; ?></li>
            </ul>
        </div>

        <div class="section">
            <h2>Região do Vinho</h2>
            <ul>
                <li><?php echo $regiao['denominacao']; ?></li>
            </ul>
        </div>

        <div class="section">
            <h2>Informações sobre o Produtor</h2>
            <ul>
                <li>Nome do Produtor: <?php echo $produtor['nome_vinicola']; ?></li>
                <li>Email: <?php echo $produtor['email']; ?></li>
                <li>Morada: <?php echo $produtor['morada']; ?></li>
                <li>Código Postal: <?php echo $produtor['codigo_postal']; ?></li>
                <li>Nº de Telefone: <?php echo $produtor['telefone']; ?></li>
            </ul>
        </div>

        <div class="section">
            <h2>Prémios</h2>
            <ul>
                <li>Nome do Prémio: <?php echo $premio['nome_distincao']; ?></li>
            </ul>
        </div>
    </div>

</body>
</html>