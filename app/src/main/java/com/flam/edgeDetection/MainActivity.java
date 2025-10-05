package com.flam.edgeDetection;

import android.Manifest;
import android.content.pm.PackageManager;
import android.graphics.SurfaceTexture;
import android.opengl.GLSurfaceView;
import android.os.Bundle;
import android.util.Log;
import android.view.TextureView;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;
import androidx.camera.core.Camera;
import androidx.camera.core.CameraSelector;
import androidx.camera.core.ImageAnalysis;
import androidx.camera.core.ImageProxy;
import androidx.camera.core.Preview;
import androidx.camera.lifecycle.ProcessCameraProvider;
import androidx.camera.view.PreviewView;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;

import com.google.common.util.concurrent.ListenableFuture;

import java.nio.ByteBuffer;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class MainActivity extends AppCompatActivity implements TextureView.SurfaceTextureListener {
    
    private static final String TAG = "MainActivity";
    private static final int CAMERA_PERMISSION_REQUEST_CODE = 1001;
    
    private PreviewView previewView;
    private GLSurfaceView glSurfaceView;
    private Button toggleButton;
    private TextView fpsTextView;
    private TextView statusTextView;
    
    private Camera camera;
    private ExecutorService cameraExecutor;
    private EdgeDetectionRenderer renderer;
    private boolean isProcessingEnabled = true;
    private long lastFrameTime = 0;
    private int frameCount = 0;
    private long fpsStartTime = 0;
    
    // Native methods
    static {
        System.loadLibrary("edgeDetection");
    }
    
    public native void initOpenCV();
    public native void processFrame(byte[] data, int width, int height, int[] output);
    public native void cleanupOpenCV();

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        
        initViews();
        initNative();
        checkCameraPermission();
        
        cameraExecutor = Executors.newSingleThreadExecutor();
    }
    
    private void initViews() {
        previewView = findViewById(R.id.previewView);
        glSurfaceView = findViewById(R.id.glSurfaceView);
        toggleButton = findViewById(R.id.toggleButton);
        fpsTextView = findViewById(R.id.fpsTextView);
        statusTextView = findViewById(R.id.statusTextView);
        
        toggleButton.setOnClickListener(v -> toggleProcessing());
        
        // Setup GLSurfaceView
        glSurfaceView.setEGLContextClientVersion(2);
        renderer = new EdgeDetectionRenderer();
        glSurfaceView.setRenderer(renderer);
        glSurfaceView.setRenderMode(GLSurfaceView.RENDERMODE_CONTINUOUSLY);
    }
    
    private void initNative() {
        initOpenCV();
    }
    
    private void checkCameraPermission() {
        if (ContextCompat.checkSelfPermission(this, Manifest.permission.CAMERA) 
                != PackageManager.PERMISSION_GRANTED) {
            ActivityCompat.requestPermissions(this, 
                new String[]{Manifest.permission.CAMERA}, 
                CAMERA_PERMISSION_REQUEST_CODE);
        } else {
            startCamera();
        }
    }
    
    @Override
    public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, 
                                         @NonNull int[] grantResults) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults);
        if (requestCode == CAMERA_PERMISSION_REQUEST_CODE) {
            if (grantResults.length > 0 && grantResults[0] == PackageManager.PERMISSION_GRANTED) {
                startCamera();
            } else {
                Toast.makeText(this, "Camera permission required", Toast.LENGTH_SHORT).show();
            }
        }
    }
    
    private void startCamera() {
        ListenableFuture<ProcessCameraProvider> cameraProviderFuture = 
            ProcessCameraProvider.getInstance(this);
        
        cameraProviderFuture.addListener(() -> {
            try {
                ProcessCameraProvider cameraProvider = cameraProviderFuture.get();
                bindCameraUseCases(cameraProvider);
            } catch (ExecutionException | InterruptedException e) {
                Log.e(TAG, "Camera provider failed", e);
            }
        }, ContextCompat.getMainExecutor(this));
    }
    
    private void bindCameraUseCases(ProcessCameraProvider cameraProvider) {
        Preview preview = new Preview.Builder().build();
        preview.setSurfaceProvider(previewView.getSurfaceProvider());
        
        ImageAnalysis imageAnalysis = new ImageAnalysis.Builder()
            .setBackpressureStrategy(ImageAnalysis.STRATEGY_KEEP_ONLY_LATEST)
            .build();
        
        imageAnalysis.setAnalyzer(cameraExecutor, this::analyzeImage);
        
        CameraSelector cameraSelector = CameraSelector.DEFAULT_BACK_CAMERA;
        
        try {
            cameraProvider.unbindAll();
            camera = cameraProvider.bindToLifecycle(this, cameraSelector, preview, imageAnalysis);
        } catch (Exception e) {
            Log.e(TAG, "Camera binding failed", e);
        }
    }
    
    private void analyzeImage(ImageProxy image) {
        if (!isProcessingEnabled) {
            image.close();
            return;
        }
        
        ByteBuffer buffer = image.getPlanes()[0].getBuffer();
        byte[] data = new byte[buffer.remaining()];
        buffer.get(data);
        
        int width = image.getWidth();
        int height = image.getHeight();
        
        // Process frame in native code
        int[] processedData = new int[width * height];
        processFrame(data, width, height, processedData);
        
        // Update renderer with processed data
        renderer.updateTexture(processedData, width, height);
        
        // Update FPS counter
        updateFPS();
        
        image.close();
    }
    
    private void updateFPS() {
        long currentTime = System.currentTimeMillis();
        frameCount++;
        
        if (fpsStartTime == 0) {
            fpsStartTime = currentTime;
        }
        
        if (currentTime - fpsStartTime >= 1000) { // Update every second
            float fps = frameCount * 1000.0f / (currentTime - fpsStartTime);
            runOnUiThread(() -> fpsTextView.setText(String.format("FPS: %.1f", fps)));
            
            frameCount = 0;
            fpsStartTime = currentTime;
        }
    }
    
    private void toggleProcessing() {
        isProcessingEnabled = !isProcessingEnabled;
        toggleButton.setText(isProcessingEnabled ? "Show Raw" : "Show Processed");
        statusTextView.setText(isProcessingEnabled ? "Edge Detection ON" : "Edge Detection OFF");
    }
    
    @Override
    public void onSurfaceTextureAvailable(@NonNull SurfaceTexture surface, int width, int height) {
        // TextureView implementation if needed
    }
    
    @Override
    public void onSurfaceTextureSizeChanged(@NonNull SurfaceTexture surface, int width, int height) {
        // Handle size changes
    }
    
    @Override
    public boolean onSurfaceTextureDestroyed(@NonNull SurfaceTexture surface) {
        return false;
    }
    
    @Override
    public void onSurfaceTextureUpdated(@NonNull SurfaceTexture surface) {
        // Handle texture updates
    }
    
    @Override
    protected void onDestroy() {
        super.onDestroy();
        cleanupOpenCV();
        if (cameraExecutor != null) {
            cameraExecutor.shutdown();
        }
    }
}



