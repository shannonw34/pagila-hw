/*
 * For each film, show the customer who most recently rented it.
 *
 * HINT:
 * Use the first_value function.
 * The window will include both PARTITION BY and ORDER BY
 */

SELECT DISTINCT
   film.title,
   FIRST_VALUE(customer.customer_id) OVER (
        PARTITION BY film.film_id
        ORDER BY rental.rental_date DESC
   ) AS customer_id,
   FIRST_VALUE(customer.first_name|| ' ' ||customer.last_name) OVER (
        PARTITION BY film.film_id
        ORDER BY rental.rental_date DESC
   ) AS customer_name
FROM film
JOIN inventory
     ON film.film_id = inventory.film_id
JOIN rental
     ON inventory.inventory_id = rental.inventory_id
JOIN customer
     ON rental.customer_id = customer.customer_id
ORDER BY film.title;
