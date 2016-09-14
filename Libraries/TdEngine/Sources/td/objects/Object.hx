package td.objects;

import kha.Shaders;
import kha.graphics4.Graphics;
import kha.graphics4.VertexBuffer;
import kha.graphics4.IndexBuffer;
import kha.graphics4.Usage;
import kha.math.FastMatrix4;

class Object extends Transform
{
	var vertexBuffer:VertexBuffer;
	var indexBuffer:IndexBuffer;
	
	public var material:Material;

	public var camera:Camera;
	public var scene:Scene;	
		
	public function new(?material:Material):Void
	{		
		super();

		matrix = FastMatrix4.identity();
		matrixDirty = false;

		// Use the passed material, otherwise use
		// a material with just a red color
		if (material != null)
			this.material = material;
		else
			this.material = new Material(Shaders.simple_vert, Shaders.simple_frag);

		camera = Camera.get();		
	}

	public function update():Void
	{
		if (matrixDirty)		
			updateMatrix(position.value, rotation.value, scale.value);		
	}	

	public function setVertices(vertices:Array<Float>, ?otherData:Array<Array<Float>>):Void
	{
		var vertexCount = Std.int(vertices.length / 3); // Vertex count - 3 floats per vertex

		// Create vertex buffer
		vertexBuffer = new VertexBuffer(
			vertexCount, 
			material.structure, // Vertex structure
			Usage.StaticUsage // Vertex data will stay the same
		);

		// Copy vertices and other data to vertex buffer
		if (otherData != null && otherData.length > 0)
		{
			var vbData = vertexBuffer.lock();
			var pos:Int;
			
			for (i in 0...Std.int(vbData.length / material.structureLength)) 
			{
				// Vertices
				vbData.set(i * material.structureLength, vertices[i * 3]);
				vbData.set(i * material.structureLength + 1, vertices[i * 3 + 1]);
				vbData.set(i * material.structureLength + 2, vertices[i * 3 + 2]);

				pos = 3;

				// Other data
				for (j in 0...otherData.length)
				{
					// First position in structureSizes is 'pos'
					for (s in 0...material.structureSizes[j + 1])
					{
						vbData.set(i * material.structureLength + pos, otherData[j][i * material.structureSizes[j + 1] + s]);						
						pos++;
					}					
				}
			}
			vertexBuffer.unlock();
		}
		else
		{
			var vbData = vertexBuffer.lock();
			for (i in 0...vbData.length) 
				vbData.set(i, vertices[i]);
			vertexBuffer.unlock();
		}
	}

	public function setIndices(indices:Array<Int>):Void
	{
		// Create index buffer
		indexBuffer = new IndexBuffer(
			indices.length, // 3 indices for our triangle
			Usage.StaticUsage // Index data will stay the same
		);
		
		// Copy indices to index buffer
		var iData = indexBuffer.lock();
		for (i in 0...iData.length)
			iData[i] = indices[i];		
		indexBuffer.unlock();
	}
	
	/**
	 * Sets the vertexBuffer, indexBuffer and pipeline
	 * to the Graphics. Use this in the render function
	 */
	public function setMaterialAndBuffers(g:Graphics):Void
	{
		// Bind data we want to draw
		g.setVertexBuffer(vertexBuffer);
		g.setIndexBuffer(indexBuffer);

		// Bind state we want to draw with
		g.setPipeline(material.pipeline);
	}	
}