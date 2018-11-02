<?php 

// the request form is 
// "?username=*defined_username*
//  &password=*defined_password*
//  &query=*your query to db*"

include __DIR__ . '/db_conf.php';

// Use these constsants to restrain access to the script
define('USER', '');
define('PASSWORD', '');

if (($_POST['username'] != USER) || ($_POST['password'] != PASSWORD))
{
	die('Get the heck outta here');
}

$response = array();

if (isset($_POST['query']))
{
	$db = new mysqli(DB_ADDRESS, DB_USER, DB_PASSWORD, DB_NAME);
	$query = $_POST['query'];
	$result = $db->query($query);

	if($result === true)
	{
		$response['success'] = true;
		$response['content'] = 'Data was updated';
		echo json_encode($response);
		exit();
	}
	if (!empty($result))
	{
		$response['success'] = true;
		$response['content'] = mysql_response_to_array($result);
	}
	else 
	{
		$response['success'] = false;
		$response['content'] = 'Server is unavailable or query was incorrect';
	}

	echo json_encode($response);
}

function mysql_response_to_array($response)
{
	$rows = array();
	while ($row = mysqli_fetch_assoc($response))
		$rows[] = $row;
	return $rows;
}

?>
