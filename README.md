# Geektree0101's MVC architecture

In recent years, more and more criticism of the Model-View-Controller pattern (MVC) surfaced and MVC was often blamed for causing too much code in one place and too closely coupled code (“Massive View Controller”). Lots of different patterns were proposed to solve the “MVC-Problem” from MVVM over MVP to VIPER and more. In this talk, we will see that most criticisms of MVC do not really understand what MVC does and does not prescribe. But more importantly, they miss the point: The architecture pattern is not the problem, how we use it is. We will see that other architectures are prone to the same problems as MVC and we will see how to address them in both MVC and other architectures.


Inspired by [Joachim Kurz's MVC is not problem](
https://www.youtube.com/watch?v=A1vzcxR-Ss0)
- [UIKonf18 – Day 1 – Joachim Kurz – MVC is Not Your Problem](
https://www.youtube.com/watch?v=A1vzcxR-Ss0)
- [Apple MVC guide](https://developer.apple.com/library/archive/documentation/General/Conceptual/DevPedia-CocoaCore/MVC.html)
- [Khanlou's MVVM is not very good](http://khanlou.com/2015/12/mvvm-is-not-very-good/)
- [Khanlou's 8 Patterns to Help You Destroy Massive View Controller](http://khanlou.com/2014/09/8-patterns-to-help-you-destroy-massive-view-controller/#smarter-views)


<img src="https://github.com/GeekTree0101/MVC/blob/master/res/screenshot.jpg" />


## Model Controller 
Business logic and data store
```swift

protocol CardDataStore {
  
  var card: Card? { get set }
}

protocol CardModelLogic: class {
  
  func getArticle() -> Promise<Void>
}

class CardModelController: CardDataStore {
  var card: Card?
  
  var service: CardService = .init()
  
}

extension CardModelController: CardModelLogic {
  
  func getArticle() -> Promise<Void> {
    
      return self.service.getCard(cardID)
        .get({ self.card = $0 })
        .asVoid()
  }
}

```

## ViewData Controller
Presentation Logic

```swift
protocol CardViewDataLogic: class {
  
  func cardViewData(error: Error?) -> CardView.ViewData
}

class CardViewDataController {
  
  var dataStore: CardDataStore?
  
}

extension CardViewDataController: CardViewDataLogic {
  
  func cardViewData(error: Error?) -> CardView.ViewData {
    
    if error != nil {

      return CardView.ViewData(
        title: "Error!",
        content: "you got error TT",
        isFollow: false
      )
    }
  
    return CardView.ViewData(
      title: dataStore?.card?.title,
      content: dataStore?.card?.content,
      isFollow: dataStore?.card?.isFollow == true
    )
  }
}
```
