import UIKit
import FirebaseStorage

final class FileStorage {
    class func uploadImage(_ image: UIImage, uid: String) async throws -> String {
        guard let imageData = image.jpegData(compressionQuality: 0.6) else { return "" }
        let ref = Storage.storage().reference(withPath: "/avatars/\(uid).jpg")
        let _ = try await ref.putDataAsync(imageData)
        let url = try await ref.downloadURL()
        return url.absoluteString
    }
    
    class func uploadImage(_ image: UIImage, uid: String, completion: @escaping(String?) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.6) else { return }
        let ref = Storage.storage().reference(withPath: "/avatars/\(uid).jpg")
        var task: StorageUploadTask!
        task = ref.putData(imageData) { metadata, error in
          task.removeAllObservers()
          ProgressHUD.dismiss()
          if let error = error {
            print("error uploading image \(error.localizedDescription)")
            return
          }
          ref.downloadURL { url, error in
            guard let url = url else { return }
            completion(url.absoluteString)
          }
        }
        task.observe(StorageTaskStatus.progress) { snapshot in
          let progress = snapshot.progress!.completedUnitCount / snapshot.progress!.totalUnitCount
          ProgressHUD.showProgress(CGFloat(progress))
        }
    }
    
    class func downloadImage(person: Person, completion: @escaping (UIImage?) -> Void) {
        if fileExistsAtPath(person.uid) {
            completion(UIImage(contentsOfFile: fileInDocumetsDirectory(fileName: person.uid)))
        } else if let url = URL(string: person.profileImageUrl) {
            let downloadQueue = DispatchQueue(label: "imageDownloadQueue")
            downloadQueue.async {
                if let data = NSData(contentsOf: url)  {
                    FileStorage.saveFileLocally(fileData: data, filename: person.uid)
                    DispatchQueue.main.async {
                        completion(UIImage(data: data as Data))
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                }
            }
        } else {
            completion(nil)
        }
    }
    
    class func saveFileLocally(fileData: NSData, filename: String) {
        let docUrl = getDocumentsURL().appending(path: filename, directoryHint: .notDirectory)
        print(docUrl)
        fileData.write(to: docUrl, atomically: true)
    }
}

// Helpers

func getDocumentsURL() -> URL {
  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!
}

func fileInDocumetsDirectory(fileName: String) -> String {
  getDocumentsURL().appendingPathComponent(fileName).path
}

func fileExistsAtPath(_ path: String) -> Bool {
  FileManager.default.fileExists(atPath: fileInDocumetsDirectory(fileName: path))
}
