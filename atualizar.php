<!DOCTYPE html>
<html lang="pt">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Atualizar Colheita</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f8ff; /* Azul claro */
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }

        .container {
            background-color: #ffffff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            max-width: 500px;
            width: 100%;
        }

        h1 {
            text-align: center;
            color: #007acc; /* Azul médio */
            margin-bottom: 20px;
        }

        form {
            display: flex;
            flex-direction: column;
        }

        label {
            font-weight: bold;
            margin-bottom: 5px;
        }

        select,
        input[type="number"],
        input[type="date"] {
            margin-bottom: 15px;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 14px;
        }

        input[type="submit"],
        input[type="reset"] {
            background-color: #007acc;
            color: white;
            border: none;
            border-radius: 5px;
            padding: 10px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s;
            margin: 5px 0;
        }

        input[type="submit"]:hover,
        input[type="reset"]:hover {
            background-color: #005f99; /* Azul mais escuro */
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
    <div class="container">
        <h1>Atualizar Registo da Colheita</h1>
        <?php include('connectDB.php'); ?>
        <form method="post" action="atualiza_colheita.php">
            <label for="colheita_id">ID da Colheita:</label>
            <select name="colheita_id" required>
                <?php
                $sql = "SELECT COLHEITA_ID FROM colheita";
                $result = mysqli_query($conn, $sql);
                if (mysqli_num_rows($result) > 0) {
                    while ($row = mysqli_fetch_assoc($result)) {
                        echo "<option value='" . $row['COLHEITA_ID'] . "'>" . $row['COLHEITA_ID'] . "</option>";
                    }
                } else {
                    echo "<option disabled>Nenhuma colheita disponível</option>";
                }
                ?>
            </select>

            <label for="data_fim">Data do fim da colheita:</label>
            <input type="date" name="data_fim" required>

            <label for="quantidade">Quantidade colhida:</label>
            <input type="number" name="quantidade" required>

            <input type="submit" value="Atualizar Colheita">
            <input type="reset" value="Limpar">
        </form>
        <a href="menu.html">Voltar ao menu</a>
        <?php mysqli_close($conn); ?>
    </div>
</body>
</html>