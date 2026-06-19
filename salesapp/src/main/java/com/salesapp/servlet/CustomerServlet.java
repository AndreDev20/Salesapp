package com.salesapp.servlet;

import com.salesapp.dao.CustomerDAO;
import com.salesapp.dao.SalesmanDAO;
import com.salesapp.model.Customer;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/customer")
public class CustomerServlet extends HttpServlet {

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
                    req.setAttribute("salesmen", salesmanDAO.findAll());
                    req.getRequestDispatcher("/WEB-INF/customer-form.jsp").forward(req, resp);
                    break;

                case "edit":
                    int id = Integer.parseInt(req.getParameter("id"));
                    Customer c = customerDAO.findById(id);
                    req.setAttribute("customer", c);
                    req.setAttribute("salesmen", salesmanDAO.findAll());
                    req.getRequestDispatcher("/WEB-INF/customer-form.jsp").forward(req, resp);
                    break;

                case "delete":
                    customerDAO.delete(Integer.parseInt(req.getParameter("id")));
                    resp.sendRedirect(req.getContextPath() + "/customer");
                    break;

                default:
                    List<Customer> list = customerDAO.findAll();
                    req.setAttribute("customers", list);
                    req.getRequestDispatcher("/WEB-INF/customer-list.jsp").forward(req, resp);
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

        Customer c = new Customer();
        c.setCustomerId(Integer.parseInt(req.getParameter("customerId")));
        c.setCustName(req.getParameter("custName"));
        c.setCity(req.getParameter("city"));
        c.setGrade(Integer.parseInt(req.getParameter("grade")));
        c.setSalesmanId(Integer.parseInt(req.getParameter("salesmanId")));

        try {
            if ("insert".equals(action)) {
                customerDAO.insert(c);
            } else if ("update".equals(action)) {
                customerDAO.update(c);
            }
            resp.sendRedirect(req.getContextPath() + "/customer");
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
