package td.objects;

class ColorObject extends Object
{
	public function new(vertices:Array<Float>, indices:Array<Int>, material:Material):Void
	{
		var model = new Model(material);		
		model.setVertices(vertices);
		model.setIndices(indices);

		super(model);				
	}
}