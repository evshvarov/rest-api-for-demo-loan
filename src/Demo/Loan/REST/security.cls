Class Demo.Loan.REST.security Extends %RegisteredObject
{

ClassMethod SetupSecurity() As %Status
{
    Set tSC = $$$OK
    d ..IntroduceSQLRole()
    d ..AddRole()
    d ..AddCORS()
    d ..IntroduceRoleDBUSER()
    d ..IntroduceRoleDBUSERWrite()
    d ..AddRoleToUser()
    d ..AddRole(,"DB_USER_ReadWrite")
    //d ..AddDelegate("/loan/api")
    Quit tSC
}

ClassMethod IntroduceSQLRole() As %Status
{
    &SQL(CREATE ROLE loan)
    If SQLCODE '= 0 {
        Quit $$$ERROR($$$GeneralError, "Error creating role: "_SQLCODE)
    }
    #; &SQL(GRANT SELECT,INSERT,UPDATE,DELETE on shvarov_loan.trip to loan)
    #; If SQLCODE '= 0 {
    #;     Quit $$$ERROR($$$GeneralError, "Error granting privileges: "_SQLCODE)
    #; }
    Quit $$$OK
}

ClassMethod IntroduceRoleDBUSER() As %Status
{
    &SQL(CREATE ROLE DB_USER_Read)
    If SQLCODE '= 0 {
        Quit $$$ERROR($$$GeneralError, "Error creating role: "_SQLCODE)
    }

    // Change to the %SYS namespace.
    new $NAMESPACE
    set $NAMESPACE="%SYS"
    set properties("Resources")="%DB_USER:R"
 
    Set sc = ##class(Security.Roles).Modify("DB_USER_Read",.properties)
    If $$$ISERR(sc) {
        Quit $$$ERROR($$$GeneralError, "Error modifying role: "_sc)
    }
    return sc
}

ClassMethod IntroduceRoleDBUSERWrite() As %Status
{
    &SQL(CREATE ROLE DB_USER_ReadWrite)
    If SQLCODE '= 0 {
        Quit $$$ERROR($$$GeneralError, "Error creating role: "_SQLCODE)
    }

    // Change to the %SYS namespace.
    new $NAMESPACE
    set $NAMESPACE="%SYS"
    set properties("Resources")="%DB_USER:RW"
 
    Set sc = ##class(Security.Roles).Modify("DB_USER_ReadWrite",.properties)
    If $$$ISERR(sc) {
        Quit $$$ERROR($$$GeneralError, "Error modifying role: "_sc)
    }
    return sc
}

ClassMethod AddRoleToUser(user = "CSPSystem", role = "DB_USER_Read") As %Status
{
    // Change to the %SYS namespace.
    new $NAMESPACE
    set $NAMESPACE="%SYS"

    set status=##class(Security.Users).Get(user, .MyUserProps)
    set $p(MyUserProps("Roles"),",",*)=role
    set status=##class(Security.Users).Modify(user,.MyUserProps)

    // Announce success.
    if $$$ISOK(status) {
        write !, "Roles for the user "_user_" were successfully modified."
    }
    if $$$ISERR(status) {
        write !, "Error modifying roles for the user "_user_"."_". Error:"_status
       Quit $$$ERROR($$$GeneralError, "Error modifying role: "_status) 
    }

    Quit status
}

ClassMethod AddRole(appname = "/loan/api", approle = "loan") As %Status
{
    // Change to the %SYS namespace.
    new $NAMESPACE
    set $NAMESPACE="%SYS"

    set status=##class(Security.Applications).Get(appname, .MyAppProps)
    set MyAppProps("MatchRoles")=MyAppProps("MatchRoles")_":"_approle

    set status=##class(Security.Applications).Modify(appname,.MyAppProps)

    // Announce success.
    if $$$ISOK(status) {
        write !, "Roles were successfully modified."
    }
    Quit status
}

ClassMethod AddCORS(appname = "/loan/api") As %Status
{
    // Change to the %SYS namespace.
    new $NAMESPACE
    set $NAMESPACE="%SYS"

    set status=##class(Security.Applications).Get(appname, .MyAppProps)
    set MyAppProps("CorsAllowlist")="*"
    set MyAppProps("CorsCredentialsAllowed")=1
    set MyAppProps("CorsHeadersList")="Content-Type,Authorization,X-Requested-With,Accept,Origin,Access-Control-Request-Method,Access-Control-Request-Headers"
    set status=##class(Security.Applications).Modify(appname,.MyAppProps)

    // Announce success.
    if $$$ISOK(status) {
        write !, "CORS methods were successfully added to."_appname
    }
    Quit status
}

}
