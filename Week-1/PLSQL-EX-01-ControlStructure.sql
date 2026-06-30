SET SERVEROUTPUT ON;

CREATE TABLE Customers (
    CustomerID NUMBER PRIMARY KEY,
    Name VARCHAR2(100),
    DOB DATE,
    Balance NUMBER(12,2),
    IsVIP VARCHAR2(5) DEFAULT 'FALSE'
);

CREATE TABLE Loans (
    LoanID NUMBER PRIMARY KEY,
    CustomerID NUMBER,
    InterestRate NUMBER(5,2),
    DueDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

INSERT INTO Customers VALUES (1, 'John Smith', DATE '1955-05-15', 15000, 'FALSE');
INSERT INTO Customers VALUES (2, 'Alice Brown', DATE '1985-08-20', 8000, 'FALSE');
INSERT INTO Customers VALUES (3, 'Robert Wilson', DATE '1960-02-10', 12000, 'FALSE');
INSERT INTO Customers VALUES (4, 'Emma Davis', DATE '1990-11-25', 5000, 'FALSE');

INSERT INTO Loans VALUES (101, 1, 8.50, SYSDATE + 15);
INSERT INTO Loans VALUES (102, 2, 9.00, SYSDATE + 45);
INSERT INTO Loans VALUES (103, 3, 7.50, SYSDATE + 20);
INSERT INTO Loans VALUES (104, 4, 10.00, SYSDATE + 10);

COMMIT;

DECLARE
    v_age NUMBER;
BEGIN
    FOR rec IN (
        SELECT l.LoanID, l.InterestRate, c.DOB
        FROM Loans l
        JOIN Customers c
        ON l.CustomerID = c.CustomerID
    ) LOOP

        v_age := FLOOR(MONTHS_BETWEEN(SYSDATE, rec.DOB) / 12);

        IF v_age > 60 THEN
            UPDATE Loans
            SET InterestRate = InterestRate - 1
            WHERE LoanID = rec.LoanID;

            DBMS_OUTPUT.PUT_LINE('1% discount applied to Loan ID: ' || rec.LoanID);
        END IF;

    END LOOP;

    COMMIT;
END;
/

BEGIN
    FOR rec IN (
        SELECT CustomerID, Balance
        FROM Customers
    ) LOOP

        IF rec.Balance > 10000 THEN
            UPDATE Customers
            SET IsVIP = 'TRUE'
            WHERE CustomerID = rec.CustomerID;

            DBMS_OUTPUT.PUT_LINE('Customer ' || rec.CustomerID || ' promoted to VIP');
        END IF;

    END LOOP;

    COMMIT;
END;
/

BEGIN
    FOR rec IN (
        SELECT c.Name, l.LoanID, l.DueDate
        FROM Customers c
        JOIN Loans l
        ON c.CustomerID = l.CustomerID
        WHERE l.DueDate BETWEEN SYSDATE AND SYSDATE + 30
    ) LOOP

        DBMS_OUTPUT.PUT_LINE(
            'Reminder: Dear ' || rec.Name ||
            ', Loan ID ' || rec.LoanID ||
            ' is due on ' || TO_CHAR(rec.DueDate, 'DD-MON-YYYY')
        );

    END LOOP;
END;
/

SELECT * FROM Customers;
SELECT * FROM Loans;