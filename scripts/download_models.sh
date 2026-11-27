#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

echo "🚀 Starting model downloads and symlinking..."

# Base directory for models in /tmp (ephemeral storage)
TEMP_MODELS_DIR="/tmp/models"
mkdir -p "$TEMP_MODELS_DIR/checkpoints"
mkdir -p "$TEMP_MODELS_DIR/loras"
mkdir -p "$TEMP_MODELS_DIR/controlnet"
mkdir -p "$TEMP_MODELS_DIR/ipadapter"
mkdir -p "$TEMP_MODELS_DIR/clip"
mkdir -p "$TEMP_MODELS_DIR/vae"
mkdir -p "$TEMP_MODELS_DIR/upscale_models"
mkdir -p "$TEMP_MODELS_DIR/sams"
mkdir -p "$TEMP_MODELS_DIR/onnx"
mkdir -p "$TEMP_MODELS_DIR/wan"

# ComfyUI models directory in /kaggle/working
COMFY_MODELS_DIR="/kaggle/working/ComfyUI/models"

# Function to download and symlink
download_and_link() {
    local url=$1
    local destination=$2
    local filename=$3
    local symlink_path=$4

    echo "Downloading $filename..."
    if [ ! -f "$destination/$filename" ]; then
        wget -q --show-progress -O "$destination/$filename" "$url"
    else
        echo "$filename already exists in $destination"
    fi

    echo "Symlinking $filename to $symlink_path..."
    mkdir -p "$(dirname "$symlink_path")"
    ln -sf "$destination/$filename" "$symlink_path"
}

# 1. Base Model (Flux or SDXL - using quantized versions)
# Flux.1-schnell-dev-fp8
download_and_link "https://huggingface.co/Kijai/flux-fp8/resolve/main/flux1-schnell-fp8.safetensors" "$TEMP_MODELS_DIR/checkpoints" "flux1-schnell-fp8.safetensors" "$COMFY_MODELS_DIR/checkpoints/flux1-schnell-fp8.safetensors"

# 2. VAE
download_and_link "https://huggingface.co/black-forest-labs/FLUX.1-schnell/resolve/main/ae.safetensors" "$TEMP_MODELS_DIR/vae" "ae.safetensors" "$COMFY_MODELS_DIR/vae/ae.safetensors"

# 3. CLIP
download_and_link "https://huggingface.co/comfyanonymous/flux_text_encoders/resolve/main/t5xxl_fp8_e4m3fn.safetensors" "$TEMP_MODELS_DIR/clip" "t5xxl_fp8_e4m3fn.safetensors" "$COMFY_MODELS_DIR/clip/t5xxl_fp8_e4m3fn.safetensors"
download_and_link "https://huggingface.co/comfyanonymous/flux_text_encoders/resolve/main/clip_l.safetensors" "$TEMP_MODELS_DIR/clip" "clip_l.safetensors" "$COMFY_MODELS_DIR/clip/clip_l.safetensors"

# 4. ReActor Node Models
mkdir -p "$COMFY_MODELS_DIR/reactor/faceswap_models"
download_and_link "https://github.com/Gourieff/comfyui-reactor-node/releases/download/v1.0.0/inswapper_128.onnx" "$TEMP_MODELS_DIR/onnx" "inswapper_128.onnx" "$COMFY_MODELS_DIR/reactor/faceswap_models/inswapper_128.onnx"

# 5. IPAdapter Plus Models
download_and_link "https://huggingface.co/h94/IP-Adapter/resolve/main/sdxl_models/ip-adapter-plus_sdxl_vit-h.safetensors" "$TEMP_MODELS_DIR/ipadapter" "ip-adapter-plus_sdxl_vit-h.safetensors" "$COMFY_MODELS_DIR/ipadapter/ip-adapter-plus_sdxl_vit-h.safetensors"

# 6. ControlNet Models (Flux ControlNet)
download_and_link "https://huggingface.co/InstantX/FLUX.1-dev-Controlnet-Canny/resolve/main/diffusion_pytorch_model.safetensors" "$TEMP_MODELS_DIR/controlnet" "flux-canny.safetensors" "$COMFY_MODELS_DIR/controlnet/flux-canny.safetensors"

# 7. SAM (Segment Anything)
download_and_link "https://dl.fbaipublicfiles.com/segment_anything/sam_vit_h_4b8939.pth" "$TEMP_MODELS_DIR/sams" "sam_vit_h_4b8939.pth" "$COMFY_MODELS_DIR/sams/sam_vit_h_4b8939.pth"

# 8. Wan 2.1 (Quantized GGUF)
mkdir -p "$COMFY_MODELS_DIR/wan"
download_and_link "https://huggingface.co/Kijai/WanVideo_GGUF/resolve/main/wan2.1_1.3b_fp8.gguf" "$TEMP_MODELS_DIR/wan" "wan2.1_1.3b_fp8.gguf" "$COMFY_MODELS_DIR/wan/wan2.1_1.3b_fp8.gguf"

echo "✅ All models downloaded and symlinked successfully!"
echo "Storage optimization: All large models are stored in /tmp and linked to /kaggle/working."