# 🗃️ Movie Dataset Information

This document describes the main tables of the database used for the analysis of movies, revenues, clients and income. 

---

## 🧱 Main tables

### 🎞️ `film`
Contains information about available movies.
- `film_id`: Unique ID of the movie.
- `title`: Title.
- description`: Short description.
- release_year`: Year of release.
- `rental_rate`: Rental price.
- replacement_cost`: Replacement cost.
- length`: Duration in minutes.
- rating`: Rating (G, PG, etc.).

---

### 👥 `customer`.
Registered customer information.
- `customer_id`: Unique ID of the customer.
- `first_name`, `last_name`: Name.
- email`: Email.
- address_id`: Customer address.
- active`: If the client is active (1) or not (0).
- `create_date`: Creation date.

---

### 🎟️ `rental`.
Movie rental records.
- `rental_id`: Rental ID.
- rental_date`: Date and time of rental.
- `return_date`: Return date.
- `inventory_id`: Relationship to the rented movie.
- customer_id`: Customer who rented.
- staff_id`: Employee who performed the operation.

---

### 💳 `payment`. 
Payments made by customers.
- payment_id`: Payment ID.
- `customer_id`: Who paid.
- staff_id`: Employee who paid.
- rental_id`: Associated rent.
- amount`: Amount paid.
- payment_date`: Payment date.

---

### 🗂️ `inventory`: `inventory`.
Relationship between movies and stores.
- inventory_id`: Inventory ID.
- `film_id`: Associated movie.
- `store_id`: Store where it is located.

---

## 🔁 Relationship between tables.

- `film` is related to `inventory` through `film_id`.
- `inventory` is joined to `rental` by `inventory_id`.
- rental` is linked to `payment` by `rental_id`.
- `customer` connects to `rental` and `payment` by `customer_id`.
- `staff` connects to `rental` and `payment` by `staff_id`.

---

👨‍💻 Done by: Miguel Ramirez

