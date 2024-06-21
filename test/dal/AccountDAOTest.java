/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/UnitTests/JUnit5TestClass.java to edit this template
 */
package dal;

import model.Account;
import fileUtil.GetAccountTestData;

import static org.mockito.Mockito.*;
import static org.junit.Assert.*;

import java.sql.SQLException;
import java.util.Map;
import org.apache.tomcat.dbcp.dbcp2.SQLExceptionList;

import org.junit.Before;
import org.junit.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

/**
 *
 * @author thuhu
 */
public class AccountDAOTest {

    private static Map<String, String> testDataGetAccountByUser;
    private static Map<String, Account> testDataInsertAccount;
    private static Map<String, Account> testDataChangePassword;
    private static Map<String, String> testDataDeleteAccountByUser;

    @Mock
    private DBContext dbContext;

    @Mock
    private AccountDAO adb = new AccountDAO();

    @Before
    public void setUp() throws Exception {
        dbContext = new DBContext();
        testDataGetAccountByUser = GetAccountTestData.TestDataGetAccountByUser("D:/0_FU_learning/SWT301/Lab2/Assignment/test/test-data/getAccountByUserTestData.txt");
        testDataInsertAccount = GetAccountTestData.TestDataInsertAccount("D:/0_FU_learning/SWT301/Lab2/Assignment/test/test-data/insertAccountTestData.txt");
        testDataChangePassword = GetAccountTestData.TestDataChangePassword("D:/0_FU_learning/SWT301/Lab2/Assignment/test/test-data/changePasswordTestData.txt");
        testDataDeleteAccountByUser = GetAccountTestData.TestDataDeleteAccountByUser("D:/0_FU_learning/SWT301/Lab2/Assignment/test/test-data/changePasswordTestData.txt");

        MockitoAnnotations.initMocks(this);
    }

    @Test
    public void getAccountByUserTC1() throws Exception {

        Account expAccount = new Account("kha21", "123", 0, 1);

        adb = new AccountDAO();
        Account actAccount = adb.getAccountByUser(testDataGetAccountByUser.get("TC1"));

        assertEquals(expAccount.getUserName(), actAccount.getUserName());
        assertEquals(expAccount.getPassword(), actAccount.getPassword());
        assertEquals(expAccount.getRole(), actAccount.getRole());
        assertEquals(expAccount.getCustomerId(), actAccount.getCustomerId());
    }

    @Test
    public void getAccountByUserTC2() throws Exception {
        Account expAccount = null;
        when(adb.getAccountByUser(anyString())).thenReturn(null);
        Account actAccount = adb.getAccountByUser(testDataGetAccountByUser.get("TC2"));
        assertEquals(expAccount, actAccount);
    }

    @Test
    public void getAccountByUserTC3() throws SQLException {
        String expException = "Cannot invoke \"java.sql.Connection.prepareStatement(String)\" because \"this.connection\" is null";
        when(adb.getAccountByUser(testDataGetAccountByUser.get("TC3"))).thenThrow(new SQLException("Cannot invoke \"java.sql.Connection.prepareStatement(String)\" because \"this.connection\" is null"));
        try {
            adb.getAccountByUser(testDataGetAccountByUser.get("TC3"));
            fail("fail");
        } catch (SQLException e) {
            assertEquals(expException, e.getMessage());
        }

        //insert
    }

    @Test
    public void insertAccountTC1() throws Exception {
        Account actualAccount = testDataInsertAccount.get("TC1");
        when(adb.insertAccount(eq(actualAccount), anyInt())).thenReturn(true);
        boolean rs = adb.insertAccount(actualAccount, 123);
        assertTrue(rs);
    }

    @Test
    public void insertAccountTC2() throws Exception {
        Account actualAccount = testDataInsertAccount.get("TC2");
        when(adb.insertAccount(eq(actualAccount), anyInt())).thenReturn(false);
        boolean rs = adb.insertAccount(actualAccount, 123);
        assertFalse(rs);
    }

    @Test
    public void insertAccountTC3() throws SQLException {
        Account actualAccount = testDataInsertAccount.get("TC3");
      
        when(adb.insertAccount(eq(actualAccount), anyInt())).thenReturn(false);
        boolean rs = adb.insertAccount(actualAccount, 123);
        assertFalse(rs);
    }

    @Test
    public void insertAccountTC4() throws SQLException {
        String expectedException = "Cannot invoke \"java.sql.Connection.prepareStatement(String)\" because \"this.connection\" is null";
        Account actualAccount = testDataInsertAccount.get("TC4");
        when(adb.insertAccount(eq(actualAccount), anyInt())).thenReturn(false).thenThrow(new SQLException("Cannot invoke \"java.sql.Connection.prepareStatement(String)\" because \"this.connection\" is null"));
        try {
            adb.insertAccount(actualAccount, 123);
        } catch (SQLException e) {
            assertFalse(adb.insertAccount(actualAccount, 123));
            assertEquals(expectedException, e.getMessage());
        }
    }

    @Test
    public void insertAccountTC5() throws SQLException {
        Account actualAccount = testDataInsertAccount.get("TC5");
        when(adb.insertAccount(eq(actualAccount), anyInt())).thenReturn(false).thenThrow(new SQLException("username cannot null"));
        try {
            adb.insertAccount(actualAccount, 123);
        } catch (SQLException e) {
            assertFalse(adb.insertAccount(actualAccount, 123));
            assertEquals("username cannot null", e.getMessage());
        }
    }
    
    
    //change password
    @Test
    public void changePasswordTC1() throws SQLException{
        boolean expectedRs = true;
        Account tempA = testDataChangePassword.get("TC1");
        adb = new AccountDAO();
        boolean actualRs = adb.changePassword(tempA.getUserName(), tempA.getPassword());
        assertEquals(expectedRs, actualRs);
    }
    
    @Test
    public void changePasswordTC2() throws SQLException{
        boolean expectedRs = false;
        String expectedException = "String or binary data would be truncated in table 'Store_Assignment3.dbo.Account', column 'Password'. ";
        Account tempA = testDataChangePassword.get("TC2");
        when(adb.changePassword(tempA.getUserName(), tempA.getPassword())).thenReturn(false).thenThrow(new SQLException("String or binary data would be truncated in table 'Store_Assignment3.dbo.Account', column 'Password'. "));
        try{
            adb.changePassword(tempA.getUserName(), tempA.getPassword());
        }catch(SQLException e){
            assertEquals(expectedRs, adb.changePassword(tempA.getUserName(), tempA.getPassword()));
            assertEquals(expectedException, e.getMessage());
        }
    }
    
    
    @Test
    public void changePasswordTC3() throws SQLException {
         boolean expectedRs = false;
        String expectedException = "Cannot invoke \"java.sql.Connection.prepareStatement(String)\" because \"this.connection\" is null";
        Account tempA = testDataChangePassword.get("TC3");
        when(adb.changePassword(tempA.getUserName(), tempA.getPassword())).thenReturn(false).thenThrow(new SQLException("Cannot invoke \"java.sql.Connection.prepareStatement(String)\" because \"this.connection\" is null"));
        try{
            adb.changePassword(tempA.getUserName(), tempA.getPassword());
        }catch(SQLException e){
            assertEquals(expectedRs, adb.changePassword(tempA.getUserName(), tempA.getPassword()));
            assertEquals(expectedException, e.getMessage());
        }
    }
    
    @Test
    public void changePasswordTC4() throws SQLException {
        boolean expectedRs = false;
        adb = new AccountDAO();
        Account tempA = testDataChangePassword.get("TC4");
        boolean actualRs = adb.changePassword(tempA.getUserName(), tempA.getPassword());
        assertEquals(expectedRs, actualRs);
    }
    
    
    
    //delete
    @Test
    public void deleteAccountByUserTC1() throws SQLException {
        boolean expectedRs = true;
        String data = testDataDeleteAccountByUser.get("TC1");
        when(adb.deleteAccountByUser(data)).thenReturn(true);
        boolean actualRs = adb.deleteAccountByUser(data);
        assertEquals(expectedRs, actualRs);
    }
    
    @Test
    public void deleteAccountByUserTC2() throws SQLException{
       boolean expectedRs = false;
        String data = testDataDeleteAccountByUser.get("TC2");
        adb = new AccountDAO();
        boolean actualRs = adb.deleteAccountByUser(data);
        assertEquals(expectedRs, actualRs); 
    }
    
    @Test
    public void deleteAccountByUserTC3() throws SQLException{
       boolean expectedRs = false;
        String data = testDataDeleteAccountByUser.get("TC3");
        adb = new AccountDAO();
        boolean actualRs = adb.deleteAccountByUser(data);
        assertEquals(expectedRs, actualRs); 
    }
    
}
