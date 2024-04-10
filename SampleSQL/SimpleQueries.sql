-- Find the titles of all books by Pratchett that cost less than $10:

  SELECT * FROM BOOK, AUTHOR, AUTHOR_BOOK
  WHERE Lname = 'Pratchett' AND Author_ID = AuthorID AND Price < 10 AND BookID = ISBN;

-- Give all the titles and the dates of purchase made by a single customer:

  SELECT DISTINCT Title, Order_Date FROM ORDERS O, IS_CONTAINED IC, BOOK B
  WHERE O.Customer_ID = xx AND O.Order_ID = IC.Order_ID AND IC.Book_ID = B.ISBN;

-- Find the titles and ISBNs for all books with less than 5 copies in stock:
 
  SELECT DISTINCT Title, ISBN FROM BOOK B
  WHERE Stock < 5;

-- Give all the customers who purchased a book by Pratchett and the titles of Pratchett books they purchased

  SELECT DISTINCT C.Fname, C.Lname, Title
  FROM CUSTOMER C, AUTHOR A, ORDERS O, IS_CONTAINED IC, BOOK B, AUTHOR_BOOK AB
  WHERE A.Lname = 'Pratchett' AND A.Author_ID = AB.AuthorID AND AB.BookID = B.ISBN AND B.ISBN = IC.Book_ID AND IC.Order_ID = O.Order_ID AND O.Customer_ID = C.Cust_ID;

-- Find the total number of books purchased by a single customer

  SELECT SUM(Quantity) FROM ORDERS O, CUSTOMER C, IS_CONTAINED IC
  WHERE C.Cust_ID = xx AND C.Cust_ID = O.Customer_ID AND O.Order_ID = IC.Order_ID;

-- Find the customer who has purchased the most books and the total number of books they have purchased:

  SELECT MAX(purchased_books), Fname, Lname FROM (
      SELECT SUM(Quantity) purchased_books, C.Fname, C.Lname 
      FROM ORDERS O, CUSTOMER C, IS_CONTAINED IC
      WHERE C.Cust_ID = O.Customer_ID AND O.Order_ID = IC.Order_ID
      GROUP BY C.Cust_ID);

-- Find all reviews for a given ISBN:

  SELECT * FROM REVIEW
  WHERE Book_ID = xx;

-- Retrieve the genre and price of available books:

  SELECT genre, price FROM BOOK 
  WHERE Stock > 0;
    
-- Find all books under $5 for a given publisher ID:

  SELECT * FROM BOOK B, PUBLISHER P 
  WHERE P.publisher_ID = xx AND B.Publisher_ID = P.Publisher_ID 
  GROUP BY ISBN HAVING price < 5;





