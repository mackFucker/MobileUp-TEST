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
```-1 час

### **2.Вход в аккаунт [VK](https://vk.com). и работа с [API](https://dev.vk.com/method).**
+ Регистрация в `AuthenticationWebView`.
+ получение токена . - 30 мин
+ Реализация класса для работы с сетью: -3 часа
 ```Swift 
   class NetworkManager() {
        func checkToken()
        func getResultStruct()
        func getData()
   }
```
### **3.Работа в Keychain.**
+ Реализация класса для работы с Keychain: -1 час 
```Swift 
class KeychainRepository() {
    func saveTokenToKeychain()
    func getTokenFromKeychain()
    func deleteTokenFromKeychain()
}
``` 
  
### **4.Заполнение `GalleryView()` изображениями из [альбома]( https://vk.com/album-128666765_266310117.).**
+ установка [SDWebImage](https://github.com/SDWebImage/SDWebImage). - 5 мин
+ заполнение ячеек колекции. - 10 мин
+ работа с navigationController. - 30 мин
+ Выход из аккаунта с алертом, `func logOutOfYourAccount()`. 1.5 часа
  
### **5. Реализация элементарной навигации в `SceneDelegate()`.**
+  проверка токена через API с помощью `func checkToken()` и заруск в зависимости от этого нужного ViewController.

### **6.Заполнение `GallerFullScreenView()` изображеними.**
+ Открытие конкретного фото по тапу на ячейку с фото в `GalleryView`. - 2 часа
+ создание Share-меню. - 3 часа
+ Вывод даты фото. - 1 час
+ `saveSuccesIndicatorShowAndHide()` - 2 часа

### **7.Обработка ошибок и добавление алертов.**
+ Ошибка `func share()`. - 30 мин
+ Ошибки с сетью. - 3 часа
    + вход.
    + выход .
    + загрузка фото.
  + ошибка с сохранением фото/успешное сохранение фото. - 1.5 часа

### **Дополнительные требования:**
+  На ячейки фотографий в коллекции добавить плейсхолдер и/или отображение степени загрузки фотографий, если они еще не скачаны. - 1 час
+ Добавить приближение фото жестом на экране показа изображения. - 1 час
+ Добавить горизонтальную ленту с остальными фото на экране просмотра отдельного фото. - ??? часов
+  Добавить локализацию для кнопки входа и алертов с ошибками и информированием об - 30 мин
успешном сохранении.
______
#### [Кихтенко Дэвид](https://t.me/speshyNaSky) 
