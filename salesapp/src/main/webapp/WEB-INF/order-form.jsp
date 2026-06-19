<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.salesapp.model.Order, com.salesapp.model.Customer, com.salesapp.model.Salesman, java.util.List" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pedido – SalesApp</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<nav>
    <a class="brand" href="${pageContext.request.contextPath}/">⚡ SalesApp</a>
    <a href="${pageContext.request.contextPath}/salesman">Vendedores</a>
    <a href="${pageContext.request.contextPath}/customer">Clientes</a>
    <a href="${pageContext.request.contextPath}/order" class="active">Pedidos</a>
</nav>
<%
    Order o = (Order) request.getAttribute("order");
    List<Customer> customers = (List<Customer>) request.getAttribute("customers");
    List<Salesman> salesmen  = (List<Salesman>)  request.getAttribute("salesmen");
    boolean isNew   = (o == null);
    String action   = isNew ? "insert" : "update";
    String title    = isNew ? "➕ Novo Pedido" : "✏️ Editar Pedido";
    String ordNoVal = isNew ? "" : String.valueOf(o.getOrdNo());
    String dateVal  = isNew ? "" : o.getOrdDate().toString();
    String amtVal   = isNew ? "" : o.getPurchAmt().toPlainString();
    int selCust     = isNew ? -1 : o.getCustomerId();
    int selSales    = isNew ? -1 : o.getSalesmanId();
%>
<div class="container">
    <div class="page-title"><h1><%= title %></h1></div>
    <div class="card form-wrap" style="margin:0 auto; padding:1.75rem;">
        <form action="${pageContext.request.contextPath}/order" method="post">
            <input type="hidden" name="action" value="<%= action %>">
            <div class="form-group">
                <label>Nº do Pedido</label>
                <input type="number" name="ordNo" required value="<%= ordNoVal %>" <%= isNew ? "" : "readonly" %>>
            </div>
            <div class="form-group">
                <label>Data do Pedido</label>
                <input type="date" name="ordDate" required value="<%= dateVal %>">
            </div>
            <div class="form-group">
                <label>Valor da Compra (R$)</label>
                <input type="number" name="purchAmt" required step="0.01" min="0" value="<%= amtVal %>" placeholder="0.00">
            </div>
            <div class="form-group">
                <label>Cliente</label>
                <select name="customerId" required>
                    <option value="">-- Selecione o Cliente --</option>
<%
    if (customers != null) {
        for (Customer c : customers) {
            String sel = (c.getCustomerId() == selCust) ? "selected" : "";
%>
                    <option value="<%= c.getCustomerId() %>" <%= sel %>><%= c.getCustomerId() %> – <%= c.getCustName() %></option>
<%
        }
    }
%>
                </select>
            </div>
            <div class="form-group">
                <label>Vendedor</label>
                <select name="salesmanId" required>
                    <option value="">-- Selecione o Vendedor --</option>
<%
    if (salesmen != null) {
        for (Salesman s : salesmen) {
            String sel = (s.getSalesmanId() == selSales) ? "selected" : "";
%>
                    <option value="<%= s.getSalesmanId() %>" <%= sel %>><%= s.getSalesmanId() %> – <%= s.getName() %></option>
<%
        }
    }
%>
                </select>
            </div>
            <div class="form-actions">
                <button type="submit" class="btn btn-primary"><%= isNew ? "💾 Registrar Pedido" : "✅ Salvar" %></button>
                <a class="btn btn-ghost" href="${pageContext.request.contextPath}/order">Cancelar</a>
            </div>
        </form>
    </div>
</div>
</body>
</html>
