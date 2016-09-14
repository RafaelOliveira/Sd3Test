package td.objects;

class SimpleObject extends Object
{
	public function new(vertices:Array<Float>, indices:Array<Int>, material:Material):Void
	{
		super(material);		
		
		setVertices(vertices);
		setIndices(indices);		
	}	
}