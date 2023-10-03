<html>
	<head>
	<meta charset="UTF-8">
	<meta name="description" content="Recenzie videohier">
	<meta name="keywords" content="Recenzia, hra">
	<meta name="author" content="Marián Kuchynka">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	
			<title> 
			Reves Gamiews 
			</title>
	
			<link rel="stylesheet" type="text/css" href="file.css">
			<link rel="shortcut icon" type="image/x-icon" href="ico.ico">
	
	</head>


<body>
	
	<div class="back">
	

<div class="podst">
			
			<br>
			<h2> Výpis dát z databázy </h2> <br><br><br>
			
			<form action="formular.php"' method='post'>
			<input type="submit" name="form" value="Zadať nové údaje do databázy."></input></form>
			* Toto tlačidlo vás presunie na formulár, kde môžete zadať nové dáta do databázy.
			<br><hr><br><br>
			
			
			<form action="tabulka.php" method="post">
			<input type="text" name="search" placeholder="Vyhľadať">
			<input type="submit" name="butt" value="Vyhľadať"></input>
			</form>
			
			* Vyhľadané dáta sa po stlačení tlačidla zobrazia nad všetkými dátami pred čiarou.<br>
			Vyhľadávať môžete podľa atribútov: <br>
			-- Meno (napísaním mena) <br>
			-- Pohlavie (napísaním písmena 'm' alebo 'z') <br>
			-- Hodnotenie (napísaním čísla 1, 2, 3, 4, alebo 5.) <br><br>
			
			
<?php
			include_once 'DB_config.php';
			$conn = mysqli_connect(DB_HOST, DB_USERNAME, DB_PASSWORD, DB_NAME); /* spojenie s databázou */
			if (!$conn)
			{ echo "<font color='red'> FAILED</font> Záznam sa nenašiel ";} /* ---------- Kontrola*/
			
			
			if(isset($_POST['butt'])){
				$search = $_POST['search']; /* Do premennej $search sa zapíše vyhľadaný text */
				
				$sql = "SELECT * FROM user WHERE Meno LIKE '$search' OR Hodnotenie Like '$search' OR Pohlavie Like '$search'";
				$result = mysqli_query($conn, $sql);
			
			
			echo '<table class="table"><tr><th>ID</th><th>Meno</th><th>Pohlavie</th><th>Pravidelnosť
			</th><th>Hodnotenie</th><th>Komentár</th><th>Čas</th><th>DELETE</th><th>UPDATE</th></tr>'; /* --- Prvý riadok tabuľky*/
			
			while($row = mysqli_fetch_array($result)){
				
				$id = $row['ID'];
				
				echo '<tr><td>' . $row['ID'] 
				. '</td><td>' . $row['Meno'] 
				. '</td><td>' . $row['Pohlavie'] 
				. '</td><td>' . $row['Pravidelnost'] 
				. '</td><td>' . $row['Hodnotenie']; 
				
				echo "</td><td><form action='koment.php?ID=$id' method='post'>";
				echo '<input type="submit" name="comment" value="Zobraziť komentár"></input></form>'; /* ----- Komentár sa bude vypisovať na inej podstránke. */
				
				echo '</td><td>' . date("d.m. Y H:i", strtotime($row['Cas']));
				
				echo "</td><td><form action='delete.php?ID=$id' method='post'>"; /* ----- ?ID=$id za linkom odošle identifikátor do delete.php, rovnako to bude fungovať pri UPDATE */
				echo '<input type="submit" name="del" value="DELETE"></input></form>';
				
				echo "</td><td><form action='update.php?ID=$id' method='post'>";
				echo '<input type="submit" name="update" value="UPDATE"></input></form>';
				
				echo '</td></tr>'; 
			}	
			echo '</table>';
			}
			
			
			
			
			
			
			
			
			
			
			
			
		echo '<br><br><br><br><br><hr><h2>' . "Všetky" . '</h2><br>';	
/* ---------------------------------------- Výpis všetkých údajov. ----------------------------------------*/
/* K výpisu všetkých dát nebudem pridávať komentáre, pretože je to to isté, ako v prípade vyhľadaných dát s rozdielom, že tu žiadna podmienka dáta nefiltruje. */

			$sql = ("SELECT * FROM user");
			$result = mysqli_query($conn, $sql);
			
			
			echo '<table class="table"><tr><th>ID</th><th>Meno</th><th>Pohlavie</th><th>Pravidelnosť
			</th><th>Hodnotenie</th><th>Komentár</th><th>Čas</th><th>DELETE</th><th>UPDATE</th></tr>';
			
			while($row = mysqli_fetch_array($result)){
				
				$id = $row['ID'];
				
				echo '<tr><td>' . $row['ID'] 
				. '</td><td>' . $row['Meno'] 
				. '</td><td>' . $row['Pohlavie'] 
				. '</td><td>' . $row['Pravidelnost'] 
				. '</td><td>' . $row['Hodnotenie']; 
				
				echo "</td><td><form action='koment.php?ID=$id' method='post'>";
				echo '<input type="submit" name="comment" value="Zobraziť komentár"></input></form>';
				
				echo '</td><td>' . date("d.m. Y H:i", strtotime($row['Cas']));
				
				echo "</td><td><form action='delete.php?ID=$id' method='post'>";
				echo '<input type="submit" name="del" value="DELETE"></input></form>';
				
				echo "</td><td><form action='update.php?ID=$id' method='post'>";
				echo '<input type="submit" name="update" value="UPDATE"></input></form>';
				
				echo '</td></tr>'; 
			}	
			echo '</table>';
					
			mysqli_free_result($result);
			mysqli_close($conn);

?>
			
		</div>
	</div>
</body>
</html>