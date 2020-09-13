/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mrperfect.helper;

import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;



public class FactoryProvider {
    private static SessionFactory factory;
    public static SessionFactory getFactory(){
        try {
            if(factory==null){
           factory= new Configuration().configure().buildSessionFactory();}
        } catch (Exception e) {
            e.printStackTrace();
        }
        return factory;
    }
}
