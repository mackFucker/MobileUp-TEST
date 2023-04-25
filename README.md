# **MobileUp-TEST**

### **1.верстка UI.**
+ Создание всех view:
```Swift
class AuthenticationView()
```
```swift
class AuthenticationWebView()
````
```swift
class GalleryView()
```
```swift
class GallerFullScreenView()
```

### **2.Вход в аккаунт [VK](https://vk.com). и работа с [API](https://dev.vk.com/method).**
+ Регистрация в `AuthenticationWebView`.
+ получение токена .
+ Реализация класса для работы с сетью: 
 ```Swift 
   class NetworkManager() {
        func checkToken()
        func getResultStruct()
        func getData()
   }
```
### **3.Работа в Keychain.**
+ Реализация класса для работы с Keychain: 
```Swift 
class KeychainRepository() {
    func saveTokenToKeychain()
    func getTokenFromKeychain()
    func deleteTokenFromKeychain()
}
``` 
  
### **4.Заполнение `GalleryView()` изображениями из [альбома]( https://vk.com/album-128666765_266310117.).**
+ установка [SDWebImage](https://github.com/SDWebImage/SDWebImage).
+ заполнение ячеек колекции.
+ работа с navigationController.
+ Выход из аккаунта с алертом, `func logOutOfYourAccount()`.
  
### **5. Реализация элементарной навигации в `SceneDelegate()`.**
+  проверка токена через API с помощью `func checkToken()` и заруск в зависимости от этого нужного ViewController.

### **6.Заполнение `GallerFullScreenView()` изображеними.**
+ Открытие конкретного фото по тапу на ячейку с фото в `GalleryView`.
  


### **7.Обработка ошибок и добавление алертов.**
+ Ошибка `func share()`.
+ Ошибки с сетью.
    + вход.
    + выход .
    + загрузка фото.
  + ошибка с сохранением фото/успешное сохранение фото.

### **Дополнительные требования:**
+  На ячейки фотографий в коллекции добавить плейсхолдер и/или отображение степени загрузки фотографий, если они еще не скачаны.
+ Добавить приближение фото жестом на экране показа изображения.
+ Добавить горизонтальную ленту с остальными фото на экране просмотра отдельного фото.
+  Добавить локализацию для кнопки входа и алертов с ошибками и информированием об
успешном сохранении.
______
#### [Кихтенко Дэвид](https://t.me/speshyNaSky) 
