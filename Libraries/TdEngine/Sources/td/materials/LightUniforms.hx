package td.materials;

import kha.FastFloat;
import kha.Color;
import kha.graphics4.Graphics;
import kha.graphics4.PipelineState;
import kha.graphics4.ConstantLocation;
import td.math.Vec3;

class LightUniforms
{
	public var normalModelMatrixId:ConstantLocation;

	public var materialShininessId:ConstantLocation;
	public var materialSpecularColorId:ConstantLocation;
	public var lightPositionId:ConstantLocation;
	public var lightColorId:ConstantLocation;
	public var lightAttenuationId:ConstantLocation;
	public var lightAmbientCoefficientId:ConstantLocation;
	public var cameraPositionId:ConstantLocation;

	public function new(pipeline:PipelineState):Void
	{
		normalModelMatrixId = pipeline.getConstantLocation('normalModel');
		materialShininessId = pipeline.getConstantLocation('materialShininess');	
		materialSpecularColorId = pipeline.getConstantLocation('materialSpecularColor');
		lightPositionId = pipeline.getConstantLocation('lightPosition');
		lightColorId = pipeline.getConstantLocation('lightColor');
		lightAttenuationId = pipeline.getConstantLocation("lightAttenuation");
		lightAmbientCoefficientId = pipeline.getConstantLocation('lightAmbientCoefficient');
		cameraPositionId = pipeline.getConstantLocation('cameraPosition');
	}

	public function update(g:Graphics, objectShininess:FastFloat, objectSpecularColor:Color, light:Light, lightAmbient:FastFloat, cameraPosition:Vec3):Void
	{
		g.setFloat(materialShininessId, objectShininess);
		g.setFloat3(materialSpecularColorId, objectSpecularColor.R, objectSpecularColor.G, objectSpecularColor.B);
		g.setFloat3(lightPositionId, light.position.x, light.position.y, light.position.z);
		g.setFloat3(lightColorId, light.color.R, light.color.G, light.color.B);
		g.setFloat(lightAttenuationId, light.attenuation);
		g.setFloat(lightAmbientCoefficientId, lightAmbient);
		g.setFloat3(cameraPositionId, cameraPosition.x, cameraPosition.y, cameraPosition.z);
	}
}