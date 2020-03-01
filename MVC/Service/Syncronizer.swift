//
//  Syncronizer.swift
//  MVC
//
//  Created by Geektree0101 on 01/03/2020.
//  Copyright © 2020 Geektree0101. All rights reserved.
//

import Foundation

class Syncronizer {
  
  static let shared = Syncronizer()
  
  private var contexts: [String: (Any?) -> Void] = [:]
  
  public func publish(id: String, model: Any?) {
    contexts.forEach({ target, callback in
      guard id != target else { return }
      callback(model)
    })
  }
  
  public func register(id: String, callback: @escaping (Any?) -> Void) {
    contexts[id] = callback
  }
  
  public func unregister(id: String) {
    contexts[id] = nil
  }
}

protocol Syncronizable {
  
  func isSyncronizable(from value: Self?) -> Bool
}

@propertyWrapper
class Syncronize<T: Syncronizable> {
  
  private var value: T?
  private let id: String
  
  init(value: T?, compare: ((T, T?) -> Bool)? = nil) {
    self.value = value
    self.id = "\(Date().timeIntervalSince1970)"
    Syncronizer.shared.register(id: id, callback: { model in
      guard let newValue = model as? T else { return }
      guard self.value?.isSyncronizable(from: newValue) == true else { return }
      guard compare?(newValue, self.value) ?? true == true else { return }
      self.value = newValue
    })
  }
  
  public func unregisterIfNeeds() {
    Syncronizer.shared.unregister(id: id)
  }
  
  var wrappedValue: T? {
    get {
      return value
    }
    set {
      self.value = newValue
      Syncronizer.shared.publish(id: id, model: value)
    }
  }
}
