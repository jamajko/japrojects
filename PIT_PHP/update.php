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


<?php
if (empty($_POST['submit'])){ /* ---------------------------------------- Pod touto podmienkou sa nachádzajú príkazy pre prípad, že tlačidlo ešte nebolo stlačené */
    include_once 'DB_config.php';
	$conn = mysqli_connect(DB_HOST, DB_USERNAME, DB_PASSWORD, DB_NAME);

@$id =$_GET['ID'];

$result = mysqli_query($conn, "SELECT * FROM user WHERE ID = '$id'");
$test = mysqli_fetch_array($result);
if(!$result)
{ echo "<font color='red'> FAILED</font> Záznam sa nenašiel ";} /* ---------- Kontrola či sa našli dáta z databázy. */

$name = $test['Meno'];
$gender = $test['Pohlavie'];
$rate = $test['Hodnotenie'];
$com = $test['Komentar'];
$check = $test['Pravidelnost'];


mysqli_close($conn);

}
			
			
			
			
			
			if(isset($_POST['submit'])){ /* ---------------------------------- Pod touto podmienkou sa nachádzajú príkazy pre prípad, že tlačidlo už bolo stlačené */
			
            include_once 'DB_config.php';
	        $conn = mysqli_connect(DB_HOST, DB_USERNAME, DB_PASSWORD, DB_NAME);

			@$id =$_GET['ID'];

			$result = mysqli_query($conn, "SELECT * FROM user WHERE ID = '$id'");
			$test = mysqli_fetch_array($result);
			
			if(!$result)
			{ echo "<font color='red'> FAILED</font> Záznam sa nenašiel ";} /* ---------- Kontrola či sa našli dáta z databázy. */
		

		
				$name = $_POST['name'];
				$gender = $_POST['gender'];
				$rate = $_POST['rate'];
				$com = nl2br($_POST['com']); /* --------------- funkcia nl2br zaistí, že sa do databázy zapíšu aj odriadkovania z textového poľa */

				if(isset($_POST['check'])){
					$check = $_POST['check'];
				}
				else{
					$check = 0;
				}
				
			
			
				$sql = "UPDATE user SET Meno='$name', Pohlavie='$gender', Hodnotenie='$rate', Komentar='$com', Pravidelnost='$check' WHERE ID = '$id'";
				$result = mysqli_query($conn, $sql) or die ("Databázový dopyt sa nepodaril");
				mysqli_close($conn);
			}
?>





<br><h2> Update dát </h2><br>
Toto je stránka pre update dát. Tu môžte upraviť dáta ako Meno používateľa, pohlavie, hodnotenie, komentár, aj zmeniť údaj o tom, či je hráč pravidelný. <br>
Updateom dát sa neupdateuje dátum a čas, kedy boli dáta upravené. Dátum a čas ostane z prvého vytvorenia riadku. <br><br><br>


<!-- ------------------------------ Formulár ------------------------------ -->

			
			<form action="<?php $_SERVER["PHP_SELF"] ?>" method='post'>
			
				<input type="text" name="name" placeholder="Meno" value="<?php echo $name ?>" required="required"> <p> <!-- kolónka na zápis mena -->
				
				
				Pohlavie: <select name="gender">
				<option value="m" <?php if($gender == 'm') {echo 'selected';} ?>>Muž</option>
				<option value="z" <?php if($gender == 'z') {echo 'selected';} ?>>Žena</option>
				</select> <!-- Rozbaľovacie menu pre výber pohlavia -->
				
				<p>
				Hodnotenie:<br>
				odpad
				<input type="radio" name="rate" value="1" <?php if($rate == 1) {echo 'checked="checked"';} ?>>
				<input type="radio" name="rate" value="2" <?php if($rate == 2) {echo 'checked="checked"';} ?>>
				<input type="radio" name="rate" value="3" <?php if($rate == 3) {echo 'checked="checked"';} ?>>
				<input type="radio" name="rate" value="4" <?php if($rate == 4) {echo 'checked="checked"';} ?>>
				<input type="radio" name="rate" value="5" <?php if($rate == 5) {echo 'checked="checked"';} ?>>
				výborná <!-- input type radio, kde user môže hru obodovať od 1 do 5 -->
				
				<p>
				<textarea name="com" rows="7" cols="100" placeholder="Komentár (nepovinné)"><?php echo $com ?></textarea>
				<!-- Blok pre komentár -->
				
				
				<p>
				<?php
				if($check == 1)
				{ echo '<input type="checkbox" name="check" value="1" checked="checked"> Hry hrávam pravidelne.'; }
				else { echo '<input type="checkbox" name="check" value="1"> Hry hrávam pravidelne.'; }
				?> <!-- checkbox pre zaškrtnutie či je hráč pravidelným hráčom -->
				
				<p>
				<input type="submit" name="submit" id="submit"></input> <!-- Tlačidlo na odoslanie dát na update. -->
			</form>
		




<!-- ---------- Tlačidlo na návrat na stránku s výpisom dát. ---------- -->
<?php
echo "<br><form action='tabulka.php' method='post'>";
echo '<input type="submit" name="up" value="Späť"></input></form>';
?>

</div>
</div>

</body>
</html>