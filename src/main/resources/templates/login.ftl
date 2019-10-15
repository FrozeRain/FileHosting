<#import "common/auth.ftl" as auth>

<@auth.auth "/login", "Login page", "/registration", "Register now", "Sign In", false>
    <#if Session?? && Session.SPRING_SECURITY_LAST_EXCEPTION??>
        <div class="alert alert-danger">
            ${Session.SPRING_SECURITY_LAST_EXCEPTION.message}
        </div>
    </#if>
</@auth.auth>