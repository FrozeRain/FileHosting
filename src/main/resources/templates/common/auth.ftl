<#macro auth path, tittle, link, linkT, bName, isRegister>
    <!DOCTYPE html>
    <html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title>Simple File | Hosting</title>
        <style type="text/css">
            table {
                width: min-content;
                border-collapse: collapse;
                border: 1px solid gray;
                border-spacing: 20px;
                margin: auto;
            }

            td {
                padding: 20px;
            }
        </style>
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"
              integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO"
              crossorigin="anonymous">

    </head>
    <body>
    <div class="container">
        <br>
        <div>
            <h2>${tittle}</h2>
        </div>
        <br>
        <form action="${path}" method="post">
            <div class="form-group row">
                <label class="col-sm-2 col-form-label" for="usr">User Name:</label>
                <div class="col-sm-3">
                    <input type="text" name="username"
                           class="form-control ${(usernameError??)?string('is-invalid', '')}" placeholder="Username"
                           id="usr" value="<#if user??>${user.username}</#if>"/>
                    <#if usernameError??>
                        <div class="invalid-feedback">
                            ${usernameError}
                        </div>
                    </#if>
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 col-form-label" for="psw">Password:</label>
                <div class="col-sm-3">
                    <input type="password" name="password"
                           class="form-control ${(passwordError??)?string('is-invalid', '')}" placeholder="Password"
                           id="psw"/>
                    <#if passwordError??>
                        <div class="invalid-feedback">
                            ${passwordError}
                        </div>
                    </#if>
                </div>
            </div>
            <#if isRegister>
                <div class="form-group row">
                    <label class="col-sm-2 col-form-label" for="psw">Confirm password:</label>
                    <div class="col-sm-3">
                        <input type="password" name="password2"
                               class="form-control ${(password2Error??)?string('is-invalid', '')}" placeholder="Retype password"
                               id="psw"/>
                        <#if password2Error??>
                            <div class="invalid-feedback">
                                ${password2Error}
                            </div>
                        </#if>
                    </div>
                </div>
            </#if>
            <div class="form-group row">
                <#nested>
            </div>
            <input type="hidden" name="_csrf" value="${_csrf.token}"/>
            <a class="btn btn-danger" href="/">Cancel</a>
            <a class="btn btn-outline-primary ml-3" href="${link}">${linkT}</a>
            <button class="btn btn-primary ml-3" type="submit">${bName}</button>
        </form>
    </div>
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
            integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
            crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"
            integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"
            crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"
            integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy"
            crossorigin="anonymous"></script>
    </body>
    </html>
</#macro>