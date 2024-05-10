const express = require('express');
const app = express();
const Stripe = require('stripe');
const key = 'sk_test_51PBvPa2LQllEX5HhIrnuxMIsPk64Y2z6YY45Q1I6wTw50JnX9veAt2HaHweo9yuaUzFA5YSehxSdKLEbLOCtLy5c001WHxUX2x';
const stripe = Stripe(key);

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.listen(5050, () => {
    console.log('Listening to port 5050');
});

app.post('/payment', async (req, res) => {
    try {
        const { amount, currency } = req.body;
        const paymentIntent = await stripe.paymentIntents.create({
            amount: amount,
            currency: currency
        });
        
        if (paymentIntent.status === 'requires_confirmation') {
            return res.status(200).json({
                message: 'Confirm Payment Please',
                client_secret: paymentIntent.client_secret
            });
        }
        
        return res.status(200).json({
            message: 'Payment is Completed'
        });
    } catch (error) {
        console.error(error.message);
        return res.status(500).json({
            error: error.message
        });
    }
});
