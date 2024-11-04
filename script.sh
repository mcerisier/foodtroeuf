#!/bin/bash

# Création de la structure des dossiers
mkdir -p food_truck_backend
mkdir -p food_truck_frontend

# Création des fichiers Python pour FastAPI
cat <<EOL > food_truck_backend/main.py
from fastapi import FastAPI
from pydantic import BaseModel
from typing import List

app = FastAPI()

# Modèles
class User(BaseModel):
    id: int
    username: str
    email: str
    role: str

class FoodTruck(BaseModel):
    id: int
    name: str
    description: str
    location: str
    availability: str

class Order(BaseModel):
    id: int
    user_id: int
    food_truck_id: int
    order_details: str
    status: str

# Données fictives
users = []
food_trucks = []
orders = []

# Routes Utilisateur
@app.post("/users/", response_model=User)
async def create_user(user: User):
    users.append(user)
    return user

# Routes Food Truck
@app.post("/food_trucks/", response_model=FoodTruck)
async def create_food_truck(food_truck: FoodTruck):
    food_trucks.append(food_truck)
    return food_truck

# Routes Commandes
@app.post("/orders/", response_model=Order)
async def create_order(order: Order):
    orders.append(order)
    return order

@app.get("/orders/{user_id}", response_model=List[Order])
async def get_orders(user_id: int):
    return [order for order in orders if order.user_id == user_id]

# Lancer le serveur avec: uvicorn main:app --reload
EOL

# Création des fichiers HTML, CSS et JavaScript pour le frontend
cat <<EOL > food_truck_frontend/index.html
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Food Truck API - Accueil</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <div class="container">
        <h1>Bienvenue dans le système de gestion des Food Trucks</h1>
        <nav>
            <ul>
                <li><a href="create_user.html">Créer un Utilisateur</a></li>
                <li><a href="create_food_truck.html">Créer un Food Truck</a></li>
                <li><a href="create_order.html">Créer une Commande</a></li>
                <li><a href="order_history.html">Historique des Commandes</a></li>
            </ul>
        </nav>
    </div>
</body>
</html>
EOL

cat <<EOL > food_truck_frontend/create_user.html
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Créer un Utilisateur</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <div class="container">
        <h1>Créer un Utilisateur</h1>
        <form id="userForm">
            <input type="text" id="username" placeholder="Nom d'utilisateur" required>
            <input type="email" id="email" placeholder="Email" required>
            <input type="text" id="role" placeholder="Rôle (student/admin/food truck)" required>
            <input type="password" id="password" placeholder="Mot de passe" required>
            <button type="submit">Créer Utilisateur</button>
        </form>
        <a href="index.html">Retour à l'accueil</a>
    </div>
    <script src="script.js"></script>
</body>
</html>
EOL

cat <<EOL > food_truck_frontend/create_food_truck.html
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Créer un Food Truck</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <div class="container">
        <h1>Créer un Food Truck</h1>
        <form id="foodTruckForm">
            <input type="text" id="foodTruckName" placeholder="Nom du food truck" required>
            <textarea id="foodTruckDescription" placeholder="Description" required></textarea>
            <input type="text" id="foodTruckLocation" placeholder="Emplacement" required>
            <input type="text" id="availability" placeholder="Disponibilité (present/absent)" required>
            <button type="submit">Créer Food Truck</button>
        </form>
        <a href="index.html">Retour à l'accueil</a>
    </div>
    <script src="script.js"></script>
</body>
</html>
EOL

cat <<EOL > food_truck_frontend/create_order.html
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Créer une Commande</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <div class="container">
        <h1>Créer une Commande</h1>
        <form id="orderForm">
            <input type="number" id="userId" placeholder="ID Utilisateur" required>
            <input type="number" id="foodTruckId" placeholder="ID Food Truck" required>
            <textarea id="orderDetails" placeholder="Détails de la commande" required></textarea>
            <input type="text" id="status" placeholder="Statut (pending/confirmed)" required>
            <button type="submit">Créer Commande</button>
        </form>
        <a href="index.html">Retour à l'accueil</a>
    </div>
    <script src="script.js"></script>
</body>
</html>
EOL

cat <<EOL > food_truck_frontend/order_history.html
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Historique des Commandes</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <div class="container">
        <h1>Historique des Commandes</h1>
        <button id="fetchOrders">Afficher les Commandes</button>
        <ul id="orderList"></ul>
        <a href="index.html">Retour à l'accueil</a>
    </div>
    <script src="script.js"></script>
</body>
</html>
EOL

# Création du fichier CSS
cat <<EOL > food_truck_frontend/styles.css
body {
    font-family: Arial, sans-serif;
    background-color: #f4f4f4;
    margin: 0;
    padding: 0;
}

.container {
    max-width: 600px;
    margin: auto;
    padding: 20px;
    background: #fff;
    border-radius: 5px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

h1 {
    text-align: center;
}

nav ul {
    list-style: none;
    padding: 0;
}

nav ul li {
    display: inline;
    margin: 0 10px;
}

form {
    display: flex;
    flex-direction: column;
}

form input, form textarea, form button {
    margin: 10px 0;
    padding: 10px;
}

form button {
    background-color: #007BFF;
    color: white;
    border: none;
    cursor: pointer;
}

form button:hover {
    background-color: #0056b3;
}
EOL

# Création du fichier JavaScript
cat <<EOL > food_truck_frontend/script.js
const API_URL = 'http://127.0.0.1:8000';

// Fonction pour créer un utilisateur
if (document.getElementById('userForm')) {
    document.getElementById('userForm').addEventListener('submit', async (event) => {
        event.preventDefault();
        
        const username = document.getElementById('username').value;
        const email = document.getElementById('email').value;
        const role = document.getElementById('role').value;
        const password = document.getElementById('password').value;

        const response = await fetch(\`\${API_URL}/users/\`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({ username, email, role, password }),
        });

        if (response.ok) {
            alert('Utilisateur créé avec succès');
            document.getElementById('userForm').reset();
        } else {
            alert('Erreur lors de la création de l\'utilisateur');
        }
    });
}

// Fonction pour créer un food truck
if (document.getElementById('foodTruckForm')) {
    document.getElementById('foodTruckForm').addEventListener('submit', async (event) => {
        event.preventDefault();

        const name = document.getElementById('foodTruckName').value;
        const description = document.getElementById('foodTruckDescription').value;
        const location = document.getElementById('foodTruckLocation').value;
        const availability = document.getElementById('availability').value;

        const response = await fetch(\`\${API_URL}/food_trucks/\`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({ name, description, location, availability }),
        });

        if (response.ok) {
            alert('Food Truck créé avec succès');
            document.getElementById('foodTruckForm').reset();
        } else {
            alert('Erreur lors de la création du Food Truck');
        }
    });
}

// Fonction pour créer une commande
if (document.getElementById('orderForm')) {
    document.getElementById('orderForm').addEventListener('submit', async (event) => {
        event.preventDefault();

        const userId = parseInt(document.getElementById('userId').value);
        const foodTruckId = parseInt(document.getElementById('foodTruckId').value);
        const orderDetails = document.getElementById('orderDetails').value;
        const status = document.getElementById('status').value;

        const response = await fetch(\`\${API_URL}/orders/\`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({ user_id: userId, food_truck_id: foodTruckId, order_details: orderDetails, status }),
        });

        if (response.ok) {
            alert('Commande créée avec succès');
            document.getElementById('orderForm').reset();
        } else {
            alert('Erreur lors de la création de la commande');
        }
    });
}

// Fonction pour afficher l'historique des commandes
if (document.getElementById('fetchOrders')) {
    document.getElementById('fetchOrders').addEventListener('click', async () => {
        const userId = prompt("Entrez votre ID Utilisateur :");
        const response = await fetch(\`\${API_URL}/orders/\${userId}\`);

        if (response.ok) {
            const orders = await response.json();
            const orderList = document.getElementById('orderList');
            orderList.innerHTML = '';

            orders.forEach(order => {
                const li = document.createElement('li');
                li.textContent = \`Commande ID: \${order.id}, Détails: \${order.order_details}, Statut: \${order.status}\`;
                orderList.appendChild(li);
            });
        } else {
            alert('Erreur lors de la récupération des commandes');
        }
    });
}
EOL

# Afficher un message de réussite
echo "Le projet Food Truck a été créé avec succès!"
