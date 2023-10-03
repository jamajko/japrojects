<?php
include_once 'DB_config.php';
$conn = mysqli_connect(DB_HOST, DB_USERNAME, DB_PASSWORD, DB_NAME);

@$id = $_GET['ID'];
$sql = "SELECT * FROM user WHERE ID = '$id' ";

$result = mysqli_query($conn, $sql);
$test = mysqli_fetch_array($result);
if(!$result)
{ echo "<font color='red'> FAILED</font> Záznam sa nenašiel ";} /* ---------- Kontrola či sa našli dáta z databázy. */

$com = $test['Komentar'];
echo $com;

mysqli_close($conn);


echo "<br><br><form action='tabulka.php' method='post'>";
echo '<input type="submit" name="com" value="Späť"></input></form>';
?>
