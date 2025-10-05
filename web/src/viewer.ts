/**
 * Edge Detection Web Viewer - TypeScript Implementation
 * Demonstrates integration with Android OpenCV processing results
 */

interface FrameData {
    original: ImageData;
    processed: ImageData;
    timestamp: number;
    fps: number;
    resolution: string;
    processingTime: number;
}

interface ViewerStats {
    fps: number;
    resolution: string;
    processingTime: number;
    frameCount: number;
    isSimulating: boolean;
}

class EdgeDetectionViewer {
    private originalCanvas!: HTMLCanvasElement;
    private processedCanvas!: HTMLCanvasElement;
    private originalCtx!: CanvasRenderingContext2D;
    private processedCtx!: CanvasRenderingContext2D;
    
    private stats: ViewerStats = {
        fps: 0,
        resolution: '640x480',
        processingTime: 0,
        frameCount: 0,
        isSimulating: false
    };
    
    private simulationInterval: number | null = null;
    private lastFrameTime: number = 0;
    
    constructor() {
        this.initializeCanvas();
        this.setupEventListeners();
        this.startStatsUpdate();
        this.loadSampleImage();
    }
    
    private initializeCanvas(): void {
        this.originalCanvas = document.getElementById('originalCanvas') as HTMLCanvasElement;
        this.processedCanvas = document.getElementById('processedCanvas') as HTMLCanvasElement;
        
        this.originalCtx = this.originalCanvas.getContext('2d')!;
        this.processedCtx = this.processedCanvas.getContext('2d')!;
        
        // Set canvas dimensions
        this.originalCanvas.width = 640;
        this.originalCanvas.height = 480;
        this.processedCanvas.width = 640;
        this.processedCanvas.height = 480;
    }
    
    private setupEventListeners(): void {
        // Add any event listeners here
        console.log('Edge Detection Viewer initialized');
    }
    
    public loadSampleImage(): void {
        // Try to load a real image first, fallback to generated sample
        this.loadImageFromFile('sample.jpg') // Change this filename to your image
            .catch(() => this.loadImageFromFile('sample.png'))
            .catch(() => this.loadImageFromFile('test.jpg'))
            .catch(() => this.loadImageFromFile('image.jpg'))
            .catch(() => {
                // Fallback to programmatic sample if no image files found
                this.drawSampleOriginal();
                this.drawSampleProcessed();
            })
            .finally(() => this.updateStats());
    }

    private async loadImageFromFile(filename: string): Promise<void> {
        return new Promise((resolve, reject) => {
            const img = new Image();
            img.onload = () => {
                // Draw original image
                this.originalCtx.clearRect(0, 0, this.originalCanvas.width, this.originalCanvas.height);
                this.originalCtx.drawImage(img, 0, 0, this.originalCanvas.width, this.originalCanvas.height);
                
                // Generate edge detection simulation
                this.generateEdgeDetectionFromImage(img);
                resolve();
            };
            img.onerror = () => reject(new Error(`Could not load ${filename}`));
            img.src = filename;
        });
    }

    private generateEdgeDetectionFromImage(img: HTMLImageElement): void {
        const canvas = document.createElement('canvas');
        const ctx = canvas.getContext('2d')!;
        canvas.width = this.processedCanvas.width;
        canvas.height = this.processedCanvas.height;
        
        // Draw image to temporary canvas
        ctx.drawImage(img, 0, 0, canvas.width, canvas.height);
        const imageData = ctx.getImageData(0, 0, canvas.width, canvas.height);
        const data = imageData.data;
        
        // Simple edge detection simulation using luminance changes
        const edgeData = ctx.createImageData(canvas.width, canvas.height);
        const edge = edgeData.data;
        
        for (let y = 1; y < canvas.height - 1; y++) {
            for (let x = 1; x < canvas.width - 1; x++) {
                const idx = (y * canvas.width + x) * 4;
                
                // Get luminance of current pixel and neighbors
                const current = data[idx] * 0.299 + data[idx + 1] * 0.587 + data[idx + 2] * 0.114;
                const right = data[idx + 4] * 0.299 + data[idx + 5] * 0.587 + data[idx + 6] * 0.114;
                const down = data[idx + canvas.width * 4] * 0.299 + data[idx + canvas.width * 4 + 1] * 0.587 + data[idx + canvas.width * 4 + 2] * 0.114;
                
                // Calculate gradient magnitude
                const gx = Math.abs(current - right);
                const gy = Math.abs(current - down);
                const magnitude = Math.sqrt(gx * gx + gy * gy);
                
                // Threshold and set edge pixel
                const edgeValue = magnitude > 30 ? 255 : 0;
                edge[idx] = edgeValue;     // R
                edge[idx + 1] = edgeValue; // G
                edge[idx + 2] = edgeValue; // B
                edge[idx + 3] = 255;       // A
            }
        }
        
        // Draw edge detection result
        this.processedCtx.clearRect(0, 0, this.processedCanvas.width, this.processedCanvas.height);
        this.processedCtx.putImageData(edgeData, 0, 0);
    }
    
    private drawSampleOriginal(): void {
        const ctx = this.originalCtx;
        const canvas = this.originalCanvas;
        
        // Clear canvas
        ctx.fillStyle = '#f0f0f0';
        ctx.fillRect(0, 0, canvas.width, canvas.height);
        
        // Draw sample shapes
        ctx.fillStyle = '#ff6b6b';
        ctx.fillRect(100, 100, 200, 150);
        
        ctx.fillStyle = '#4ecdc4';
        ctx.beginPath();
        ctx.arc(400, 200, 80, 0, 2 * Math.PI);
        ctx.fill();
        
        ctx.fillStyle = '#45b7d1';
        ctx.beginPath();
        ctx.moveTo(300, 350);
        ctx.lineTo(200, 450);
        ctx.lineTo(400, 450);
        ctx.closePath();
        ctx.fill();
        
        // Add some text
        ctx.fillStyle = '#2c3e50';
        ctx.font = '24px Arial';
        ctx.fillText('Sample Original Frame', 200, 50);
    }
    
    private drawSampleProcessed(): void {
        const ctx = this.processedCtx;
        const canvas = this.processedCanvas;
        
        // Clear canvas
        ctx.fillStyle = '#000000';
        ctx.fillRect(0, 0, canvas.width, canvas.height);
        
        // Simulate edge detection by drawing outlines
        ctx.strokeStyle = '#ffffff';
        ctx.lineWidth = 2;
        
        // Rectangle outline
        ctx.strokeRect(100, 100, 200, 150);
        
        // Circle outline
        ctx.beginPath();
        ctx.arc(400, 200, 80, 0, 2 * Math.PI);
        ctx.stroke();
        
        // Triangle outline
        ctx.beginPath();
        ctx.moveTo(300, 350);
        ctx.lineTo(200, 450);
        ctx.lineTo(400, 450);
        ctx.closePath();
        ctx.stroke();
        
        // Add some noise to simulate real edge detection
        this.addNoise(ctx, canvas);
        
        // Add text
        ctx.fillStyle = '#ffffff';
        ctx.font = '24px Arial';
        ctx.fillText('Edge Detection Result', 180, 50);
    }
    
    private addNoise(ctx: CanvasRenderingContext2D, canvas: HTMLCanvasElement): void {
        const imageData = ctx.getImageData(0, 0, canvas.width, canvas.height);
        const data = imageData.data;
        
        // Add random noise to simulate edge detection artifacts
        for (let i = 0; i < data.length; i += 4) {
            if (Math.random() < 0.1) { // 10% chance of noise
                const noise = Math.random() * 50;
                data[i] = Math.min(255, data[i] + noise);     // Red
                data[i + 1] = Math.min(255, data[i + 1] + noise); // Green
                data[i + 2] = Math.min(255, data[i + 2] + noise); // Blue
            }
        }
        
        ctx.putImageData(imageData, 0, 0);
    }
    
    public toggleSimulation(): void {
        if (this.stats.isSimulating) {
            this.stopSimulation();
        } else {
            this.startSimulation();
        }
    }
    
    private startSimulation(): void {
        this.stats.isSimulating = true;
        this.lastFrameTime = Date.now();
        
        this.simulationInterval = window.setInterval(() => {
            this.updateSimulation();
        }, 1000 / 15); // 15 FPS simulation
        
        this.updateStatus('Simulation Running', true);
    }
    
    private stopSimulation(): void {
        this.stats.isSimulating = false;
        
        if (this.simulationInterval) {
            clearInterval(this.simulationInterval);
            this.simulationInterval = null;
        }
        
        this.updateStatus('Simulation Stopped', false);
    }
    
    private updateSimulation(): void {
        const currentTime = Date.now();
        const deltaTime = currentTime - this.lastFrameTime;
        
        // Update FPS
        this.stats.fps = 1000 / deltaTime;
        this.stats.frameCount++;
        this.stats.processingTime = Math.random() * 20 + 5; // Simulate 5-25ms processing
        
        this.lastFrameTime = currentTime;
        
        // Redraw with slight variations
        this.drawSampleOriginal();
        this.drawSampleProcessed();
        this.updateStats();
    }
    
    public exportFrame(): void {
        // Create a combined image
        const exportCanvas = document.createElement('canvas');
        exportCanvas.width = 1280;
        exportCanvas.height = 480;
        const exportCtx = exportCanvas.getContext('2d')!;
        
        // Draw both images side by side
        exportCtx.drawImage(this.originalCanvas, 0, 0);
        exportCtx.drawImage(this.processedCanvas, 640, 0);
        
        // Add title
        exportCtx.fillStyle = '#000000';
        exportCtx.font = '32px Arial';
        exportCtx.fillText('Edge Detection Export', 400, 50);
        
        // Download
        const link = document.createElement('a');
        link.download = `edge-detection-${Date.now()}.png`;
        link.href = exportCanvas.toDataURL();
        link.click();
        
        console.log('Frame exported successfully');
    }
    
    public resetStats(): void {
        this.stats.frameCount = 0;
        this.stats.fps = 0;
        this.stats.processingTime = 0;
        this.updateStats();
        
        console.log('Stats reset');
    }
    
    private updateStats(): void {
        document.getElementById('fpsValue')!.textContent = this.stats.fps.toFixed(1);
        document.getElementById('resolutionValue')!.textContent = this.stats.resolution;
        document.getElementById('processingTimeValue')!.textContent = `${this.stats.processingTime.toFixed(1)}ms`;
        document.getElementById('frameCountValue')!.textContent = this.stats.frameCount.toString();
    }
    
    private updateStatus(message: string, isOnline: boolean): void {
        const indicator = document.getElementById('statusIndicator')!;
        const text = document.getElementById('statusText')!;
        
        indicator.className = `status-indicator ${isOnline ? 'status-online' : 'status-offline'}`;
        text.textContent = message;
    }
    
    private startStatsUpdate(): void {
        // Update stats display every second
        setInterval(() => {
            this.updateStats();
        }, 1000);
    }
    
    public async loadUserImageFromFile(file: File): Promise<void> {
        return new Promise((resolve, reject) => {
            const reader = new FileReader();
            reader.onload = (e) => {
                const img = new Image();
                img.onload = () => {
                    // Draw original image
                    this.originalCtx.clearRect(0, 0, this.originalCanvas.width, this.originalCanvas.height);
                    this.originalCtx.drawImage(img, 0, 0, this.originalCanvas.width, this.originalCanvas.height);
                    
                    // Generate edge detection
                    this.generateEdgeDetectionFromImage(img);
                    this.updateStats();
                    
                    console.log('User image loaded successfully');
                    resolve();
                };
                img.onerror = () => reject(new Error('Failed to load image'));
                img.src = e.target?.result as string;
            };
            reader.onerror = () => reject(new Error('Failed to read file'));
            reader.readAsDataURL(file);
        });
    }

    // Method to receive data from Android app (for future WebSocket integration)
    public receiveFrameData(frameData: FrameData): void {
        // This would be called when receiving real data from the Android app
        console.log('Received frame data:', frameData);
        
        // Update canvases with real data
        this.originalCtx.putImageData(frameData.original, 0, 0);
        this.processedCtx.putImageData(frameData.processed, 0, 0);
        
        // Update stats
        this.stats.fps = frameData.fps;
        this.stats.processingTime = frameData.processingTime;
        this.stats.frameCount++;
        
        this.updateStats();
    }
}

// Global functions for HTML buttons
let viewer: EdgeDetectionViewer;

function loadUserImage(event: Event): void {
    const input = event.target as HTMLInputElement;
    const file = input.files?.[0];
    
    if (file) {
        viewer.loadUserImageFromFile(file)
            .then(() => console.log('Image loaded successfully'))
            .catch((error) => {
                console.error('Error loading image:', error);
                alert('Failed to load image. Please try a different image file.');
            });
    }
}

function loadSampleImage(): void {
    viewer.loadSampleImage();
}

function toggleSimulation(): void {
    viewer.toggleSimulation();
}

function exportFrame(): void {
    viewer.exportFrame();
}

function resetStats(): void {
    viewer.resetStats();
}

// Initialize viewer when page loads
document.addEventListener('DOMContentLoaded', () => {
    viewer = new EdgeDetectionViewer();
});



