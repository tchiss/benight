<?php

$nametest = "toto";

$JSON = '{
  "authenticationToken": "vxwxd7J8AlNNFPS8k0a0FfUFtq0ewzFdc",
  "backgroundColor": "rgb(60, 65, 76)",
  "barcode": {
    "format": "PKBarcodeFormatPDF417",
    "message": "123456789",
    "messageEncoding": "iso-8859-1"
  },
  "description": "'.$nametest.'",
  "eventTicket": {
    "backFields": [
      {
        "key": "terms",
        "label": "TERMS AND CONDITIONS",
        "value": "Generico offers this pass, including all information, software, products and services available from this pass or offered as part of or in conjunction with this pass (the \"pass\"), to you, the user, conditioned upon your acceptance of all of the terms, conditions, policies and notices stated here. Generico reserves the right to make changes to these Terms and Conditions immediately by posting the changed Terms and Conditions in this location.\n\nUse the pass at your own risk. This pass is provided to you \"as is,\" without warranty of any kind either express or implied. Neither Generico nor its employees, agents, third-party information providers, merchants, licnsors or the like warrant that the pass or its operation will be accurate, reliable, uninterrupted or error-free. No agent or representative has the authority to create any warranty regarding the pass on behalf of Generico. Generico reserves the right to change or discontinue at any time any aspect or feature of the pass."
      }
    ],
    "primaryFields": [
      {
        "key": "event",
        "label": "EVENT",
        "value": "'.$nametest.'"
      }
    ],
    "secondaryFields": [
      {
        "key": "loc",
        "label": "LOCATION",
        "value": "Moscone West"
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
  "organizationName": "Benight",
  "passTypeIdentifier": "pass.com.benigh",
  "relevantDate": "2014-12-08T13:00-08:00",
  "serialNumber": "nmyuxofgnb",
  "teamIdentifier": "RK36ZAQX82",
  "webServiceURL": "https://example.tld/pass"
}';

?>
