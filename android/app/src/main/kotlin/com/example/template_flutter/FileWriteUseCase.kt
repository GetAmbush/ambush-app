import android.app.Activity
import android.content.Intent
import android.net.Uri
import android.os.Build
import androidx.annotation.RequiresApi
import androidx.core.app.ActivityCompat.startActivityForResult
import androidx.lifecycle.LifecycleOwner

private const val CREATE_FILE = 1002

class FileWriteUseCase(private val lifecycleOwner: LifecycleOwner?) {
    @RequiresApi(Build.VERSION_CODES.O)
    fun accessFileSystem() {
        val intent = Intent(Intent.ACTION_CREATE_DOCUMENT).apply {
            addCategory(Intent.CATEGORY_OPENABLE)
            type = "application/json"
            putExtra(Intent.EXTRA_TITLE, "invoice_app.json")
        }
        startActivityForResult(lifecycleOwner as Activity, intent, CREATE_FILE, null)
    }

    suspend fun writeFileContent(uri: Uri, content: String) {
        try {
            val contentResolver = (lifecycleOwner as Activity).contentResolver
            val outputStream = contentResolver.openOutputStream(uri)
            outputStream?.bufferedWriter().use { writer ->
                if (writer != null) {
                    writer.write(content)
                    writer.flush()
//                    _resultFlow.emit(Result.success("File written successfully"))
                } else {
//                    _resultFlow.emit(Result.failure(Error("Failed to open output stream")))
                }
            }
        } catch (e: Exception) {
//            _resultFlow.emit(Result.failure(Error("Error writing file: ${e.message}")))
        }
    }
}