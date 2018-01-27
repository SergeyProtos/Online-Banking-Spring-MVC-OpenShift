package MyApp.config;

import MyApp.model.Customer;
import MyApp.services.BankService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;

@Component
public class CreateDefaultCustomer {

    @Autowired
    private BankService bankService;

    @PostConstruct
    public void createDefaultUser() {
        Customer defaultCustomer = new Customer("user", "user", "user",
                "user", "user@gmail.com", "+038-000-111-22-33");
        bankService.addCustomer(defaultCustomer);
    }
}
