//
// GenericPersistentStorageTests.swift
// MusicBrowserTests
//
        
import XCTest
@testable import MusicBrowser

final class GenericPersistentStorageTests: XCTestCase {

    private var sut: GenericPersistentStorage<MockModel>!
    private var storage: StuStorable!
    private let storageName = "fixture.foo"

    override func setUp() {
        super.setUp()

        storage = StuStorable()
        sut = GenericPersistentStorage(storage: storage, storageName: storageName);
    }

    func testSettingData() throws {
        let model = MockModel(value: "fixture.value")
        XCTAssertNoThrow(try sut.setValue(model))

        XCTAssertEqual(storage.writtenFile, storageName)
        let data = try XCTUnwrap(storage.writtenData)
        let writtenModel = try JSONDecoder().decode(MockModel.self, from: data)

        XCTAssertEqual(writtenModel.value, model.value)
    }

    func testGettingData() throws {
        let model = MockModel(value: "fixture.value")
        storage.dataToReturnWhileReading = try JSONEncoder().encode(model)

        let readModel = try XCTUnwrap(try sut.getValue())

        XCTAssertEqual(readModel.value, model.value)
        XCTAssertEqual(storage.readFile, storageName)
    }

    func testSettingDataForCustomKey() throws {
        let model = MockModel(value: "fixture.value")
        XCTAssertNoThrow(try sut.setValue(model, forKey: "custom.key"))

        XCTAssertEqual(storage.writtenFile, "custom.key")
        let data = try XCTUnwrap(storage.writtenData)
        let writtenModel = try JSONDecoder().decode(MockModel.self, from: data)

        XCTAssertEqual(writtenModel.value, model.value)
    }

    func testGettingDataForCustomKey() throws {
        let model = MockModel(value: "fixture.value")
        storage.dataToReturnWhileReading = try JSONEncoder().encode(model)

        let readModel = try XCTUnwrap(try sut.getValue(forKey: "custom.key"))

        XCTAssertEqual(readModel.value, model.value)
        XCTAssertEqual(storage.readFile, "custom.key")
    }
}

// MARK: Private

private struct MockModel: Codable {
    let value: String
}

private final class StuStorable: Storable {
    enum StubError: Error {
        case missingMock
    }

    private(set) var writtenFile: String?
    private(set) var writtenData: Data?

    private(set) var readFile: String?
    var dataToReturnWhileReading: Data?

    func writeData(_ data: Data, to file: String) throws {
        writtenFile = file
        writtenData = data;
    }

    func remove(file: String) throws { /* not tested */ }

    func readData(from file: String) throws -> Data {
        readFile = file
        if let data = dataToReturnWhileReading {
            return data
        }
        throw StubError.missingMock
    }
}
