# Yardsi

A flutter application for yard games!

## Getting Started


1. Create a `.env` file like below and place it in the root of the project. Update the `API_URL` to match your environment.

```sh
DEBUG=true
API_URL=http://localhost
```
2. Login with either your user (in production) or use the admin credentials.
    * This assumes you have the API up and running either locally or you are pointing at the production API.
    * Username: admin@example.com
    * Password: admin
3. `flutter run`


## About Flutter

This project is a starting point for a Flutter application.

By default, the application will use the live API at https://api-yardgames.darkmode.live.

To use a local version, run the application with the following argument.

- `flutter run --dart-define=API_URL=http://127.0.0.1:8000`
