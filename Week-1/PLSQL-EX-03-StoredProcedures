SET SERVEROUTPUT ON;

CREATE TABLE SavingsAccounts (
    AccountID NUMBER PRIMARY KEY,
    CustomerName VARCHAR2(100),
    Balance NUMBER(12,2)
);

CREATE TABLE Employees (
    EmployeeID NUMBER PRIMARY KEY,
    EmployeeName VARCHAR2(100),
    Department VARCHAR2(50),
    Salary NUMBER(12,2)
);

CREATE TABLE Accounts (
    AccountID NUMBER PRIMARY KEY,
    CustomerName VARCHAR2(100),
    Balance NUMBER(12,2)
);

INSERT INTO SavingsAccounts VALUES (101, 'John Smith', 10000);
INSERT INTO SavingsAccounts VALUES (102, 'Alice Brown', 15000);
INSERT INTO SavingsAccounts VALUES (103, 'Robert Wilson', 20000);

INSERT INTO Employees VALUES (1, 'David Wilson', 'IT', 50000);
INSERT INTO Employees VALUES (2, 'Emma Davis', 'IT', 60000);
INSERT INTO Employees VALUES (3, 'Michael Brown', 'HR', 45000);

INSERT INTO Accounts VALUES (201, 'John Smith', 10000);
INSERT INTO Accounts VALUES (202, 'Alice Brown', 5000);

COMMIT;

CREATE OR REPLACE PROCEDURE ProcessMonthlyInterest
IS
BEGIN
    UPDATE SavingsAccounts
    SET Balance = Balance + (Balance * 0.01);

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Monthly interest applied successfully.');
END;
/

CREATE OR REPLACE PROCEDURE UpdateEmployeeBonus (
    p_department IN VARCHAR2,
    p_bonus_percentage IN NUMBER
)
IS
BEGIN
    UPDATE Employees
    SET Salary = Salary + (Salary * p_bonus_percentage / 100)
    WHERE Department = p_department;

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Bonus updated for department: ' || p_department);
END;
/

CREATE OR REPLACE PROCEDURE TransferFunds (
    p_from_account IN NUMBER,
    p_to_account IN NUMBER,
    p_amount IN NUMBER
)
IS
    v_balance NUMBER;
BEGIN
    SELECT Balance
    INTO v_balance
    FROM Accounts
    WHERE AccountID = p_from_account;

    IF v_balance < p_amount THEN
        DBMS_OUTPUT.PUT_LINE('Insufficient balance. Transfer failed.');
    ELSE
        UPDATE Accounts
        SET Balance = Balance - p_amount
        WHERE AccountID = p_from_account;

        UPDATE Accounts
        SET Balance = Balance + p_amount
        WHERE AccountID = p_to_account;

        COMMIT;

        DBMS_OUTPUT.PUT_LINE('Funds transferred successfully.');
    END IF;
END;
/

BEGIN
    ProcessMonthlyInterest;
END;
/

BEGIN
    UpdateEmployeeBonus('IT', 10);
END;
/

BEGIN
    TransferFunds(201, 202, 2000);
END;
/

SELECT * FROM SavingsAccounts;
SELECT * FROM Employees;
SELECT * FROM Accounts;