<#import "common/default.ftl" as def>
<#assign
user = Session.SPRING_SECURITY_CONTEXT.authentication.principal
>
<@def.page>

    <div class="row" xmlns="http://www.w3.org/1999/html">
        <div class="col-6">
            <form method="post" action="/home" enctype="multipart/form-data">
                <div class="form-group">
                    <div class="form-row">
                        <label for="nameOfFile">Name of File</label>
                        <input class="form-control" id="nameOfFile" type="text" name="filename"
                               placeholder="Enter custom name of file"/>
                        <div class="custom-file mt-3">
                            <label class="custom-file-label" for="currentFile">Choose a file</label>
                            <input class="custom-file-input" id="currentFile" type="file" name="file"/>
                            <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                        </div>
                    </div>
                    <div class="form-row mt-3">
                        <button class="btn btn-primary" type="submit">Upload</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
    <br>
    <div class="row">
        <form method="get" action="/home">
            <div class="form-group">
                <div class="form-row">
                    <div class="mt-1">
                        <input class="form-control" type="text" name="filter" value="<#if filter??>${filter}</#if>"
                               placeholder="Search"/>
                    </div>
                    <button class="btn btn-primary ml-3" type="submit">Search</button>
                </div>
            </div>
        </form>
    </div>
    <#if warn??>
        <div class="alert alert-danger">
            ${warn}
        </div>
    </#if>
    <ul class="list-group">
        <#list files as f>
            <li class="list-group-item list-group-item-primary">
                <div class="row">
                    <div class="col-3 mt-1">
                        Name: ${f.fileName}
                    </div>
                    <div class="col-3 mt-1">
                        Owner: ${f.authorName}
                    </div>
                    <div class="col-3 mt-1">
                        Size: ${f.fileSize}B
                    </div>
                    <div class="col-2">
                        <form method="get" action="/download">
                        <button class="btn btn-outline-primary" type="submit" name="file" value="${f.id}">
                            DOWNLOAD
                        </button>
                        </form>
                    </div>
                    <div class="col-1">
                        <#if user??>
                            <#if user.id == f.user.id>
                                <a class="btn btn-outline-danger" href="/delete/file/${f.id}">X</a>
                            </#if>
                        </#if>
                    </div>
                </div>
            </li>
        </#list>
    </ul>
</@def.page>