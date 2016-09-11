package td.models;

class SimpleModel extends Model
{
	public function new(vertices:Array<Float>, indices:Array<Int>, material:Material):Void
	{
		super(material);		
		
		setVertices(vertices);
		setIndices(indices);		
	}	
}