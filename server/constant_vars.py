from dotenv import load_dotenv
import firebase_admin
from firebase_admin import credentials, firestore
import stripe
import os

load_dotenv()

cred = credentials.Certificate("key.json")
firebase_admin.initialize_app(cred)

db=firestore.client()

stripe_keys = {
    "secret_key": os.getenv("SECRET_KEY"),
    "publishable_key": os.getenv("PUBLISHABLE_KEY"),
}

endpoint_secret = os.getenv("ENDPOINT_SECRET")
