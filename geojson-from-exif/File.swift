import Foundation

class File {
    
    class func exists (path: String) -> (Bool, Bool) {
        var isDir:ObjCBool=true;
        var exists = NSFileManager().fileExistsAtPath(path, isDirectory:&isDir);
        return (exists, isDir.boolValue );
    }
    
    class func read (path: String, encoding: NSStringEncoding = NSUTF8StringEncoding) -> String {
        if File.exists(path).0 {
            return String(contentsOfFile:path, encoding: NSUTF8StringEncoding, error: nil)!;
        }
        
        return "";
    }
    
    class func write (path: String, content: String, encoding: NSStringEncoding = NSUTF8StringEncoding) -> Bool {
        return content.writeToFile(path, atomically: true, encoding: encoding, error: nil)
    }
    
    class func currentPath() -> String {
        return NSFileManager().currentDirectoryPath;
    }
    
    class func listDirectory(path: String, extensions: Array<String> = []) -> Array<String> {
        var error: NSError?
        let filemanager = NSFileManager.defaultManager();
        let contents = filemanager.contentsOfDirectoryAtPath(path, error: &error) as Array<String>;
        if (error != nil) {
            println("Errors: \(error)")
        }
        return contents.map() {
                // Add full path
                (var file:String ) -> String in
                return path.stringByAppendingPathComponent(file);
            }.filter() {
                // Filter out directories & specified extensions
                var exists = File.exists($0);
                return (exists.0 && !exists.1) &&
                    (extensions.count == 0 || extensions.contains($0.pathExtension.lowercaseString ));
            } as Array<String>;
    }
    
    class func createSubDirectory(subdirectoryPath:NSString) -> Bool {
        var error:NSError?
        var isDir:ObjCBool=false;
        var exists:Bool = NSFileManager.defaultManager().fileExistsAtPath(subdirectoryPath, isDirectory:&isDir)
        if (exists) {
            /* a file of the same name exists, we don't care about this so won't do anything */
            if (isDir.boolValue == true) {
                /* subdirectory already exists, don't create it again */
                return true;
            }
        }
        var success:Bool = NSFileManager.defaultManager().createDirectoryAtPath(subdirectoryPath, withIntermediateDirectories:true, attributes:nil, error:&error)
        
        if (error != nil) {
            println(error)
        }
        
        return success;
    }
    
}