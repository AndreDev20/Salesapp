<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.salesapp.model.Customer, java.util.List" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Clientes – SalesApp</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<nav>
    <a class="brand" href="${pageContext.request.contextPath}/">⚡ SalesApp</a>
    <a href="${pageContext.request.contextPath}/salesman">Vendedores</a>
    <a href="${pageContext.request.contextPath}/customer" class="active">Clientes</a>
    <a href="${pageContext.request.contextPath}/order">Pedidos</a>
</nav>
<div class="container">
    <div class="page-title">
        <h1>👥 Clientes</h1>
        <a class="btn btn-primary" href="${pageContext.request.contextPath}/customer?action=new">+ Novo Cliente</a>
    </div>
    <div class="card">
<%
    List<Customer> customers = (List<Customer>) request.getAttribute("customers");
    if (customers == null || customers.isEmpty()) {
%>
        <div class="empty">
            <div class="icon">👥</div>
            <p>Nenhum cliente cadastrado ainda.</p>
        </div>
<%
    } else {
%>
        <table>
            <thead>
                <tr><th>ID</th><th>Nome</th><th>Cidade</th><th>Grade</th><th>Vendedor</th><th>Ações</th></tr>
            </thead>
            <tbody>
<%
        for (Customer c : customers) {
%>
                <tr>
                    <td><span class="badge badge-blue"><%= c.getCustomerId() %></span></td>
                    <td><strong><%= c.getCustName() %></strong></td>
                    <td><%= c.getCity() != null ? c.getCity() : "" %></td>
                    <td><span class="badge badge-purple"><%= c.getGrade() %></span></td>
                    <td><%= c.getSalesmanName() != null ? c.getSalesmanName() : "" %></td>
                    <td>
                        <a class="btn btn-ghost btn-sm" href="${pageContext.request.contextPath}/customer?action=edit&id=<%= c.getCustomerId() %>">✏️ Editar</a>
                        <a class="btn btn-danger btn-sm" href="${pageContext.request.contextPath}/customer?action=delete&id=<%= c.getCustomerId() %>"
                           onclick="return confirm('Excluir cliente <%= c.getCustName() %>?')">🗑️ Excluir</a>
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
