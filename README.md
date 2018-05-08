# MI-AFP homework #10

Homework to create simple reactive currency convertor

## Task 

Your task is to create frontend application for currency converter. Conversion rates and supported currencies are provided by backend via simple API that is prepared for you online.

- Create simple page with labeled input boxes for each currency supported by given API (it can change!), start with amount 1 in first currency type.
- When user edits amount in any field, other will be recalculated.
- Every five seconds are rates updated and boxes recalculated, it can be turned on/off by button.
- Using some CSS (framework) is optional but would be nice...

You can use any Haskell or Haskell-like technology for frontend that was introduced in the tutorial. We highly recommend to use Elm and practice the Model-Update-View architecture.

### API

Visit: https://dummy-currency-api.herokuapp.com

API key is the sha1 hash of string *MI-AFP* (you can use http://www.sha1-online.com, we don't want to make it totally public).

### Setup

1) In project directory, copy the `.env-default` into `.env` file
2) In `.env`, fill in your environment cofiguration
2) Run `yarn install`
3) Run `yarn dev`, the app is now running at `localhost:7000`

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE)
file for more details.

