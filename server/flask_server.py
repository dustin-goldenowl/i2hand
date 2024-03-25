from flask import Flask, request, jsonify
import stripe
from constant_vars import endpoint_secret, db, stripe_keys

app = Flask(__name__)

stripe.api_key = stripe_keys["secret_key"]

@app.route("/stripe-checkout", methods=["POST"])
def stripe_webhook():
    payload = request.get_data(as_text=True)
    id = request.args.get('id')
    print(id)
    sig_header = request.headers.get("Stripe-Signature")

    try:
        event = stripe.Webhook.construct_event(
            payload, sig_header, endpoint_secret
        )

    except ValueError as e:
        # Invalid payload
        return "Invalid payload", 400
    except stripe.error.SignatureVerificationError as e:
        # Invalid signature
        return "Invalid signature", 400

    # Handle the payment_intent.succeeded event
    if event["type"] == "payment_intent.succeeded":
        print("Payment was successful.")
        # TODO: run some custom code here

    return "Success", 200

# main driver function
if __name__ == '__main__':
	app.run()
