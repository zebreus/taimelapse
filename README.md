# taimelapse

A script for creating timelapse videos with ai upscaling

## Usage

You can run this script as a nix flake with the following command:

```bash
nix run github:zebreus/taimelapse

nix run github:zebreus/taimelapse -- --cut-all 500 --aspect-ratio 16:9 /path/to/images/GOPR0{050..300}.JPG
```

The recommended workflow is to first run the script with a single frame and find the correct `cut`, `rotate`, `aspect-ratio`, and `final-height` parameters. If the result is satisfactory, you run the script with all the frames and the `--upscale` flag. Use the `--framerate` flag to set an appropriate framerate for the video.

## Overview

This script runs five main stages:

1. Verify that all frames are valid
2. Process all frames with `imagemagick`
3. Upscale all frames with `realesrgan`
4. Scale all images to the final size
5. Create a video with `ffmpeg`
