#1
CREATE TABLE Libraries (
  id SERIAL PRIMARY KEY,
  name VARCHAR(20) NOT NULL,
  address VARCHAR(20) NOT NULL
);

#2
CREATE TABLE Customers (
  id SERIAL PRIMARY KEY,
  firstName VARCHAR(20) NOT NULL,
  lastName VARCHAR(20) NOT NULL,
  age INT NOT NULL,
  email VARCHAR(20) NOT NULL,
  address VARCHAR(20) NOT NULL
);

#3
CREATE TABLE Books (
  id SERIAL PRIMARY KEY,
  name VARCHAR(20) NOT NULL,
  genre VARCHAR(20) NOT NULL,
  author VARCHAR(20) NOT NULL,
  customer_id INT,
  isFree BOOLEAN NOT NULL DEFAULT TRUE,
  taken_time TIMESTAMP,
  quantity INT NOT NULL,
  CONSTRAINT customer_dependency FOREIGN KEY (customer_id) REFERENCES Customers(id) ON DELETE SET NULL,
  CONSTRAINT quantity_shold_be_nonnegative CHECK (quantity >= 0)
);


################################################
INSERT INTO Libraries (name, address)
VALUES ('Wroclaw books lib', 'Rynek 345');

INSERT INTO Customers (firstName, lastName, age, email, address)
VALUES ('TOM', 'KRUZZ', 45,'tommycruzzo@sinc.com', 'legnicka 56');

INSERT INTO Books (name, genre, author, customer_id, quantity)
VALUES
  ('BOOK_ONE', 'HORORR', 'AUTHOR_ONE', (SELECT id FROM Customers WHERE firstName = 'TOM' AND lastName = 'KRUZZ'), 100),
  ('BOOK_TWO', 'SIENCE', 'AUTHOR_TWO', (SELECT id FROM Customers WHERE firstName = 'TOM' AND lastName = 'KRUZZ'), 500);
################################################
ALTER TABLE Books
ALTER COLUMN taken_time SET DATA TYPE TIMESTAMPTZ USING taken_time AT TIME ZONE 'UTC';
--------
-- Create a new book with automatic timestamp
INSERT INTO Books (name, genre, author, customer_id, isFree, taken_time, quantity)
VALUES ('Book 4', 'Fantasy', 'Author 4', (SELECT id FROM Customers WHERE firstName = 'TOM' AND lastName = 'KRUZZ'), TRUE, CURRENT_TIMESTAMP, 5);


