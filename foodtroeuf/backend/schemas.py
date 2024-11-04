# schemas.py
from pydantic import BaseModel
from typing import List, Optional

class UserBase(BaseModel):
    username: str
    email: str
    role: str

class UserCreate(UserBase):
    password: str

class User(UserBase):
    id: int

    class Config:
        orm_mode = True

class FoodTruckBase(BaseModel):
    name: str
    description: str
    location: str
    availability: str

class FoodTruckCreate(FoodTruckBase):
    pass

class FoodTruck(FoodTruckBase):
    id: int
    menu_items: List["Menu"] = []

    class Config:
        orm_mode = True

class MenuBase(BaseModel):
    food_truck_id: int
    item_name: str
    description: str
    price: float

class MenuCreate(MenuBase):
    pass

class Menu(MenuBase):
    id: int

    class Config:
        orm_mode = True

class OrderBase(BaseModel):
    user_id: int
    food_truck_id: int
    order_details: str
    status: str

class OrderCreate(OrderBase):
    pass

class Order(OrderBase):
    id: int

    class Config:
        orm_mode = True
