import XCTest
@testable import SDL
@testable import SDL_gfx

final class SDL_gfx_Tests: XCTestCase {
    func testFramerate() {
        var framerateManager = FPSmanager()
        SDL_initFramerate(&framerateManager)
        let frameCount = SDL_getFramecount(&framerateManager)
        XCTAssertEqual(frameCount, 0)
    }
}
