/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package fileUtil;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import model.Account;

/**
 *
 * @author thuhu
 */
public class GetAccountTestData {

    public static Map<String, String> TestDataGetAccountByUser(String filePath) {
        Map<String, String> testData = new HashMap<>();
        try (BufferedReader br = new BufferedReader(new FileReader(filePath))) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length == 2) {
                    testData.put(parts[0], parts[1]);
                }
            }
        } catch (IOException e) {
            System.out.println(e);
        }
        return testData;
    }
    
     public static Map<String, Account> TestDataInsertAccount(String filePath) {
        Map<String, Account> testData = new HashMap<>();
        try (BufferedReader br = new BufferedReader(new FileReader(filePath))) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length == 3) {
                    String testCaseId = parts[0];
                    String username = parts[1];
                    String password = parts[2];
                    Account account = new Account();
                    account.setUserName(username);
                    account.setPassword(password);
                    testData.put(testCaseId, account);
                }
            }
        } catch (IOException e) {
            System.out.println(e);
        }
        return testData;
    }
     
     public static Map<String, Account> TestDataChangePassword(String filePath) {
        Map<String, Account> testData = new HashMap<>();
        try (BufferedReader br = new BufferedReader(new FileReader(filePath))) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length == 3) {
                      String testCaseId = parts[0];
                    String username = parts[1];
                    String password = parts[2];
                    Account account = new Account();
                    account.setUserName(username);
                    account.setPassword(password);
                    testData.put(testCaseId, account);
                }
            }
        } catch (IOException e) {
            System.out.println(e);
        }
        return testData;
    }
     
     public static Map<String, String> TestDataDeleteAccountByUser(String filePath) {
        Map<String, String> testData = new HashMap<>();
        try (BufferedReader br = new BufferedReader(new FileReader(filePath))) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length == 2) {
                    testData.put(parts[0], parts[1]);
                }
            }
        } catch (IOException e) {
            System.out.println(e);
        }
        return testData;
    }
}
