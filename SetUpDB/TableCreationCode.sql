CREATE TABLE AUTHOR( 
	Author_ID	INT		NOT NULL,
	Fname		VARCHAR(30)	NOT NULL,
	Mi		CHAR(1),
	Lname		VARCHAR(30)	NOT NULL,
	PRIMARY KEY(Author_ID)
);

CREATE TABLE "PUBLISHER" (
	"Publisher_ID"	INT 		NOT NULL,
	"Name"		VARCHAR(15) 	NOT NULL,
	"Address"	VARCHAR(50),
	"PNum"		INT,
	PRIMARY KEY("Publisher_ID")
);

CREATE TABLE "BOOK" (
	"ISBN"		VARCHAR(13) 	NOT NULL,
	"Pub_Date"	DATE,
	"Price"		DECIMAL(10, 2) 	NOT NULL,
	"Stock"		NUMERIC 	NOT NULL,
	"Title"		VARCHAR(1000) 	NOT NULL,
	"Genre"		VARCHAR(30),
	"Publisher_ID"	INT,
	PRIMARY KEY("ISBN"),
	FOREIGN KEY("Publisher_ID") REFERENCES "PUBLISHER"("Publisher_ID")
);

CREATE TABLE AUTHOR_BOOK (
	AuthorID 	INT,
	BookID 		VARCHAR(13),
	PRIMARY KEY (AuthorID, BookID),
	FOREIGN KEY (AuthorID) REFERENCES AUTHOR(Author_ID),
	FOREIGN KEY (BookID) REFERENCES BOOK(ISBN)
);

CREATE TABLE CUSTOMER( 
	Cust_ID 	INT,
	Fname		VARCHAR(15)	NOT NULL,
	Mi		CHAR(1),
	Lname		VARCHAR(30)	NOT NULL,
	Bill_addr	VARCHAR(50)	NOT NULL,
	Ship_addr	VARCHAR(50)	NOT NULL,	
	PNum		INT,
	Email		VARCHAR(50)	NOT NULL,
	PRIMARY KEY(Cust_ID)
);

CREATE TABLE CC_INFO( 
	Cust_ID 	INT,
	CC		CHAR(16)	NOT NULL,
	CVV		CHAR(3)		NOT NULL,
	Exp		CHAR(5)		NOT NULL,
	FOREIGN KEY("Cust_ID") REFERENCES "CUSTOMER" ("Cust_ID")
);

CREATE TABLE IS_CONTAINED ( 
	Order_ID	INT,
	Book_ID		VARCHAR(13),
	Quantity	INT,
	PRIMARY KEY(Order_ID, Book_ID),
	FOREIGN KEY(Order_ID) REFERENCES ORDERS(Order_ID),
	FOREIGN KEY(Book_ID) REFERENCES BOOK(ISBN)
);

CREATE TABLE ORDERS ( 
	Order_ID	INT,
	Customer_ID	INT	NOT NULL,
	Order_Date	DATE	NOT NULL,
	Delivery_Date	DATE	NOT NULL,
	PRIMARY KEY(Order_ID),
	FOREIGN KEY(Customer_ID) REFERENCES CUSTOMER(Cust_ID)
);

CREATE TABLE REVIEW ( 
	Stars		INT	NOT NULL,
	Date		DATE	NOT NULL,
	Customer_ID	INT,
	Book_ID		VARCHAR(13) 	NOT NULL,
	PRIMARY KEY(Customer_ID, Book_ID),
	FOREIGN KEY(Customer_ID) REFERENCES CUSTOMER(Cust_ID),
	FOREIGN KEY(Book_ID) REFERENCES BOOK(ISBN)
);
