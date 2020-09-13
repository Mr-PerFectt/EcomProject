/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mrperfect.dao;

import com.mrperfect.entities.Category;
import com.mrperfect.entities.Product;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

/**
 *
 * @author JEET
 */
public class CategoryDao {
    private SessionFactory factory;

    public CategoryDao(SessionFactory factory) {
        this.factory = factory;
    }
    
    
    public int saveCategory(Category cat){
        
      Session session=  this.factory.openSession();
       Transaction tx = session.beginTransaction();
       int catId=(int) session.save(cat);
       tx.commit();
       session.close();
        
        
        
        return catId;
    
    
    }
    
    public List<Category>getCategories(){
        Session openSession = this.factory.openSession();
    
    Query query=openSession.createQuery("from Category");
        List<Category> list = query.list();
        return list;

    }
    
    
    public Category getCategoreisById(int cid){
    Category cat=null;
        try {
            Session openSession = this.factory.openSession();
            
        
            cat =  openSession.get(Category.class, cid);
        } catch (Exception e) {
            
            e.printStackTrace();
        }
        return cat;
    }
    
    public List<Product> getAllProduct(){
    
    
    Session s=this.factory.openSession();
    
   Query query= s.createQuery("from Product");
    
    List<Product> list=query.list();
        return list;
    
    }
    
    // fetch all product list
}






