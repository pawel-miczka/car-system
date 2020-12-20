package mtasa.shared.classes;

@:native('Vector2')
extern class Vector2 {
	public var x: Int;
	public var y: Int;

	@:native('create')
	public function new(x: Int, y: Int);
}
