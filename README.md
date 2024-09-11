# Recipe RESTful API with MongoDB

This RESTful API allows you to manage recipes and their ratings using PHP and MongoDB. The API supports basic CRUD operations and allows for searching and rating recipes.

## Table of Contents

- [Setup](#setup)
- [Endpoints](#endpoints)
  - [GET /](#get-)
  - [GET /recipes](#get-recipes)
  - [POST /recipes](#post-recipes)
  - [GET /recipes/{id}](#get-recipesid)
  - [PUT/PATCH /recipes/{id}](#putpatch-recipesid)
  - [DELETE /recipes/{id}](#delete-recipesid)
  - [POST /recipes/{id}/rating](#post-recipesidrating)
  - [GET /search?q=](#get-searchq)
  
- [Examples](#examples)

---

## Setup

### Prerequisites

- PHP 7.x or higher
- MongoDB server or MongoDB Atlas
- Composer (for dependencies)

### Installation

1. Clone the repository:

    ```bash
    git clone https://github.com/cnvrt/api-recipes.git
    cd recipe-api
    ```

2. Install dependencies using Composer:

    ```bash
    composer install
    ```

3. Set up your MongoDB connection:

    Create an `.env` file and add your MongoDB credentials:

    ```bash
    MONGO_USER=your_username
    MONGO_PASS=your_password
    ```

4. Run the API:

    You can use PHP's built-in server for local testing:

    ```bash
    php -S localhost:8000
    ```

---

## Endpoints

### GET /

Returns an empty body.

#### Example Request:

```bash
GET / HTTP/1.1
Host: localhost:8000
```

---

### GET /recipes

Retrieves all the recipes stored in the MongoDB database.

#### Example Request:

```bash
GET /recipes HTTP/1.1
Host: localhost:8000
```

#### Example Response:

```json
[
  {
    "_id": "64f1f9cbe25b43d3446789bc",
    "name": "Spaghetti Carbonara",
    "ingredients": ["spaghetti", "eggs", "bacon", "cheese"],
    "instructions": "Boil pasta. Fry bacon. Mix eggs with cheese. Combine all."
  },
  {
    "_id": "64f1f9d2e25b43d3446789bd",
    "name": "Chicken Alfredo",
    "ingredients": ["chicken", "pasta", "cream", "cheese"],
    "instructions": "Cook pasta and chicken. Combine with cream and cheese."
  }
]
```

---

### POST /recipes

Adds a new recipe to the database.

#### Example Request:

```bash
POST /recipes HTTP/1.1
Host: localhost:8000
Content-Type: application/json

{
  "name": "Pancakes",
  "ingredients": ["flour", "milk", "eggs"],
  "instructions": "Mix ingredients. Cook on medium heat."
}
```

#### Example Response:

```json
{
  "message": "Recipe created",
  "_id": "64f1f9cbe25b43d3446789bf",
  "data": {
    "name": "Pancakes",
    "ingredients": ["flour", "milk", "eggs"],
    "instructions": "Mix ingredients. Cook on medium heat."
  }
}
```

---

### GET /recipes/{id}

Fetches a single recipe by its id.

#### Example Request:

```bash
GET /recipes/64f1f9cbe25b43d3446789bf HTTP/1.1
Host: localhost:8000
```

#### Example Response:

```json
{
  "_id": "64f1f9cbe25b43d3446789bf",
  "name": "Pancakes",
  "ingredients": ["flour", "milk", "eggs"],
  "instructions": "Mix ingredients. Cook on medium heat."
}
```

---

### PUT/PATCH /recipes/{id}

Updates an existing recipe.

#### Example Request:

```
PUT /recipes/64f1f9cbe25b43d3446789bf HTTP/1.1
Host: localhost:8000
Content-Type: application/json

{
  "name": "Blueberry Pancakes",
  "ingredients": ["flour", "milk", "eggs", "blueberries"]
}
```

#### Example Response:

```
{
  "message": "Recipe updated"
}
```

---

### DELETE /recipes/{id}

Deletes a recipe by its id.

#### Example Request:

```
DELETE /recipes/64f1f9cbe25b43d3446789bf HTTP/1.1
Host: localhost:8000
```

#### Example Response:

```
{
  "message": "Recipe deleted"
}
```

---

### POST /recipes/{id}/rating

Adds a rating to a recipe.

#### Example Request:

```
POST /recipes/64f1f9cbe25b43d3446789bf/rating HTTP/1.1
Host: localhost:8000
Content-Type: application/json

{
  "rating": 5,
  "comment": "Delicious and easy to make!"
}
```
#### Example Response:

```
{
  "message": "Rating added",
  "data": {
    "recipe_id": "64f1f9cbe25b43d3446789bf",
    "rating": 5,
    "comment": "Delicious and easy to make!"
  }
}
```

---

### GET /search?q=

Search for recipes by name. The search is case-insensitive.

#### Example Request:

```
GET /search?q=pancakes HTTP/1.1
Host: localhost:8000
```

#### Example Response:

```
[
  {
    "_id": "64f1f9cbe25b43d3446789bf",
    "name": "Pancakes",
    "ingredients": ["flour", "milk", "eggs"],
    "instructions": "Mix ingredients. Cook on medium heat."
  }
]
```

---

## Examples
### Create a Recipe

```
curl -X POST http://localhost:8000/recipes \
  -H "Content-Type: application/json" \
  -d '{"name": "Pancakes", "ingredients": ["flour", "milk", "eggs"], "instructions": "Mix ingredients. Cook on medium heat."}'
```

### Get All Recipes

```
curl http://localhost:8000/recipes
```

### Search for Recipes
```
curl http://localhost:8000/search?q=pancakes
```

---

Make sure to replace the MongoDB connection and setup information with your actual credentials and details if necessary. This README should provide enough documentation for others to easily use and understand your API.

---

### License
This project is open-source and available under the MIT License.
