<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.salesapp.model.Salesman" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vendedor – SalesApp</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<nav>
    <a class="brand" href="${pageContext.request.contextPath}/">⚡ SalesApp</a>
    <a href="${pageContext.request.contextPath}/salesman" class="active">Vendedores</a>
    <a href="${pageContext.request.contextPath}/customer">Clientes</a>
    <a href="${pageContext.request.contextPath}/order">Pedidos</a>
</nav>
<%
    Salesman s = (Salesman) request.getAttribute("salesman");
    boolean isNew = (s == null);
    String action = isNew ? "insert" : "update";
    String title  = isNew ? "➕ Novo Vendedor" : "✏️ Editar Vendedor";
    String idVal  = isNew ? "" : String.valueOf(s.getSalesmanId());
    String nameVal= isNew ? "" : s.getName();
    String cityVal= isNew ? "" : (s.getCity() != null ? s.getCity() : "");
    String commVal= isNew ? "" : s.getCommission().toPlainString();
%>
<div class="container">
    <div class="page-title"><h1><%= title %></h1></div>
    <div class="card form-wrap" style="margin:0 auto; padding:1.75rem;">
        <form action="${pageContext.request.contextPath}/salesman" method="post">
            <input type="hidden" name="action" value="<%= action %>">
            <div class="form-group">
                <label>ID do Vendedor</label>
                <input type="number" name="salesmanId" required value="<%= idVal %>" <%= isNew ? "" : "readonly" %>>
            </div>
            <div class="form-group">
                <label>Nome Completo</label>
                <input type="text" name="name" required maxlength="30" value="<%= nameVal %>" placeholder="Ex: João Silva">
            </div>
            <div class="form-group">
                <label>Cidade</label>
                <input type="text" name="city" maxlength="15" value="<%= cityVal %>" placeholder="Ex: São Paulo">
            </div>
            <div class="form-group">
                <label>Comissão (ex: 0.15 = 15%)</label>
                <input type="number" name="commission" required step="0.01" min="0" max="1" value="<%= commVal %>" placeholder="0.00">
            </div>
            <div class="form-actions">
                <button type="submit" class="btn btn-primary"><%= isNew ? "💾 Cadastrar" : "✅ Salvar" %></button>
                <a class="btn btn-ghost" href="${pageContext.request.contextPath}/salesman">Cancelar</a>
            </div>
        </form>
    </div>
</div>
</body>
</html>
