<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.salesapp.model.Salesman, java.util.List" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vendedores – SalesApp</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<nav>
    <a class="brand" href="${pageContext.request.contextPath}/">⚡ SalesApp</a>
    <a href="${pageContext.request.contextPath}/salesman" class="active">Vendedores</a>
    <a href="${pageContext.request.contextPath}/customer">Clientes</a>
    <a href="${pageContext.request.contextPath}/order">Pedidos</a>
</nav>
<div class="container">
    <div class="page-title">
        <h1>🧑‍💼 Vendedores</h1>
        <a class="btn btn-primary" href="${pageContext.request.contextPath}/salesman?action=new">+ Novo Vendedor</a>
    </div>
    <div class="card">
<%
    List<Salesman> salesmen = (List<Salesman>) request.getAttribute("salesmen");
    if (salesmen == null || salesmen.isEmpty()) {
%>
        <div class="empty">
            <div class="icon">🧑‍💼</div>
            <p>Nenhum vendedor cadastrado ainda.<br>Clique em <strong>+ Novo Vendedor</strong> para começar.</p>
        </div>
<%
    } else {
%>
        <table>
            <thead>
                <tr><th>ID</th><th>Nome</th><th>Cidade</th><th>Comissão</th><th>Ações</th></tr>
            </thead>
            <tbody>
<%
        for (Salesman s : salesmen) {
%>
                <tr>
                    <td><span class="badge badge-blue"><%= s.getSalesmanId() %></span></td>
                    <td><strong><%= s.getName() %></strong></td>
                    <td><%= s.getCity() %></td>
                    <td><span class="badge badge-green"><%= s.getCommission() %></span></td>
                    <td>
                        <a class="btn btn-ghost btn-sm" href="${pageContext.request.contextPath}/salesman?action=edit&id=<%= s.getSalesmanId() %>">✏️ Editar</a>
                        <a class="btn btn-danger btn-sm" href="${pageContext.request.contextPath}/salesman?action=delete&id=<%= s.getSalesmanId() %>"
                           onclick="return confirm('Excluir vendedor <%= s.getName() %>?')">🗑️ Excluir</a>
                    </td>
                </tr>
<%
        }
%>
            </tbody>
        </table>
<%
    }
%>
    </div>
</div>
</body>
</html>
