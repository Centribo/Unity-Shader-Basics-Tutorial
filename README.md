# Unity-Shader-Basics-Tutorial

Welcome, this tutorial is supposed to be a gentle introduction into writing shaders for Unity. It assume you have some previous knowledge in working with Unity but have never touched shaders or materials.

We'll be building up the shader in parts, stopping along the way to show what everything does.

## Part 1: What's a Shader?

Shaders are part of the computer graphics rendering pipeline. They're small applicaitons that tell the computer how to render and shade objects in a scene. This includes calculating the color and light values for a given object so that it can be shown on screen. Ontop of that, shaders are used to create many of the special and post-processing effects that you see in games today. 

In modern game engines, (Including Unity) shaders run in a programmable GPU (Graphics Processing Unit) rendering pipeline, which allow them to run in parallel and do many shader calculations very quickly.

Wikipedia has a great article about shaders [here.](https://en.wikipedia.org/wiki/Shader)

## Part 2: The Rendering Pipeline

For our purposes, we'll simplify the rendering pipeline. Here's a image showing what we'll discuss in this tutorial:

![Simplified Rendering Pipeline](./Images/Rendering_Pipeline.png)

I like to think of shaders as programs that transform one type of information (model data, colours, etc.) to another type of information (pixels/fragments). Object data is data that is inherit to the object. Things such as points in the model, normals, triangles, UV coordinates, etc. Custom Data/Properties are things that we can pass into a shader to use. Things such as colours, textures, numbers, etc.

The first step of the shader pipeline is the vertex function. Vertices, as you might know, are just points. The vertex function will work with the vertices in the model (Along with other data such as normals) and prepare them for the next step, the fragment function.

The fragment function will take in vertices and shade them in. Think of it like a painter and their paint brush. It ultimately outputs pixel data, in a (R, G, B, A) format.

Lastly, the pixels are pushed to a frame buffer, where they may be manipulated further (even by other shaders!) until they are drawn on screen.

## Part 3: Scene Setup

So before we start writing some shader code, let's setup our scene. Create a new project in Unity, and import all the assets:

* [Bowl model](./Assets/Models/Bowl.blend)

* [Noise texture](./Assets/Textures/Noise.png)

* [Bowl texture](./Assets/Textures/Bowl.png)

Add a cube, a sphere, and the bowl model to a new scene and save the scene. Here's what your scene should look like after:

![Setup 1](./Images/Setup_1.png)

Next, right click in the Project view (Or go to Create) and add a new Unlit Shader. We'll call it "Tutorial_Shader" for now.

*If you're curious about the other kinds of shaders, I'll talk about them at the near the end.*

![Setup 2](./Images/Setup_2.png)

Then, right click the shader file we just made and go to Create > Material. Unity will automatically create a material that uses that shader with the correct name.

__Note: a "Material" in Unity is just a *instance* of a shader. It just saves the values of the custom data/properties.__

![Setup 3](./Images/Setup_3.png)

Lastly, apply the material to all the objects we've added to the scene by clicking and dragging them to each object.

Everything in the scene should look white and without shadows or shading, like this:

![Setup 4](./Images/Setup_4.png)

## Part 4: Skeleton of a Unlit Shader

Time to start writing our shader! Let's open our Tutorial_Shader.shader file we create before. You'll see Unity automatically generates some code for us to use/build off of. For the sake of this tutorial, delete all of this and make the .shader file blank. All shaders in Unity are written in language called "ShaderLab".

To start we'll add this code:

```
Shader "Unlit/Tutorial_Shader" {
	...
}
```
These lines of code just specify where the shader code is. The string in quotes after the *Shader* keyword specify to Unity where you'll find the shader.

For example:
```hlsl
Shader "A/B/C/D/E_Shader" {
	...
}
```
![Skeleton 1](./Images/Skeleton_1.png)

If you save your shader and switch back to Unity, you'll notice all our objects now are pink:

![Skeleton 2](./Images/Skeleton_2.png)

This is a fallback shader that Unity will use whenever your shader has errors in it. If you ever get pink objects, you can click on your shader file in the project window and look at the inspector to see the corresponding errors. For now, we'll have pink objects because we haven't completed our shader.

Next up is the properties block:

```
Shader "Unlit/Tutorial_Shader" {
	Properties {
		...
	}
}
```

The properties block is where we can pass in that custom data we were walking about before. Anything we declare here will be shown in the Unity editor for us to change and be exposed to scripting aswell.

Underneath our properties block we'll have our subshader:

```
Shader "Unlit/Tutorial_Shader" {
	Properties {
		...
	}

	SubShader {
		...
	}
}
```

Each shader has 1 or more subshaders. If you're deploying to multiple platforms it can be useful to add multiple subshaders; For example, you might want a subshader that is higher quality for PC/Desktop and lower quality but faster subshader for mobile.

Then we have our pass:
```
Shader "Unlit/Tutorial_Shader" {
	Properties {
		...
	}

	SubShader {
		Pass {
			...
		}
	}
}
```
Each subshader has atleast one pass, which is actually where the object get rendered. Some effects require having multiple passes, but we'll just focus on one for now.

Within our pass, we have the actual rendering code block:
```
Shader "Unlit/Tutorial_Shader" {
	Properties {
		...
	}

	SubShader {
		Pass {
			CGPROGRAM
				...
			ENDCG
		}
	}
}
```
Anything within CGPROGRAM and ENDCG is where we actually write our shading code. For Unity this is a variant of HLSL and CG shading languages.

Next, we'll tell Unity what our vertex and fragment functions are:
```
Shader "Unlit/Tutorial_Shader" {
	Properties {
		...
	}

	SubShader {
		Pass {
			CGPROGRAM
				#pragma vertex vertexFunction
				#pragma fragment fragmentFunction
			ENDCG
		}
	}
}
```
Here, we're saying we have a vertex function called "vertexFunction", and a fragment function called "fragmentFunction"".

We'll define those functions aswell:
```
Shader "Unlit/Tutorial_Shader" {
	Properties {
		...
	}

	SubShader {
		Pass {
			CGPROGRAM
				#pragma vertex vertexFunction
				#pragma fragment fragmentFunction

				void vertexFunction () {

				}

				void fragmentFunction () {

				}
			ENDCG
		}
	}
}
```
If you save your shader now and return to Unity, your objects will disappear! That's because this is bare skeleton for a unlit shader, but we're not returning anything for Unity to actually render.

## Part 5: Basic Shading