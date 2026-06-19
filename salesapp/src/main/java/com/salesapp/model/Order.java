package com.salesapp.model;

import java.math.BigDecimal;
import java.time.LocalDate;

public class Order {
    private int ordNo;
    private BigDecimal purchAmt;
    private LocalDate ordDate;
    private int customerId;
    private int salesmanId;

    // Para exibição (join)
    private String customerName;
    private String salesmanName;

    public Order() {}

    public Order(int ordNo, BigDecimal purchAmt, LocalDate ordDate, int customerId, int salesmanId) {
        this.ordNo      = ordNo;
        this.purchAmt   = purchAmt;
        this.ordDate    = ordDate;
        this.customerId = customerId;
        this.salesmanId = salesmanId;
    }

    public int getOrdNo()                        { return ordNo; }
    public void setOrdNo(int ordNo)              { this.ordNo = ordNo; }
    public BigDecimal getPurchAmt()              { return purchAmt; }
    public void setPurchAmt(BigDecimal purchAmt) { this.purchAmt = purchAmt; }
    public LocalDate getOrdDate()                { return ordDate; }
    public void setOrdDate(LocalDate ordDate)    { this.ordDate = ordDate; }
    public int getCustomerId()                   { return customerId; }
    public void setCustomerId(int customerId)    { this.customerId = customerId; }
    public int getSalesmanId()                   { return salesmanId; }
    public void setSalesmanId(int salesmanId)    { this.salesmanId = salesmanId; }
    public String getCustomerName()              { return customerName; }
    public void setCustomerName(String n)        { this.customerName = n; }
    public String getSalesmanName()              { return salesmanName; }
    public void setSalesmanName(String n)        { this.salesmanName = n; }
}
