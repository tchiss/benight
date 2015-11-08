<?php
$log = print_r($_SERVER,1);
$log .= print_r($_POST,1);
$log .= print_r($_GET,1);
file_put_contents('./log/'.time().'.txt', $log);

date_default_timezone_set('UTC');

function getProperDateFormat($value)
{
    $date = $value;
    $dateFormatString = 'Y-m-d\TH:i';
    $date = $date->format($dateFormatString);
    $date .= 'Z';
    return $date;
}

if(($_REQUEST['ObjectId'] != '')&&($_REQUEST['authKey'] != "KNfCMt9TUSgYBfg"))
{
    require('./passkit.php');

    require 'vendor/autoload.php';

    Parse\ParseClient::initialize('KB0XBMX06SVCiUnSUKKgA52v2pee75nSGexrh0wT', 'ZhCIBPq3Sa8MIAO5l6mLtpU2ksHrX1rs2eb8VhLr', '0cLzD2VR4L9Q3iduvkCt2j4YAoUAk3Aj1lEr7hge');


    $Certificates = array('AppleWWDRCA'  => './certs/AppleWWDRCA.pem',
        'Certificate'  => './certs/Certificate.p12',
        'CertPassword' => 'benight');
    $eventName = "Error";
    $eventCode = "Error";
    $eventPlace = "Error";
    $eventDate = "2015-04-04T06:00Z";
    $query = new Parse\ParseQuery("Tickets");
    try
    {
        $reservation = $query->get($_POST['ObjectId']);
        $eventName = (string) $reservation->get("EventName");
        $eventCode = (string) $reservation->get("objectId");
        $eventAlt = 'Benight.cc';
        $eventPlace = (string) $reservation->get("EventPlace");
        $eventDate = getProperDateFormat($reservation->get("Date"));

        //$nametest = "Pokemon";
        // The object was retrieved successfully.
    }
    catch (Parse\ParseException $ex)
    {
        $eventName = "Error";
        $eventCode = "Error";
        $eventAlt = 'Benight.cc';
        http_response_code(500);
        die("Bad Request");
    }


    $ImageFiles = array('images/icon.png', 'images/icon@2x.png', 'images/logo.png', 'images/logo@2x.png', 'images/background.png','images/background@2x.png');

    $data = array('./data/array.php',
        './data/event.php',
        './data/small.php',
        './data/coupon.json',
        './data/event.json',
        './data/small.json',
        './data/generic.json');
    if($_GET['update'] != '')
    {
        $example_data = 4;
    }
    elseif(!is_numeric($_POST['aexample']))
    {
        $example_data = rand(0,6);
    }
    else
    {
        $example_data = $_POST['aexample'];
    }


    if($example_data < 3)
    {
        $JSON = '{
  "authenticationToken": "vxwxd7J8AlNNFPS8k0a0FfUFtq0ewzFdc",
  "backgroundColor": "rgb(109, 110, 113)",
  "barcode": {
    "format": "PKBarcodeFormatQR",
    "message": "'.$eventCode.'",
    "messageEncoding": "iso-8859-1",
    "altText":"'.$eventAlt.'"
  },
  "description": "Benight Tickets.",
  "eventTicket": {
    "backFields": [
      {
        "key": "terms",
        "label": "TERMS AND CONDITIONS",
        "value": "Benight Ticket. Terms and Condition in Progress."
      }
    ],
    "primaryFields": [
      {
        "key": "event",
        "label": "EVENT",
        "value": "'.$eventName.'"
      }
    ],
    "secondaryFields": [
      {
        "key": "loc",
        "label": "LOCATION",
        "value": "'.$eventPlace.'"
      },
      {
         "key": "date",
         "label": "Date and Time",
         "dateStyle": "PKDateStyleMedium",
         "timeStyle": "PKDateStyleShort",
         "value": "'.$eventDate.'",
         "isRelative": true
      }
    ]
  },
  "foregroundColor": "rgb(255, 255, 255)",
  "labelColor" : "rgb(81,82,84)",
  "formatVersion": 1,
  "locations": [
    {
      "latitude": 37.6189722,
      "longitude": -122.3748889
    },
    {
      "latitude": 37.33182,
      "longitude": -122.03118
    }
  ],
  "organizationName": "Benight",
  "passTypeIdentifier": "pass.com.benigh",
  "serialNumber": "nmyuxofgnb",
  "teamIdentifier": "RK36ZAQX82",
  "webServiceURL": "https://tickets.benight.cc/",
  "revelantDate": "'.$eventDate.'"
}';
        //include($data[$example_data]);
    }
    else
    {
        $JSON = file_get_contents($data[$example_data]);
    }


    $TempPath = 'tmp';

    echoPass(createPass($Certificates, $ImageFiles, $JSON, 'passtest', $TempPath));

    m_uwait(12500);
    die();
}

else if (($_POST['time'] != '')&&($_POST['aexample'] != ""))
{
    require('./passkit.php');

    require 'vendor/autoload.php';

    Parse\ParseClient::initialize('KB0XBMX06SVCiUnSUKKgA52v2pee75nSGexrh0wT', 'ZhCIBPq3Sa8MIAO5l6mLtpU2ksHrX1rs2eb8VhLr', '0cLzD2VR4L9Q3iduvkCt2j4YAoUAk3Aj1lEr7hge');


    $Certificates = array('AppleWWDRCA'  => './certs/AppleWWDRCA.pem',
        'Certificate'  => './certs/Certificate.p12',
        'CertPassword' => 'benight');
    $eventName = "Error";
    $eventCode = "Error";
    $eventPlace = "Error";
    $eventDate = "2015-04-04T06:00Z";
    $query = new Parse\ParseQuery("Tickets");
    try
    {
        $reservation = $query->get("ilnRO4HmzR");
        $eventName = (string) $reservation->get("EventName");
        $eventCode = (string) $reservation->get("objectId");
        $eventAlt = 'Benight.cc';
        $eventPlace = (string) $reservation->get("EventPlace");
        $eventDate = getProperDateFormat($reservation->get("Date"));

        //$nametest = "Pokemon";
        // The object was retrieved successfully.
    }
    catch (Parse\ParseException $ex)
    {
        $eventName = "Error";
        $eventCode = "Error";
        $eventAlt = 'Benight.cc';
        http_response_code(500);
        die("Bad Request");
    }


    $ImageFiles = array('images/icon.png', 'images/icon@2x.png', 'images/logo.png');

    $data = array('./data/array.php',
        './data/event.php',
        './data/small.php',
        './data/coupon.json',
        './data/event.json',
        './data/small.json',
        './data/generic.json');
    if($_GET['update'] != '')
    {
        $example_data = 4;
    }
    elseif(!is_numeric($_POST['aexample']))
    {
        $example_data = rand(0,6);
    }
    else
    {
        $example_data = $_POST['aexample'];
    }


    if($example_data < 3)
    {
        $JSON = '{
  "authenticationToken": "vxwxd7J8AlNNFPS8k0a0FfUFtq0ewzFdc",
  "backgroundColor": "rgb(109, 110, 113)",
  "barcode": {
    "format": "PKBarcodeFormatQR",
    "message": "'.$eventCode.'",
    "messageEncoding": "iso-8859-1",
    "altText":"'.$eventAlt.'"
  },
  "description": "Benight Tickets.",
  "eventTicket": {
    "backFields": [
      {
        "key": "terms",
        "label": "TERMS AND CONDITIONS",
        "value": "Benight Ticket. Terms and Condition in Progress."
      }
    ],
    "primaryFields": [
      {
        "key": "event",
        "label": "EVENT",
        "value": "'.$eventName.'"
      }
    ],
    "secondaryFields": [
      {
        "key": "loc",
        "label": "LOCATION",
        "value": "'.$eventPlace.'"
      },
      {
         "key": "date",
         "label": "Date and Time",
         "dateStyle": "PKDateStyleMedium",
         "timeStyle": "PKDateStyleShort",
         "value": "'.$eventDate.'",
         "isRelative": true
      }
    ]
  },
  "foregroundColor": "rgb(255, 255, 255)",
  "formatVersion": 1,
  "locations": [
    {
      "latitude": 37.6189722,
      "longitude": -122.3748889
    },
    {
      "latitude": 37.33182,
      "longitude": -122.03118
    }
  ],
  "labelColor" : "rgb(81,82,84)",
  "organizationName": "Benight",
  "passTypeIdentifier": "pass.com.benigh",
  "serialNumber": "nmyuxofgnb",
  "teamIdentifier": "RK36ZAQX82",
  "webServiceURL": "https://tickets.benight.cc/",
  "revelantDate": "'.$eventDate.'"
}';
        //include($data[$example_data]);
    }
    else
    {
        $JSON = file_get_contents($data[$example_data]);
    }


    $TempPath = 'tmp';

    echoPass(createPass($Certificates, $ImageFiles, $JSON, 'passtest', $TempPath));

    m_uwait(12500);
    die();
}
?>
<html>
<head>
    <meta charset="utf-8">
    <meta content="width=220, initial-scale=1.3" name="viewport">
    <meta content="IE=edge,chrome=1" http-equiv="X-UA-Compatible">
    <title>passkit.php demo</title>
    <style>
        body{
            width: 220px;
            margin: 30px auto;
        }
        form, input, select{
            display: block;
            font-size: 16px;
            margin: 25px auto 25px auto;
            width: 220px;
        }
        input, select{
            width: 220px;
        }
        h1{
            width: 185px;
            font-family: "Hoefler Text", Constantia, Palatino, Georgia, serif;
            margin: auto;
        }
        #repo{
            font-family: "Lucida Grande", "Lucida Sans Unicode", Geneva, sans-serif;
            font-size: 7pt;
            color: #444;
        }
    </style>
</head>
<body>
<h1>passkit.php</h1>
<p>select a example and press the submit button to generate a pass</p>
<form action="./" method="post">
    <select id="aexample" name="aexample" size="1">
        <option value="0">event (php)</option>
    </select>
    <input style="display:none;" name="time" id="time" type="text" value="<?php echo time(); ?>">
    <input type="submit" value="Generate Passbook Pass">
</form>
</body>
</html>
