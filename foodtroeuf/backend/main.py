# main.py
from fastapi import FastAPI, Depends, HTTPException
from sqlalchemy.orm import Session
import crud, models, schemas
from database import SessionLocal, engine

# Créer les tables
models.Base.metadata.create_all(bind=engine)

app = FastAPI()

# Dependency pour obtenir une session de base de données
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

# Routes Utilisateur
@app.post("/users/", response_model=schemas.User)
def create_user(user: schemas.UserCreate, db: Session = Depends(get_db)):
    return crud.create_user(db=db, user=user)

@app.get("/users/", response_model=list[schemas.User])
def read_users(skip: int = 0, limit: int = 10, db: Session = Depends(get_db)):
    users = crud.get_users(db, skip=skip, limit=limit)
    return users

# Routes Food Truck
@app.post("/food_trucks/", response_model=schemas.FoodTruck)
def create_food_truck(food_truck: schemas.FoodTruckCreate, db: Session = Depends(get_db)):
    return crud.create_food_truck(db=db, food_truck=food_truck)

@app.get("/food_trucks/", response_model=list[schemas.FoodTruck])
def read_food_trucks(skip: int = 0, limit: int = 10, db: Session = Depends(get_db)):
    food_trucks = crud.get_food_trucks(db, skip=skip, limit=limit)
    return food_trucks

# Routes Menu
@app.post("/menus/", response_model=schemas.Menu)
def create_menu_item(menu_item: schemas.MenuCreate, db: Session = Depends(get_db)):
    return crud.create_menu_item(db=db, menu_item=menu_item)

# Routes Commandes
@app.post("/orders/", response_model=schemas.Order)
def create_order(order: schemas.OrderCreate, db: Session = Depends(get_db)):
    return crud.create_order(db=db, order=order)

@app.get("/orders/{user_id}", response_model=list[schemas.Order])
def read_orders(user_id: int, db: Session = Depends(get_db)):
    orders = crud.get_orders(db, user_id=user_id)
    return orders

