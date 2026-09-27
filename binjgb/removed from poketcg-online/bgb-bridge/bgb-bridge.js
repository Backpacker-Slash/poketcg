const WebSocket = require('ws');
const net = require('net');

const WS_PORT = 8080;
const BGB_GDB_PORT = 55555;
const BGB_HOST = '127.0.0.1';

let bgbSocket = null;
let bgbConnected = false;

// 1. Connect to BGB GDB Server
function connectToBGB() {
    console.log(`[Bridge] Connecting to BGB Debugger at ${BGB_HOST}:${BGB_GDB_PORT}...`);
    
    bgbSocket = net.connect(BGB_GDB_PORT, BGB_HOST, () => {
        console.log('[Bridge] Connected to BGB Debugger!');
        bgbConnected = true;
    });

    bgbSocket.on('data', (data) => {
        // GDB ACK response handling
        // console.log('[BGB -> Bridge]:', data.toString());
    });

    bgbSocket.on('error', (err) => {
        console.error('[Bridge] BGB Connection Error:', err.message);
        bgbConnected = false;
    });

    bgbSocket.on('close', () => {
        console.log('[Bridge] BGB disconnected. Retrying in 3 seconds...');
        bgbConnected = false;
        setTimeout(connectToBGB, 3000);
    });
}

// Helper: Format GDB Protocol Packet ($<cmd>#<checksum>)
function sendGdbCommand(cmd) {
    if (!bgbConnected || !bgbSocket) return;

    let checksum = 0;
    for (let i = 0; i < cmd.length; i++) {
        checksum = (checksum + cmd.charCodeAt(i)) % 256;
    }
    const hexChecksum = checksum.toString(16).padStart(2, '0');
    const packet = `$${cmd}#${hexChecksum}`;
    
    bgbSocket.write(packet);
}

// Helper: Write bytes to Game Boy WRAM via GDB 'M' command
// Format: M <address_hex>,<length_hex>:<data_hex>
function writeMemoryToBGB(address, bytes) {
    if (!bgbConnected) return;

    const addrHex = address.toString(16).toUpperCase();
    const lenHex = bytes.length.toString(16).toUpperCase();
    const dataHex = bytes.map(b => b.toString(16).padStart(2, '0')).join('');

    sendGdbCommand(`M${addrHex},${lenHex}:${dataHex}`);
}

// 2. Start WebSocket Server for Browser Launcher
const wss = new WebSocket.Server({ port: WS_PORT }, () => {
    console.log(`[Bridge] WebSocket Server listening on ws://localhost:${WS_PORT}`);
});

wss.on('connection', (ws) => {
    console.log('[Bridge] Browser launcher connected!');

    ws.on('message', (message) => {
        try {
            const packet = JSON.parse(message);
            
            if (packet.type === 'RAM_WRITE') {
                // Write memory payload directly into BGB
                writeMemoryToBGB(packet.address, packet.bytes);
            }
        } catch (e) {
            console.error('[Bridge] Invalid packet from browser:', e);
        }
    });

    ws.on('close', () => {
        console.log('[Bridge] Browser launcher disconnected.');
    });
});

connectToBGB();