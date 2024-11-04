# models.py
from sqlalchemy import Column, Integer, String, ForeignKey, Text, Float
from sqlalchemy.orm import relationship
from database import Base

class User(Base):
    __tablename__ = "users"

    id = Column(Integer, primary_key=True, index=True)
    username = Column(String, unique=True, index=True)
    password = Column(String)
    email = Column(String, unique=True, index=True)
    role = Column(String)  # student, admin, food truck

class FoodTruck(Base):
    __tablename__ = "food_trucks"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, index=True)
    description = Column(Text)
    location = Column(String)
    availability = Column(String)  # present or absent

class Menu(Base):
    __tablename__ = "menus"

    id = Column(Integer, primary_key=True, index=True)
    food_truck_id = Column(Integer, ForeignKey("food_trucks.id"))
    item_name = Column(String)
    description = Column(Text)
    price = Column(Float)

    food_truck = relationship("FoodTruck", back_populates="menu_items")

FoodTruck.menu_items = relationship("Menu", back_populates="food_truck", cascade="all, delete-orphan")

class Order(Base):
    __tablename__ = "orders"

    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("users.id"))
    food_truck_id = Column(Integer, ForeignKey("food_trucks.id"))
    order_details = Column(Text)
    status = Column(String)  # confirmed, pending

    user = relationship("User")
    food_truck = relationship("FoodTruck")
