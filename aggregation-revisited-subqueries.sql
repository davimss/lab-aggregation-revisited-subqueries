-- Select the first name, last name, and email address of all the customers who have rented a movie.

SELECT FIRST_NAME, LAST_NAME, EMAIL
FROM SAKILA.CUSTOMER
WHERE ACTIVE = 1;

-- What is the average payment made by each customer (display the customer id, customer name (concatenated), and the average payment made).

SELECT C.CUSTOMER_ID, CONCAT(C.FIRST_NAME, ' ', C.LAST_NAME) AS 'NAME', ROUND(AVG(P.AMOUNT), 2) AS 'AVERAGE PAYMENT'
FROM SAKILA.CUSTOMER C
LEFT JOIN SAKILA.PAYMENT P
ON C.CUSTOMER_ID
GROUP BY 1
ORDER BY 3 DESC;

-- Select the name and email address of all the customers who have rented the "Action" movies.
	-- Write the query using multiple join statements
	-- Write the query using sub queries with multiple WHERE clause and IN condition
	-- Verify if the above two queries produce the same results or not

SELECT DISTINCT CONCAT(C.FIRST_NAME, ' ', C.LAST_NAME) AS 'NAME', C.EMAIL
FROM SAKILA.CUSTOMER C
LEFT JOIN SAKILA.STORE ST
ON C.STORE_ID = ST.STORE_ID
LEFT JOIN SAKILA.INVENTORY INV
ON ST.STORE_ID = INV.STORE_ID
LEFT JOIN SAKILA.FILM F
ON INV.FILM_ID = F.FILM_ID
LEFT JOIN SAKILA.FILM_CATEGORY FC
ON F.FILM_ID = FC.FILM_ID
LEFT JOIN SAKILA.CATEGORY CAT
ON FC.CATEGORY_ID = CAT.CATEGORY_ID
WHERE CAT.NAME = 'ACTION'
ORDER BY 1 DESC;

SELECT CONCAT(FIRST_NAME, ' ', LAST_NAME) AS 'NAME', EMAIL FROM SAKILA.CUSTOMER
WHERE STORE_ID IN(
	SELECT STORE_ID FROM SAKILA.STORE
	WHERE STORE_ID IN (
		SELECT STORE_ID FROM SAKILA.INVENTORY
        WHERE FILM_ID IN (
			SELECT FILM_ID FROM SAKILA.FILM
            WHERE FILM_ID IN (
				SELECT CATEGORY_ID FROM SAKILA.FILM_CATEGORY
                WHERE CATEGORY_ID IN (
					SELECT CATEGORY_ID FROM SAKILA.CATEGORY
					WHERE NAME = 'ACTION')))))
ORDER BY 1 DESC;

-- Use the case statement to create a new column classifying existing columns as either low or high value transactions based on the amount of payment. 
	-- If the amount is between 0 and 2, label should be low and if the amount is between 2 and 4, the label should be medium, 
    -- and if it is more than 4, then it should be high.
    
SELECT *, 
CASE
	WHEN AMOUNT < 2 THEN 'LOW'
	WHEN AMOUNT < 4 THEN 'MEDIUM'
    WHEN AMOUNT > 4 THEN 'HIGH'
END AS 'TRANS_LABEL'
FROM SAKILA.PAYMENT;