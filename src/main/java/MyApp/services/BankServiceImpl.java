package MyApp.services;

import MyApp.dao.*;
import MyApp.model.Account;
import MyApp.model.Credit;
import MyApp.model.Customer;
import MyApp.model.Deposit;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class BankServiceImpl implements BankService {

    @Autowired
    private CustomerDAO customerDAO;

    @Autowired
    private AccountDAO accountDAO;

    @Autowired
    private DepositDAO depositDAO;

    @Autowired
    private CreditDAO creditDAO;

    @Autowired
    private InterestRatesDAO interestRatesDAO;

    @Transactional
    public void addCustomer(Customer customer) {
        customerDAO.addCustomer(customer);
    }

    @Transactional
    public boolean loginExists(String login) {
        return customerDAO.loginExists(login);
    }

    @Transactional
    public boolean isLogin(String login, String password) {
        return customerDAO.isLogin(login, password);
    }

    @Transactional
    public void addAccount(Account account, String login) {
        accountDAO.addAccount(account, login);
    }

    @Transactional
    public void closeAccount(int accountID, String login) {
        accountDAO.closeAccount(accountID, login);
    }

    @Transactional
    public List<Account> findAccountsByLogin(String login) {
        return accountDAO.findAccountsByLogin(login);
    }

    @Transactional
    public Account findAccountByID(int accountID) {
        return accountDAO.findAccountByID(accountID);
    }

    @Transactional
    public void addFundsOnAccount(int accountID, double amount) {
        accountDAO.addFundsOnAccount(accountID, amount);
    }

    @Transactional
    public void transferFunds(int accountFrom, int accountTo, double amount) {
        accountDAO.transferFunds(accountFrom, accountTo, amount);
    }

    @Transactional
    public boolean isAccounts(String login) {
        List<Account> accounts = accountDAO.findAccountsByLogin(login);
        int counter = 0;
        for (Account account : accounts) {
            if (account.getId() >= 1) {
                counter++;
            }
        }
        if (counter >= 1) return true;
        else return false;
    }

    @Transactional
    public void openDeposit(Deposit deposit, String login) {
        depositDAO.openDeposit(deposit, login);
    }

    @Transactional
    public void closeDeposit(int id, String login) {
        depositDAO.closeDeposit(id, login);
    }

    @Transactional
    public double depositInterestCalculation(int id, String login) {
        return depositDAO.depositInterestCalculation(id, login);
    }

    @Transactional
    public List<Deposit> findDepositsByLogin(String login) {
        return depositDAO.findDepositsByLogin(login);
    }

    @Transactional
    public boolean isDeposits(String login) {
        List<Deposit> deposits = depositDAO.findDepositsByLogin(login);
        int counter = 0;
        for (Deposit deposit : deposits) {
            if (deposit.getId() >= 1) {
                counter++;
            }
        }
        if (counter >= 1) return true;
        else return false;
    }

    @Transactional
    public void getCredit(Credit credit, String login) {
        creditDAO.getCredit(credit, login);
    }

    @Transactional
    public void closeCredit(int id, String login) {
        creditDAO.closeCredit(id, login);
    }

    @Transactional
    public void repayCredit(String login, int creditID, int accountID, double amount) {
        creditDAO.repayCredit(login, creditID, accountID, amount);
    }

    @Transactional
    public double creditInterestCalculation(int id, String login) {
        return creditDAO.creditInterestCalculation(id, login);
    }

    @Transactional
    public List<Credit> findCreditsByLogin(String login) {
        return creditDAO.findCreditsByLogin(login);
    }

    @Transactional
    public boolean isCredits(String login) {
        List<Credit> credits = creditDAO.findCreditsByLogin(login);
        int counter = 0;
        for (Credit credit : credits) {
            if (credit.getId() >= 0) {
                counter++;
            }
        }
        if (counter >= 1) return true;
        else return false;
    }

    @Transactional
    public void setInterestRatesOnDeposits() {
        interestRatesDAO.setInterestRatesOnDeposits();
    }

    @Transactional
    public void setInterestRatesOnCredits() {
        interestRatesDAO.setInterestRatesOnCredits();
    }

    @Transactional
    public double findInterestRateOnDeposit(double currency, int term) {
        return interestRatesDAO.findInterestRateOnDeposit(currency, term);
    }

    @Transactional
    public double findInterestRateOnCredit(double currency, int term) {
        return interestRatesDAO.findInterestRateOnCredit(currency, term);
    }

    @Transactional
    public boolean isDouble(String string) {
        try {
            double toCheck = Double.parseDouble(string);
        } catch (NumberFormatException nfe) {
            return false;
        }
        return true;
    }
}