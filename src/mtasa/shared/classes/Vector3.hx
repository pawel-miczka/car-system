package mtasa.shared.classes;

@:native('Vector3')
extern class Vector3 {
	public var x: Float;
	public var y: Float;
	public var z: Float;

	@:overload(function(x: Float, y: Float, z: Float): Vector3 {})
	public static function create(data: Dynamic): Vector3;
}
