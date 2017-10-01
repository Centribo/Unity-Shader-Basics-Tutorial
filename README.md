# Unity-Shader-Basics-Tutorial

Welcome, this tutorial is supposed to be a gentle introduction into writing shaders for Unity. It assume you have some previous knowledge in working with Unity but have never touched shaders or materials.

We'll be building up the shader in parts, stopping along the way to show what everything does.

## Part 1: What's a Shader?

Shaders are part of the computer graphics rendering pipeline. They're small applicaitons that tell the computer how to render and shade objects in a scene. This includes calculating the color and light values for a given object so that it can be shown on screen. Ontop of that, shaders are used to create many of the special and post-processing effects that you see in games today. 

In modern game engines, (Including Unity) shaders run in a programmable GPU (Graphics Processing Unit) rendering pipeline, which allow them to run in parallel and do many shader calculations very quickly.

Wikipedia has a great article about shaders [here.](https://en.wikipedia.org/wiki/Shader)

## Part 2: The Rendering Pipeline

For our purposes, we'll simplify the rendering pipeline. Here's a image showing what we'll discuss in this tutorial:

![Simplified Rendering Pipeline](./Images/Rendering_Pipeline.png "Simplified Rendering Pipeline")

I like to think of shaders as programs that transform one type of information (model data, colours, etc.) to another type of information (pixels/fragments).