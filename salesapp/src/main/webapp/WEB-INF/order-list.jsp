<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.salesapp.model.Order, java.util.List" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pedidos – SalesApp</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<nav>
    <a class="brand" href="${pageContext.request.contextPath}/">⚡ SalesApp</a>
    <a href="${pageContext.request.contextPath}/salesman">Vendedores</a>
    <a href="${pageContext.request.contextPath}/customer">Clientes</a>
    <a href="${pageContext.request.contextPath}/order" class="active">Pedidos</a>
</nav>
<div class="container">
    <div class="page-title">
        <h1>📋 Pedidos</h1>
        <a class="btn btn-primary" href="${pageContext.request.contextPath}/order?action=new">+ Novo Pedido</a>
    </div>
    <div class="card">
<%
    List<Order> orders = (List<Order>) request.getAttribute("orders");
    if (orders == null || orders.isEmpty()) {
%>
        <div class="empty">
            <div class="icon">📋</div>
            <p>Nenhum pedido registrado ainda.</p>
        </div>
<%
    } else {
%>
        <table>
            <thead>
                <tr><th>Nº Pedido</th><th>Data</th><th>Valor (R$)</th><th>Cliente</th><th>Vendedor</th><th>Ações</th></tr>
            </thead>
            <tbody>
<%
        for (Order o : orders) {
%>
                <tr>
                    <td><span class="badge badge-blue"><%= o.getOrdNo() %></span></td>
                    <td><%= o.getOrdDate() %></td>
                    <td><span class="badge badge-green">R$ <%= o.getPurchAmt() %></span></td>
                    <td><%= o.getCustomerName() != null ? o.getCustomerName() : "" %></td>
                    <td><%= o.getSalesmanName() != null ? o.getSalesmanName() : "" %></td>
                    <td>
                        <a class="btn btn-ghost btn-sm" href="${pageContext.request.contextPath}/order?action=edit&id=<%= o.getOrdNo() %>">✏️ Editar</a>
                        <a class="btn btn-danger btn-sm" href="${pageContext.request.contextPath}/order?action=delete&id=<%= o.getOrdNo() %>"
                           onclick="return confirm('Excluir pedido #<%= o.getOrdNo() %>?')">🗑️ Excluir</a>
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
