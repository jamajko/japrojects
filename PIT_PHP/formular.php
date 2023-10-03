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
			
			<br><h2> Formulár pre zadanie nových dát </h2>
			Pomocou tohto formuláru môžete do databázy vložiť údaje ako Meno, Pohlavie, Hodnotenie, Komentár, Pravidelnosť. <br>
			Atribút ID sa zapisuje autoinkrementáciou.
			Atribút Čas sa s zapíše podľa aktuálneho času po stlačení tlačidla odoslať. <br> <hr> <br>
			
			
			
<!-- ------------------------------ Formulár ------------------------------ -->
			
			<form action="<?php $_SERVER["PHP_SELF"] ?>" method="post">
			
				<input type="text" name="name" placeholder="Meno" required="required"> <br><br><br> <!-- ------- Meno -->
				
				Pohlavie: <select name="gender">
				<option value="m">Muž</option>
				<option value="z">Žena</option> <!-- ------- Pohlavie -->
				</select> <br><br><br>
				
				
				Hodnotenie:<br>
				odpad
				<input type="radio" name="rate" value="1" checked="checked">
				<input type="radio" name="rate" value="2">
				<input type="radio" name="rate" value="3">
				<input type="radio" name="rate" value="4">
				<input type="radio" name="rate" value="5"> <!-- ------- Hodnotenie -->
				výborná <br><br><br>
				
				
				<textarea name="com" rows="7" cols="100" placeholder="Komentár (nepovinné)"></textarea> <!-- ------- Komentár -->
				<br><br>
				
				
				<input type="checkbox" name="check" value="1"> Hry hrávam pravidelne. <!-- ------- Pravidelnosť -->
				<br><br>
				
				
				<input type="submit" name="button" value="Odoslat"></input> <!-- ------- Tlačidlo na odoslanie dát -->
			</form>
			
			
			

			
			<?php
			include_once 'DB_config.php';
			$conn = mysqli_connect(DB_HOST, DB_USERNAME, DB_PASSWORD, DB_NAME);
			
/* --------------------- Insert --------------------*/
			
			if(isset($_POST['button'])){ /* ----- Podmienka, ktorá zaistí, aby sa dáta načítali až po stlačení tlačidla */

				$name = $_POST['name'];
				$gender = $_POST['gender'];
				$rate = $_POST['rate'];
				$com = nl2br($_POST['com']); /* ----- funkcia nl2br zaistí, že sa do databázy zapíšu aj odriadkovania z textového poľa */

				if(isset($_POST['check'])){
					$check = $_POST['check'];
				}
				else{
					$check = 0;
				}
				
				
/* ----- Vkladanie dát do tabuľky v databáze, current_timestamp zapíše do atribútu aktuálny dátum a čas, keď používateľ stlačí tlačidlo odoslať ----- */
				$sql = "INSERT INTO user(Meno, Pohlavie, Hodnotenie, Komentar, Pravidelnost, Cas) VALUES('$name', '$gender', '$rate', '$com', '$check', current_timestamp)";
				mysqli_query($conn, $sql);
			}
			
echo "<br><form action='tabulka.php' method='post'>";
echo '<input type="submit" name="up" value="Späť"></input></form>'; /* ----- Tlačidlo na návrat k výpisu */
				
			?>
			
		</div>
	</div>
</body>
</html>