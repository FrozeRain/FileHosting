<#import "common/default.ftl" as def>

<@def.page>
    <h4>User editor</h4>
    <form action="/panel" method="post">
        <div class="form-row">
            <div class="form-group">
                <label for="inputName">User Name:</label>
                <input class="form-control" id="inputName" type="text" name="username" value="${user.username}">
                <input type="hidden" name="user" value="${user.id}">
            </div>
        </div>
        <div class="form-row">
            <ul class="list-group">
                <#list roles as role>
                    <li class="list-group-item list-group-item-primary">
                        ${role}: <input class="form-control" type="checkbox"
                                                 name="${role}" ${user.roles?seq_contains(role)?string("checked", "")}>
                    </li>
                </#list>
            </ul>
            <input type="hidden" value="${_csrf.token}" name="_csrf">
        </div>
        <div class="form-row mt-3">
            <button class="btn btn-primary" type="submit">Save User</button>
        </div>
    </form>
</@def.page>