package test;

import static org.junit.Assert.*;

import java.io.UnsupportedEncodingException;

import org.junit.Test;

import com.kakaopay.db.DaoShortURL;

public class DaoShortURLTest {

	DaoShortURL daoSU = new DaoShortURL();
	
	@Test
	public void testCreateConnection() {
		
		assertNotEquals(daoSU, new DaoShortURL());
	}

	@Test
	public void testInsertUrlMapping() throws UnsupportedEncodingException {
		daoSU.createConnection();
		int temp = daoSU.selectSequence();
		assertNotEquals(temp, daoSU.selectSequence());
	}

	@Test
	public void testSelectSequence() {
		daoSU.createConnection();
		int temp = daoSU.selectSequence();
		assertNotEquals(temp, daoSU.selectSequence());
	}

	@Test
	public void testSelectUrlCheck() {
		
	}

	@Test
	public void testSelectShortUrlCheck() {

	}

	@Test
	public void testSelectUrlMapping() {

	}

	@Test
	public void testShutdown() {
	
	}

}
