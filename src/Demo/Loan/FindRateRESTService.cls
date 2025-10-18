/// This is from https://github.com/intersystems/Samples-DemoLoan
/// Use or operation of this code is subject to acceptance of the license available in the code 
/// repository for this code.
/// 
/// A Business Service for process Applications received from CSP pages. 
/// To use this service, open DemoLoanForm.csp page and fill in the form.
/// The demo application will show your receipt notice on the web page, and will send the final Approval response by email
Class Demo.Loan.FindRateRESTService Extends Ens.BusinessService
{

/// Process REST API request from <var>pCSPRequest</var> argument and calls the Demo.Loan.FindRateDecisionProcessBPL Business Process.
/// Returns %Status - error status in case of failure to send a message to the Demo.Loan.FindRateDecisionProcessBPL Business Process.
/// Output argument <var>pOutput</var> contains a string with a receipt notice.
Method OnProcessInput(pRESTRequest As %Stream.Object, pOutput As Ens.StringContainer) As %Status
{
	set tApplication = ##class(Demo.Loan.Msg.Application).%New()
	//s ^AProcess=1
    set tApplication.Amount = pRESTRequest.%Get("amount")
	set tApplication.Name = pRESTRequest.%Get("name")
	set tApplication.TaxID = pRESTRequest.%Get("taxid")
	set tApplication.Nationality = pRESTRequest.%Get("nationality")
	set tApplication.BusinessOperationType = "mail"
	set tApplication.Destination = pRESTRequest.%Get("email")
	set tSC = ..SendRequestAsync("Demo.Loan.FindRateDecisionProcessBPL",tApplication)  
	return:$$$ISERR(tSC) tSC

	set pOutput = ##class(Ens.StringContainer).%New(tApplication.GetRecordNumberText(1))
	return tSC
}

}
