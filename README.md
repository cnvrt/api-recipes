# Recipe RESTful API with MongoDB

This RESTful API allows you to manage recipes and their ratings using PHP and MongoDB. The API supports basic CRUD operations and allows for searching and rating recipes.

---

Make sure to replace the MongoDB connection and setup information with your actual credentials and details. This README should provide enough documentation for others to easily use and understand my API.

---

## For Dockerfile 
First create `MONGO_USER` & `MONGO_PASS` from your mongodb atlas Account 
Then add it in your server's Secrets/.env or add it in `$mongoUri` string of /index.php (e.g., 
`$mongoUri = "mongodb+srv://user123:pass123@cluster0.i2re1dg.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0";` ,
`$mongoUri = "mongodb://user123:pass123@localhost:27017/mydatabase";`
). 

```
$ docker build -t my-image .
$ docker run -p 4000:80 my-image
```
Then follow the 6th step of [Installation](#Installation)

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
    $ git clone https://github.com/cnvrt/api-recipes.git
    $ cd recipe-api
    ```

2. Install dependencies:

    ```bash
    $ composer install
    ```

3. Set up your MongoDB connection:

    Create an `.env` file and add your MongoDB credentials:

    ```sh
    MONGO_USER=your_username
    MONGO_PASS=your_password
    ```

4. Run the API:

    You can use PHP's built-in server for local testing:

    ```bash
    $ php -S localhost:8000
    ```

5. If the PHP `mongodb` extension is not enabled:

    **For Windows:**

    1. Download the extension from [![mongodb php extension](https://pecl.php.net/img/windows-icon.png)][mongodb-php-extension]/latest/your-php-version/.

    ```bash
    $ php -i | findstr /C:"extension_dir"
    extension_dir => \xampp\php\ext => \xampp\php\ext
    ```
    
    2. Unzip the downloaded file and move `php_mongodb.dll` to the directory received from the command above (e.g., `C:\xampp\php\ext\`). 

    ```bash
    $ php --ini
    Configuration File (php.ini) Path:
    Loaded Configuration File:         C:\xampp\php\php.ini
    $ echo extension=php_mongodb.dll >> C:/xampp/php/php.ini
    ```

    **For Linux:** 

    ```bash
    $ apt-get update
    $ pecl install mongodb
    $ php --ini
    Configuration File (php.ini) Path: /usr/local/php/8.2.13/ini
    Loaded Configuration File:         /usr/local/php/8.2.13/ini/php.ini
    $ echo extension=mongodb.so >> /usr/local/php/8.2.13/ini/php.ini
    ```

6. If you are using MongoDB Atlas, whitelist your server's IP address:

    1. Open `http://localhost:8000/ip.php` and copy the IP address from the page.

    2. Paste the IP address into the Network Access section of your MongoDB Atlas configuration.


---

## Endpoints

### GET /

Returns an empty body.

#### Example Request:

```sh
GET / HTTP/1.1
Host: localhost:8000
```

---

### GET /recipes

Retrieves all the recipes stored in the MongoDB database.

#### Example Request:

```sh
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

```sh
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

```sh
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

```sh
PUT /recipes/64f1f9cbe25b43d3446789bf HTTP/1.1
Host: localhost:8000
Content-Type: application/json

{
  "name": "Blueberry Pancakes",
  "ingredients": ["flour", "milk", "eggs", "blueberries"]
}
```

#### Example Response:

```json
{
  "message": "Recipe updated"
}
```

---

### DELETE /recipes/{id}

Deletes a recipe by its id.

#### Example Request:

```sh
DELETE /recipes/64f1f9cbe25b43d3446789bf HTTP/1.1
Host: localhost:8000
```

#### Example Response:

```json
{
  "message": "Recipe deleted"
}
```

---

### POST /recipes/{id}/rating

Adds a rating to a recipe.

#### Example Request:

```sh
POST /recipes/64f1f9cbe25b43d3446789bf/rating HTTP/1.1
Host: localhost:8000
Content-Type: application/json

{
  "rating": 5,
  "comment": "Delicious and easy to make!"
}
```
#### Example Response:

```json
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

```sh
GET /search?q=pancakes HTTP/1.1
Host: localhost:8000
```

#### Example Response:

```json
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

```bash
$ curl -X POST http://localhost:8000/recipes -H "Content-Type: application/json" -d '{"name": "Pancakes", "ingredients": ["flour", "milk", "eggs"], "instructions": "Mix ingredients. Cook on medium heat."}'
```

### Get All Recipes

```bash
$ curl http://localhost:8000/recipes
```

### Search for Recipes
```bash
$ curl http://localhost:8000/search?q=pancakes
```

---

Make sure to replace the MongoDB connection and setup information with your actual credentials and details. This README should provide enough documentation for others to easily use and understand my API.

---

### License
This project is open-source and available under the MIT License.


[mongodb-php-extension]: https://pecl.php.net/package/mongodb
