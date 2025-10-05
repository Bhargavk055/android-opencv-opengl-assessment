# Web Viewer README

## TypeScript Edge Detection Viewer

This is a TypeScript-based web viewer for displaying processed frames from the Android edge detection app.

## Features

- **Real-time Statistics Display**: Shows FPS, resolution, processing time, and frame count
- **Side-by-side Comparison**: Displays original and processed frames
- **Simulation Mode**: Simulates real-time processing for demonstration
- **Frame Export**: Export processed frames as PNG images
- **Modern UI**: Beautiful gradient design with responsive layout

## Setup

### Prerequisites
- Node.js (v16 or later)
- npm or yarn

### Installation
```bash
cd web
npm install
```

### Build
```bash
npm run build
```

### Development
```bash
npm run watch
```

### Running
Open `index.html` in a web browser, or use a local server:
```bash
python -m http.server 8080
```

Then navigate to `http://localhost:8080`

## Usage

### Load Sample Image
Click "Load Sample Image" to display a sample frame with edge detection applied.

### Toggle Simulation
Click "Toggle Simulation" to start/stop real-time frame simulation at 15 FPS.

### Export Frame
Click "Export Frame" to download the current frame as a PNG image.

### Reset Stats
Click "Reset Stats" to reset the frame counter and statistics.

## Architecture

### TypeScript Classes
- `EdgeDetectionViewer`: Main viewer class that manages canvas rendering and statistics
- `FrameData`: Interface for frame data structure
- `ViewerStats`: Interface for viewer statistics

### Key Methods
- `loadSampleImage()`: Loads and displays sample frames
- `toggleSimulation()`: Starts/stops frame simulation
- `exportFrame()`: Exports current frame to PNG
- `receiveFrameData()`: Receives frame data from Android app (for future WebSocket integration)

## Future Enhancements

### WebSocket Integration
The viewer is designed to receive real-time data from the Android app via WebSocket:

```typescript
const ws = new WebSocket('ws://localhost:8080');
ws.onmessage = (event) => {
    const frameData = JSON.parse(event.data);
    viewer.receiveFrameData(frameData);
};
```

### HTTP Endpoint
Alternatively, frames can be received via HTTP POST:

```typescript
fetch('/api/frame', {
    method: 'POST',
    body: JSON.stringify(frameData)
});
```

## Browser Compatibility
- Chrome 90+
- Firefox 88+
- Safari 14+
- Edge 90+

## Performance
- Canvas rendering optimized for 60 FPS
- Efficient image data handling
- Minimal DOM manipulation

## License
MIT



