SET SERVEROUTPUT ON;

CREATE TABLE Customers (
    CustomerID NUMBER PRIMARY KEY,
    CustomerName VARCHAR2(100),
    DateOfBirth DATE
);

CREATE TABLE Loans (
    LoanID NUMBER PRIMARY KEY,
    LoanAmount NUMBER(12,2),
    InterestRate NUMBER(5,2),
    DurationYears NUMBER
);

CREATE TABLE Accounts (
    AccountID NUMBER PRIMARY KEY,
    CustomerName VARCHAR2(100),
    Balance NUMBER(12,2)
);

INSERT INTO Customers VALUES (1, 'John Smith', DATE '1990-05-15');
INSERT INTO Customers VALUES (2, 'Alice Brown', DATE '1985-08-20');

INSERT INTO Loans VALUES (101, 500000, 8, 5);
INSERT INTO Loans VALUES (102, 300000, 7.5, 3);

INSERT INTO Accounts VALUES (201, 'John Smith', 10000);
INSERT INTO Accounts VALUES (202, 'Alice Brown', 5000);

COMMIT;

CREATE OR REPLACE FUNCTION CalculateAge (
    p_dob DATE
)
RETURN NUMBER
IS
    v_age NUMBER;
BEGIN
    v_age := FLOOR(MONTHS_BETWEEN(SYSDATE, p_dob) / 12);
    RETURN v_age;
END;
/

CREATE OR REPLACE FUNCTION CalculateMonthlyInstallment (
    p_loan_amount NUMBER,
    p_interest_rate NUMBER,
    p_duration_years NUMBER
)
RETURN NUMBER
IS
    v_monthly_installment NUMBER;
BEGIN
    v_monthly_installment :=
        (p_loan_amount +
        (p_loan_amount * p_interest_rate * p_duration_years / 100))
        / (p_duration_years * 12);

    RETURN ROUND(v_monthly_installment, 2);
END;
/

CREATE OR REPLACE FUNCTION HasSufficientBalance (
    p_account_id NUMBER,
    p_amount NUMBER
)
RETURN BOOLEAN
IS
    v_balance NUMBER;
BEGIN
    SELECT Balance
    INTO v_balance
    FROM Accounts
    WHERE AccountID = p_account_id;

    RETURN v_balance >= p_amount;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN FALSE;
END;
/

DECLARE
    v_age NUMBER;
    v_installment NUMBER;
BEGIN
    v_age := CalculateAge(DATE '1990-05-15');
    DBMS_OUTPUT.PUT_LINE('Age = ' || v_age);

    v_installment := CalculateMonthlyInstallment(500000, 8, 5);
    DBMS_OUTPUT.PUT_LINE('Monthly Installment = ' || v_installment);

    IF HasSufficientBalance(201, 2000) THEN
        DBMS_OUTPUT.PUT_LINE('Sufficient Balance Available');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Insufficient Balance');
    END IF;
END;
/

SELECT * FROM Customers;
SELECT * FROM Loans;
SELECT * FROM Accounts;