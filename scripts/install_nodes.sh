#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

echo "🚀 Starting ComfyUI custom nodes installation..."

# Change to the working directory
cd /kaggle/working

# Clone ComfyUI
echo "📦 Cloning ComfyUI..."
git clone --depth 1 https://github.com/comfyanonymous/ComfyUI.git
cd ComfyUI

# Install ComfyUI requirements
echo "📋 Installing ComfyUI requirements..."
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118
pip install -r requirements.txt

# Install custom nodes
echo "🔌 Installing custom nodes..."

# ComfyUI-Manager
echo "Installing ComfyUI-Manager..."
git clone https://github.com/ltdr2/ComfyUI-Manager.git custom_nodes/ComfyUI-Manager
pip install -r custom_nodes/ComfyUI-Manager/requirements.txt

# ReActor Node
echo "Installing ReActor Node..."
git clone https://github.com/Gourieff/comfyui-reactor-node.git custom_nodes/comfyui-reactor-node
pip install -r custom_nodes/comfyui-reactor-node/requirements.txt

# IPAdapter Plus
echo "Installing IPAdapter Plus..."
git clone https://github.com/cubiq/ComfyUI_IPAdapter_plus.git custom_nodes/ComfyUI_IPAdapter_plus
pip install -r custom_nodes/ComfyUI_IPAdapter_plus/requirements.txt

# ControlNet Aux
echo "Installing ControlNet Aux..."
git clone https://github.com/Fannovel16/comfyui_controlnet_aux.git custom_nodes/comfyui_controlnet_aux
pip install -r custom_nodes/comfyui_controlnet_aux/requirements.txt

# Segment Anything
echo "Installing Segment Anything..."
git clone https://github.com/pythongosssss/ComfyUI_segment_anything.git custom_nodes/ComfyUI_segment_anything
pip install -r custom_nodes/ComfyUI_segment_anything/requirements.txt

# Florence-2
echo "Installing Florence-2..."
git clone https://github.com/chaofengc/ComfyUI-Florence2.git custom_nodes/ComfyUI-Florence2
pip install -r custom_nodes/ComfyUI-Florence2/requirements.txt

# VideoHelperSuite
echo "Installing VideoHelperSuite..."
git clone https://github.com/Kosinkadink/ComfyUI-VideoHelperSuite.git custom_nodes/ComfyUI-VideoHelperSuite
pip install -r custom_nodes/ComfyUI-VideoHelperSuite/requirements.txt

# Wan2.1 Wrapper
echo "Installing Wan2.1 Wrapper..."
git clone https://github.com/extraltorrent/ComfyUI-WanVideoWrapper.git custom_nodes/ComfyUI-WanVideoWrapper
pip install -r custom_nodes/ComfyUI-WanVideoWrapper/requirements.txt

# AnimateDiff Evolved
echo "Installing AnimateDiff Evolved..."
git clone https://github.com/Kosinkadink/ComfyUI-AnimateDiff-Evolved.git custom_nodes/ComfyUI-AnimateDiff-Evolved
pip install -r custom_nodes/ComfyUI-AnimateDiff-Evolved/requirements.txt

# Install additional dependencies
echo "📦 Installing additional dependencies..."
pip install insightface onnxruntime-gpu opencv-python-headless rembg

echo "✅ Installation completed successfully!"
echo "All custom nodes have been installed."