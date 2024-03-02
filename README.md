
# ChatPaLM

A Flutter project that enables you to access the PaLM API from a Flutter application. In order to use ChatPaLM, you need to get an API Key from [aistudio.google.com](https://aistudio.google.com/). Once you have the key, you can paste it in the profile section of the application and start writing prompts from within the application.

https://medium.com/google-cloud/introducing-chatpalm-b11ed75f083f

# Demo


https://github.com/darshmashru/ChatPaLM/assets/70889682/08ecb8de-bf04-491a-a275-31942ab609a6




## Deployment

To run this project we have to first create a .env file in the root directory

```bash
  git clone https://github.com/darshmashru/ChatPaLM.git
```

```bash
  touch .env
```

Add Your Enviornment Variables 

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `PALM_API_KEY` | `string` | **Required**. Your API key |
| `FIREBASE_WEB` | `string` | **Required**. Your Firebase Web API key |
| `FIREBASE_IOS` | `string` | **Required**. Your Firebase IOS API key |
| `FIREBASE_ANDROID` | `string` | **Required**. Your Firebase Android API key |
| `FIREBASE_MACOS` | `string` | **Required**. Your Firebase MACOS API key |

Your final file would look like 
```bash
PALM_API_KEY = YOUR_API_KEY
FIREBASE_WEB = YOUR_API_KEY
FIREBASE_ANDROID = YOUR_API_KEY
FIREBASE_IOS = YOUR_API_KEY
FIREBASE_MACOS = YOUR_API_KEY
```


Finally , To Run The Application

```bash
Flutter Run
```



## Screenshots

<div align="center">
  <img src="https://demochatpalm.s3.eu-north-1.amazonaws.com/chatpalm1.png" alt="Screenshot 1" width="200"/>
  <img src="https://demochatpalm.s3.eu-north-1.amazonaws.com/chatpalm2.png" alt="Screenshot 2" width="200"/>
</div>

<div align="center">
  <img src="https://demochatpalm.s3.eu-north-1.amazonaws.com/chatpalm3.png" alt="Screenshot 3" width="200"/>
  <img src="https://demochatpalm.s3.eu-north-1.amazonaws.com/chatpalm4.png" alt="Screenshot 4" width="200"/>
</div>



## Authors

- [@darshmashru](https://www.github.com/darshmashru)
- [@prabirkalwani](https://www.github.com/prabirkalwani)
- [@vedantheda](https://www.github.com/vedantheda)

