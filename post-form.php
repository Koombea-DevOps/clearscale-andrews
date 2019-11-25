<?php

// Enable AWS SDK for PHP
require '/vendor/autoload.php';
// Load libraries
use Aws\Sns\SnsClient;
use Aws\Exception\AwsException;

// Initialize SnsClient
$SnSclient = new SnsClient([
  'region' => getenv('AWS_REGION'),
  'version' => '2010-03-31'
]);

// Body message
$message = $_POST['body'];

// SNS topic
$topic = getenv('SNS_TOPIC_ARN');

// Send message to the defined topic
try {
  $result = $SnSclient->publish([
    'Message' => $message,
    'TopicArn' => $topic,
  ]);
  var_dump($result);
} catch (AwsException $e) {
  // output error message if fails
  error_log($e->getMessage());
}

?>
