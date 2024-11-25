//
//  FileReadUseCase.swift
//  Runner
//
//  Created by Pedro Alvarez on 25/11/24.
//

import UniformTypeIdentifiers
import Combine

final class FileReadUseCase: NSObject {
    private let contentSubject = PassthroughSubject<String?, BackupError>()
    
    var contentPublisher: AnyPublisher<String?, BackupError> {
        contentSubject.eraseToAnyPublisher()
    }
    
    func read(_ vc: UIViewController?) {
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [UTType.json])
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        vc?.present(documentPicker, animated: true, completion: nil)
    }
}

extension FileReadUseCase: UIDocumentPickerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let url = urls.first else { return }
        
        do {
            let data = try Data(contentsOf: url)
            let jsonString = String(data: data, encoding: .utf8)
            contentSubject.send(jsonString)
        } catch {
            contentSubject.send(completion: .failure(.init(message: "Failed to read")))
        }
    }
}
