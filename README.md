# Fashion Influencer AI Generation with ComfyUI

This repository provides a complete setup for creating AI fashion influencers using ComfyUI on Kaggle with T4 x2 GPUs.

## Setup Instructions

### Kaggle Notebook Requirements
1. Enable **2x T4 GPU** with 15GB VRAM each
2. Turn on **Internet Access** (required for model downloads)
3. Allocate at least 20GB disk space in `/kaggle/working`

## Installation Steps

1. **Clone this repository**
2. Run `scripts/install_nodes.sh` to install all custom nodes
3. Run `scripts/download_models.sh` to download and symlink models
4. Execute the main notebook to launch ComfyUI with Cloudflared tunnel

## Features

- AI face swapping and consistency enhancement
- Clothing and background replacement
- Image-to-video generation
- Cloudflare tunnel for remote access

## Custom Nodes Included

- ComfyUI-Manager
- ReActor Node
- IPAdapter Plus
- ControlNet Aux
- Segment Anything
- ComfyUI-VideoHelperSuite
- Wan2.1 Wrapper

## Workflow Templates

The `workflows/` directory contains JSON templates for:
- Base character creation
- Clothing and background swapping
- Image-to-video motion transfer

---

## Usage

1. Run the notebook cells sequentially
2. The Cloudflared tunnel will expose ComfyUI at `https://your-tunnel-name.comfyui-kaggle-influencer.com`
3. Access ComfyUI through the tunnel URL

---

## Troubleshooting

### VRAM Optimization
- Use FP8 quantization for models
- Keep only necessary models in `/kaggle/working/models`
- Use `--lowvram` flag for ComfyUI startup

### Disk Space
- Models are downloaded to `/tmp/models/` and symlinked
- Clean up old models periodically

---

## License

This project is licensed under the MIT License. Feel free to modify and distribute.