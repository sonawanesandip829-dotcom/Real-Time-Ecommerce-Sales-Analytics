import mysql.connector
import random
import time
from datetime import datetime

# MySQL connection
connection = mysql.connector.connect(
    host="localhost",
    user="root",
    password="Sandip@123",
    database="realtime_ecommerce"
)

cursor = connection.cursor()

# Sample data
products = [
    ("Laptop", "Electronics", 55000),
    ("Smartphone", "Electronics", 25000),
    ("Headphones", "Electronics", 3000),
    ("Smart Watch", "Electronics", 5000),
    ("Keyboard", "Accessories", 1500),
    ("Mouse", "Accessories", 800),
    ("Backpack", "Fashion", 2000),
    ("Shoes", "Fashion", 3500)
]

customers = [
    "Rahul", "Amit", "Priya", "Sneha", "Neha",
    "Rohit", "Pooja", "Akash", "Vikas", "Kiran"
]

cities = [
    "Pune", "Mumbai", "Nashik", "Nagpur",
    "Aurangabad", "Nanded", "Parbhani"
]

payments = [
    "UPI", "Credit Card", "Debit Card", "Cash on Delivery"
]

statuses = [
    "Processing",
    "Shipped",
    "Delivered",
    "Cancelled"
]

# Get the latest order ID from MySQL
cursor.execute("SELECT MAX(order_id) FROM orders")
result = cursor.fetchone()

if result[0] is None:
    order_id = 1001
else:
    order_id = result[0] + 1


print("Real-Time Order Generator Started...")

while True:

    # Select random data
    customer = random.choice(customers)
    product, category, price = random.choice(products)
    city = random.choice(cities)
    payment = random.choice(payments)
    status = random.choice(statuses)

    quantity = random.randint(1, 3)
    sales = price * quantity

    order_date = datetime.now()

    # Insert order into MySQL
    query = """
    INSERT INTO orders
    (order_id, order_date, customer_id, customer_name,
     product_name, category, quantity, price, sales,
     city, payment_method, order_status)
    VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
    """

    values = (
        order_id,
        order_date,
        random.randint(100, 999),
        customer,
        product,
        category,
        quantity,
        price,
        sales,
        city,
        payment,
        status
    )

    cursor.execute(query, values)
    connection.commit()

    print(
    f"Order {order_id} | "
    f"{product} | "
    f"{city} | "
    f"Rs.{sales} | "
    f"{status}"
)

    order_id += 1

    # Wait 5 seconds
    time.sleep(5)