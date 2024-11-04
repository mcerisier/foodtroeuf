# crud.py
from sqlalchemy.orm import Session
import models, schemas

def get_user(db: Session, user_id: int):
    return db.query(models.User).filter(models.User.id == user_id).first()

def get_users(db: Session, skip: int = 0, limit: int = 10):
    return db.query(models.User).offset(skip).limit(limit).all()

def create_user(db: Session, user: schemas.UserCreate):
    db_user = models.User(**user.dict())
    db.add(db_user)
    db.commit()
    db.refresh(db_user)
    return db_user

def get_food_truck(db: Session, food_truck_id: int):
    return db.query(models.FoodTruck).filter(models.FoodTruck.id == food_truck_id).first()

def get_food_trucks(db: Session, skip: int = 0, limit: int = 10):
    return db.query(models.FoodTruck).offset(skip).limit(limit).all()

def create_food_truck(db: Session, food_truck: schemas.FoodTruckCreate):
    db_food_truck = models.FoodTruck(**food_truck.dict())
    db.add(db_food_truck)
    db.commit()
    db.refresh(db_food_truck)
    return db_food_truck

def create_menu_item(db: Session, menu_item: schemas.MenuCreate):
    db_menu_item = models.Menu(**menu_item.dict())
    db.add(db_menu_item)
    db.commit()
    db.refresh(db_menu_item)
    return db_menu_item

def create_order(db: Session, order: schemas.OrderCreate):
    db_order = models.Order(**order.dict())
    db.add(db_order)
    db.commit()
    db.refresh(db_order)
    return db_order

def get_orders(db: Session, user_id: int):
    return db.query(models.Order).filter(models.Order.user_id == user_id).all()
