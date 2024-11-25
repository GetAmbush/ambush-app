package com.theolm.ambush_app

import FileWriteUseCase
import android.app.Activity
import android.content.Intent
import android.os.Build
import androidx.annotation.RequiresApi
import androidx.lifecycle.lifecycleScope
import com.example.template_flutter.FileReadUseCase
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.flow.first
import kotlinx.coroutines.flow.firstOrNull
import kotlinx.coroutines.launch

class MainActivity: FlutterActivity() {
    private val fileWriteUseCase by lazy { FileWriteUseCase(this) }
    private val fileReadUseCase by lazy { FileReadUseCase(this) }
    private var content: String? = null

    @RequiresApi(Build.VERSION_CODES.O)
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            "flutter.dev/preferences"
        ).setMethodCallHandler { call, result ->
            when(call.method) {
                "create_backup" -> handleCreateBackup(call.arguments)
                "restore_backup" -> handleRestoreBackup(result)
                else -> result.notImplemented()
            }
        }
    }

    @RequiresApi(Build.VERSION_CODES.O)
    private fun handleCreateBackup(arguments: Any) {
        (arguments as? Map<String, String>)?.let { args ->
            content = args["data"]
            fileWriteUseCase.accessFileSystem()
        }
    }

    @RequiresApi(Build.VERSION_CODES.O)
    private fun handleRestoreBackup(result: MethodChannel.Result) {
        lifecycleScope.launch {
            fileReadUseCase.resultFlow.firstOrNull()?.let { output ->
                output.onSuccess { content ->
                    result.success(content)
                }.onFailure { error ->
                    result.error(error.message ?: "", null, null)
                }
            }
        }
        fileReadUseCase.accessFileSystem()
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        lifecycleScope.launch {
            if(resultCode == Activity.RESULT_OK) {
                if(requestCode == OPEN_REQUEST_CODE) {
                    fileReadUseCase.handleActivityResult(data)
                } else if(requestCode == CREATE_REQUEST_CODE) {
                    val uri = data?.data
                    uri?.let { uri ->
                        content?.let { content ->
                            fileWriteUseCase.writeFileContent(uri, content)
                        }
                    }
                }
            }
        }
    }

    companion object {
        const val CREATE_REQUEST_CODE = 1
        const val OPEN_REQUEST_CODE = 2
    }
}
