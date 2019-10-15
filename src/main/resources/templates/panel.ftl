<#import "common/default.ftl" as def>

<@def.page>
    <h4>User list</h4>
    <table class="table">
        <thead class="thead-dark">
        <tr>
            <th scope="col">
                Name
            </th>
            <th scope="col">
                Roles
            </th>
            <th scope="col"></th>
        </tr>
        </thead>
        <tbody>
        <#list users as us>
            <tr>
                <td>${us.username}</td>
                <td><#list us.roles as role>${role}<#sep>, </#list></td>
                <td>
                    <form action="/panel/user/${us.id}" method="get">
                        <button class="btn btn-primary" type="submit">Edit User</button>
                    </form>
                </td>
            </tr>
        </#list>
        </tbody>
    </table>
</@def.page>