import XCTest
import PromiseKit
@testable import MVC

class CardViewDataControllerTests: XCTestCase {
  
  struct StubDataStore: CardDataStore {

    var cardID: Int = -1
    var card: Card?
  }
  
  class MockCardViewDataController: CardViewDataController {
    
  }
  
  var mockCardViewDataController: MockCardViewDataController!
  
  override func setUp() {
    mockCardViewDataController = MockCardViewDataController()
    super.setUp()
  }
  
}

// MARK: - CardViewData

extension CardViewDataControllerTests {
  
  func test_should_be_mapping_card_view_data() {
    // given
    self.mockCardViewDataController.dataStore = StubDataStore(
      cardID: 1,
      card: Card(
        id: 1,
        title: "hello",
        content: "world",
        isFollow: true
      )
    )
    
    // when
    let viewData = self.mockCardViewDataController.cardViewData(error: nil)
    
    // then
    XCTAssertEqual(viewData.content, "world")
    XCTAssertEqual(viewData.isFollow, true)
    XCTAssertEqual(viewData.title, "hello")
  }
}
