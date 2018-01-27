package MyApp.controllers;

import MyApp.dao.EventDAO;
import MyApp.model.Account;
import MyApp.model.Credit;
import MyApp.services.BankService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

@Controller
public class CreditController {

    @Autowired
    private BankService bankService;

    @Autowired
    private EventDAO eventDAO;

    @RequestMapping(value = "/main/get_credit", method = RequestMethod.POST)
    public String getCredit(Model model, @RequestParam String login, @RequestParam String accountID,
                            @RequestParam String currency, @RequestParam String amount, @RequestParam String term) {

        boolean amountIsDouble = bankService.isDouble(amount);
        if (amountIsDouble) {
            int id = Integer.parseInt(accountID);
            int creditCurrency = Integer.parseInt(currency);
            double amountDouble = Double.parseDouble(amount);
            int termInt = Integer.parseInt(term);

            int accountCurrency = 0;
            List<Account> accounts = bankService.findAccountsByLogin(login);
            for (Account account : accounts) {
                if (id == account.getId()) {
                    accountCurrency = account.getCurrency();
                }
            }

            double interestRate = bankService.findInterestRateOnCredit(creditCurrency, termInt);

            Date date0 = new Date();
            SimpleDateFormat sdf = new SimpleDateFormat("dd.MM.yyyy");
            String dateOpen = sdf.format(date0);

            Calendar calendar = Calendar.getInstance();
            calendar.setTime(date0);
            calendar.add(Calendar.DAY_OF_YEAR, termInt);
            Date date1 = calendar.getTime();
            String dateClose = sdf.format(date1);

            if (accountCurrency == creditCurrency) {
                Credit credit = new Credit(creditCurrency, amountDouble, termInt, interestRate, dateOpen, dateClose);
                bankService.getCredit(credit, login);
                bankService.addFundsOnAccount(id, amountDouble);
                eventDAO.createEvent(login, "Loan in amount " + amount + " in currency " + currency +
                        " has been received successfully.");
                model.addAttribute("message", "Loan has been received successfully.");
                model.addAttribute("status", 1);
            } else {
                model.addAttribute("message", "Loan receiving error. Incorrect currency of account.");
                model.addAttribute("status", 0);
            }
        } else {
            model.addAttribute("message", "Loan receiving error. You've specified incorrect amount");
            model.addAttribute("status", 0);
        }

        model.addAttribute("login", login);
        model.addAttribute("accounts", bankService.findAccountsByLogin(login));
        model.addAttribute("isAccounts", bankService.isAccounts(login));
        model.addAttribute("deposits", bankService.findDepositsByLogin(login));
        model.addAttribute("isDeposits", bankService.isDeposits(login));
        model.addAttribute("credits", bankService.findCreditsByLogin(login));
        model.addAttribute("isCredits", bankService.isCredits(login));
        model.addAttribute("events", eventDAO.findEventsByLogin(login));
        return "main";
    }

    @RequestMapping(value = "/main/close_credit", method = RequestMethod.POST)
    public String openDeposit(Model model, @RequestParam String login, @RequestParam String creditId,
                              @RequestParam String accountId) {

            int creditID = Integer.parseInt(creditId);
            int accountID = Integer.parseInt(accountId);
            double creditAmount = 0;
            int creditCurrency = 0;
            double accountAmount = 0;
            int accountCurrency = 0;

            List<Credit> credits = bankService.findCreditsByLogin(login);
            for (Credit credit : credits) {
                if (creditID == credit.getId()) {
                    creditAmount = credit.getAmount();
                    creditCurrency = credit.getCurrency();
                }
            }

            List<Account> accounts = bankService.findAccountsByLogin(login);
            for (Account account : accounts) {
                if (accountID == account.getId()) {
                    accountAmount = account.getAmount();
                    accountCurrency = account.getCurrency();
                }
            }

            double interest = bankService.creditInterestCalculation(creditID, login);

            if (creditCurrency == accountCurrency && accountAmount < creditAmount) {
                bankService.addFundsOnAccount(accountID, -accountAmount);
                bankService.repayCredit(login, creditID, accountID, accountAmount);
                eventDAO.createEvent(login, "Loan has been successfully repaid from account #" + accountId +
                        " in amount " + accountAmount + " in currency " +
                        accountCurrency);
                model.addAttribute("message", "Loan has been repaid successfully.");
                model.addAttribute("status", 1);
            } else if (creditCurrency == accountCurrency && accountAmount >= (creditAmount + interest)){
                bankService.addFundsOnAccount(accountID, -creditAmount);
                bankService.addFundsOnAccount(accountID, -interest);
                bankService.closeCredit(creditID, login);
                eventDAO.createEvent(login, "Loan in amount " + creditAmount + " in currency " +
                        creditCurrency + " has been closed successfully. Interest on the loan = " + interest +
                        ". Loan and interest amount has been repaid from account #" + accountId);
                model.addAttribute("message", "Loan has been closed successfully.");
                model.addAttribute("status", 1);
            }
            else {
                model.addAttribute("message", "Loan repay error. Incorrect account currency or lack of funds on account.");
                model.addAttribute("status", 0);
            }

        model.addAttribute("login", login);
        model.addAttribute("accounts", bankService.findAccountsByLogin(login));
        model.addAttribute("isAccounts", bankService.isAccounts(login));
        model.addAttribute("deposits", bankService.findDepositsByLogin(login));
        model.addAttribute("isDeposits", bankService.isDeposits(login));
        model.addAttribute("credits", bankService.findCreditsByLogin(login));
        model.addAttribute("isCredits", bankService.isCredits(login));
        model.addAttribute("events", eventDAO.findEventsByLogin(login));
        return "main";
    }
}
