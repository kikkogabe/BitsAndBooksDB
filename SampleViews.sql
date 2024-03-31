-- Author sales summary. This generates a table that outlines authors and their sales summary (including number of copies sold and total $).

CREATE VIEW author_sales_summary AS
  SELECT A.Fname, A.Mi, A.Lname, SUM(IC.Quantity) AS copies_sold, SUM(B.Price * IC.Quantity) AS dollar_total
  FROM AUTHOR A, AUTHOR_BOOK AB, IS_CONTAINED IC, BOOK B
  WHERE A.Author_id = AB.AuthorId AND AB.BookID = IC.Book_ID AND AB.BookID = B.ISBN
  GROUP BY A.Author_id
  ORDER BY SUM(B.Price * IC.Quantity) DESC;

-- Genre Sale Summary. This generates a table that outlines genres and their sales summary (including number of copies sold and total $).

CREATE VIEW genre_sale_summary AS
  SELECT B.genre, SUM(IC.Quantity) AS copies_sold, SUM(B.Price * IC.Quantity) AS dollar_total
  FROM BOOK B, IS_CONTAINED IC
  WHERE B.ISBN = IC.Book_ID
  GROUP BY B.Genre
  ORDER BY SUM(IC.Quantity) DESC;
