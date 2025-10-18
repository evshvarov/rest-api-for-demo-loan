Class Demo.Loan.REST.spec Extends %REST.Spec [ ProcedureBlock ]
{

Parameter HandleCorsRequest = 1;

Parameter CONTENTTYPE = "application/json";

Parameter ExposeServerExceptions = 1;

XData OpenAPI [ MimeType = application/json ]
{
{
  "swagger":"2.0",
  "info":{
    "version":"1.0.0",
    "title":"Form Submission API"
  },
  "basePath":"/loan/api",
  "schemes":[
    "http",
    "https"
  ],
  "paths":{
    "/_spec":{
      "get":{
        "summary":"Get this API's Swagger spec",
        "description":"Returns the OpenAPI 2.0 (Swagger) specification for this service.",
        "operationId":"GetSpec",
        "produces":[
          "application/json"
        ],
        "responses":{
          "200":{
            "description":"The Swagger spec document",
            "schema":{
              "type":"object",
              "additionalProperties":true
            }
          }
        }
      }
    },
    "/submit":{
      "post":{
        "summary":"Submit form data",
        "description":"Collects form input data and stores it for processing.",
        "operationId":"submitForm",
        "parameters":[
          {
            "in":"body",
            "name":"formData",
            "description":"Form data to be submitted",
            "required":true,
            "schema":{
              "type":"object",
              "required":[
                "amount",
                "name",
                "taxid",
                "nationality",
                "email"
              ],
              "properties":{
                "amount":{
                  "type":"number",
                  "format":"integer",
                  "description":"The monetary amount"
                },
                "name":{
                  "type":"string",
                  "example":"John Doe",
                  "description":"Full name of the individual"
                },
                "taxid":{
                  "type":"string",
                  "example":"AB123456C",
                  "description":"Tax identification number"
                },
                "nationality":{
                  "type":"string",
                  "example":"british",
                  "description":"Nationality of the individual"
                },
                "email":{
                  "type":"string",
                  "format":"email",
                  "example":"john.doe@example.com",
                  "description":"Email address of the individual"
                }
              }
            }
          }
        ],
        "responses":{
          "200":{
            "description":"Form submitted successfully",
            "schema":{
              "type":"object",
              "properties":{
                "status":{
                  "type":"string",
                  "example":"success"
                },
                "message":{
                  "type":"string",
                  "example":"Form data received successfully."
                }
              }
            }
          },
          "400":{
            "description":"Invalid input data",
            "schema":{
              "type":"object",
              "properties":{
                "status":{
                  "type":"string",
                  "example":"error"
                },
                "message":{
                  "type":"string",
                  "example":"Validation error: missing or invalid fields."
                }
              }
            }
          }
        }
      }
    }
  }
}
}

}
