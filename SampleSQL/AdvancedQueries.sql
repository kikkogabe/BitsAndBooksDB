-- Provide the customer names and the total dollar amount each customer has spent. 

SELECT C.FName, C.Lname, SUM (B.Price * I.Quantity)
FROM CUSTOMER C, BOOK B, ORDERS O, IS_CONTAINED I
WHERE C.Cust_ID = O.Customer_ID AND O.Order_ID = I.Order_ID AND I.Book_ID = B.ISBN
GROUP BY C.Fname, C.Lname;


-- Provide the customer names and e-mail addresses for customers who have spent more than the average customer.

SELECT C.FName, C.Lname, C.Email
FROM CUSTOMER C, BOOK B, ORDERS O, IS_CONTAINED I
WHERE C.Cust_ID = O.Customer_ID AND O.Order_ID = I.Order_ID AND I.Book_ID = B.ISBN
GROUP BY C.Cust_ID
HAVING SUM(B.Price * I.Quantity) > ( SELECT AVG (spent) FROM (
        SELECT SUM (B.Price * I.Quantity) as spent
        FROM CUSTOMER C, BOOK B, ORDERS O, IS_CONTAINED I
        WHERE C.Cust_ID = O.Customer_ID AND O.Order_ID = I.Order_ID AND I.Book_ID = B.ISBN
        GROUP BY C.Cust_ID))

-- Provide the titles and associated total copies sold to customers, sorted from the title that has sold the most individual copies to the title that has sold the least.


SELECT B.Title, SUM (I.Quantity)
FROM BOOK B, IS_CONTAINED I
WHERE B.ISBN = I.Book_ID
GROUP BY B.Title
ORDER BY SUM (I.Quantity) DESC;

-- Provide the titles and associated dollar totals for copies sold to customers, sorted from the title that has sold the highest dollar amount to the title that has sold the smallest.

SELECT B.Title, SUM(B.Price * I.Quantity)
FROM BOOK B, IS_CONTAINED I
WHERE B.ISBN = I.Book_ID
GROUP BY B.Title
ORDER BY SUM(B.Price * I.Quantity) DESC;

-- Find the most popular author in the database (i.e. the one who has sold the most books)

SELECT A.Fname, A.Mi, A.Lname
FROM AUTHOR A, AUTHOR_BOOK AB, IS_CONTAINED I
WHERE A.Author_id = AB.AuthorId AND AB.BookID = I.Book_ID
GROUP BY A.Author_id
ORDER BY SUM(I.Quantity) DESC
LIMIT 1;

-- Find the most profitable author in the database for this store (i.e. the one who has brought in the most money)

SELECT A.Fname, A.Mi, A.Lname
FROM AUTHOR A, AUTHOR_BOOK AB, IS_CONTAINED I, BOOK B
WHERE A.Author_id = AB.AuthorId AND AB.BookID = I.Book_ID AND AB.BookID = B.ISBN
GROUP BY A.Author_id
ORDER BY SUM(B.Price * I.Quantity) DESC
LIMIT 1;


-- Provide the customer information for customers who purchased anything written by the most profitable author in the database.

SELECT C.Cust_ID, C.Fname, C.Lname, C.Email, C.Pnum
FROM CUSTOMER C, IS_CONTAINED I, AUTHOR_BOOK AB, ORDERS O
WHERE C.Cust_ID = O.Customer_ID AND O.Order_ID = I.Order_ID AND I.Book_ID = AB.BookID AND AB.AuthorId IN (
        SELECT A.Author_ID
        FROM AUTHOR A, AUTHOR_BOOK AB, IS_CONTAINED I, BOOK B
        WHERE A.Author_id = AB.AuthorId AND AB.BookID = I.Book_ID AND AB.BookID = B.ISBN
        GROUP BY A.Author_id
        ORDER BY SUM(B.Price * I.Quantity) DESC
        LIMIT 1);

-- Provide the authors who wrote the books purchased by the customers who have spent more than the average customer.
 

SELECT A.Fname, A.Mi, A.Lname
FROM AUTHOR A, AUTHOR_BOOK AB, IS_CONTAINED I, ORDERS O
WHERE  O.Order_ID = I.Order_ID AND I.Book_ID = AB.BookID AND AB.AuthorId = A.Author_id AND O.Customer_ID IN (
        SELECT C.Cust_ID
        FROM CUSTOMER C, BOOK B, ORDERS O, IS_CONTAINED I
        WHERE C.Cust_ID = O.Customer_ID AND O.Order_ID = I.Order_ID AND I.Book_ID = B.ISBN
        GROUP BY C.Cust_ID
        HAVING SUM(B.Price * I.Quantity) > ( SELECT AVG (spent) FROM (
                SELECT SUM (B.Price * I.Quantity) as spent
                FROM CUSTOMER C, BOOK B, ORDERS O, IS_CONTAINED I
                WHERE C.Cust_ID = O.Customer_ID AND O.Order_ID = I.Order_ID AND I.Book_ID = B.ISBN
                GROUP BY C.Cust_ID)));
