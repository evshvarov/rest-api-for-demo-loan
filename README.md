## rest-api-for-demo-loan
 This is a addon module for Demo Loan InterSystems Interoperability demo package that introduces REST API business service to handle incoming REST API calls for credit requests.

## Prerequisites
Needs DEMO Loan installed

## Installation with ZPM

zpm:USER>install interoperability-loan-rest-api

## Installation for development

Clone/git pull the repo into any local directory e.g. like it is shown below (here I show all the examples related to this repository, but I assume you have your own derived from the template):

```
$ git clone git@github.com:evshvarov/rest-api-for-demo-loan.git
```

Open the terminal in this directory and run:

```
$ docker-compose up -d --build
```

or open the folder in VSCode and do the following:
![rest](https://user-images.githubusercontent.com/2781759/78183327-63569800-7470-11ea-8561-c3b547ce9001.gif)


## How to Work With it

This addon creates /loan/api REST web-application on IRIS which implements submit API call which expects data for the credit inquary.
In order to make it work, install it to DEMO Loan demo and add REST API service of 
"Demo.Loan.FindRateRESTService" type and connect it with Business Process, similar to "Demo.Loan.FindRateCSPService".

It can work with any frontend, but at least with demo-loan-frontend, so install it as
zpm "install demo-loan-frontend" before hand and open
Open http://localhost:52773/loan/index.html to test the REST API


