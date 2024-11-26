package com.example.template_flutter

import android.app.Activity
import android.net.Uri
import androidx.lifecycle.LifecycleOwner
import kotlinx.coroutines.flow.MutableSharedFlow
import kotlinx.coroutines.flow.SharedFlow

class FileWriteUseCase(private val lifecycleOwner: LifecycleOwner?) {
    private val _resultFlow = MutableSharedFlow<Result<String>>()
    val resultFlow: SharedFlow<Result<String>> get() = _resultFlow

    suspend fun writeFileContent(uri: Uri, content: String) {
        try {
            val contentResolver = (lifecycleOwner as Activity).contentResolver
            val outputStream = contentResolver.openOutputStream(uri)
            outputStream?.bufferedWriter().use { writer ->
                if (writer != null) {
                    writer.write(content)
                    writer.flush()
                    _resultFlow.emit(Result.success(uri.toString()))
                } else {
                    _resultFlow.emit(Result.failure(Error("Failed to open output stream")))
                }
            }
        } catch (e: Exception) {
            _resultFlow.emit(Result.failure(Error("Error writing file: ${e.message}")))
        }
    }
}