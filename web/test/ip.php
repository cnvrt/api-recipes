<?php
// External service URL to get the public IP address
$url = 'https://ifconfig.me';
$url = 'https://api.my-ip.io/ip.json';
$url = 'https://api.ipify.org?format=json';

// Initialize cURL session
$ch = curl_init();

// Set cURL options
curl_setopt($ch, CURLOPT_URL, $url);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);

// Execute the cURL request
$response = curl_exec($ch);

// Check for cURL errors
if(curl_errno($ch)) {
    echo 'cURL Error: ' . curl_error($ch);
    exit;
}

// Close cURL session
curl_close($ch);

// Decode the JSON response
$data = json_decode($response, true);

// Extract the IP address
$public_ip = $data['ip'];

// Print the public IP address
echo 'Your public IP address is: ' . $public_ip;
?>
