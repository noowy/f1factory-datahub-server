<?php 

include __DIR__ . '/db_conf.php';
define('USER', 'f1drm');
define('PASSWORD', '4563728deK');

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
		if ($_POST['extra'] == 'get_id')
		{
			$last_id = $db->query('SELECT LAST_INSERT_ID() AS new_id');
			$response['content'] = mysql_response_to_array($last_id);
		}
		else
		{
			$response['content'] = 'Data was updated';
		}
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