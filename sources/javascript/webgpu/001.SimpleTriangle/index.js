import 'babel-polyfill';
import vertspv from './shaders/vert.spv';
import fragspv from './shaders/frag.spv';

if(!navigator || !navigator.gpu)
    console.error("No WebGPU. Sorry!")

async function setup()
{
    // Check webGPU is supported
    if(!navigator.gpu) {
        console.error("webGPU not supported")
        throw "webGPU not supported";
    }

    // Request device
    const gpu = navigator.gpu;
    const adapter = await gpu.requestAdapter();
    const device = await adapter.requestDevice();
    console.log(navigator);
    console.log(adapter);
    console.log(device);

    //Swapchain
    const swapChainFormat = "rgba8unorm";
    const canvas = document.getElementById("screen");
    const ctx = canvas.getContext('gpupresent')
    const swapchain = ctx.configureSwapChain({
        device: device,
        format: swapChainFormat
    });
    console.log(ctx);
    console.log(swapchain);

    //Initialize Resources
    let createBuffer = (arr, usage) => {
        let desc = { size: arr.byteLength, usage };
        let [ buffer, bufferMapped ] = device.createBufferMapped(desc);
        const writeArray =
            arr instanceof Uint16Array ? 
            new Uint16Array(bufferMapped) :
            new Float32Array(bufferMapped);
        writeArray.set(arr);
        buffer.unmap();
        return buffer;
    };
    
    const positionBuffer = createBuffer(new Float32Array([
         1.0, -1.0, 0.0, // 0
        -1.0, -1.0, 0.0, // 1 
         0.0,  1.0, 0.0, // 2
    ]), GPUBufferUsage.VERTEX);
    const colorBuffer = createBuffer(new Float32Array([
        1.0, 0.0, 0.0, // 0
        0.0, 1.0, 0.0, // 1
        0.0, 0.0, 1.0, // 2
    ]), GPUBufferUsage.VERTEX);
    const indexBuffer = createBuffer(new Uint16Array([ 
        0, 1, 2
    ]), GPUBufferUsage.INDEX);

    // Shaders
    async function loadSPV(url)
    {
        const res = await fetch(url);
        const buffer = await res.arrayBuffer();
        return new Uint32Array(buffer);
    }
    const vertModule = device.createShaderModule({ code: await loadSPV(vertspv) });
    const fragModule = device.createShaderModule({ code: await loadSPV(fragspv) });

    // Pipeline
    const positionAttribDesc = { shaderLocation: 0, offset: 0, format: 'float3' };
    const colorAttribDesc = { shaderLocation: 1, offset: 0, format: 'float3' };
    const positionBufferDesc = { attributes: [ positionAttribDesc ], arrayStride: 4 * 3 };
    const colorBufferDesc = { attributes: [ colorAttribDesc ], arrayStride: 4 * 3 };
    const vertexState = { indexFormat: 'uint16', vertexBuffers: [ positionBufferDesc, colorBufferDesc ] };
    const vertexStage = { module: vertModule, entryPoint: 'main' };
    const fragmentStage = { module: fragModule, entryPoint: 'main' };
    const colorState = {
        format: swapChainFormat,
        alphaBlend: { srcFactor: 'one', dstFactor: 'zero', operation: 'add' },
        colorBlend: { srcFactor: 'one', dstFactor: 'zero', operation: 'add' },
        writeMask: GPUColorWrite.ALL
    };
    const rasterizationState = {
        frontFace: 'cw',
        cullMode: 'back'
    };

    const layout = device.createPipelineLayout({ 
        bindGroupLayouts: [] 
    });

    const pipeline = device.createRenderPipeline({
        primitiveTopology: 'triangle-list', vertexState,
        vertexStage, layout,
        rasterizationState,
        fragmentStage,
        colorStates: [ colorState ],        
    });

    function triangleRenderPass(backBufferView)
    {
        let colorAttachment = {
            attachment: backBufferView,
            loadValue: { r: 0, g: 0, b: 0, a: 1 },
            storeOp: 'store'
        };

        const renderPassDesc = {
            colorAttachments: [ colorAttachment ],
        };

        let commandEncoder = device.createCommandEncoder()
        let pass = commandEncoder.beginRenderPass(renderPassDesc);
        pass.setPipeline(pipeline);
        pass.setViewport(0, 0, canvas.width, canvas.height, 0, 1);
        pass.setScissorRect(0, 0, canvas.width, canvas.height);
        pass.setVertexBuffer(0, positionBuffer);
        pass.setVertexBuffer(1, colorBuffer);
        pass.setIndexBuffer(indexBuffer);
        pass.drawIndexed(3, 1, 0, 0, 0);
        pass.endPass();
        return commandEncoder.finish()
    }

    function sendCommands(queue, backBufferView)
    {
        const commands = [
            triangleRenderPass(backBufferView)
        ];
        queue.submit(commands);
    }

    const queue = device.defaultQueue;
    let render = () => {        
        const colorTexture = swapchain.getCurrentTexture();
        const backBufferView = colorTexture.createView();
    
        sendCommands(device.defaultQueue, backBufferView);
        requestAnimationFrame(render);
    };
    return render;
}

setup().then(render => {
    requestAnimationFrame(render);
});