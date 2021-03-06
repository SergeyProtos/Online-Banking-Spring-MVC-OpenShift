<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<body>
<head>
    <title>TopBank Online Banking</title>
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.3/jquery.min.js" type="text/javascript"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
    <style>
        <%@include file="main.css"%>
    </style>
</head>
<div class="container-fluid">
    <div class="row">
        <div class="col-md-2" align="center">
            <img height="100px" width="100px"
                 src="<c:url value="https://cdn4.iconfinder.com/data/icons/personal-business-finance-gray-series/64/gray-26-512.png"/>"
                 alt="Online Banking Icon"/>
        </div>
        <div class="col-md-3" align="left"><h4 class="title-blue">TopBank Online Banking</h4></div>
        <div class="col-md-3" align="left">
            <h4 class="title-blue">Your last action:</h4>
            <c:if test="${status eq 1}">
                <span><img height="25px" width="25px"
                           src="<c:url value="https://cdn2.iconfinder.com/data/icons/color-svg-vector-icons-part-2/512/apply_ok_check_yes_dialog-128.png"/>"
                           alt="Ok"/></span>
                <span class="message-ok"><b>${message}</b></span>
            </c:if>
            <c:if test="${status eq 0}">
                <span><img height="30px" width="30px"
                           src="<c:url value="https://cdn0.iconfinder.com/data/icons/small-n-flat/24/678069-sign-error-128.png"/>"
                           alt="Error"/></span>
                <span class="message-error"><b>${message}</b></span>
            </c:if>
        </div>
        <div class="col-md-3" align="left">
            <h4 class="title-blue">You've logged in as: ${login}</h4>
        </div>
        <div class="col-md-1" align="center">
            <form action="/" method="POST">
                <input class="btn btn-primary" type="submit" value="Log out"/>
            </form>
        </div>
    </div>
    <div class="row">
        <div class="col-md-2">
            <h4 class="title-blue" align="center">Available operations:</h4>
            <button type="button" class="btn btn-primary btn-lg btn-block" id="open-account">Open Account</button>
            <button type="button" class="btn btn-primary btn-lg btn-block" id="add-funds">Deposit Cash</button>
            <button type="button" class="btn btn-primary btn-lg btn-block" id="withdraw-cash">Withdraw Cash</button>
            <button type="button" class="btn btn-primary btn-lg btn-block" id="transfer-funds">Transfer Funds</button>
            <button type="button" class="btn btn-primary btn-lg btn-block" id="close-account">Close Account</button>
            <button type="button" class="btn btn-primary btn-lg btn-block" id="open-deposit">Open Deposit</button>
            <button type="button" class="btn btn-primary btn-lg btn-block" id="close-deposit">Close Deposit</button>
            <button type="button" class="btn btn-primary btn-lg btn-block" id="get-credit">Get Loan</button>
            <button type="button" class="btn btn-primary btn-lg btn-block" id="close-credit">Repay Loan</button>
        </div>
        <div class="col-md-5">
            <h4 class="title-blue">My Accounts:</h4>
            <c:if test="${isAccounts eq false}">
                <p class="no-data">You have no opened accounts yet. To open account press button "Open Account".</p>
            </c:if>
            <c:if test="${isAccounts eq true}">
                <table class="table table-striped">
                    <thead>
                    <tr>
                        <td>ID</td>
                        <td>Currency</td>
                        <td>Amount</td>
                    </tr>
                    </thead>
                    <c:forEach items="${accounts}" var="account">
                        <tr>
                            <td>${account.id}</td>
                            <td>${account.currency}</td>
                            <td>${account.amount}</td>
                        </tr>
                    </c:forEach>
                </table>
            </c:if>
            <h4 class="title-blue">My Deposits:</h4>
            <c:if test="${isDeposits eq false}">
                <p class="no-data">You have no opened deposits yet. To open deposit press button "Open Deposit".</p>
            </c:if>
            <c:if test="${isDeposits eq true}">
                <table class="table table-striped" align="center">
                    <thead>
                    <tr>
                        <td>ID</td>
                        <td>Currency</td>
                        <td>Amount</td>
                        <td>Interest Rate</td>
                        <td>Term</td>
                        <td>Opening Date</td>
                        <td>Closing Date</td>
                    </tr>
                    </thead>
                    <c:forEach items="${deposits}" var="deposit">
                        <tr>
                            <td>${deposit.id}</td>
                            <td>${deposit.currency}</td>
                            <td>${deposit.amount}</td>
                            <td>${deposit.interestRate}%</td>
                            <td>${deposit.term}</td>
                            <td>${deposit.dateOpen}</td>
                            <td>${deposit.dateClose}</td>
                        </tr>
                    </c:forEach>
                </table>
            </c:if>
            <h4 class="title-blue">My Loans:</h4>
            <c:if test="${isCredits eq false}">
                <p class="no-data">You have no opened loans yet. To get loan press button "Get Loan".</p>
            </c:if>
            <c:if test="${isCredits eq true}">
                <table class="table table-striped">
                    <thead>
                    <tr>
                        <td>ID</td>
                        <td>Currency</td>
                        <td>Amount</td>
                        <td>Interest Rate</td>
                        <td>Term</td>
                        <td>Opening Date</td>
                        <td>Closing Date</td>
                    </tr>
                    </thead>
                    <c:forEach items="${credits}" var="credit">
                        <tr>
                            <td>${credit.id}</td>
                            <td>${credit.currency}</td>
                            <td>${credit.amount}</td>
                            <td>${credit.interestRate}%</td>
                            <td>${credit.term}</td>
                            <td>${credit.dateOpen}</td>
                            <td>${credit.dateClose}</td>
                        </tr>
                    </c:forEach>
                </table>
            </c:if>
        </div>
        <div class="col-md-5">
            <h4 class="title-blue">My Last Actions:</h4>
            <table class="table table-striped">
                <thead>
                <tr>
                    <td>Date / Time</td>
                    <td>Event</td>
                </tr>
                </thead>
                <c:forEach items="${events}" var="event">
                    <tr>
                        <td>${event.date}</td>
                        <td>${event.message}</td>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </div>
</div>

<div class="overlay"></div>
<section class="pop-ups">

    <div class="pop-up" id="pop-up-open-account">
        <div class="close">X</div>
        <form class="form" action="/main/open_account" method="POST">
            <h4>Account Opening</h4><br>
            <input type="hidden" name="login" value="${login}">
            Select account currency<br>
            <select name="currency">
                <option value="980">UAH (980)</option>
                <option value="840">USD (840)</option>
                <option value="978">EUR (978)</option>
            </select><br><br>
            <input type="submit" class="btn btn-primary" value="Open Account"/>
        </form>
    </div>

    <div class="pop-up" id="pop-up-close-account">
        <div class="close">X</div>
        <form class="form" action="/main/close_account" method="POST">
            <h4>Account Closing</h4><br>
            <input type="hidden" name="login" value="${login}">
            <c:if test="${isAccounts eq false}">
                <p class="no-data">You have no opened accounts to close.</p>
            </c:if>
            <c:if test="${isAccounts eq true}">
                Select account to close:<br>
                (you can close only account with no funds)<br>
                <select name="accountID">
                    <c:forEach items="${accounts}" var="account">
                        <option value="${account.id}">ID: ${account.id}, currency: ${account.currency},
                            amount: ${account.amount}</option>
                    </c:forEach>
                </select><br><br>
                <input type="submit" class="btn btn-primary" value="Close Account"/>
            </c:if>
        </form>
    </div>

    <div class="pop-up" id="pop-up-add-funds">
        <div class="close">X</div>
        <form class="form" action="/main/deposit_cash" method="POST">
            <h4>Account Replenishment</h4><br>
            <input type="hidden" name="login" value="${login}">
            <c:if test="${isAccounts eq false}">
                <p class="no-data">You have no opened accounts to replenish.
                    You have to open account in required currency first.</p>
            </c:if>
            <c:if test="${isAccounts eq true}">
                Select account to replenish:<br>
                <select name="accountID">
                    <c:forEach items="${accounts}" var="account">
                        <option value="${account.id}">ID: ${account.id}, currency: ${account.currency},
                            amount: ${account.amount}</option>
                    </c:forEach>
                </select><br><br>
                Amount to replenish<br>
                <input type="text" name="amount" value="1000"><br><br>
                <input type="submit" class="btn btn-primary" value="Deposit Cash"/>
            </c:if>
        </form>
    </div>

    <div class="pop-up" id="pop-up-withdraw-cash">
        <div class="close">X</div>
        <form class="form" action="/main/withdraw_cash" method="POST">
            <h4>Cash Withdrawal</h4><br>
            <input type="hidden" name="login" value="${login}">
            <c:if test="${isAccounts eq false}">
                <p class="no-data">You have no opened accounts to withdraw the cash.</p>
            </c:if>
            <c:if test="${isAccounts eq true}">
                Select account to withdraw the cash<br>
                <select name="accountID">
                    <c:forEach items="${accounts}" var="account">
                        <option value="${account.id}">ID: ${account.id}, currency: ${account.currency},
                            amount: ${account.amount}</option>
                    </c:forEach>
                </select><br><br>
                Withdrawal Amount<br>
                <input type="text" name="amount" value="1000"><br><br>
                <input type="submit" class="btn btn-primary" value="Withdraw Cash"/>
            </c:if>
        </form>
    </div>

    <div class="pop-up" id="pop-up-transfer-funds">
        <div class="close">X</div>
        <form class="form" action="/main/transfer_funds" method="POST">
            <h4>Funds Transferring</h4><br>
            <input type="hidden" name="login" value="${login}">
            <c:if test="${isAccounts eq false}">
                <p class="no-data">You have no opened accounts to transfer funds.
                    You have to open at least two accounts in the same currency first.</p>
            </c:if>
            <c:if test="${isAccounts eq true}">
                Select account to transfer funds from<br>
                <select name="accountFrom">
                    <c:forEach items="${accounts}" var="account">
                        <option value="${account.id}">ID: ${account.id}, currency: ${account.currency},
                            amount: ${account.amount}</option>
                    </c:forEach>
                </select><br><br>
                Select account to transfer funds to<br>
                (currency of accounts must match)<br>
                <select name="accountTo">
                    <c:forEach items="${accounts}" var="account">
                        <option value="${account.id}">ID: ${account.id}, currency: ${account.currency},
                            amount: ${account.amount}</option>
                    </c:forEach>
                </select><br><br>
                Specify transfer amount<br>
                <input type="text" name="amount" value="1000"><br><br>
                <input type="submit" class="btn btn-primary" value="Transfer Funds"/>
            </c:if>
        </form>
    </div>

    <div class="pop-up" id="pop-up-open-deposit">
        <div class="close">X</div>
        <form class="form" action="/main/open_deposit" method="POST">
            <h4>Deposit Opening</h4><br>
            <input type="hidden" name="login" value="${login}">
            <c:if test="${isAccounts eq false}">
                <p class="no-data">You have no opened accounts to open deposit. Open account in required currency
                    first.</p>
            </c:if>
            <c:if test="${isAccounts eq true}">
                Select account to transfer funds on deposit from<br>
                <select name="accountID">
                    <c:forEach items="${accounts}" var="account">
                        <option value="${account.id}">ID: ${account.id}, currency: ${account.currency},
                            amount: ${account.amount}</option>
                    </c:forEach>
                </select><br><br>
                Select deposit currency<br>
                (must match with account currency)<br>
                (980 - UAH, 840 - USD, 978 - EUR)<br>
                <select name="currency">
                    <option value="980">UAH (980)</option>
                    <option value="840">USD (840)</option>
                    <option value="978">EUR (978)</option>
                </select><br><br>
                Specify deposit amount<br>
                <input type="text" name="amount" value="1000"><br><br>
                Select deposit term<br>
                <select name="term">
                    <option value="30">30 days</option>
                    <option value="90">90 days</option>
                    <option value="180">180 days</option>
                    <option value="360">360 days</option>
                </select><br><br>
                <input type="submit" class="btn btn-primary" value="Open Deposit"/>
            </c:if>
        </form>
    </div>

    <div class="pop-up" id="pop-up-close-deposit">
        <div class="close">X</div>
        <form class="form" action="/main/close_deposit" method="POST">
            <h4>Deposit Closing</h4><br>
            <input type="hidden" name="login" value="${login}">
            <c:choose>
                <c:when test="${isAccounts eq false}">
                    <p class="no-data">You have no opened account to transfer funds from deposit.
                        Open account in required currency first.</p>
                </c:when>
                <c:when test="${isDeposits eq false}">
                    <p class="no-data">You have no deposits to close.</p>
                </c:when>
                <c:otherwise>
                    Select deposit to close<br>
                    <select name="depositId">
                        <c:forEach items="${deposits}" var="deposit">
                            <option value="${deposit.id}">ID: ${deposit.id}, currency: ${deposit.currency},
                                amount: ${deposit.amount}</option>
                        </c:forEach>
                    </select><br><br>
                    Select account to transfer deposit and interest amounts<br>
                    (currency of deposit and account must match)<br>
                    (980 - UAH, 840 - USD, 978 - EUR)<br>
                    <select name="accountId">
                        <c:forEach items="${accounts}" var="account">
                            <option value="${account.id}">ID: ${account.id}, currency: ${account.currency},
                                amount: ${account.amount}</option>
                        </c:forEach>
                    </select><br><br>
                    <input type="submit" class="btn btn-primary" value="Close Deposit"/>
                </c:otherwise>
            </c:choose>
        </form>
    </div>

    <div class="pop-up" id="pop-up-get-credit">
        <div class="close">X</div>
        <form class="form" action="/main/get_credit" method="POST">
            <h4>Getting Loan</h4><br>
            <input type="hidden" name="login" value="${login}">
            <c:if test="${isAccounts eq false}">
                <p class="no-data">You have no opened account to transfer loan funds.
                    Open account in required currency first.</p>
            </c:if>
            <c:if test="${isAccounts eq true}">
                Select loan currency<br>
                <select name="currency">
                    <option value="980">UAH (980)</option>
                    <option value="840">USD (840)</option>
                    <option value="978">EUR (978)</option>
                </select><br><br>
                Specify loan amount<br>
                <input type="text" name="amount" value="1000"><br><br>
                Select loan term<br>
                <select name="term">
                    <option value="30">30 days</option>
                    <option value="90">90 days</option>
                    <option value="180">180 days</option>
                    <option value="360">360 days</option>
                </select><br><br>
                Select account to transfer loan funds<br>
                (currency of loan and account must match)<br>
                (980 - UAH, 840 - USD, 978 - EUR)<br>
                <select name="accountID">
                    <c:forEach items="${accounts}" var="account">
                        <option value="${account.id}">ID: ${account.id}, currency: ${account.currency},
                            amount: ${account.amount}</option>
                    </c:forEach>
                </select><br><br>
                <input type="submit" class="btn btn-primary" value="Get Loan"/>
            </c:if>
        </form>
    </div>

    <div class="pop-up" id="pop-up-close-credit">
        <div class="close">X</div>
        <form class="form" action="/main/close_credit" method="POST">
            <h4>Loan Repayment</h4><br>
            <input type="hidden" name="login" value="${login}">
            <c:choose>
                <c:when test="${isAccounts eq false}">
                    <p class="no-data">You have no opened account to repay the loan.
                        Open account in required currency first.</p>
                </c:when>
                <c:when test="${isCredits eq false}">
                    <p class="no-data">You have no loans to repay.</p>
                </c:when>
                <c:otherwise>
                    Select loan to repay<br>
                    <select name="creditId">
                        <c:forEach items="${credits}" var="credit">
                            <option value="${credit.id}">ID: ${credit.id}, currency: ${credit.currency},
                                amount: ${credit.amount}</option>
                        </c:forEach>
                    </select><br><br>
                    Select account to repay loan and interest amounts<br>
                    (loan currency and account currency must match)<br>
                    (980 - UAH, 840 - USD, 978 - EUR)<br>
                    <select name="accountId">
                        <c:forEach items="${accounts}" var="account">
                            <option value="${account.id}">ID: ${account.id}, currency: ${account.currency},
                                amount: ${account.amount}</option>
                        </c:forEach>
                    </select><br><br>
                    <input type="submit" class="btn btn-primary" value="Repay Loan"/>
                </c:otherwise>
            </c:choose>
        </form>
    </div>
</section>

<script type="text/javascript">
    $('#open-account').click(function () {
        $('#pop-up-open-account, .close').css({'opacity': 1.0, 'visibility': 'visible'});
        $('.overlay').css({'opacity': 0.8, 'visibility': 'visible'});
    });
    $('#add-funds').click(function () {
        $('#pop-up-add-funds, .close').css({'opacity': 1.0, 'visibility': 'visible'});
        $('.overlay').css({'opacity': 0.8, 'visibility': 'visible'});
    });
    $('#withdraw-cash').click(function () {
        $('#pop-up-withdraw-cash, .close').css({'opacity': 1.0, 'visibility': 'visible'});
        $('.overlay').css({'opacity': 0.8, 'visibility': 'visible'});
    });
    $('#transfer-funds').click(function () {
        $('#pop-up-transfer-funds, .close').css({'opacity': 1.0, 'visibility': 'visible'});
        $('.overlay').css({'opacity': 0.8, 'visibility': 'visible'});
    });
    $('#close-account').click(function () {
        $('#pop-up-close-account, .close').css({'opacity': 1.0, 'visibility': 'visible'});
        $('.overlay').css({'opacity': 0.8, 'visibility': 'visible'});
    });
    $('#open-deposit').click(function () {
        $('#pop-up-open-deposit, .close').css({'opacity': 1.0, 'visibility': 'visible'});
        $('.overlay').css({'opacity': 0.8, 'visibility': 'visible'});
    });
    $('#close-deposit').click(function () {
        $('#pop-up-close-deposit, .close').css({'opacity': 1.0, 'visibility': 'visible'});
        $('.overlay').css({'opacity': 0.8, 'visibility': 'visible'});
    });
    $('#get-credit').click(function () {
        $('#pop-up-get-credit, .close').css({'opacity': 1.0, 'visibility': 'visible'});
        $('.overlay').css({'opacity': 0.8, 'visibility': 'visible'});
    });
    $('#close-credit').click(function () {
        $('#pop-up-close-credit, .close').css({'opacity': 1.0, 'visibility': 'visible'});
        $('.overlay').css({'opacity': 0.8, 'visibility': 'visible'});
    });
    $('.close').click(function () {
        $('#pop-up-open-account, #pop-up-close-account, #pop-up-add-funds, #pop-up-withdraw-cash, #pop-up-transfer-funds, #pop-up-open-deposit, #pop-up-close-deposit, #pop-up-get-credit, #pop-up-close-credit, .overlay').css({
            'opacity': 0,
            'visibility': 'hidden'
        });
    });
</script>
</body>
</html>