___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "TAG",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "Solute Conversion Tracking",
  "categories": [
    "CONVERSIONS",
    "UTILITY"
  ],
  "brand": {
    "id": "mbaersch",
    "displayName": "mbaersch",
    "thumbnail": "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAMAAABEpIrGAAAAY1BMVEUAAAD4rwD3rgD/tAD/twD3rwD3rgD4rwD4rgD4rwD3rwD/sgD4rgD4rwD3rwD4rwD3rwD6sAD5sAD6rgD3rwD3rwD3rgD4rwD4rwD4rwD4sQD3sgD3rgD4rwD6rwD/qgD4rwBqzhCrAAAAIHRSTlMAtcAKBuzq9tLOyRfWrKaeYltUPOXLwZeSaU0h5kYzEjR1BxUAAAC9SURBVDjL7dHJEoMgEATQjoAb7ltcssz/f2VqxDImApdc8y4cumscAcazKpOQdmE6PnDUKDrp2z0WBVmVYstjckgkWE5GNwS7bZ+C85pYNGkcyNqMbQCx7hcv+CLXwTeBhk+lcSIzTmaUfFQ42b59RcwLSFjIiH8EvG8Kq5TvFDznAqsLZ//CzwX/Vb8fy1Oo1ud2F7TiqHUWloyTDI6CniJisymo4NPQkZGDC26x8BcKAV+hvwPOgkrGFsYLFsczbltos6AAAAAASUVORK5CYII\u003d"
  },
  "description": "Track landingpages and conversions for Solute.",
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "SELECT",
    "name": "tagType",
    "displayName": "Tag Type",
    "macrosInSelect": false,
    "selectItems": [
      {
        "value": "landing",
        "displayValue": "Landingpage"
      },
      {
        "value": "conversion",
        "displayValue": "Conversion"
      }
    ],
    "simpleValueType": true
  },
  {
    "type": "GROUP",
    "name": "grpConversion",
    "displayName": "Conversion Data",
    "groupStyle": "NO_ZIPPY",
    "subParams": [
      {
        "type": "TEXT",
        "name": "value",
        "displayName": "Value",
        "simpleValueType": true,
        "valueValidators": [
          {
            "type": "NON_EMPTY"
          }
        ],
        "defaultValue": 0
      },
      {
        "type": "TEXT",
        "name": "orderId",
        "displayName": "Order ID",
        "simpleValueType": true,
        "valueValidators": [],
        "defaultValue": ""
      },
      {
        "type": "TEXT",
        "name": "factor",
        "displayName": "Factor (0 to 1)",
        "simpleValueType": true,
        "valueValidators": [
          {
            "type": "NON_EMPTY"
          },
          {
            "type": "DECIMAL"
          }
        ],
        "defaultValue": 1
      }
    ],
    "enablingConditions": [
      {
        "paramName": "tagType",
        "paramValue": "conversion",
        "type": "EQUALS"
      }
    ]
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

const sendPixel = require('sendPixel');
const encodeUriComponent = require('encodeUriComponent');
const getQueryParameters = require('getQueryParameters');
const makeInteger = require('makeInteger');
const getUrl = require('getUrl');
const getTimestampMillis = require('getTimestampMillis');
const localStorage = require('localStorage');
const Math = require('Math');
const log = require('logToConsole');

const pageUrl = getUrl();

if (data.tagType === "landing") {
  const soluteclid = getQueryParameters("soluteclid");
  if (soluteclid) {
    localStorage.setItem("soluteclid", getTimestampMillis() + " " + pageUrl);
    let url = "https://cmodul.solutenetwork.com/landing?url=" + encodeUriComponent(pageUrl);
    sendPixel(url, data.gtmOnSuccess, data.gtmOnFailure);      
  } else data.gtmOnSuccess(); 
} else {
  const soluteclid = localStorage.getItem("soluteclid");
  if (soluteclid) {
    const ttl = 1000*60*60*24*30;
    const parts = soluteclid.split(" ", 2);
    const timespan = getTimestampMillis() - makeInteger(parts[0]);
    if (timespan < ttl) {
      let url = "https://cmodul.solutenetwork.com/conversion" + 
          "?val=" + encodeUriComponent(data.value||0) + 
          "&oid=" + encodeUriComponent(data.orderId) + 
          "&factor=" + encodeUriComponent(data.factor||1) + 
          "&url=" + encodeUriComponent(parts[1]);
    } else {
      localStorage.removeItem("soluteclid");
      data.gtmOnSuccess();
    }
  } else data.gtmOnSuccess(); 
}


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "logging",
        "versionId": "1"
      },
      "param": [
        {
          "key": "environments",
          "value": {
            "type": 1,
            "string": "debug"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "access_local_storage",
        "versionId": "1"
      },
      "param": [
        {
          "key": "keys",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "soluteclid"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "send_pixel",
        "versionId": "1"
      },
      "param": [
        {
          "key": "allowedUrls",
          "value": {
            "type": 1,
            "string": "specific"
          }
        },
        {
          "key": "urls",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "https://cmodul.solutenetwork.com/*"
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "get_url",
        "versionId": "1"
      },
      "param": [
        {
          "key": "urlParts",
          "value": {
            "type": 1,
            "string": "any"
          }
        },
        {
          "key": "queriesAllowed",
          "value": {
            "type": 1,
            "string": "any"
          }
        }
      ]
    },
    "isRequired": true
  }
]


___TESTS___

scenarios: []


___NOTES___

Created on 10.9.2024, 15:36:20


