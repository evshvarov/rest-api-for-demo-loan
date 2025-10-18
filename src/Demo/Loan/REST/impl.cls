/// Business logic class defined by OpenAPI in Demo.Loan.REST.spec<br/>
/// Created Oct 5, 2025 11:58:29
Class Demo.Loan.REST.impl Extends %REST.Impl [ ProcedureBlock ]
{

/// Returns the OpenAPI 2.0 (Swagger) specification for this service.
ClassMethod GetSpec() As %DynamicObject
{
    set specname=$p(..%ClassName(1),".impl")
    Set spec = {}.%FromJSON(##class(%Dictionary.CompiledXData).%OpenId(specname_".spec||OpenAPI").Data)
	Set url = $Select(%request.Secure:"https",1:"http") _ "://"_$Get(%request.CgiEnvs("SERVER_NAME")) _ ":" _ $Get(%request.CgiEnvs("SERVER_PORT")) _ %request.Application
	Set spec.servers = [{"url" : (url)}]
	Quit spec
}

/// Collects form input data and stores it for processing.<br/>
/// The method arguments hold values for:<br/>
///     formData, Form data to be submitted<br/>
ClassMethod submitForm(formData As %Stream.Object) As %Stream.Object
{
    
    set formDataObj= {}.%FromJSON(formData.Read())
    set tSC=##class(Ens.Director).CreateBusinessService("Demo.Loan.FindRateRESTService",.tService)
	if ($$$ISERR(tSC)) { return "Error creating Business Service: "_tSC  quit }
    set tSC=tService.ProcessInput(formDataObj,.output)
	if ($$$ISERR(tSC)) { return "Error processing Business Service: "_tSC  quit }
	if $IsObject($Get(output)) { 
        //set ^CacheTempUserA("Output")=output.StringValue
        set resObj={}
        set resObj.Output=output.StringValue
        return resObj.%ToJSON()
    }

    return formData
}

}
