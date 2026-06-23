SET SERVEROUTPUT ON;

CREATE TABLE Customers (
    CustomerID NUMBER PRIMARY KEY,
    CustomerName VARCHAR2(100),
    Balance NUMBER(12,2),
    City VARCHAR2(50)
);

CREATE TABLE Employees (
    EmployeeID NUMBER PRIMARY KEY,
    EmployeeName VARCHAR2(100),
    Salary NUMBER(12,2),
    Department VARCHAR2(50)
);

CREATE TABLE Accounts (
    AccountID NUMBER PRIMARY KEY,
    CustomerID NUMBER,
    Balance NUMBER(12,2)
);

INSERT INTO Customers VALUES (1, 'John Smith', 10000, 'New York');
INSERT INTO Customers VALUES (2, 'Alice Brown', 15000, 'Chicago');

INSERT INTO Employees VALUES (101, 'David Wilson', 50000, 'IT');
INSERT INTO Employees VALUES (102, 'Emma Davis', 60000, 'HR');

INSERT INTO Accounts VALUES (201, 1, 5000);
INSERT INTO Accounts VALUES (202, 1, 7000);
INSERT INTO Accounts VALUES (203, 2, 10000);

COMMIT;

CREATE OR REPLACE PACKAGE CustomerManagement AS
    PROCEDURE AddCustomer(
        p_customer_id NUMBER,
        p_customer_name VARCHAR2,
        p_balance NUMBER,
        p_city VARCHAR2
    );

    PROCEDURE UpdateCustomer(
        p_customer_id NUMBER,
        p_customer_name VARCHAR2,
        p_city VARCHAR2
    );

    FUNCTION GetCustomerBalance(
        p_customer_id NUMBER
    ) RETURN NUMBER;
END CustomerManagement;
/

CREATE OR REPLACE PACKAGE BODY CustomerManagement AS

    PROCEDURE AddCustomer(
        p_customer_id NUMBER,
        p_customer_name VARCHAR2,
        p_balance NUMBER,
        p_city VARCHAR2
    )
    IS
    BEGIN
        INSERT INTO Customers
        VALUES (p_customer_id, p_customer_name, p_balance, p_city);
        COMMIT;
    END;

    PROCEDURE UpdateCustomer(
        p_customer_id NUMBER,
        p_customer_name VARCHAR2,
        p_city VARCHAR2
    )
    IS
    BEGIN
        UPDATE Customers
        SET CustomerName = p_customer_name,
            City = p_city
        WHERE CustomerID = p_customer_id;
        COMMIT;
    END;

    FUNCTION GetCustomerBalance(
        p_customer_id NUMBER
    )
    RETURN NUMBER
    IS
        v_balance NUMBER;
    BEGIN
        SELECT Balance
        INTO v_balance
        FROM Customers
        WHERE CustomerID = p_customer_id;

        RETURN v_balance;
    END;

END CustomerManagement;
/

CREATE OR REPLACE PACKAGE EmployeeManagement AS
    PROCEDURE HireEmployee(
        p_employee_id NUMBER,
        p_employee_name VARCHAR2,
        p_salary NUMBER,
        p_department VARCHAR2
    );

    PROCEDURE UpdateEmployee(
        p_employee_id NUMBER,
        p_employee_name VARCHAR2,
        p_department VARCHAR2
    );

    FUNCTION CalculateAnnualSalary(
        p_employee_id NUMBER
    ) RETURN NUMBER;
END EmployeeManagement;
/

CREATE OR REPLACE PACKAGE BODY EmployeeManagement AS

    PROCEDURE HireEmployee(
        p_employee_id NUMBER,
        p_employee_name VARCHAR2,
        p_salary NUMBER,
        p_department VARCHAR2
    )
    IS
    BEGIN
        INSERT INTO Employees
        VALUES (p_employee_id, p_employee_name, p_salary, p_department);
        COMMIT;
    END;

    PROCEDURE UpdateEmployee(
        p_employee_id NUMBER,
        p_employee_name VARCHAR2,
        p_department VARCHAR2
    )
    IS
    BEGIN
        UPDATE Employees
        SET EmployeeName = p_employee_name,
            Department = p_department
        WHERE EmployeeID = p_employee_id;
        COMMIT;
    END;

    FUNCTION CalculateAnnualSalary(
        p_employee_id NUMBER
    )
    RETURN NUMBER
    IS
        v_salary NUMBER;
    BEGIN
        SELECT Salary
        INTO v_salary
        FROM Employees
        WHERE EmployeeID = p_employee_id;

        RETURN v_salary * 12;
    END;

END EmployeeManagement;
/

CREATE OR REPLACE PACKAGE AccountOperations AS
    PROCEDURE OpenAccount(
        p_account_id NUMBER,
        p_customer_id NUMBER,
        p_balance NUMBER
    );

    PROCEDURE CloseAccount(
        p_account_id NUMBER
    );

    FUNCTION GetTotalBalance(
        p_customer_id NUMBER
    ) RETURN NUMBER;
END AccountOperations;
/

CREATE OR REPLACE PACKAGE BODY AccountOperations AS

    PROCEDURE OpenAccount(
        p_account_id NUMBER,
        p_customer_id NUMBER,
        p_balance NUMBER
    )
    IS
    BEGIN
        INSERT INTO Accounts
        VALUES (p_account_id, p_customer_id, p_balance);
        COMMIT;
    END;

    PROCEDURE CloseAccount(
        p_account_id NUMBER
    )
    IS
    BEGIN
        DELETE FROM Accounts
        WHERE AccountID = p_account_id;
        COMMIT;
    END;

    FUNCTION GetTotalBalance(
        p_customer_id NUMBER
    )
    RETURN NUMBER
    IS
        v_total NUMBER;
    BEGIN
        SELECT SUM(Balance)
        INTO v_total
        FROM Accounts
        WHERE CustomerID = p_customer_id;

        RETURN NVL(v_total, 0);
    END;

END AccountOperations;
/

BEGIN
    CustomerManagement.AddCustomer(
        3,
        'Robert Wilson',
        20000,
        'Boston'
    );

    CustomerManagement.UpdateCustomer(
        1,
        'John Smith',
        'Dallas'
    );
END;
/

BEGIN
    EmployeeManagement.HireEmployee(
        103,
        'Michael Brown',
        55000,
        'Finance'
    );

    EmployeeManagement.UpdateEmployee(
        101,
        'David Wilson',
        'Finance'
    );
END;
/

BEGIN
    AccountOperations.OpenAccount(
        204,
        2,
        8000
    );

    AccountOperations.CloseAccount(
        204
    );
END;
/

DECLARE
    v_balance NUMBER;
    v_salary NUMBER;
    v_total_balance NUMBER;
BEGIN
    v_balance := CustomerManagement.GetCustomerBalance(1);
    DBMS_OUTPUT.PUT_LINE('Customer Balance: ' || v_balance);

    v_salary := EmployeeManagement.CalculateAnnualSalary(101);
    DBMS_OUTPUT.PUT_LINE('Annual Salary: ' || v_salary);

    v_total_balance := AccountOperations.GetTotalBalance(1);
    DBMS_OUTPUT.PUT_LINE('Total Account Balance: ' || v_total_balance);
END;
/

SELECT * FROM Customers;
SELECT * FROM Employees;
SELECT * FROM Accounts;