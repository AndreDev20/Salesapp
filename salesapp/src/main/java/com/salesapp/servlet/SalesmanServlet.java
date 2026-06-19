package com.salesapp.servlet;

import com.salesapp.dao.SalesmanDAO;
import com.salesapp.model.Salesman;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/salesman")
public class SalesmanServlet extends HttpServlet {

    private final SalesmanDAO dao = new SalesmanDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        if (action == null) action = "list";

        try {
            switch (action) {
                case "new":
                    req.getRequestDispatcher("/WEB-INF/salesman-form.jsp").forward(req, resp);
                    break;

                case "edit":
                    int id = Integer.parseInt(req.getParameter("id"));
                    Salesman s = dao.findById(id);
                    req.setAttribute("salesman", s);
                    req.getRequestDispatcher("/WEB-INF/salesman-form.jsp").forward(req, resp);
                    break;

                case "delete":
                    dao.delete(Integer.parseInt(req.getParameter("id")));
                    resp.sendRedirect(req.getContextPath() + "/salesman");
                    break;

                default:
                    List<Salesman> list = dao.findAll();
                    req.setAttribute("salesmen", list);
                    req.getRequestDispatcher("/WEB-INF/salesman-list.jsp").forward(req, resp);
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

        Salesman s = new Salesman();
        s.setSalesmanId(Integer.parseInt(req.getParameter("salesmanId")));
        s.setName(req.getParameter("name"));
        s.setCity(req.getParameter("city"));
        s.setCommission(new BigDecimal(req.getParameter("commission")));

        try {
            if ("insert".equals(action)) {
                dao.insert(s);
            } else if ("update".equals(action)) {
                dao.update(s);
            }
            resp.sendRedirect(req.getContextPath() + "/salesman");
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
