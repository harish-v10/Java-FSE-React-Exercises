SET SERVEROUTPUT ON;

CREATE TABLE Customers (
    CustomerID NUMBER PRIMARY KEY,
    CustomerName VARCHAR2(100)
);

CREATE TABLE Accounts (
    AccountID NUMBER PRIMARY KEY,
    CustomerID NUMBER,
    Balance NUMBER(12,2)
);

CREATE TABLE Loans (
    LoanID NUMBER PRIMARY KEY,
    CustomerID NUMBER,
    LoanAmount NUMBER(12,2),
    InterestRate NUMBER(5,2)
);

CREATE TABLE Transactions (
    TransactionID NUMBER PRIMARY KEY,
    CustomerID NUMBER,
    AccountID NUMBER,
    Amount NUMBER(12,2),
    TransactionDate DATE
);

INSERT INTO Customers VALUES (1, 'John Smith');
INSERT INTO Customers VALUES (2, 'Alice Brown');

INSERT INTO Accounts VALUES (101, 1, 10000);
INSERT INTO Accounts VALUES (102, 2, 15000);

INSERT INTO Loans VALUES (201, 1, 500000, 8.50);
INSERT INTO Loans VALUES (202, 2, 300000, 9.00);

INSERT INTO Transactions VALUES (1, 1, 101, 2000, SYSDATE);
INSERT INTO Transactions VALUES (2, 1, 101, 1500, SYSDATE);
INSERT INTO Transactions VALUES (3, 2, 102, 3000, SYSDATE);

COMMIT;

DECLARE
    CURSOR GenerateMonthlyStatements IS
        SELECT c.CustomerName,
               t.TransactionID,
               t.Amount,
               t.TransactionDate
        FROM Customers c
        JOIN Transactions t
        ON c.CustomerID = t.CustomerID
        WHERE EXTRACT(MONTH FROM t.TransactionDate) =
              EXTRACT(MONTH FROM SYSDATE)
        AND EXTRACT(YEAR FROM t.TransactionDate) =
            EXTRACT(YEAR FROM SYSDATE);

    v_customer_name Customers.CustomerName%TYPE;
    v_transaction_id Transactions.TransactionID%TYPE;
    v_amount Transactions.Amount%TYPE;
    v_transaction_date Transactions.TransactionDate%TYPE;

BEGIN
    OPEN GenerateMonthlyStatements;

    LOOP
        FETCH GenerateMonthlyStatements
        INTO v_customer_name,
             v_transaction_id,
             v_amount,
             v_transaction_date;

        EXIT WHEN GenerateMonthlyStatements%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE(
            'Customer: ' || v_customer_name ||
            ', Transaction ID: ' || v_transaction_id ||
            ', Amount: ' || v_amount ||
            ', Date: ' || TO_CHAR(v_transaction_date,'DD-MON-YYYY')
        );
    END LOOP;

    CLOSE GenerateMonthlyStatements;
END;
/

DECLARE
    CURSOR ApplyAnnualFee IS
        SELECT AccountID, Balance
        FROM Accounts;

    v_account_id Accounts.AccountID%TYPE;
    v_balance Accounts.Balance%TYPE;

    v_fee NUMBER := 500;

BEGIN
    OPEN ApplyAnnualFee;

    LOOP
        FETCH ApplyAnnualFee
        INTO v_account_id, v_balance;

        EXIT WHEN ApplyAnnualFee%NOTFOUND;

        UPDATE Accounts
        SET Balance = Balance - v_fee
        WHERE AccountID = v_account_id;

        DBMS_OUTPUT.PUT_LINE(
            'Annual fee deducted from Account ID: ' ||
            v_account_id
        );
    END LOOP;

    CLOSE ApplyAnnualFee;

    COMMIT;
END;
/

DECLARE
    CURSOR UpdateLoanInterestRates IS
        SELECT LoanID, InterestRate
        FROM Loans;

    v_loan_id Loans.LoanID%TYPE;
    v_interest_rate Loans.InterestRate%TYPE;

BEGIN
    OPEN UpdateLoanInterestRates;

    LOOP
        FETCH UpdateLoanInterestRates
        INTO v_loan_id, v_interest_rate;

        EXIT WHEN UpdateLoanInterestRates%NOTFOUND;

        UPDATE Loans
        SET InterestRate = InterestRate + 0.50
        WHERE LoanID = v_loan_id;

        DBMS_OUTPUT.PUT_LINE(
            'Interest rate updated for Loan ID: ' ||
            v_loan_id
        );
    END LOOP;

    CLOSE UpdateLoanInterestRates;

    COMMIT;
END;
/

SELECT * FROM Customers;
SELECT * FROM Accounts;
SELECT * FROM Loans;
SELECT * FROM Transactions;