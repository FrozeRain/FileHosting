<#assign
context = Session.SPRING_SECURITY_CONTEXT??
>

<#if context>
    <#assign
    user = Session.SPRING_SECURITY_CONTEXT.authentication.principal
    name = user.getUsername()
    <#--    isAdmin = user.getAuthorities()?seq_contains('ADMIN') -->
    isAdmin = user.isAdmin()

    >
<#else>
    <#assign
    name = "Guest"
    isAdmin = false
    >
</#if>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <a class="navbar-brand" href="/">Simple File Hosting</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
            aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item">
                <a class="nav-link" href="/home">Home</a>
            </li>
            <#if isAdmin>
                <li class="nav-item">
                    <a class="nav-link" href="/panel">Admin Panel</a>
                </li>
            </#if>
        </ul>

        <div class="navbar-text mr-2">${name}</div>
        <#if context>
            <form action="/logout" method="post">
                <button class="btn btn-primary" type="submit">Sing Out</button>
                <input type="hidden" name="_csrf" value="${_csrf.token}"/>
            </form>
        </#if>
    </div>
</nav>