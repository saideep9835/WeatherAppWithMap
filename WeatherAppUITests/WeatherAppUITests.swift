import XCTest
import MapKit

final class WeatherAppUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    func testSearchWeatherForCity() throws {
        let cityTextField = app.textFields["cityTextField"]
        let stateCodeTextField = app.textFields["stateCodeTextField"]
        let countryCodeTextField = app.textFields["countryCodeTextField"]
        let searchButton = app.buttons["button"] // Assuming you have a search button with this ID

        // Type city, state code, and country code
        cityTextField.tap()
        cityTextField.typeText("Arizona")

        stateCodeTextField.tap()
        stateCodeTextField.typeText("200")

        countryCodeTextField.tap()
        countryCodeTextField.typeText("300")

        // Tap the search button
        searchButton.tap()

        // Assert that the state name label is updated
        let stateNameLabel = app.staticTexts["stateNameLabel"]
        XCTAssertTrue(stateNameLabel.exists, "State name label should exist")
        //XCTAssertEqual(stateNameLabel.label, "Name of State: Arizona")

        // Assert that the temperature label is updated
        let temperatureLabel = app.staticTexts["temperatureLabel"]
        XCTAssertTrue(temperatureLabel.exists, "Temperature label should exist")
        XCTAssertNotEqual(temperatureLabel.label, "", "Temperature label should not be empty")

        // Assert that the description label is updated
        let descriptionLabel = app.staticTexts["descriptionLabel"]
        XCTAssertTrue(descriptionLabel.exists, "Description label should exist")
        XCTAssertNotEqual(descriptionLabel.label, "No Description", "Description label should show weather description")
    }
}
