package test;

import static org.junit.Assert.*;

import java.util.Random;

import org.junit.Test;

import com.kakaopay.getshorturl.MakeShortURL;

public class MakeShortURLTest {
	MakeShortURL msu = new MakeShortURL();
	@Test
	public void testGetURl() throws Exception {
		
		assertEquals( "HczBmHkx", msu.GetURl(622));

	}

	@Test
	public void testEncode() throws Exception {
		
       Random random = new Random(622);  // 매개변수 DB 시퀀스 값
        final long max_val = 218340105584897L; // 62글자의 8개 경우의수
        long ran_val= random.nextLong();
        if(ran_val<0)
           ran_val = ran_val*-1;  // 음수이면 양수로 
        ran_val = ran_val%max_val; 
        
        assertEquals( msu.GetURl(622) ,msu.Encode(ran_val));
       
        
		
	}

}
