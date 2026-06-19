package com.salesapp.servlet;

import com.salesapp.dao.CustomerDAO;
import com.salesapp.dao.OrderDAO;
import com.salesapp.dao.SalesmanDAO;
import com.salesapp.model.Order;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;

@WebServlet("/order")
public class OrderServlet extends HttpServlet {

    private final OrderDAO    orderDAO    = new OrderDAO();
    private final CustomerDAO customerDAO = new CustomerDAO();
    private final SalesmanDAO salesmanDAO = new SalesmanDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        if (action == null) action = "list";

        try {
            switch (action) {
                case "new":
                    req.setAttribute("customers", customerDAO.findAll());
                    req.setAttribute("salesmen",  salesmanDAO.findAll());
                    req.getRequestDispatcher("/WEB-INF/order-form.jsp").forward(req, resp);
                    break;

                case "edit":
                    int id = Integer.parseInt(req.getParameter("id"));
                    Order o = orderDAO.findById(id);
                    req.setAttribute("order",     o);
                    req.setAttribute("customers", customerDAO.findAll());
                    req.setAttribute("salesmen",  salesmanDAO.findAll());
                    req.getRequestDispatcher("/WEB-INF/order-form.jsp").forward(req, resp);
                    break;

                case "delete":
                    orderDAO.delete(Integer.parseInt(req.getParameter("id")));
                    resp.sendRedirect(req.getContextPath() + "/order");
                    break;

                default:
                    List<Order> list = orderDAO.findAll();
                    req.setAttribute("orders", list);
                    req.getRequestDispatcher("/WEB-INF/order-list.jsp").forward(req, resp);
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");

        Order o = new Order();
        o.setOrdNo(Integer.parseInt(req.getParameter("ordNo")));
        o.setPurchAmt(new BigDecimal(req.getParameter("purchAmt")));
        o.setOrdDate(LocalDate.parse(req.getParameter("ordDate")));
        o.setCustomerId(Integer.parseInt(req.getParameter("customerId")));
        o.setSalesmanId(Integer.parseInt(req.getParameter("salesmanId")));

        try {
            if ("insert".equals(action)) {
                orderDAO.insert(o);
            } else if ("update".equals(action)) {
                orderDAO.update(o);
            }
            resp.sendRedirect(req.getContextPath() + "/order");
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
