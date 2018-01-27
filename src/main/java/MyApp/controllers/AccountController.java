package MyApp.controllers;

import MyApp.dao.EventDAO;
import MyApp.model.Account;
import MyApp.services.BankService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
public class AccountController {

    @Autowired
    private BankService bankService;

    @Autowired
    private EventDAO eventDAO;

    @RequestMapping(value = "/main/open_account", method = RequestMethod.POST)
    public String openAccount(Model model, @RequestParam String currency, @RequestParam String login) {

        if (!currency.equals("") && !login.equals("")) {
            int currencyInt = Integer.parseInt(currency);
            if (currencyInt == 980 || currencyInt == 840 || currencyInt == 978) {
                Account account = new Account(currencyInt);
                bankService.addAccount(account, login);
                model.addAttribute("message", "Account has been opened successfully.");
                model.addAttribute("status", 1);
                eventDAO.createEvent(login, "Account in currency " + currency + " has been opened successfully.");
            } else {
                model.addAttribute("message", "Account opening error. Wrong currency");
                model.addAttribute("status", 0);
            }
        } else {
            model.addAttribute("message", "Account opening error. Wrong login or currency");
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

    @RequestMapping(value = "/main/deposit_cash", method = RequestMethod.POST)
    public String addFundsOnAccount(Model model, @RequestParam String accountID, @RequestParam String amount,
                                    @RequestParam String login) {

        boolean amountIsDouble = bankService.isDouble(amount);
        if (amountIsDouble) {
            int id = Integer.parseInt(accountID);
            double amountDouble = Double.parseDouble(amount);
            int currency = 0;
            List<Account> accounts = bankService.findAccountsByLogin(login);
            for (Account account : accounts) {
                int checkID = account.getId();
                if (checkID == id) {
                    currency = account.getCurrency();
                }
            }
            bankService.addFundsOnAccount(id, amountDouble);
            model.addAttribute("message", "Funds have been added on account successfully.");
            model.addAttribute("status", 1);
            eventDAO.createEvent(login, "Funds in amount " + amountDouble + " in currency " + currency +
                    " have been added on account #" + id + " successfully.");
        } else {
            model.addAttribute("message", "Add funds failed. You've specified incorrect amount.");
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

    @RequestMapping(value = "/main/withdraw_cash", method = RequestMethod.POST)
    public String withdrawCash(Model model, @RequestParam String accountID, @RequestParam String amount,
                               @RequestParam String login) {

        boolean amountIsDouble = bankService.isDouble(amount);
        if (amountIsDouble) {
            int id = Integer.parseInt(accountID);
            double amountToWithdraw = Double.parseDouble(amount);
            double amountOnAccount = 0;
            int accountCurrency = 0;
            List<Account> accounts = bankService.findAccountsByLogin(login);
            for (Account account : accounts) {
                int checkID = account.getId();
                if (checkID == id) {
                    amountOnAccount = account.getAmount();
                    accountCurrency = account.getCurrency();
                }
            }

            if (amountOnAccount >= amountToWithdraw) {
                bankService.addFundsOnAccount(id, -amountToWithdraw);
                model.addAttribute("message", "Cash has been withdrawn from account successfully.");
                model.addAttribute("status", 1);
                eventDAO.createEvent(login, "Cash in amount " + amountToWithdraw + " in currency " + accountCurrency +
                        " have been withdrawn from account #" + id + " successfully.");
            } else {
                model.addAttribute("message", "Withdrawal cash failed. Lack of funds on account to withdraw.");
                model.addAttribute("status", 0);
            }
        } else {
            model.addAttribute("message", "Withdrawal cash failed. You've specified incorrect amount.");
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

    @RequestMapping(value = "/main/transfer_funds", method = RequestMethod.POST)
    public String transferFunds(Model model, @RequestParam String accountFrom, @RequestParam String accountTo,
                                @RequestParam String amount, @RequestParam String login) {

        boolean amountIsDouble = bankService.isDouble(amount);
        if (amountIsDouble) {
            int fromAccount = Integer.parseInt(accountFrom);
            int toAccount = Integer.parseInt(accountTo);
            double amountDouble = Double.parseDouble(amount);
            int currencyFrom = 0;
            int currencyTo = 0;
            boolean enoughFundsForTransfer = false;
            List<Account> accounts = bankService.findAccountsByLogin(login);
            for (Account account : accounts) {
                if (account.getId() == fromAccount && account.getAmount() >= amountDouble) {
                    enoughFundsForTransfer = true;
                    currencyFrom = account.getCurrency();
                }
                if (account.getId() == toAccount) {
                    currencyTo = account.getCurrency();
                }
            }
            if (enoughFundsForTransfer && currencyFrom == currencyTo && fromAccount != toAccount) {
                bankService.transferFunds(fromAccount, toAccount, amountDouble);
                eventDAO.createEvent(login, "Funds in amount " + amount + " in currency " + currencyFrom +
                        " has been transferred from account #" + fromAccount + " to account #" + toAccount + " successfully.");
                model.addAttribute("message", "Funds has been transferred successfully.");
                model.addAttribute("status", 1);
            } else if (fromAccount == toAccount) {
                model.addAttribute("message", "Funds transfer failed. You've specified the same account.");
                model.addAttribute("status", 0);
            } else {
                model.addAttribute("message", "Funds transfer failed. Incorrect currency " +
                        "or lack of funds on account to transfer.");
                model.addAttribute("status", 0);
            }
        } else {
            model.addAttribute("message", "Funds transfer failed. You've specified incorrect amount.");
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

    @RequestMapping(value = "/main/close_account", method = RequestMethod.POST)
    public String closeAccount(Model model, @RequestParam String accountID, @RequestParam String login) {

        int id = Integer.parseInt(accountID);
        Account account = bankService.findAccountByID(id);
        double amountOnAccount = account.getAmount();
        if (amountOnAccount == 0) {
            bankService.closeAccount(id, login);
            eventDAO.createEvent(login, "Account #" + id + " has been closed successfully.");
            model.addAttribute("message", "Account has been closed successfully.");
            model.addAttribute("status", 1);
        } else if (amountOnAccount > 0) {
            model.addAttribute("message", "Account closing failed. There are some funds on account. " +
                    "You can only close account with no funds on it.");
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