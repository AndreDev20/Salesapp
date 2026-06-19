<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sales Manager</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

<nav>
    <a class="brand" href="${pageContext.request.contextPath}/">⚡ SalesApp</a>
    <a href="${pageContext.request.contextPath}/salesman">Vendedores</a>
    <a href="${pageContext.request.contextPath}/customer">Clientes</a>
    <a href="${pageContext.request.contextPath}/order">Pedidos</a>
</nav>

<div class="container">
    <div class="hero">
        <h1>Gestão de <span>Vendas</span></h1>
        <p>Cadastre vendedores, clientes e ordens de compra em um só lugar.</p>

        <div class="cards-grid">
            <a class="nav-card" href="${pageContext.request.contextPath}/salesman">
                <div class="icon">🧑‍💼</div>
                <h3>Vendedores</h3>
                <p>Cadastre e gerencie sua equipe de vendas com comissões.</p>
            </a>
            <a class="nav-card" href="${pageContext.request.contextPath}/customer">
                <div class="icon">👥</div>
                <h3>Clientes</h3>
                <p>Mantenha o cadastro completo dos seus clientes.</p>
            </a>
            <a class="nav-card" href="${pageContext.request.contextPath}/order">
                <div class="icon">📋</div>
                <h3>Pedidos</h3>
                <p>Registre ordens de compra vinculadas a clientes e vendedores.</p>
            </a>
        </div>
    </div>
</div>

</body>
</html>
