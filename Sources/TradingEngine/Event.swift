class Event<T> {
  public typealias EventHandler = (T) -> Void
  fileprivate var eventHandlers = Array<Invocable>()
  
  public var handlersCount:Int {
    return eventHandlers.count
  }
  
  public func raise(data: T) {
    for handler in self.eventHandlers {
      handler.invoke(data:data)
    }
  }
  
  public func addHandler(_ handler:@escaping EventHandler) -> Disposable {
    let wrapper = EventHandlerWrapper(handler: handler, event: self)
    eventHandlers.append(wrapper)
    return wrapper
  }
  
}

internal class EventHandlerWrapper<T>:Disposable, Invocable {
  let handler: (T) -> Void
  let event: Event<T>
  
  init(handler:@escaping (T) -> Void, event:Event<T>) {
    self.handler = handler
    self.event = event
  }
  
  func invoke(data: Any) -> () {
    guard let handlerData = data as? T else {
      fatalError("Invalid data type:\(type(of:data))  Expected type:\(T.self)")
    }
    handler(handlerData)
  }
  
  func dispose() {
    event.eventHandlers = event.eventHandlers.filter { $0 !== self }
  }
}
