package td.objects;

import kha.Shaders;
import kha.graphics4.Graphics;

class Object extends Transform
{
	public var model:Model;
	public var material:Material;
	public var camera:Camera;
	public var scene:Scene;	

	public function new(model:Model, material:Material):Void
	{
		super();

		this.model = model;
				
		// Use the passed material, otherwise use
		// a material with just a red color
		if (material != null)
			this.material = material;
		else
			this.material = new Material(Shaders.simple_vert, Shaders.simple_frag);

		camera = Camera.get();
	}

	override public function update():Void
	{
		if (matrixDirty)		
			updateMatrix(position.value, rotation.value, scale.value);		
	}

	/**
	 * Sets the vertexBuffer, indexBuffer and pipeline
	 * to the Graphics. Use this in the render function
	 */
	public function setMaterialAndBuffers(g:Graphics):Void
	{
		// Bind data we want to draw
		g.setVertexBuffer(model.vertexBuffer);
		g.setIndexBuffer(model.indexBuffer);

		// Bind state we want to draw with
		g.setPipeline(material.pipeline);
	}
}