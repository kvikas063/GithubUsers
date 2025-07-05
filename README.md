
# 🧑🏻‍💻 GitHubUsers

A simple iOS app to find **Git** users for everyone, built with UIKit in Swift.

## 📦 Screens/Modules:

## 1. Welcome
There are two options to proceed.


#### 1. Proceed with Login
    Set Github personal access token from Constant file to Token Manager.
    Add your GitHub personal toke while running the project.

**Note:** `Token` is removed during commit due to github push protection policy.

#### 2. Continue as Guest
    Continue as guest without access token.

### 2. Users List
Fetch and show github users from `users` api.

It shows `Logout` button on top bar for logout functionality and takes the user to login screen. 
It has `reload` button to retry and reload users from above api.

It also handles error case in case of no availabe users found.

#### Search Users
There is a search field to search users from `search/users` api

### 3. User Detail
Fetch and show user detail and repositories from `users/<id>` and `users/\(id)/repos` api.

    Select any repository card will take you to repostory web page.

It also handles error case in case of no availabe users found.

---

#### Token Manager
    It handles access token for login
#### Network Manager
    It handles all network request.

### Unit Tests
This contains all the unit test cases of view models for all the modules 

### Architecture: 
MVVM (Model-View-ViewModel) architecture design is used, to implement this project and can be scaled too, using module based structure.

## 🚀 Features
- **Custome Loading Indicator**
- **Network Monitoring**
- **Image Downloader and Caching**
- **Error Label**

---

## 📸 Preview

|              Light Mode Demo              |             Dark Mode Demo               |
| ----------------------------------------- | ---------------------------------------- |
| ![GitHub Users Demo](GithubUsers/GithubUsers/Resources/light.gif) | ![GitHub Users Demo](GithubUsers/GithubUsers/Resources/dark.gif) |


---

## 🧾 License

This project is open-sourced under the **MIT License**. Feel free to use, modify, and contribute.

---

## 🙌 Author

Created with ❤️ by [@VikasKumar](https://www.linkedin.com/in/vikaskumar063/)

🔗 GitHub: [https://github.com/kvikas063](https://github.com/kvikas063)

---
