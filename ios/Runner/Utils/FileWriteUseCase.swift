//
//  FileSelector.swift
//  Runner
//
//  Created by Pedro Alvarez on 25/11/24.
//

import UniformTypeIdentifiers
import Combine

final class FileWriteUseCase: NSObject {
    private let pathSubject = PassthroughSubject<String, BackupError>()
    
    var pathPublisher: AnyPublisher<String, BackupError> {
        pathSubject.eraseToAnyPublisher()
    }
    
    private var data: String?
    
    func write(_ data: String, vc: UIViewController?) {
        self.data = data
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [UTType.folder])
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        vc?.present(documentPicker, animated: true, completion: nil)
    }
}

extension FileWriteUseCase: UIDocumentPickerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let folderURL = urls.first else { return }
        
        let fileName = "invoice_app.json"
        
        guard let data else {
            pathSubject.send(completion: .failure(.init(message: "Failure to save")))
            return
        }
        
        let fileURL = folderURL.appendingPathComponent(fileName)
        
        do {
            try data.write(to: fileURL, atomically: true, encoding: .utf8)
            pathSubject.send(fileURL.absoluteString)
        } catch {
            pathSubject.send(completion: .failure(.init(message: "Failure to save")))
        }
    }
}
