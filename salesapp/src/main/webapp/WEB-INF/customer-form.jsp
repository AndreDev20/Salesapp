<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.salesapp.model.Customer, com.salesapp.model.Salesman, java.util.List" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cliente – SalesApp</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<nav>
    <a class="brand" href="${pageContext.request.contextPath}/">⚡ SalesApp</a>
    <a href="${pageContext.request.contextPath}/salesman">Vendedores</a>
    <a href="${pageContext.request.contextPath}/customer" class="active">Clientes</a>
    <a href="${pageContext.request.contextPath}/order">Pedidos</a>
</nav>
<%
    Customer c = (Customer) request.getAttribute("customer");
    List<Salesman> salesmen = (List<Salesman>) request.getAttribute("salesmen");
    boolean isNew = (c == null);
    String action  = isNew ? "insert" : "update";
    String title   = isNew ? "➕ Novo Cliente" : "✏️ Editar Cliente";
    String idVal   = isNew ? "" : String.valueOf(c.getCustomerId());
    String nameVal = isNew ? "" : c.getCustName();
    String cityVal = isNew ? "" : (c.getCity() != null ? c.getCity() : "");
    String gradeVal= isNew ? "" : String.valueOf(c.getGrade());
    int selSalesman= isNew ? -1 : c.getSalesmanId();
%>
<div class="container">
    <div class="page-title"><h1><%= title %></h1></div>
    <div class="card form-wrap" style="margin:0 auto; padding:1.75rem;">
        <form action="${pageContext.request.contextPath}/customer" method="post">
            <input type="hidden" name="action" value="<%= action %>">
            <div class="form-group">
                <label>ID do Cliente</label>
                <input type="number" name="customerId" required value="<%= idVal %>" <%= isNew ? "" : "readonly" %>>
            </div>
            <div class="form-group">
                <label>Nome do Cliente</label>
                <input type="text" name="custName" required maxlength="30" value="<%= nameVal %>" placeholder="Ex: Maria Oliveira">
            </div>
            <div class="form-group">
                <label>Cidade</label>
                <input type="text" name="city" maxlength="15" value="<%= cityVal %>" placeholder="Ex: Campinas">
            </div>
            <div class="form-group">
                <label>Grade (1–5)</label>
                <input type="number" name="grade" required min="1" max="5" value="<%= gradeVal %>">
            </div>
            <div class="form-group">
                <label>Vendedor Responsável</label>
                <select name="salesmanId" required>
                    <option value="">-- Selecione --</option>
<%
    if (salesmen != null) {
        for (Salesman s : salesmen) {
            String sel = (s.getSalesmanId() == selSalesman) ? "selected" : "";
%>
                    <option value="<%= s.getSalesmanId() %>" <%= sel %>><%= s.getSalesmanId() %> – <%= s.getName() %></option>
<%
        }
    }
%>
                </select>
            </div>
            <div class="form-actions">
                <button type="submit" class="btn btn-primary"><%= isNew ? "💾 Cadastrar" : "✅ Salvar" %></button>
                <a class="btn btn-ghost" href="${pageContext.request.contextPath}/customer">Cancelar</a>
            </div>
        </form>
    </div>
</div>
</body>
</html>
