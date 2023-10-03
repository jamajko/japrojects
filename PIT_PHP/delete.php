<?php
include_once 'DB_config.php';
$conn = mysqli_connect(DB_HOST, DB_USERNAME, DB_PASSWORD, DB_NAME);

@$id = $_GET['ID'];
$sql = "DELETE FROM user WHERE ID = '$id' ";

$result = mysqli_query($conn, $sql);
mysqli_close($conn);

if($result) /* -------------------------------------------------------------------------------- Kontrola vymazania dát.*/
{ echo "<font color='green'> Vymazanie dát prebehlo úspešne </font>";}
else { echo "<font color='red'> FAILED</font> Vymazanie dát sa nepodarilo ";}

echo "<br><br><form action='tabulka.php' method='post'>";
echo '<input type="submit" name="del" value="Späť"></input></form>';
?>
