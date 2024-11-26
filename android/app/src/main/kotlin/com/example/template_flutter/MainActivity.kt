package com.theolm.ambush_app

import com.example.template_flutter.FileWriteUseCase
import android.app.Activity
import android.content.Intent
import android.os.Build
import androidx.annotation.RequiresApi
import androidx.core.app.ActivityCompat
import androidx.lifecycle.lifecycleScope
import com.example.template_flutter.FileReadUseCase
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.flow.firstOrNull
import kotlinx.coroutines.launch

class MainActivity : FlutterActivity() {
    private val fileWriteUseCase by lazy { FileWriteUseCase(this) }
    private val fileReadUseCase by lazy { FileReadUseCase(this) }
    private var backupData: String? = null

    @RequiresApi(Build.VERSION_CODES.O)
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            "flutter.dev/preferences"
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "create_backup" -> handleCreateBackup(call.arguments, result)
                "restore_backup" -> handleRestoreBackup(result)
                else -> result.notImplemented()
            }
        }
    }

    private fun accessFileSystem(requestCode: Int) {
        val intentAction = if (requestCode == CREATE_REQUEST_CODE) {
            Intent.ACTION_CREATE_DOCUMENT
        } else {
            Intent.ACTION_OPEN_DOCUMENT
        }
        val intent = Intent(intentAction).apply {
            addCategory(Intent.CATEGORY_OPENABLE)
            type = "application/json"
            putExtra(Intent.EXTRA_TITLE, "invoice_app.json")
        }
        ActivityCompat.startActivityForResult(this, intent, requestCode, null)
    }

    @RequiresApi(Build.VERSION_CODES.O)
    @Suppress("UNCHECKED_CAST")
    private fun handleCreateBackup(arguments: Any, result: MethodChannel.Result) {
        lifecycleScope.launch {
            fileWriteUseCase.resultFlow.firstOrNull()?.let { output ->
                output.onFailure { error ->
                    result.error(error.message ?: "Error occurred", null, null)
                }
            }
        }
        (arguments as? Map<String, String>)?.let { args ->
            backupData = args["data"]
            accessFileSystem(CREATE_REQUEST_CODE)
        }
    }

    @RequiresApi(Build.VERSION_CODES.O)
    private fun handleRestoreBackup(result: MethodChannel.Result) {
        lifecycleScope.launch {
            fileReadUseCase.resultFlow.firstOrNull()?.let { output ->
                output.onSuccess { content ->
                    result.success(content)
                }.onFailure { error ->
                    result.error(error.message ?: "Error occurred", null, null)
                }
            }
        }
        accessFileSystem(OPEN_REQUEST_CODE)
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        lifecycleScope.launch {
            val uri = data?.data
            uri?.let { uri ->
                if (resultCode == Activity.RESULT_OK) {
                    if (requestCode == OPEN_REQUEST_CODE) {
                        fileReadUseCase.readFileContent(uri)
                    } else if (requestCode == CREATE_REQUEST_CODE) {
                        backupData?.let { content ->
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
