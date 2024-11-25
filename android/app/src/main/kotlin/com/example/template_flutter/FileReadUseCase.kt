package com.example.template_flutter

import android.app.Activity
import android.content.Intent
import android.net.Uri
import android.os.Build
import androidx.annotation.RequiresApi
import androidx.core.app.ActivityCompat.startActivityForResult
import androidx.lifecycle.LifecycleOwner
import kotlinx.coroutines.flow.MutableSharedFlow
import kotlinx.coroutines.flow.SharedFlow

class FileReadUseCase(private val lifecycleOwner: LifecycleOwner?) {
    private val _resultFlow = MutableSharedFlow<Result<String>>()
    val resultFlow: SharedFlow<Result<String>> get() = _resultFlow

    @RequiresApi(Build.VERSION_CODES.O)
    fun accessFileSystem() {
        val intent = Intent(Intent.ACTION_OPEN_DOCUMENT).apply {
            addCategory(Intent.CATEGORY_OPENABLE)
            type = "application/json"
            putExtra(Intent.EXTRA_TITLE, "invoice_app.json")
        }
        startActivityForResult(lifecycleOwner as Activity, intent, 1001, null)
    }

    suspend fun handleActivityResult(data: Intent?) {
        val uri = data?.data
        if (uri != null) {
            readFileContent(uri)
        }
    }

    private suspend fun readFileContent(uri: Uri) {
        try {
            val contentResolver = (lifecycleOwner as Activity).contentResolver
            val inputStream = contentResolver.openInputStream(uri)
            val content = inputStream?.bufferedReader().use { it?.readText() }
            if (content != null) {
                _resultFlow.emit(Result.success(content))
            } else {
                _resultFlow.emit(Result.failure(Error("Failed to read file content")))
            }
        } catch (e: Exception) {
            _resultFlow.emit(Result.failure(Error(e.message)))
        }
    }
}