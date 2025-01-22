<!DOCTYPE html>
<html lang="pt">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BD VINISYS - Introduzir Colheita</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f8ff;
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
            color: #007acc;
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

        input[type="number"],
        input[type="date"],
        select {
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
            background-color: #005f99;
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
        <h1>Introduzir Nova Colheita</h1>
        <?php include('connectDB.php'); ?>
        <form method="post" action="regista_colheita.php">
            <label for="colheita_id">ID da colheita:</label>
            <input type="number" name="colheita_id" required>

            <label for="ano">Ano:</label>
            <input type="number" name="ano" required>

            <label for="data_inicio">Data de início:</label>
            <input type="date" name="data_inicio" required>

            <label for="regiao">Região:</label>
            <select name="regiao" required>
                <?php
                $sql = "SELECT REGIAO_ID FROM regiao";
                $result = mysqli_query($conn, $sql);
                if (mysqli_num_rows($result) > 0) {
                    while ($row = mysqli_fetch_assoc($result)) {
                        echo "<option value='" . $row['REGIAO_ID'] . "'>" . $row['REGIAO_ID'] . "</option>";
                    }
                } else {
                    echo "<option disabled>Nenhuma região disponível</option>";
                }
                ?>
            </select>

            <label for="produtor">Produtor:</label>
            <select name="produtor" required>
                <?php
                $sql = "SELECT PRODUTOR_ID FROM produtor";
                $result = mysqli_query($conn, $sql);
                if (mysqli_num_rows($result) > 0) {
                    while ($row = mysqli_fetch_assoc($result)) {
                        echo "<option value='" . $row['PRODUTOR_ID'] . "'>" . $row['PRODUTOR_ID'] . "</option>";
                    }
                } else {
                    echo "<option disabled>Nenhum produtor disponível</option>";
                }
                ?>
            </select>

            <input type="submit" value="Enviar">
            <input type="reset" value="Limpar">
        </form>
        <a href="menu.html">Voltar ao menu</a>
        <?php
        mysqli_close($conn);
        ?>
    </div>
</body>
</html>