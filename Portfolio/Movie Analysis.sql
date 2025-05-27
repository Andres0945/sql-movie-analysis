-- 1. Most Rented Movies
-- Objetivo: Identificar las películas que han sido rentadas con mayor frecuencia.
SELECT f.title, COUNT(r.rental_id) AS total_rentals
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
GROUP BY f.title
ORDER BY total_rentals DESC
LIMIT 10;




-- 2. Actors in the Most Films
-- Objetivo: Saber qué actores han participado en más películas.
SELECT a.first_name, a.last_name, COUNT(fa.film_id) AS film_count
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id
ORDER BY film_count DESC
LIMIT 10;





-- 3. Revenue by Store
-- Objetivo: Ver cuánto ha generado cada tienda en ingresos.
SELECT i.store_id, SUM(p.amount) AS total_revenue
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
GROUP BY i.store_id;





-- 4. Top Customers by Rentals
-- Objetivo: Conocer los clientes que han rentado más películas.
SELECT c.first_name, c.last_name, COUNT(r.rental_id) AS rentals
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id
ORDER BY rentals DESC
LIMIT 10;





-- 5. Revenue per Category
-- Objetivo: Calcular los ingresos por cada categoría de película.
SELECT cat.name AS category, SUM(p.amount) AS revenue
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category cat ON fc.category_id = cat.category_id
GROUP BY cat.name
ORDER BY revenue DESC;



-- 6. High Replacement Cost Movies
-- Objetivo: Detectar películas con alto costo de reemplazo y que valen la pena rentar.
SELECT f.title, f.replacement_cost, COUNT(r.rental_id) AS total_rentals
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.film_id
HAVING f.replacement_cost > 20 AND COUNT(r.rental_id) > 30
ORDER BY f.replacement_cost DESC;




-- 7. Average Movie Length per Category
-- Objetivo: Saber cuánto duran en promedio las películas por categoría.
SELECT c.name AS category, AVG(f.length) AS avg_length
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY avg_length DESC;




-- 8. Most Popular Rental Days
-- Objetivo: Determinar qué días de la semana hay más rentas.
SELECT TO_CHAR(r.rental_date, 'Day') AS day_of_week, COUNT(*) AS total_rentals
FROM rental r
GROUP BY day_of_week
ORDER BY total_rentals DESC;




-- 9. Top Customers Generating Most Revenue
-- Objetivo: Calcular qué porcentaje de ingresos proviene de los clientes más activos.
WITH revenue_per_customer AS (
    SELECT customer_id, SUM(amount) AS total_spent
    FROM payment
    GROUP BY customer_id
),
total_revenue AS (
    SELECT SUM(total_spent) AS total FROM revenue_per_customer
)
SELECT r.customer_id, r.total_spent,
       ROUND(100.0 * r.total_spent / t.total, 2) AS percentage_of_total
FROM revenue_per_customer r, total_revenue t
ORDER BY r.total_spent DESC
LIMIT 10;




-- 10. Average Time Between Rental and Return
-- Objetivo: Calcular el promedio de días entre la renta y la devolución.
SELECT ROUND(AVG(EXTRACT(EPOCH FROM return_date - rental_date) / 86400.0), 2) AS avg_days_rented
FROM rental
WHERE return_date IS NOT NULL;









