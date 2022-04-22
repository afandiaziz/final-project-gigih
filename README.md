![Logo](https://www.anakbangsabisa.org/generasi-gigih/assets/gengigih-logo.png)

# Family Catering - Final Project Backend

Web API [berdasarkan 7 user story problem statement](https://github.com/afandiaziz/final-project-gigih/blob/main/GG_2.0_Back_End_Class_Final_Project.pdf). Web API ini dibangun menggunakan framework Ruby on Rails dan database SQLite3. API tersebut diantaranya

### Customers

```http
  GET /customers
```

```http
  GET /customers/${id}
```

| Parameter | Type      | Description |
| :-------- | :-------- | :---------- |
| `id`      | `integer` | _Optional_  |

```http
  POST /customers
```

| Parameter | Type     | Description  |
| :-------- | :------- | :----------- |
| `name`    | `string` | **Required** |
| `email`   | `string` | **Required** |
| `phone`   | `string` | **Required** |

```http
  PUT /customers/${id}
```

| Parameter | Type      | Description  |
| :-------- | :-------- | :----------- |
| `id`      | `integer` | **Required** |
| `name`    | `string`  | _Optional_   |
| `email`   | `string`  | _Optional_   |
| `phone`   | `string`  | _Optional_   |

```http
  DELETE /customers/${id}
```

| Parameter | Type      | Description  |
| :-------- | :-------- | :----------- |
| `id`      | `integer` | **Required** |

### Categories

```http
  GET /categories
```

```http
  GET /categories/${id}
```

| Parameter | Type      | Description |
| :-------- | :-------- | :---------- |
| `id`      | `integer` | _Optional_  |

```http
  POST /categories
```

| Parameter | Type     | Description  |
| :-------- | :------- | :----------- |
| `name`    | `string` | **Required** |

```http
  PUT /categories/${id}
```

| Parameter | Type      | Description  |
| :-------- | :-------- | :----------- |
| `id`      | `integer` | **Required** |
| `name`    | `string`  | _Optional_   |

```http
  DELETE /categories/${id}
```

| Parameter | Type      | Description  |
| :-------- | :-------- | :----------- |
| `id`      | `integer` | **Required** |

### Menu Item Categories

```http
  GET /item_categories
```

```http
  GET /item_categories/${id}
```

| Parameter | Type      | Description |
| :-------- | :-------- | :---------- |
| `id`      | `integer` | _Optional_  |

```http
  POST /item_categories
```

| Parameter     | Type      | Description  |
| :------------ | :-------- | :----------- |
| `category_id` | `integer` | **Required** |
| `item_id`     | `integer` | **Required** |

```http
  PUT /item_categories/${id}
```

| Parameter     | Type      | Description  |
| :------------ | :-------- | :----------- |
| `id`          | `integer` | **Required** |
| `category_id` | `integer` | _Optional_   |
| `item_id`     | `integer` | _Optional_   |

```http
  DELETE /item_categories/${id}
```

| Parameter | Type      | Description  |
| :-------- | :-------- | :----------- |
| `id`      | `integer` | **Required** |

### Menu Items

```http
  GET /menu_items
```

```http
  GET /menu_items/${id}
```

| Parameter | Type      | Description |
| :-------- | :-------- | :---------- |
| `id`      | `integer` | _Optional_  |

```http
  POST /menu_items
```

| Parameter     | Type     | Description  |
| :------------ | :------- | :----------- |
| `name`        | `string` | **Required** |
| `price`       | `float`  | **Required** |
| `description` | `string` | _Optional_   |

```http
  PUT /menu_items/${id}
```

| Parameter     | Type      | Description  |
| :------------ | :-------- | :----------- |
| `id`          | `integer` | **Required** |
| `name`        | `string`  | _Optional_   |
| `price`       | `float`   | _Optional_   |
| `description` | `string`  | _Optional_   |

```http
  DELETE /menu_items/${id}
```

| Parameter | Type      | Description  |
| :-------- | :-------- | :----------- |
| `id`      | `integer` | **Required** |

### Orders

```http
  GET /orders
```

```http
  GET /orders/${id}
```

| Parameter | Type      | Description |
| :-------- | :-------- | :---------- |
| `id`      | `integer` | _Optional_  |

```http
  POST /orders
```

| Parameter     | Type      | Description  |
| :------------ | :-------- | :----------- |
| `customer_id` | `integer` | **Required** |

```http
  PUT /orders/${id}
```

| Parameter | Type      | Description  |
| :-------- | :-------- | :----------- |
| `id`      | `integer` | **Required** |
| `status`  | `string`  | _Optional_   |

### Order Details

```http
  GET /order_details
```

```http
  GET /order_details/${id}
```

| Parameter | Type      | Description |
| :-------- | :-------- | :---------- |
| `id`      | `integer` | _Optional_  |

```http
  POST /order_details
```

| Parameter      | Type      | Description  |
| :------------- | :-------- | :----------- |
| `order_id`     | `integer` | **Required** |
| `menu_item_id` | `integer` | **Required** |
| `quantity`     | `integer` | **Required** |
| `price`        | `float`   | **Required** |

### Report

```http
  GET /report
```

| Parameter    | Type     | Description |
| :----------- | :------- | :---------- |
| `date_start` | `date`   | _Optional_  |
| `date_end`   | `date`   | _Optional_  |
| `price`      | `float`  | _Optional_  |
| `email`      | `string` | _Optional_  |

### Orders Exceed the Limit

```http
  PUT /orders-exceed-limit
```

[![Run in Postman](https://run.pstmn.io/button.svg)](https://app.getpostman.com/run-collection/5427578-04d7534f-d5dc-4d22-88b5-63e81ac3d49f?action=collection%2Ffork&collection-url=entityId%3D5427578-04d7534f-d5dc-4d22-88b5-63e81ac3d49f%26entityType%3Dcollection%26workspaceId%3D58e3854c-57d6-4dff-9586-aee7db494bff)

Serta terdapat Unit Testing Models dan Requests dengan 139 Test Case

```
Finished in 10.67 seconds (files took 7.5 seconds to load)
139 examples, 0 failures
```

## Installation

#### To run this project

```
bundle install
ruby bin/rails server
```

#### Don't forget to migrate and seeds

```
rails db:migrate
rails db:seed
```

#### Run Unit Testing

```
bundle exec rspec -fd
```

##

[![linkedin](https://img.shields.io/badge/linkedin-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/afandiaziz/)
