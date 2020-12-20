package mtasa.server.classes;

import mtasa.client.classes.Element;
import mtasa.shared.classes.Vector3;

@:native('Player')
extern class Player extends Element {
	public var position: Vector3;
	public var rotation: Vector3;
}
