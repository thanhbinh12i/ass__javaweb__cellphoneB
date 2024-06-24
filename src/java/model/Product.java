/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

/**
 *
 * @author PC
 */
public class Product {

    private String productId, image, brand, productName;
    private double price;
    private String description;
    private int yearOfProduction, quantity, notSale, discount;

    public Product() {
    }

    public Product(String productId, String image, String brand, String productName, double price, String description, int yearOfProduction, int quantity, int notSale, int discount) {
        this.productId = productId;
        this.image = image;
        this.brand = brand;
        this.productName = productName;
        this.price = price;
        this.description = description;
        this.yearOfProduction = yearOfProduction;
        this.quantity = quantity;
        this.notSale = notSale;
        this.discount = discount;
    }

    

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getProductId() {
        return productId;
    }

    public void setProductId(String productId) {
        this.productId = productId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public double getPrice() {
        return this.price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getYearOfProduction() {
        return yearOfProduction;
    }

    public void setYearOfProduction(int yearOfProduction) {
        this.yearOfProduction = yearOfProduction;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public int getNotSale() {
        return notSale;
    }

    public void setNotSale(int notSale) {
        this.notSale = notSale;
    }

    public int getDiscount() {
        return discount;
    }

    public void setDiscount(int discount) {
        this.discount = discount;
    }

    public String formatNumber(double num) {
        return String.format("%,.0f", num).replace(",", ".");
    }
    public String getFormat() {
        return formatNumber(this.price);
    }

}
