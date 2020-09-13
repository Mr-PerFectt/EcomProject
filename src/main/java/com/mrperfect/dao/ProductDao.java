
package com.mrperfect.dao;

import com.mrperfect.entities.Product;
import java.util.List;
import org.hibernate.Session;

import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;


public class ProductDao {
    
      private SessionFactory factory;

    public ProductDao(SessionFactory factory) {
        this.factory = factory;
    }
    public boolean saveProduct(Product product){
          boolean f=false;
        try {
            
            
            Session openSession = this.factory.openSession();
            Transaction beginTransaction = openSession.beginTransaction();
            openSession.save(product);
            beginTransaction.commit();
            
            openSession.close();
     f=true;
            
        } catch (Exception e) {
            
            e.printStackTrace();
            f=false;
        }
        
        
        return f;
    
    
    }
    
    // fetch product
    
    public List<Product> getAllProduct(){
    
          Session openSession = this.factory.openSession();
         Query query= openSession.createQuery("from Product");
         
         List<Product> list=query.list();
          return list;
    }
    
    //fect product using category
    
     public List<Product> getAllProductById(int cid){
    
          Session openSession = this.factory.openSession();
         Query query= openSession.createQuery("from Product as p where p.category.categoryId=: id");
         query.setParameter("id", cid);
         List<Product> list=query.list();
          return list;
    }
}

