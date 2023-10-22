# ChatPaLM

## Introduction :-

A Flutter project that enables you to access the PaLM API from a Flutter application. In order to use ChatPaLM, you need to get an API Key from makersuite.google.com.
Once you have the key, you can paste it in the profile section of the application and start writing prompts from within the application.

## API Reference

#### SET UP YOUR ENVIORNMENT VARIABLES

Create a .env file in the project root when you clone this repo and insert
the following:-

```http
touch .env
```

```http
vim .env
```

| Parameter      | Type     | Description                               |
| :------------- | :------- | :---------------------------------------- |
| `PALM_API_KEY` | `string` | **Required**. Your API key For PaLM Model |

| Parameter      | Type     | Description                             |
| :------------- | :------- | :-------------------------------------- |
| `FIREBASE_WEB` | `string` | **Required**. API Key For Firebase Auth |

| Parameter      | Type     | Description                             |
| :------------- | :------- | :-------------------------------------- |
| `FIREBASE_IOS` | `string` | **Required**. API Key For Firebase Auth |

| Parameter        | Type     | Description                             |
| :--------------- | :------- | :-------------------------------------- |
| `FIREBASE_MACOS` | `string` | **Required**. API Key For Firebase Auth |

| Parameter          | Type     | Description                             |
| :----------------- | :------- | :-------------------------------------- |
| `FIREBASE_ANDROID` | `string` | **Required**. API Key For Firebase Auth |

Your Final File Would Look Like :-

```http
PALM_API_KEY = YOUR_API_KEY

FIREBASE_WEB = YOUR_API_KEY

FIREBASE_ANDROID = YOUR_API_KEY

FIREBASE_IOS = YOUR_API_KEY

FIREBASE_MACOS = YOUR_API_KEY

```

## Demonstration

## Authors

- [@Darsh Mashru](https://www.github.com/darshmashru)
- [@Prabir Kalwani](https://www.github.com/prabirkalwani)
