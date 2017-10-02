using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RainbowColour : MonoBehaviour {

	Renderer rend;
	Material material;

	// Use this for initialization
	void Start () {
		rend = GetComponent<Renderer>();
		material = rend.material;
		material.SetColor("_Colour", Color.magenta);
	}
	
	// Update is called once per frame
	void Update () {
		
	}
}
