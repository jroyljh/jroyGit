package com.kakaopay.getshorturl;

import java.util.Random;

public class MakeShortURL {
	
    public String GetURl(int seed) throws Exception {
        //System.out.println("IN!!!!!!!!!!!!!!!!!!!!!!!!!");
       
        Random random = new Random(seed);  // 매개변수 DB 시퀀스 값
        
        final long max_val = 218340105584897L; // 62글자의 8개 경우의수
        
        long ran_val= random.nextLong();
        //System.out.println(" =============== " +ran_val);
        
        if(ran_val<0)
           ran_val = ran_val*-1;  // 음수이면 양수로 
        
        ran_val = ran_val%max_val; 
      
        //System.out.println(" =============== " +ran_val);
       // for(int i=0; i<500; i++){
        String short_url = Encode(ran_val);
        
            //System.out.println(Encode(ran_val)+" =============== " + decodeToLog(Encode(ran_val))+ " =========== " + ran_val );
       // }
     
        return short_url;
        
      
   }
   
   public  String Encode(long value){
       final char[] BASE62 ="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789".toCharArray();
       
       final StringBuilder sb = new StringBuilder();
       
       do{
           long i = value%62;
           sb.append(BASE62[(int)i]);
           value /= 62;
           
       }while (value>0);
       
       return sb.toString();
       
       
   }
   
   public static long decodeToLog(String value){
      final char[] BASE62 ="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789".toCharArray();
      long result=0;
      long power=1;
      for(int i=0; i<value.length();i++){
          int digit = new String(BASE62).indexOf(value.charAt(i));
          result += digit * power;
          power *= 62;
      }
      return result;
   }
   

}
