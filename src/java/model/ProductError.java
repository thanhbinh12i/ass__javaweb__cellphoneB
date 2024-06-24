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
public class ProductError {
    private String productId, image, brand, productName;
    private String price;
    private String description;
    private String yearOfProduction, quantity, notSale, discount;

    public ProductError() {
        this.productId = "";
        this.image = "";
        this.brand = "";
        this.productName = "";
        this.price = "";
        this.description = "";
        this.yearOfProduction = "";
        this.quantity = "";
        this.notSale = "";
        this.discount = "";
    }

    
    
    public ProductError(String productId, String image, String brand, String productName, String price, String description, String yearOfProduction, String quantity, String notSale, String discount) {
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

    public String getProductId() {
        return productId;
    }

    public void setProductId(String productId) {
        this.productId = productId;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getYearOfProduction() {
        return yearOfProduction;
    }

    public void setYearOfProduction(String yearOfProduction) {
        this.yearOfProduction = yearOfProduction;
    }

    public String getQuantity() {
        return quantity;
    }

    public void setQuantity(String quantity) {
        this.quantity = quantity;
    }

    public String getNotSale() {
        return notSale;
    }

    public void setNotSale(String notSale) {
        this.notSale = notSale;
    }

    public String getDiscount() {
        return discount;
    }

    public void setDiscount(String discount) {
        this.discount = discount;
    }
    
}
